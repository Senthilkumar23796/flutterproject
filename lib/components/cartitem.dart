import 'package:flutter/material.dart';

class CartItem{
  final String foodName;
  final String foodImage;
  final String foodPrice;
  int quantity;
  CartItem({required this.foodName,required this.foodImage,required this.foodPrice,this.quantity=0});
}