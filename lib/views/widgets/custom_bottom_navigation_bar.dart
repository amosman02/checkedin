import 'package:flutter/material.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatefulWidget {
  int selectedIndex;
  Function onItemTapped;
  CustomBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 60, right: 60, bottom: 20),
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            currentIndex: widget.selectedIndex,
            onTap: widget.onItemTapped as void Function(int)?,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: [
              (widget.selectedIndex == 0)
                  ? BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.home,
                        color: AppColor.primary,
                      ),
                      label: '',
                    )
                  : BottomNavigationBarItem(
                      icon: Icon(IconlyLight.home, color: Colors.grey[600]),
                      label: ''),
              (widget.selectedIndex == 1)
                  ? BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.profile,
                        color: AppColor.primary,
                      ),
                      label: '')
                  : BottomNavigationBarItem(
                      icon: Icon(
                        IconlyLight.profile,
                        color: Colors.grey[600],
                      ),
                      label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
