import 'package:flutter/material.dart';
import 'package:demofood/components/text_model.dart';
import 'package:demofood/constants/colors.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextModel(stringName: 'My Orders'),
        backgroundColor: appbarColor,
        iconTheme: IconThemeData(
          color: baseColor,
        ),
      ),
    );
  }
}
