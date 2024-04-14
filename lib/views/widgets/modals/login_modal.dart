import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checkedin/views/screens/page_switcher.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/custom_text_field.dart';

final _firebase = FirebaseAuth.instance;

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  var _enteredEmail = TextEditingController();
  var _enteredPassword = TextEditingController();

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 85 / 100,
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            physics: const BouncingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              // header
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'inter'),
                ),
              ),
              // Form
              // const CustomTextField(
              //   title: 'Email',
              //   hint: 'youremail@email.com',
              // ),
              // const CustomTextField(
              //     title: 'Password',
              //     hint: '**********',
              //     obsecureText: true,
              //     margin: EdgeInsets.only(top: 16)),
              // Log in Button
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const PageSwitcher()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColor.primarySoft,
                  ),
                  child: Text('Login',
                      style: TextStyle(
                          color: AppColor.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter')),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Forgot your password? ',
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter',
                          ),
                          text: 'Reset')
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
