import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/API/reservation.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/ui/Home/Order/calender_order_details.dart';
import 'package:qutub_clinet/ui/Home/Order/payment1.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';

class NewOrderDetails extends StatefulWidget {
  ReservationModel reservationModel;
  NewOrderDetails({this.reservationModel});

  @override
  _NewOrderDetailsState createState() => _NewOrderDetailsState();
}

class _NewOrderDetailsState extends State<NewOrderDetails> {
  List<Widget> getProductsWidgets({String type}) {
    List<Widget> productsWidgets = [];

    //  print("LenPrice:${widget.model.priceList.length}");
    for (int i = 0; i < widget.reservationModel.selectedItems.length; i++) {
      productsWidgets.add(
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: MyColor.customColor,
              borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(
              widget.reservationModel.selectedItems.keys.elementAt(i),
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              widget.reservationModel.selectedItems.values.elementAt(i) +
                  " ريال",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    return productsWidgets;
  }

  var myKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.custGrey2,
      key: myKey,
      appBar: AppBar(
        title: Text(
          'تفاصيل الحجز',
          style: TextStyle(color: MyColor.customColor),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColor.customColor,
            ),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: MyColor.whiteColor,
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
                            Text('${widget.reservationModel.vendorName}',
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
                            child: CalenderOrderDetails(
                                widget.reservationModel.selectedDate)),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: MyColor.customColor,
                          child: ListTile(
                            leading: Text(
                              'الوقت',
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(widget.reservationModel.selectedTime,
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        (widget.reservationModel.status == "confirm")
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text('الدفع', style: TextStyle()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    color: MyColor.customColor,
                                    child: ListTile(
                                      title: Text(
                                        'بطاقة مدي',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        '8888 3333 **** ****',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                (widget.reservationModel.status == "cancel")
                    ? Container()
                    : (widget.reservationModel.status == "sent")
                        ? CustomButton(
                            backgroundColor: Colors.red[800],
                            btnPressed: () async {
                              //cancel reservation
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (ctx) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          content: Text('هل تريد الغاء الحجز؟',
                                              style: TextStyle(
                                                  color: MyColor.customColor)),
                                          actions: [
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              onPressed: () {
                                                dismissDialog(context);
                                              },
                                              child: Text(
                                                'لا',
                                                style: TextStyle(),
                                              ),
                                              color: MyColor.customColor,
                                              textColor: MyColor.whiteColor,
                                            ),
                                            OutlineButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              borderSide: BorderSide(
                                                  color: MyColor.customColor),
                                              onPressed: () async {
                                                dismissDialog(context);
                                                showMyDialog(
                                                    context: context,
                                                    msg: 'جاري الغاء الحجز');
                                                await cancelReservation(
                                                        model: widget
                                                            .reservationModel)
                                                    .then((value) {
                                                  dismissDialog(context);
                                                  sendDashboardNotificationReject();
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .check_circle,
                                                                      color: Color.fromRGBO(
                                                                          43,
                                                                          188,
                                                                          177,
                                                                          1),
                                                                      size: 80,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'تم الغاء الحجز بنجاح',
                                                                      style: TextStyle(
                                                                          color:
                                                                              MyColor.customColor),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    RaisedButton(
                                                                      onPressed:
                                                                          () {
                                                                        dismissDialog(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      color: MyColor
                                                                          .customColor,
                                                                      child: Text(
                                                                          'العودة'),
                                                                    )
                                                                  ],
                                                                ),
                                                              ));
                                                }).catchError((e) {
                                                  dismissDialog(context);
                                                  showSnackbarError(
                                                      scaffoldKey: myKey,
                                                      msg:
                                                          'حدث خطأ اثناء الألغاء .. حاول مرة اخرى');
                                                });
                                              },
                                              child: Text(
                                                'نعم',
                                                style: TextStyle(
                                                    color: MyColor.customColor),
                                              ),
                                              color: MyColor.whiteColor,
                                            )
                                          ],
                                        ),
                                      ));
                            },
                            textColor: Colors.white,
                            txt: 'الغاء الحجز',
                          )
                        : Container(
                            color: MyColor.customColor,
                            padding: EdgeInsets.all(6),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => Payment1(
                                                    reservationModel:
                                                        widget.reservationModel,
                                                  )));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Colors.white,
                                    textColor: MyColor.customColor,
                                    child: Text('ادفع الأن'),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${widget.reservationModel.totalPrice} ريال',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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

  Future<dynamic> sendDashboardNotificationReject() async {
    await FirebaseFirestore.instance
        .collection(MyCollections.dashBoardUsers)
        .get()
        .then((value) async {
      Future.forEach(value.docs, (element) async {
        if (element.data()['fcm_token'] != null) {
          print('Token:${element.data()['fcm_token']}');
          await sendToAllClients(element.data()['fcm_token'], 'حجز ملغي');
        }
      });
    });
  }
}
