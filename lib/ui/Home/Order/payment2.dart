import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:qutub_clinet/ui/Home/Order/payment3.dart';

import '../../colors.dart';

class Payment2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.custGrey2,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'الدفع',
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'تفاصيل الدفع ',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: MyColor.customColor,
                      ),
                      Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        color: MyColor.customColor,
                      )),
                      Icon(
                        Icons.credit_card,
                        color: MyColor.customColor,
                      ),
                      Expanded(
                          child: Divider(
                              indent: 10, endIndent: 10, color: Colors.grey)),
                      Icon(
                        Icons.check,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CreditCardWidget(
                    cardNumber: "4078 1234 5634 9012",
                    expiryDate: "10 / 21",
                    cardHolderName: "Mohamed Ali",
                    cvvCode: "987",
                    showBackView:
                        false, //true when you want to show cvv(back) view
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_box,
                            color: MyColor.customColor,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('حفظ هذه البطاقة للمدفوعات المستقبلية؟')
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        width: 140,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: MyColor.customColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => Payment3()));
                          },
                          child: Text('التالي'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
