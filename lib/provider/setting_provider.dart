import 'package:flutter/material.dart';
import 'package:demofood/components/cartitem.dart';

class SettingProvider extends ChangeNotifier {

  List<CartItem> _items=[
    CartItem(foodName: "Lemon Rice", foodPrice: "40", foodImage: 'assets/images/lemon.jpg'),
    CartItem(foodName: "Tomato Rice", foodPrice: "40", foodImage: 'assets/images/tomato.png'),
    CartItem(foodName: "Sambar Rice", foodPrice: "40", foodImage: 'assets/images/sambar.jpg'),
    CartItem(foodName: "Curd Rice", foodPrice: "40", foodImage: 'assets/images/curd.jpg'),
    CartItem(foodName: "Mint Rice", foodPrice: "40", foodImage: 'assets/images/ricemint.jpg'),
    CartItem(foodName: "Vegetable Rice", foodPrice: "40", foodImage: 'assets/images/veg.png'),
    CartItem(foodName: "Mushroom Rice", foodPrice: "40", foodImage: 'assets/images/mushroom.jpg'),
  ];
  List<CartItem> get items=>_items;

  //For Increment and Decrement a Food Count
  //int _count=0;

  bool _isVisible = false;

  bool get isVisible => _isVisible;

  //Strong password requirement
  RegExp strongPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');

  //Email Value
  RegExp emailRequirement = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // General Validator
  validator(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  //Mobilenumber Validator
  mobileValidator(String value) {
    if (value.isEmpty) {
      return "Enter a Mobilenumber";
    } else if (value.length < 10) {
      return "Enter a Valid Mobilenumber";
    } else {
      return null;
    }
  }

  //Strong password requirement
  /*
  1. must have a small letter
  2. must have a capital letter
  3. must have a digit or number
  4. contain a special character
  5. minimum 8 character long
   */

  //Passord Validator
  passwordValidator(String value) {
    if (value.isEmpty) {
      return "Enter a Password";
    } else if (!strongPassword.hasMatch(value)) {
      return "Password Must be contain a (Ex:Abc@1234)";
    } else {
      return null;
    }
  }

//Confirm Password
  confirmValidator(String value1, String value2) {
    if (value1.isEmpty) {
      return "Re-enter a Password";
    } else if (value1 != value2) {
      return "Password doesn't Match";
    } else {
      return null;
    }
  }

//Email Validator
  emailValidator(String value) {
    if (value.isEmpty) {
      return "Enter a Email Id";
    } else if (!emailRequirement.hasMatch(value)) {
      return 'Enter a Valid Email';
    } else {
      return null;
    }
  }

//Password Show & Hide
  void showhidePassword() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

//Snack Bar Message
  snackBarMessage(String message, context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message)));
  }

void incrementCount(int index){
    _items[index].quantity++;
    notifyListeners();
}
void decrementCount(int index){
    if(_items[index].quantity>0){
      _items[index].quantity--;
    notifyListeners();
    }
}
//int get countValue=>_count;

}
