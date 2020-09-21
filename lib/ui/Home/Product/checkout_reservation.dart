import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/Home/Product/calender_dialog.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

class CheckoutReservation extends StatefulWidget {
  Map<int, bool> selectedPrices;
  ProductModel model;
  VendorModel vendorModel;
  CheckoutReservation(this.selectedPrices, this.model, this.vendorModel);

  @override
  _CheckoutReservationState createState() => _CheckoutReservationState();
}

class _CheckoutReservationState extends State<CheckoutReservation> {
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
    //  print(selectedPrices.keys.elementAt(0).priceList);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      key: checkoutKey,
      appBar: AppBar(
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
          "تنفيذ الطلب",
          style: TextStyle(color: MyColor.customColor),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'تفاصيل الطلب',
                      style:
                          TextStyle(fontSize: 16, color: MyColor.customColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'اسم المنتج',
                            style: TextStyle(
                                fontSize: 16, color: MyColor.customColor),
                          ),
                          ...getProductsWidgets(type: "name")
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'التكلفة',
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.customColor),
                            ),
                            ...getProductsWidgets(type: "price")
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'اضف ملاحظات',
                      style:
                          TextStyle(fontSize: 16, color: MyColor.customColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  labelColor: Colors.grey,
                  lineCount: 2,
                  controller: noteController,
                  txtColor: MyColor.customColor,
                  txtLablel: 'ملاحظات (اختياري)',
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'طرق الدفع',
                      style:
                          TextStyle(fontSize: 16, color: MyColor.customColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/cash.png',
                      scale: 8,
                    ),
                    title: Text(
                      'كاش',
                      style: TextStyle(color: MyColor.customColor),
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.green[600],
                      size: 30,
                    ),
                  ),
                ),
                Card(
                  color: Colors.grey[200],
                  child: ListTile(
                    enabled: false,

                    leading: Image.asset(
                      'assets/visa.png',
                      scale: 18,
                    ),
                    title: Text('مدي / بطاقة الأئتمان'),
                    //trailing: Icon(Icons.),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'المجموع',
                      style:
                          TextStyle(fontSize: 16, color: MyColor.customColor),
                    ),
                    Text(
                      '$total ريال',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                    backgroundColor: MyColor.customColor,
                    btnPressed: () async {
                      var result = await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: CalenderDialog(selectedDate,
                                        widget.vendorModel, null)),
                              ));
                      if (result[0] != null) {
                        selectedDate = result[0].toString();
                      } else {
                        selectedDate = null;
                      }

                      // selectedDate=result[0];
                      print("BackDate:$selectedDate");
                      setState(() {});
                      print("MyTotalPrice:$total");

                      //    print(reservationModel.toMap());
                    },
                    textColor: Colors.white,
                    txt: (selectedDate == null)
                        ? 'تحديد التاريخ'
                        : '$selectedDate'),
                SizedBox(
                  height: 10,
                ),
                (selectedDate == null)
                    ? Container()
                    : CustomButton(
                        backgroundColor: MyColor.customColor,
                        btnPressed: () {
                          DatePicker.showTimePicker(context, onConfirm: (dt) {
                            final f = new intl.DateFormat().add_jm();
                            String s = f.format(dt);
                            selectedTime = s;
                            setState(() {});
                          });
                        },
                        textColor: Colors.white,
                        txt: (selectedTime == null)
                            ? 'تحديد الوقت'
                            : selectedTime,
                      ),
                SizedBox(
                  height: 10,
                ),
                (selectedTime == null)
                    ? Container()
                    : CustomButton(
                        backgroundColor: MyColor.customColor,
                        btnPressed: () async {
                          print("SecondTotalPrice:$total");
                          reservationModel = ReservationModel(
                              clientID: FirebaseAuth.instance.currentUser.uid,
                              notes: noteController.text,
                              paymentMethod: "cash",
                              selectedDate: selectedDate,
                              selectedTime: selectedTime,
                              vendorName: widget.vendorModel.name,
                              totalPrice: total.toString(),
                              selectedItems: selectedPriceByUser);
                          showMyDialog(
                              context: context, msg: 'جاري ارسال الطلب');
                          await FirebaseFirestore.instance
                              .collection("reservations")
                              .doc()
                              .set(reservationModel.toMap())
                              .then((value) async {
                            // final Email email = Email(
                            //   body: 'Hey! \n Your order summary:\n ${widget.selectedPrices} \n Total:$total',
                            //   subject: 'Your order from GLADNESS',
                            //   recipients: ['elshatlawey90@gmail.com'],
                            //   cc: [
                            //     "elshatlawey90@gmail.com"
                            //   ],
                            //   bcc: [
                            //     "elshatlawey90@gmail.com"
                            //   ],
                            //   //attachmentPaths: ['/path/to/attachment.zip'],
                            //   isHTML: false,

                            // );

                            // await FlutterEmailSender.send(email);
                            sendDashboardNotification();
                            dismissDialog(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }).catchError((e) {
                            dismissDialog(context);
                            showSnackbarError(
                                msg: 'حدث حطأ في ارسال الطلب حاول مرة اخرى',
                                scaffoldKey: checkoutKey);
                            print("ErrorInsertReserv:$e");
                          });
                        },
                        textColor: Colors.white,
                        txt: 'تنفيذ الطلب',
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> sendDashboardNotification() async {
    await FirebaseFirestore.instance
        .collection(MyCollections.dashBoardUsers)
        .get()
        .then((value) async {
      print('DocsValue:${value.docs.length}');

      Future.forEach(value.docs, (element) async {
        if (element.data()['fcm_token'] != null) {
          print('Token:${element.data()['fcm_token']}');
          await sendToAllClients(element.data()['fcm_token'], 'طلب جديد');
        }
      });
    });
  }
}
