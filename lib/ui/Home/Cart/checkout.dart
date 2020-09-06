import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/cart.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/common.dart';
import 'package:qutub_clinet/models/addressModel.dart';
import 'package:qutub_clinet/models/couponModel.dart';
import 'package:qutub_clinet/models/extralVatModel.dart';
import 'package:qutub_clinet/models/orderModel.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/ui/Drawer/address/addAddress.dart';
import 'package:qutub_clinet/ui/Drawer/address/addresses.dart';
import 'package:qutub_clinet/ui/Drawer/address/selectedAddress.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  AddressModel addressModel;
  List<ProductModel> products = [];
  ExtraVatModel vatModel;
  CouponModel couponModel;

  var noteController = TextEditingController();
  var couponController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyAddress();
    ///////////////////////////////////////////

    //////////////////////////////////////////
    getCartProducts().then((value) async {
      // if (value is List<ProductModel>) {
      //   products.addAll(value);
      //   await getExtraVat().then((value) {
      //     vatModel = value;
      //     vatModel??=ExtraVatModel(
      //       txt: "0"
      //     );
      //     int t1 = 0;
      //     products.forEach((element) {
      //       t1 += (element.quaintity * (int.parse(element.price)));
      //     });
      //     double v1 = (double.parse(vatModel.txt) * t1) / 100;
      //     vatValue = v1;

      //     setState(() {});
      //   });
      //   setState(() {});
      // }
    });
  }

  getMyAddress() {
    getDefaultAddress().then((value) {
      if (value is AddressModel) {
        setState(() {
          addressModel = value;
        });
      }
    });
  }

  int total = 0;
  double completeTotal=0;

  double vatValue = 0.0;
  List<Widget> getProductsWidgets({String type}) {
    List<Widget> productsWidgets = [];
    total = 0;
    // products.forEach((element) {
    //   if (type == "total") {
    //     total += (element.quaintity * (int.parse(element.price)));
    //   }
    //   productsWidgets.add(Text(
    //     (type == "name")
    //         ? element.name
    //         : (type == "quantity")
    //             ? "${element.quaintity}X ${element.price}"
    //             : (element.quaintity * (int.parse(element.price))).toString(),
    //     textAlign: TextAlign.right,
    //     style: TextStyle(color: Colors.grey, fontSize: 14),
    //   ));
    // });
    return productsWidgets;
 
 
 }

  var checkoutKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      key: checkoutKey,
      appBar: AppBar(
        title: Text('تنفيذ الطلب'),
        centerTitle: true,
        backgroundColor: MyColor.customColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'عنوان التوصيل',
                  style: TextStyle(fontSize: 16, color: MyColor.customColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              (addressModel == null)
                                  ? ''
                                  : addressModel.address,
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              (addressModel == null) ? '' : addressModel.phone,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => MyAddresses()));
                          getMyAddress();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.red[800])),
                        color: Colors.transparent,
                        elevation: 0,
                        textColor: Colors.red[800],
                        child: Text('تغيير'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
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
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'الكمية',
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.customColor),
                            ),
                            ...getProductsWidgets(type: "quantity")
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
                              'الأجمالي',
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
                  'اضف ملاحظات',
                  style: TextStyle(fontSize: 16, color: MyColor.customColor),
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
                Text(
                  'كوبون الخصم',
                  style: TextStyle(fontSize: 16, color: MyColor.customColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: CustomTextField(
                      labelColor: Colors.grey,
                      controller: couponController,
                      txtColor: MyColor.customColor,
                      txtLablel: 'الكوبون',
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      child: RaisedButton(
                        onPressed: () {
                          if (couponController.text.isNotEmpty) {
                            checkPromoCode(code: couponController.text)
                                .then((value) {
                              if (value == false) {
                                couponModel=null;
                                showSnackbarError(
                                    msg: 'كوبون خصم غير صحيح',
                                    scaffoldKey: checkoutKey);
                              }else{
                                couponModel=value;
                                
                              }
                              setState(() {
                                  
                                });
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.green[600])),
                        color: Colors.transparent,
                        elevation: 0,
                        textColor: Colors.green[600],
                        child: Text('تفعيل'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
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
                      '${total + vatValue} ريال',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                (vatModel == null)
                    ? Container()
                    : Text(
                        'يشمل ضريبة القيمة المضافة  (%${vatModel.txt})',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      ' رسوم التوصيل يتم تحديدها من خلال التاجر',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                (couponModel==null)?Container():
                     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'قيمة الخصم',
                      style:
                          TextStyle(fontSize: 16, color:Colors.red[800]),
                    ),
                    Text(
                      '${couponModel.discountValue} ريال',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
           
                SizedBox(
                  height: 10,
                ),

             (couponModel==null)?Container():   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'التكلفة الكلية',
                      style:
                          TextStyle(fontSize: 16, color: MyColor.customColor),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red[800])),
                      child: Text(
                        '${total- int.parse(couponModel.discountValue)} ريال',
                        style: TextStyle(color: Colors.red[800], fontSize: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  backgroundColor: Colors.green[600],
                  textColor: MyColor.whiteColor,
                  btnPressed: () async {
                    if(addressModel==null){
                      showSnackbarError(
                        msg: 'قم بتحديد عنوان التوصيل',
                        scaffoldKey: checkoutKey
                      );
                      return;
                    }
                    int compeletTotal=0;
                    if(couponModel==null){
                      completeTotal=(total+vatValue);
                    }else{
                      completeTotal=(total-int.parse(couponModel.discountValue))+vatValue;
                    }
                      Map<String,dynamic> prodMap={};
                      products.forEach((element) { 
                      //  prodMap[element.id]=element.quaintity;
                      });
                      //GetDate
                      int timeStamp = DateTime.now().millisecondsSinceEpoch;
                    OrderModel orderModel=OrderModel(
                      userID: userProvider.userModel.userToken,
                      address: addressModel.address,
                      phone: addressModel.phone,
                      notes: noteController.text,
                      coupon: (couponModel==null)?null:couponModel.coupon,
                      couponValue: (couponModel==null)?null:couponModel.discountValue,
                      deliveryCost: null,
                      paymentType: 'cash',
                      total: (total+vatValue).toString(),
                      totalCost: completeTotal.toString(),
                      orderStatus: Common.reviewStatus,
                      productsQuantity: prodMap,
                      timeStamp: timeStamp
                    );
                    showMyDialog(
                      context: context,
                      msg: 'جاري ارسال الطلب'
                    );
                    await sendOrder(orderModel);
                    await clearCart(context);
                    dismissDialog(context);
                    showSnackbarError(
                      msg: 'تم ارسال الطلب بنجاح',
                      scaffoldKey: checkoutKey
                    );
                    Future.delayed(Duration(seconds: 3),
                    (){
                      Navigator.pop(context);
                    }
                    );
                  },
                  txt: 'تنفيذ الطلب',
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
 
    );
  }
}
