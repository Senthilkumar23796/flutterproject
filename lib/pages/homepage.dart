import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:demofood/components/text_model.dart';
import 'package:demofood/constants/colors.dart';
import 'package:demofood/pages/booknow.dart';
import 'package:demofood/pages/myorders.dart';
import 'package:demofood/pages/profilepage.dart';
import 'package:demofood/pages/signinpage.dart';
import 'package:demofood/provider/setting_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SQLite/sqlite.dart';
import '../jsonModels/users.dart';

class HomePage extends StatefulWidget {
  final Users? profile;

  const HomePage({super.key, this.profile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Method to get Selected food items and quantities
  List<Map<String, dynamic>> getSelectedItems(BuildContext context) {
    final settingProvider =
        Provider.of<SettingProvider>(context, listen: false);
    List<Map<String, dynamic>> selectedItems = [];
    for (int i = 0; i < settingProvider.items.length; i++) {
      final item = settingProvider.items[i];
      if (item.quantity > 0) {
        selectedItems.add({
          'index': i,
          'foodName': item.foodName,
          'foodPrice': item.foodPrice,
          'quantity': item.quantity
        });
      }
    }
    return selectedItems;
  }

  Users? profile;
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String? profileJson = prefs.getString('profile');
    if (profileJson != null) {
      setState(() {
        profile = usersFromMap(profileJson);
      });
    }
  }

  void _navigateToProfile(BuildContext context) async {
    if (widget.profile == null || widget.profile!.usrEmail == null) {
      // Show some error message or handle the null case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No profile data available.')),
      );
      //print(widget.profile);
      return;
    }
    try {
      Users? usrDetails = await db.getUser(profile!.usrEmail);
      if (usrDetails != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      profile: usrDetails,
                    )));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User Details Not Found')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching uset Details:$e')));
    }

    // Users? usrDetails = await db.getUser(widget.profile!.usrEmail);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             ProfilePage(
    //               profile: usrDetails,
    //             )));
  }

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
        title: const TextModel(stringName: 'Food List'),
        automaticallyImplyLeading: false,
        backgroundColor: appbarColor,
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: TextModel(
              stringName: 'Histroy',
            ),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(buttonColor)),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              _navigateToProfile(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
            },
            child: Icon(
              Icons.person,
              color: baseColor,
              size: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: TextModel(stringName: 'Alert...!'),
                      content: TextModel(
                        stringName: 'Are sure want to Signout',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            _logout(context);
                          },
                          child: TextModel(
                            stringName: 'Yes',
                          ),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(buttonColor)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: TextModel(
                            stringName: 'No',
                          ),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(appbarColor)),
                        ),
                      ],
                    );
                  });
            },
            child: const Icon(
              Icons.power_settings_new,
              color: baseColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 5)
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: TextModel(
            stringName: "Welcome To JRS Home Foods",
          ),
          //child: Text(widget.profile!.usrName??""),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<SettingProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {},
                  child: ListView.builder(
                    itemCount: value.items.length,
                    itemBuilder: (context, index) {
                      final itemList = value.items[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(color: baseColor)),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Image(
                                      image: AssetImage(itemList.foodImage),
                                      height: 150,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextModel(
                                              stringName: itemList.foodName),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              const TextModel(
                                                  stringName: '\u20B9'),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              TextModel(
                                                  stringName:
                                                      itemList.foodPrice),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Available Count : 10",
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                    color: availColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 25,
                                            width: 120,
                                            //color: baseColor,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: baseColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Provider.of<SettingProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .decrementCount(
                                                                  index);
                                                        },
                                                        child: const Icon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: Colors.white,
                                                        child: TextModel(
                                                            stringName: itemList
                                                                .quantity
                                                                .toString()))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: baseColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Provider.of<SettingProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .incrementCount(
                                                                  index);
                                                        },
                                                        child: const Icon(
                                                          FontAwesomeIcons.plus,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            color: appbarColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyOrders()));
                    },
                    child: TextModel(
                      stringName: 'My Orders',
                    ),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(buttonColor)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Provider.of<SettingProvider>(context,listen: false).addCart(cartItem);
                      List<Map<String, dynamic>> selectedItems =
                          getSelectedItems(context);
                      //print(selectedItems);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookNow(
                                    selectedItems: selectedItems,
                                  )));
                    },
                    child: TextModel(
                      stringName: 'Book Now',
                    ),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(bookColor)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
