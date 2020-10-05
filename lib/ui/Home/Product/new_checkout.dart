import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/Home/Order/payment3.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart' as intl;
import 'package:toggle_switch/toggle_switch.dart';
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
  List<Widget> getProductsWidgets() {
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
        productsWidgets.add(
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: MyColor.customColor,
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                widget.model.priceList.keys.elementAt(i),
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                widget.model.priceList.values.elementAt(i) + " ريال",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
        // productsWidgets.add(Text(
        //   (type == "name")
        //       ? widget.model.priceList.keys.elementAt(i)
        //       : widget.model.priceList.values.elementAt(i),
        //   textAlign: TextAlign.right,
        //   style: TextStyle(color: Colors.grey, fontSize: 14),
        // ));
      }
    }
    return productsWidgets;
  }

  var noteController = TextEditingController();

  String selectedDate;
  String selectedTime = "";
  ReservationModel reservationModel;
  var checkoutKey = GlobalKey<ScaffoldState>();
  String timePeroid = "AM";

  @override
  Widget build(BuildContext context) {
    print("Vendor:${widget.vendorModel.imgPath}");
    return Scaffold(
      key: checkoutKey,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('${widget.vendorModel.name}',
                                style: TextStyle(fontSize: 17)),
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
                        ...getProductsWidgets(),
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
                            child: CalenderDialog(
                                selectedDate, widget.vendorModel, this)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Container(
                            //   width: 150,
                            //   height: 50,
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         'الوقت',
                            //         style:
                            //             TextStyle(color: MyColor.customColor),
                            //       ),
                            //       SizedBox(
                            //         width: 15,
                            //       ),
                            //       Expanded(
                            //         child: CustomButton(
                            //           backgroundColor: MyColor.whiteColor,
                            //           btnPressed: () {
                            //             DatePicker.showTime12hPicker(context,
                            //                 onConfirm: (dt) {
                            //               final f =
                            //                   new intl.DateFormat().add_jm();
                            //               String s = f.format(dt).split(" ")[0];
                            //               print(s);
                            //               selectedTime = s;
                            //               setState(() {});
                            //             });
                            //           },
                            //           textColor: MyColor.customColor,
                            //           txt: (selectedTime == null)
                            //               ? new intl.DateFormat()
                            //                   .add_jm()
                            //                   .format(DateTime.now())
                            //                   .split(" ")[0]
                            //               : selectedTime,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            Card(
                              color: MyColor.customColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ToggleSwitch(
                                  cornerRadius: 20.0,
                                  activeBgColor: Colors.white,
                                  activeFgColor: MyColor.customColor,
                                  inactiveBgColor: MyColor.customColor,
                                  inactiveFgColor: Colors.white,
                                  labels: ['AM', 'PM'],
                                  onToggle: (index) {
                                    print('switched to: $index');
                                    if (index == 0) {
                                      timePeroid = "AM";
                                    } else {
                                      timePeroid = "PM";
                                    }
                                    print(timePeroid);
                                    // setState(() {});
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: MyColor.customColor,
                  padding: EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: RaisedButton(
                          onPressed: () async {
                            // print("dATE:" + selectedDate);
                            if (selectedDate == null) {
                              showSnackbarError(
                                  scaffoldKey: checkoutKey,
                                  msg: 'قم بتحديد التاريخ');
                              return;
                            }
                            // if (selectedTime == null) {
                            //   showSnackbarError(
                            //       scaffoldKey: checkoutKey,
                            //       msg: 'قم بتحديد الوقت');
                            //   return;
                            // }

                            print("SecondTotalPrice:$total");
                            reservationModel = ReservationModel(
                                clientID: FirebaseAuth.instance.currentUser.uid,
                                notes: "",
                                paymentMethod: "",
                                vendorImgPath: widget.vendorModel.imgPath,
                                selectedDate: selectedDate,
                                selectedTime: selectedTime + " " + timePeroid,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Payment3()));
                            }).catchError((e) {
                              dismissDialog(context);
                              showSnackbarError(
                                  msg: 'حدث حطأ في ارسال الطلب حاول مرة اخرى',
                                  scaffoldKey: checkoutKey);
                              print("ErrorInsertReserv:$e");
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          textColor: MyColor.customColor,
                          child: Text('احجز الأن'),
                        ),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$total ريال',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
