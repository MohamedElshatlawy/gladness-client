import 'package:flutter/material.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calender_dialog.dart';

class NewCheckout extends StatefulWidget {
  Map<int, bool> selectedPrices;
  ProductModel model;
  VendorModel vendorModel;
  NewCheckout(this.selectedPrices, this.model, this.vendorModel);

  @override
  _NewCheckoutState createState() => _NewCheckoutState();
}

class _NewCheckoutState extends State<NewCheckout> {
  int total = 0;

  String replaceFarsiNumber(String s1) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = [
      '/٠/g',
      '/١/g',
      '/٢/g',
      '/٣/g',
      '/٤/g',
      '/٥/g',
      '/٦/g',
      ' /٧/g',
      '/٨/g',
      '/٩/g'
    ];
    Map<String, String> farsiMap = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '٤': "4",
      '۵': "5",
      '٦': "6",
      '۷': "7",
      '۸': "8",
      '۹': "9"
    };
    // String myStr="";
    // for(int i=0;i<input.length;i++){
    //   print(input[i]);
    //   if(farsi.contains(input[i])){
    //     print(true);
    //     myStr+=farsiMap[input[i]];
    //   }else{
    //     print(false);
    //      myStr+=input[i];
    //   }
    // }
    //return myStr;
  }

  Map<String, dynamic> selectedPriceByUser = {};
  List<Widget> getProductsWidgets({String type}) {
    total = 0;
    List<Widget> productsWidgets = [];
    selectedPriceByUser.clear();

    List<int> trueIndexs = [];
    widget.selectedPrices.forEach((key, value) {
      if (value == true) {
        trueIndexs.add(key);
      }
    });
    print("LenPrice:${widget.model.priceList.length}");
    for (int i = 0; i < widget.model.priceList.length; i++) {
      if (trueIndexs.contains(i)) {
        selectedPriceByUser[widget.model.priceList.keys.elementAt(i)] =
            widget.model.priceList.values.elementAt(i);
        int price = int.parse(widget.model.priceList.values.elementAt(i));
        print(price);
        total += price;

        productsWidgets.add(Text(
          (type == "name")
              ? widget.model.priceList.keys.elementAt(i)
              : widget.model.priceList.values.elementAt(i),
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ));
      }
    }
    return productsWidgets;
  }

  var noteController = TextEditingController();

  String selectedDate;
  String selectedTime;
  ReservationModel reservationModel;
  var checkoutKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.custGrey2,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColor.customColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: MyColor.whiteColor,
        title: Text(
          "اسم الفئة",
          style: TextStyle(color: MyColor.customColor),
        ),
        centerTitle: true,
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Vendor Name', style: TextStyle(fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text('الخدمات', style: TextStyle()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: MyColor.customColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    title: Text(
                      'اسم الخدمة',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      '2000 SAR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text('التاريخ والوقت', style: TextStyle()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ), 
                Container(
                 
                    width: MediaQuery.of(context).size.width,
                    child: CalenderDialog(selectedDate, widget.vendorModel))
              ],
            ),
          )),
    );
  }
}
