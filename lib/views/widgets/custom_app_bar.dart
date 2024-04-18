import 'package:flutter/material.dart';
import 'package:checkedin/views/utils/AppColor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool showProfilePhoto;
  final ImageProvider? profilePhoto;
  final Function? profilePhotoOnPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.showProfilePhoto,
      this.profilePhoto,
      this.profilePhotoOnPressed});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
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
                        image: profilePhoto!, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
