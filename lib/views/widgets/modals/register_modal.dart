import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:checkedin/views/screens/page_switcher.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/custom_text_field.dart';
import 'package:checkedin/views/widgets/modals/login_modal.dart';

final _firebase = FirebaseAuth.instance;

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'email': _enteredEmail,
        'name': _enteredName,
        'image_url':
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      });
      if (!mounted) return;
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed!')));
    }
  }

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
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              // header
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'inter'),
                ),
              ),
              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      title: 'Email',
                      hint: 'youremail@email.com',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email address is required';
                        }
                        if (!value.contains("@")) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          setState(() => _enteredEmail = value!),
                    ),
                    CustomTextField(
                      title: 'Full Name',
                      hint: 'Your Full Name',
                      margin: const EdgeInsets.only(top: 16),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                      onSaved: (value) => setState(() => _enteredName = value!),
                    ),
                    CustomTextField(
                      title: 'Password',
                      hint: '**********',
                      obsecureText: true,
                      margin: const EdgeInsets.only(top: 16),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 charactesr';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          setState(() => _enteredPassword = value!),
                    ),
                    // CustomTextField(
                    //   title: 'Retype Password',
                    //   hint: '**********',
                    //   obsecureText: true,
                    //   margin: const EdgeInsets.only(top: 16),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Renter the password';
                    //     }
                    //     if (value != _enteredPassword) {
                    //       return 'Passwords are not matched';
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) =>
                    //       setState(() => _enteredSecondPassword = value!),
                    // ),
                    // Register Button
                    Container(
                      margin: const EdgeInsets.only(top: 32, bottom: 6),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _submit,
                        // () {
                        //   Navigator.of(context).pop();
                        //   Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (context) => const PageSwitcher()));
                        // },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColor.primarySoft,
                        ),
                        child: Text('Register',
                            style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter')),
                      ),
                    ),
                  ],
                ),
              ),

              // Login textbutton
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    isScrollControlled: true,
                    builder: (context) {
                      return const LoginModal();
                    },
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account? ',
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter',
                          ),
                          text: 'Log in')
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
