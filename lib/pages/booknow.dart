import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/text_model.dart';
import '../constants/colors.dart';

class BookNow extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const BookNow({Key? key, required this.selectedItems}) : super(key: key);

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  int totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    //List<Map<String, dynamic>> selectedItems = widget.selectedItems;
    return Scaffold(
      appBar: AppBar(
        title: TextModel(
          stringName: 'Your Orders',
        ),
        backgroundColor: appbarColor,
        iconTheme: IconThemeData(
          color: baseColor,
        ),
      ),
      body: widget.selectedItems.isEmpty
          ? Center(
              child: TextModel(
              stringName: 'No Items Selected',
            ))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.selectedItems[index];
                      final int quantity = item['quantity'];
                      final int foodPrice = int.parse(item['foodPrice']);
                      //print(item);
                      if (item != null) {
                        return ListTile(
                          title: TextModel(
                            stringName: item['foodName'],
                          ),
                          subtitle: Text(
                            "Quantity : ${quantity.toString()}",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          trailing: Wrap(spacing: 10, children: [
                            TextModel(stringName: '\u20B9'),
                            TextModel(
                              stringName: '${quantity * foodPrice}',
                            )
                          ]),
                        );
                      }
                    },
                  ),
                ),
                if(widget.selectedItems.isNotEmpty)
                Container(
                  width: double.infinity,
                  height: 60,
                  color: appbarColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TextModel(
                                stringName:
                                    'Total Price : \u20B9 ${totalAmount}'),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: TextModel(
                            stringName: 'Confirm Order',
                          ),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(buttonColor)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  void calculateTotalAmount() {
    int total = 0;
    for (final item in widget.selectedItems) {
      final int quantity = item['quantity'];
      final int foodPrice = int.parse(item['foodPrice']);
      total += quantity * foodPrice;
    }
    setState(() {
      totalAmount = total;
    });
  }
}
