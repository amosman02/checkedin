import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/user_info_tile.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _pickedImageFile;
  final _userCredentials = FirebaseAuth.instance;

  void _logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 250,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${_userCredentials.currentUser!.uid}.jpg');

    await storageRef.putFile(_pickedImageFile!);
    final imageUrl = await storageRef.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_userCredentials.currentUser!.uid)
        .update({'image_url': imageUrl});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Data found!'),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          final userData = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              // brightness: Brightness.dark,
              backgroundColor: AppColor.primary,
              elevation: 0,
              centerTitle: true,
              title: const Text('My Profile',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    // primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            body: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                // Section 1 - Profile Picture Wrapper
                Container(
                  color: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 130,
                        //   height: 130,
                        //   margin: const EdgeInsets.only(bottom: 15),
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey,
                        //     borderRadius: BorderRadius.circular(100),
                        //     // Profile Picture
                        //     image: DecorationImage(
                        //         image: NetworkImage(),
                        //         fit: BoxFit.cover),
                        //   ),
                        // ),
                        CircleAvatar(
                          radius: 65,
                          // foregroundImage: userData['image_url'] != null ? NetworkImage(userData['image_url']) : FileImage(_pickedImageFile!),
                          foregroundImage: NetworkImage(userData['image_url']),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Change Profile Picture',
                                style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            const SizedBox(width: 8),
                            SvgPicture.asset('assets/icons/camera.svg',
                                color: Colors.white),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Section 2 - User Info Wrapper
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoTile(
                        margin: const EdgeInsets.only(bottom: 16),
                        label: 'Email',
                        value: userData['email'],
                      ),
                      UserInfoTile(
                        margin: const EdgeInsets.only(bottom: 16),
                        label: 'Full Name',
                        value: userData['name'],
                      ),
                      UserInfoTile(
                        margin: const EdgeInsets.only(bottom: 16),
                        label: 'Subscription Type',
                        value: 'Premium Subscription',
                        valueBackground: AppColor.secondary,
                      ),
                      const UserInfoTile(
                        margin: EdgeInsets.only(bottom: 16),
                        label: 'Subscription Time',
                        value: 'Until 22 Oct 2021',
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 32, bottom: 6, left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _logout,
                          // () {
                          //   Navigator.of(context).pop();
                          //   Navigator.of(context).pushReplacement(
                          //       MaterialPageRoute(
                          //           builder: (context) => const PageSwitcher()));
                          // },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColor.warning,
                          ),
                          child: Text('Logout',
                              style: TextStyle(
                                  color: AppColor.primaryExtraSoft,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'inter')),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
