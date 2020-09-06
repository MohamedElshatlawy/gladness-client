import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/Home/Product/reservation_list_item.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';
import 'checkout_reservation.dart';

class Reservation extends StatefulWidget {
  VendorModel vendorModel;
  
  Reservation(this.vendorModel);
  @override
  _PriceListViewState createState() => _PriceListViewState();
}

class _PriceListViewState extends State<Reservation> {
  ProductModel productModel;
  Map<int,bool> selectedPriceList = {};
  var resev_key=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      key: resev_key,
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
          "احجز الأن",
          style: TextStyle(color: MyColor.customColor),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            margin: EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(MyCollections.products)
                  .where("vendorID", isEqualTo: widget.vendorModel.id)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapSHot) {
                if (snapSHot.hasError)
                  return new Text('خطأ: ${snapSHot.error}');
                switch (snapSHot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  case ConnectionState.none:
                    return Center(
                      child: Text('لايوجد اتصال بالأنترنت'),
                    );
                  case ConnectionState.active:

                  case ConnectionState.done:
                    print(
                        "Len:${snapSHot.data.docs[0].data()['priceList'].length}");
                    return (snapSHot.data.docs.isEmpty)
                        ? Center(
                            child: Text('لا يوجد قائمة اسعار'),
                          )
                        : Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                    itemCount: snapSHot.data.docs[0]
                                        .data()['priceList']
                                        .length,
                                    itemBuilder: (ctx, index) {
                                      productModel = ProductModel.fromJson(
                                          id: snapSHot.data.docs[0].id,
                                          json: snapSHot.data.docs[0].data());
                                      selectedPriceList[index]=false;
 
                                      return ReservationListItem(
                                          productModel, selectedPriceList, index);
                                    }),
                              ),
                              SizedBox(height: 10,),
                              CustomButton(
                                backgroundColor: MyColor.customColor,
                                textColor: Colors.white,
                                txt: 'تنفيذ الطلب',
                                btnPressed: (){
                                  int c=0;
                                  selectedPriceList.forEach((key, value) { 
                                    if(value==true)
                                    c++;
                                  });
                                  if(c!=0){
                                    print(selectedPriceList);
                                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CheckoutReservation(
                                             selectedPriceList,
                                             productModel,
                                             widget.vendorModel
                                            
                                           )));
                            
                                  }else{
                                    showSnackbarError(
                                      msg: 'قم بأختيار منتج من قائمة الأسعار',
                                      scaffoldKey: resev_key
                                    );
                                  }
                               },
                              )
                            ],
                          );
                }
                return Container();
              },
            )),
      ),
    );
  }

}
