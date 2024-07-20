import 'package:flutter/material.dart';
import 'package:demofood/SQLite/sqlite.dart';
import 'package:demofood/components/text_model.dart';
import 'package:demofood/jsonModels/users.dart';
import 'package:demofood/pages/forget_password.dart';
import 'package:demofood/pages/homepage.dart';
import 'package:demofood/pages/signuppage.dart';
import 'package:demofood/provider/setting_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/text_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final provider = SettingProvider();
  final formkey = GlobalKey<FormState>();
  bool isLoginTrue = false;
  final db = DatabaseHelper();

  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async{
    Users? usrDetails=await db.getUser(usernameController.text);
    var response = await db.login(Users(
        usrEmail: usernameController.text,
        usrPassword: passwordController.text));
    //print(response);
    if (response == true) {
      final prefs=await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('useEmail', usrDetails!.usrEmail);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(profile: usrDetails,),
          ));
    }
    else{
      setState(() {
        isLoginTrue=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffB81736), Color(0xff281537)])),
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 30),
            child: Text(
              "Hello\nSign In !",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 250, left: 10, right: 10, bottom: 20.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextModel(
                          stringName: 'Email',
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                          controller: usernameController,
                          hintText: "Enter your Email",
                          inputType: TextInputType.emailAddress,
                          validator: (value) => provider.emailValidator(value)),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextModel(stringName: 'Password')),
                      const SizedBox(height: 10),
                      Consumer<SettingProvider>(
                        builder: (context, notifier, child) {
                          return MyTextField(
                            controller: passwordController,
                            hintText: 'Enter your Password',
                            isVisible: !notifier.isVisible,
                            trailingIcon: IconButton(
                                onPressed: () => notifier.showhidePassword(),
                                icon: Icon(notifier.isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            validator: (value) =>
                                provider.passwordValidator(value),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Color(0xffB81736),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              login();
                            } else {
                              //other wise show the error message
                              //show snack bar
                              provider.snackBarMessage(
                                  "Fix the Error", context);
                            }
                          },
                          child: TextModel(stringName: 'Sign In')),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a Member? ',
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
                                    builder: (context) => SignupPage(),
                                  ));
                            },
                            child: TextModel(stringName: 'Sign Up'),
                          )
                        ],
                      ),
                     const SizedBox(
                        height: 20,
                      ),
                      //If your Username and Password is incorrect show this text
                      isLoginTrue
                          ? Text('Username and Password is incorrect !',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ))
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
