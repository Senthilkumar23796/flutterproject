import 'package:flutter/material.dart';
import 'package:demofood/pages/homepage.dart';
import 'package:demofood/pages/profilepage.dart';
import 'package:demofood/pages/signinpage.dart';
import 'package:demofood/pages/signuppage.dart';
import 'package:demofood/provider/setting_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs=await SharedPreferences.getInstance();
  final isLoggedIn=prefs.getBool('isLoggedIn')??false;
  runApp(MyApp(initialRoute:isLoggedIn?'/home':'/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key,required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(BuildContext context)=>SettingProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          '/':(context)=>const InitialScreen(),
          '/signin':(context)=> const SigninPage(),
          '/signup':(context)=> const SignupPage(),
          '/home':(context)=> const HomePage(),
          '/profile':(context)=>const ProfilePage()
        },
        //home: InitialScreen(),
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient:
            LinearGradient(colors: [Color(0xffB81736), Color(0xff281537)])),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Text(
                "JRS HOME FOODS",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        letterSpacing: 5)),
              ),
            ),
            // SizedBox(height: 30,),
            // Image(image: AssetImage("assets/images/streetfood.png"),height: 150,width: 100,),
            SizedBox(
              height: 100,
            ),

            Text(
              "WELCOME BACK",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 5)),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  minimumSize: Size(300, 50)),
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: Text("SIGN IN",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(300, 50)),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text("SIGN UP",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xffB81736),
                          fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}
