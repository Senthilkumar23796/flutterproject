import 'package:flutter/material.dart';
import 'package:demofood/components/text_field.dart';
import 'package:demofood/components/text_model.dart';
import 'package:demofood/pages/signinpage.dart';
import 'package:demofood/provider/setting_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  final provider = SettingProvider();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffB81736), Color(0xff281537)])),
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 30),
                child: Text(
                  "Hello\nForget Password !",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 250, left: 10, right: 10, bottom: 20),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(stringName: 'Email'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          controller: emailController,
                          hintText: 'Enter your Email',
                          validator: (value) => provider.emailValidator(value),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(stringName: 'New Password'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Consumer<SettingProvider>(
                            builder: (context, notifier, child) {
                          return MyTextField(
                            controller: newController,
                            hintText: 'Enter your New Password',
                            isVisible: !notifier.isVisible,
                            trailingIcon: IconButton(
                                onPressed: () => notifier.showhidePassword(),
                                icon: Icon(notifier.isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            validator: (value) =>
                                provider.passwordValidator(value),
                          );
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(stringName: 'Confirm Password'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Consumer<SettingProvider>(
                            builder: (context, notifier, child) {
                          return MyTextField(
                            controller: confirmController,
                            hintText: 'Enter your Confirm Password',
                            isVisible: !notifier.isVisible,
                            trailingIcon: IconButton(
                                onPressed: () => notifier.showhidePassword(),
                                icon: Icon(notifier.isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            validator: (value) => provider.confirmValidator(
                                value, newController.text),
                          );
                        }),
                        SizedBox(
                          height: 15.0,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                //if form validated move to Signin page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninPage()));
                              } else {
                                //show the snack bar
                              }
                            },
                            child: TextModel(stringName: 'Submit')),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do you know a Password? ',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SigninPage(),
                                    ));
                              },
                              child: TextModel(stringName: 'Sign In'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
