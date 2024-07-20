import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demofood/SQLite/sqlite.dart';
import 'package:demofood/components/text_field.dart';
import 'package:demofood/components/text_model.dart';
import 'package:demofood/jsonModels/users.dart';
import 'package:demofood/pages/signinpage.dart';
import 'package:demofood/provider/setting_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
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
              padding: const EdgeInsets.only(top: 80.0, left: 30.0),
              child: Text(
                "Hello\nSignup !",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 220, left: 15, right: 15, bottom: 20),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(
                            stringName: 'Name',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          controller: usernameController,
                          hintText: "Enter your Name",
                          validator: (value) =>
                              provider.validator(value, 'Enter a Name'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(
                            stringName: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          controller: emailController,
                          hintText: "Enter your Email",
                          inputType: TextInputType.emailAddress,
                          validator: (value) => provider.emailValidator(value),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(
                            stringName: 'Mobilenumber',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          controller: mobileController,
                          hintText: "Enter your Mobilenumber",
                          inputFormat: [FilteringTextInputFormatter.digitsOnly],
                          inputType: TextInputType.phone,
                          validator: (value) => provider.mobileValidator(value),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(
                            stringName: 'Password',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Consumer<SettingProvider>(
                            builder: (context, notifier, child) {
                          return MyTextField(
                            controller: passwordController,
                            hintText: "Enter your Password",
                            isVisible: !notifier.isVisible,
                            trailingIcon: IconButton(
                              onPressed: () => notifier.showhidePassword(),
                              icon: Icon(notifier.isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            validator: (value) =>
                                provider.passwordValidator(value),
                          );
                        }),
                        SizedBox(
                          height: 15.0,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                final db = DatabaseHelper();
                                db
                                    .signUp(Users(
                                      usrName: usernameController.text,
                                      usrEmail: emailController.text,
                                      usrMobile: mobileController.text,
                                      usrPassword: passwordController.text,
                                    ))
                                    .whenComplete(() => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SigninPage(),

                                        )));

                              } else {
                                //Other wise show the error message
                                //show the snackbar
                                print("Success");
                              }
                            },
                            child: TextModel(stringName: 'Sign Up')),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account? ',
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
