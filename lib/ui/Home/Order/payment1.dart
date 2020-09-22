import 'package:flutter/material.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/ui/Home/Order/payment2.dart';
import 'package:qutub_clinet/ui/colors.dart';

class Payment1 extends StatelessWidget {
  ReservationModel reservationModel;
  Payment1({this.reservationModel});
  List<Widget> getProductsWidgets({String type}) {
    List<Widget> productsWidgets = [];

    //  print("LenPrice:${widget.model.priceList.length}");
    for (int i = 0; i < reservationModel.selectedItems.length; i++) {
      productsWidgets.add(Text(
        (type == "name")
            ? reservationModel.selectedItems.keys.elementAt(i)
            : (type == "date")
                ? reservationModel.selectedDate
                : reservationModel.selectedItems.values.elementAt(i),
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ));
    }
    return productsWidgets;
  }

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
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'طريقة الدفع ',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'اختر احد طرق الدفع التالية',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Color.fromRGBO(43, 188, 177, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            leading: Image.asset(
                              'assets/credit-card.png',
                              scale: 12,
                            ),
                            title: Text(
                              'الدفع بالبطاقة الائتمانية',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text('ادفع باستخدام MasterCard أو Visa'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            leading: Image.asset(
                              'assets/maddy.png',
                              scale: 12,
                            ),
                            title: Text(
                              'الدفع ببطاقة مدى',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text('ادفع مباشرة من حسابك المصرفي'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            leading: Image.asset(
                              'assets/apple-pay.png',
                              scale: 12,
                            ),
                            title: Text(
                              'الدفع باستخدام Apple pay ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text('ادفع مباشرة باستخدام apple pay'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                'تفاصيل الطلب',
                                style: TextStyle(
                                    fontSize: 16, color: MyColor.customColor),
                              ),
                            ],
                          ),
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
                                        fontSize: 16,
                                        color: MyColor.customColor),
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
                                      'الوقت',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.customColor),
                                    ),
                                    ...getProductsWidgets(type: "date")
                                  ],
                                )),

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
                                          fontSize: 16,
                                          color: MyColor.customColor),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('المجموع'),
                              Text(
                                '${reservationModel.totalPrice} SAR',
                                style: TextStyle(
                                    color: Color.fromRGBO(43, 188, 177, 1)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 120,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: MyColor.customColor,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => Payment2()));
                      },
                      child: Text('التالي'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
