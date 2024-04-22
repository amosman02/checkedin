import 'package:checkedin/views/screens/page_switcher.dart';
import 'package:flutter/material.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:iconly/iconly.dart';

class ReservationConfirmModal extends StatelessWidget {
  const ReservationConfirmModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: AppColor.primaryExtraSoft,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                IconlyBold.tick_square,
                color: AppColor.primary,
                size: 200,
              ),
              const Text(
                'Your reservation confirmed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'inter',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const PageSwitcher()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColor.primarySoft,
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: AppColor.whiteSoft,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'inter'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
