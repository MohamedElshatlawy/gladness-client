import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/API/order.dart';
import 'package:qutub_clinet/API/reservation.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/common.dart';
import 'package:qutub_clinet/models/orderModel.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';

class OrderDetails extends StatefulWidget {
  ReservationModel orderModel;
  OrderDetails({this.orderModel});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<ProductModel> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mappingProducts();
  }

  void mappingProducts() async {
    // widget.orderModel.productsQuantity.forEach((key, v) async {
    //   await getProductDetails(key).then((value) {
    //     if (value is ProductModel) {
    //       value.quaintity = v;
    //       products.add(value);
    //       setState(() {});
    //     }
    //   });
    // });
  }
  List<Widget> getProductsWidgets({String type}) {
    List<Widget> productsWidgets = [];

    //  print("LenPrice:${widget.model.priceList.length}");
    for (int i = 0; i < widget.orderModel.selectedItems.length; i++) {
      productsWidgets.add(Text(
        (type == "name")
            ? widget.orderModel.selectedItems.keys.elementAt(i)
            : widget.orderModel.selectedItems.values.elementAt(i),
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ));
    }
    return productsWidgets;
  }

  var myKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myKey,
      backgroundColor: MyColor.customGreyColor,
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
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   'عنوان التوصيل',
                //   style: TextStyle(fontSize: 16, color: MyColor.customColor),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Icon(
                //         Icons.location_on,
                //         color: Colors.grey,
                //         size: 25,
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Expanded(
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //              " widget.orderModel.address",
                //               style: TextStyle(fontSize: 14),
                //             ),
                //             Text(
                //               "widget.orderModel.phone",
                //               style:
                //                   TextStyle(fontSize: 14, color: Colors.grey),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       RaisedButton(
                //         onPressed: () {},
                //         color:
                //            MyColor.customColor,
                //         textColor: MyColor.whiteColor,
                //         child: Text("تم الطلب"
                //             ),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadiusDirectional.circular(8)),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Divider(),
                // SizedBox(
                //   height: 10,
                // ),
                Text(
                  'تفاصيل الطلب',
                  style: TextStyle(fontSize: 16, color: MyColor.customColor),
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
                    // Expanded(
                    //     flex: 1,
                    //     child: Column(
                    //       children: <Widget>[
                    //         Text(
                    //           'الكمية',
                    //           style: TextStyle(
                    //               fontSize: 16, color: MyColor.customColor),
                    //         ),
                    //         ...getProductsWidgets(type: "quantity")
                    //       ],
                    //     )),

                    /* Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'سعر القطعة',
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.customColor),
                            ),
                            Text(
                              '20',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            Text(
                              '20',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            )
                          ],
                        )),
                 
                 */
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'التكلفة',
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.customColor),
                            ),
                            ...getProductsWidgets(type: "total")
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'ملاحظات',
                  style: TextStyle(fontSize: 16, color: MyColor.customColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  (widget.orderModel.notes.isEmpty)
                      ? 'لايوجد ملاحظات'
                      : widget.orderModel.notes,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'طرق الدفع',
                  style: TextStyle(fontSize: 16, color: MyColor.customColor),
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
                      'التكلفة',
                      style:
                          TextStyle(fontSize: 16, color: MyColor.customColor),
                    ),
                    Text(
                      '${widget.orderModel.totalPrice} ريال',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
                // Text(
                //   'يشمل ضريبة القيمة المضافة',
                //   style: TextStyle(fontSize: 14, color: Colors.grey),
                // ),

                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       'كوبون الخصم',
                //       style:
                //           TextStyle(fontSize: 16, color: MyColor.customColor),
                //     ),
                //     Text(
                //      "coupon",
                //       style: TextStyle(fontSize: 16, color: Colors.grey),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),

                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  backgroundColor: MyColor.customColor,
                  btnPressed: () {},
                  textColor: Colors.white,
                  txt: ' تاريخ الحجز  ${widget.orderModel.selectedDate}',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  backgroundColor: MyColor.customColor,
                  btnPressed: () {},
                  textColor: Colors.white,
                  txt: ' موعد الحجز  ${widget.orderModel.selectedTime}',
                ),
                SizedBox(
                  height: 10,
                ),
                (widget.orderModel.status == "cancel")
                    ? Container()
                    : CustomButton(
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
                                                    model: widget.orderModel)
                                                .then((value) {
                                              dismissDialog(context);
                                              sendDashboardNotificationReject();
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (ctx) => AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      43,
                                                                      188,
                                                                      177,
                                                                      1),
                                                              size: 80,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'تم الغاء الحجز بنجاح',
                                                              style: TextStyle(
                                                                  color: MyColor
                                                                      .customColor),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            RaisedButton(
                                                              onPressed: () {
                                                                dismissDialog(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              textColor:
                                                                  Colors.white,
                                                              color: MyColor
                                                                  .customColor,
                                                              child: Text(
                                                                  'العودة'),
                                                            )
                                                          ],
                                                        ),
                                                      ));
                                              // Fluttertoast.showToast(
                                              //     msg: "تم الغاء الحجز بنجاح",
                                              //     toastLength:
                                              //         Toast.LENGTH_SHORT,
                                              //     gravity: ToastGravity.CENTER,
                                              //     timeInSecForIosWeb: 1,
                                              //     backgroundColor:
                                              //         Colors.green[600],
                                              //     textColor: Colors.white,
                                              //     fontSize: 16.0);
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
                // (widget.orderModel.status==Common.rejectedStatus)?
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     Text('سبب الغاء الطلب',style: TextStyle(
                //       color: Colors.red[800]
                //     ),),
                //     SizedBox(
                //   height: 10,
                // ),
                // // Text('${widget.orderModel.reasonOfReject}',style: TextStyle(
                // //       color: Colors.grey
                // //     ),),

                //   ],
                // ):Container()

                /*(widget.orderModel.deliveryCost != null &&
                        widget.orderModel.orderStatus == Common.acceptedStatus)
                    ? CustomButton(
                        backgroundColor: MyColor.customColor,
                        btnPressed: () {
                          confirmOrder(widget.orderModel.id);

                          Navigator.pop(context);
                        },
                        textColor: MyColor.whiteColor,
                        txt: 'تأكيد',
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),*/
              ],
            ),
          ),
        ),
      ),
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
