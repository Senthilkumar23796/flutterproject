import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:demofood/components/text_model.dart';
import 'package:demofood/constants/colors.dart';
import 'package:demofood/jsonModels/users.dart';
import 'package:demofood/pages/signinpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final Users? profile;

  const ProfilePage({super.key, this.profile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('usrEmail');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SigninPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextModel(
          stringName: 'Profile',
        ),
        iconTheme: IconThemeData(color: baseColor),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                CircleAvatar(
                  backgroundColor: baseColor,
                  radius: 70,
                  child: _imageFile == null
                      ? CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/person_1.jpg"),
                          radius: 68,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(_imageFile!),
                          radius: 68,
                        ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: TextModel(
                                stringName: 'Choose Your Image From',
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: TextModel(
                                      stringName: 'Camera',
                                    ),
                                    leading: Icon(Icons.camera_alt),
                                    onTap: () {
                                      Navigator.pop(
                                          context, ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    title: TextModel(
                                      stringName: 'Gallery',
                                    ),
                                    leading: Icon(Icons.folder_open),
                                    onTap: () {
                                      Navigator.pop(
                                          context, ImageSource.gallery);
                                    },
                                  )
                                ],
                              ),
                            );
                          }).then((imageSource) {
                        if (imageSource != null) {
                          getImage(imageSource);
                        }
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: baseColor,
                      radius: 20,
                      child: Icon(
                        Icons.folder,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: 15,
              ),
              TextModel(stringName: widget.profile!.usrName ?? ''),
              Text(
                widget.profile!.usrEmail ?? "",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    _logout(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    color: baseColor,
                    child: Text(
                      "SIGN OUT",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: baseColor,
                ),
                title: TextModel(
                  stringName: widget.profile!.usrName ?? '',
                ),
                subtitle: Text(
                  'Name',
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: baseColor,
                ),
                title: TextModel(
                  stringName: widget.profile!.usrEmail ?? '',
                ),
                subtitle: Text(
                  'Email',
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  color: baseColor,
                ),
                title: TextModel(
                  stringName: widget.profile!.usrMobile ?? '',
                ),
                subtitle: Text(
                  'Mobilenumber',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }
}
