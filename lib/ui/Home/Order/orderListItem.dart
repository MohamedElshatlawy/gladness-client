import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qutub_clinet/common.dart';
import 'package:qutub_clinet/models/orderModel.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/ui/Home/Order/orderDetails.dart';

import '../../colors.dart';
import 'new_order_details.dart';

class OrderListItem extends StatelessWidget {
  int index;
  ReservationModel orderModel;
  OrderListItem({this.index, this.orderModel});
  @override
  Widget build(BuildContext context) {
    //getAsciiID();
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => NewOrderDetails(
                      reservationModel: orderModel,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColor.whiteColor,
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'اسم التاجر : ${orderModel.vendorName}',
                        style: TextStyle(color: MyColor.customColor),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => NewOrderDetails(
                                        reservationModel: orderModel,
                                      )));
                        },
                        color: (orderModel.status == "cancel")
                            ? MyColor.custGrey2
                            : (orderModel.status == "sent")
                                ? MyColor.customColor
                                : Color.fromRGBO(43, 188, 177, 1),
                        textColor: (orderModel.status == "cancel")
                            ? MyColor.customColor
                            : MyColor.whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text('التفاصيل'),
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: (orderModel.vendorImgPath != null)
                    ? Container(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            orderModel.vendorImgPath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: (orderModel.status == "cancel")
                              ? MyColor.custGrey2
                              : (orderModel.status == "sent")
                                  ? MyColor.customColor
                                  : Color.fromRGBO(43, 188, 177, 1),
                        ),
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              (orderModel.status == "cancel")
                                  ? "تم الإلغاء"
                                  : (orderModel.status == "confirm")
                                      ? 'تم التأكيد'
                                      : "تم الطلب",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: (orderModel.status == "cancel")
                                      ? MyColor.customColor
                                      : MyColor.whiteColor),
                            ),
                            Divider(
                              color: (orderModel.status == "cancel")
                                  ? MyColor.customColor
                                  : MyColor.whiteColor,
                              endIndent: 10,
                              indent: 10,
                            ),
                            Text(
                              '${orderModel.totalPrice}',
                              style: TextStyle(
                                  color: (orderModel.status == "cancel")
                                      ? MyColor.customColor
                                      : MyColor.whiteColor),
                            ),
                            Text(
                              'ريال',
                              style: TextStyle(
                                  color: (orderModel.status == "cancel")
                                      ? MyColor.customColor
                                      : MyColor.whiteColor),
                            )
                          ],
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
