import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checkedin/views/utils/AppColor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool showProfilePhoto;
  final Function? profilePhotoOnPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.showProfilePhoto,
      this.profilePhotoOnPressed});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Error occurd'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final userData = snapshot.data!;

        return Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: AppBar(
            backgroundColor: AppColor.primary,
            title: title,
            elevation: 0,
            actions: [
              Visibility(
                visible: showProfilePhoto,
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: profilePhotoOnPressed as void Function()?,
                    icon: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(userData['image_url']),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
