import 'package:flutter/material.dart';
import 'package:qutub_clinet/common.dart';
import 'package:qutub_clinet/models/orderModel.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/ui/Home/Order/orderDetails.dart';

import '../../colors.dart';

class OrderListItem extends StatelessWidget {
  int index;
  ReservationModel orderModel;
  OrderListItem({this.index, this.orderModel});
  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        Navigator.push(
            context, 
            MaterialPageRoute(
                builder: (ctx) => OrderDetails(
                      orderModel: orderModel,
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
                child: Container(
                 
              padding: EdgeInsets.all(10),
           
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'طلب رقم # $index',
                    style: TextStyle(color: MyColor.customColor),
                  ),
                 
                ],
              ),
            )),
            Container(
               decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                       color:  (orderModel.status=="cancel")?Colors.red[800]: MyColor.customColor,
                  ),
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width / 4,
            
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    (orderModel.status=="cancel")?"تم الإلغاء":
                    "تم الطلب",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MyColor.whiteColor),
                  ),
                  Divider(
                    color: MyColor.whiteColor,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Text(
                    '${orderModel.totalPrice}',
                    style: TextStyle(color: MyColor.whiteColor),
                  ),
                  Text(
                    'ريال',
                    style: TextStyle(color: MyColor.whiteColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
