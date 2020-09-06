import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/API/cart.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/ui/Home/Cart/checkout.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/setupGridItemSize.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import 'Cart/cartProductItem.dart';

class CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gridItem = GridItemSize(context, 305);
    var userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(MyCollections.userCollection)
          .doc(userProvider.userModel.userToken)
          .collection(MyCollections.cart)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapSHot) {
        if (snapSHot.hasError) return new Text('خطأ: ${snapSHot.error}');
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
            return (snapSHot.data.docs.isEmpty)
                ? Center(
                    child: Text('لا يوجد منتجات'),
                  )
                : Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: gridItem.aspectRatio),
                              itemCount: snapSHot.data.docs.length,
                              itemBuilder: (ctx, index) {
                                var model = ProductModel.fromJson(
                                    id: snapSHot
                                        .data.docs[index].id,
                                    json: snapSHot.data.docs[index].data());
                                return CartProductItem(
                                  productModel: model,
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: CustomButton(
                            backgroundColor: Colors.green[600],
                            textColor: MyColor.whiteColor,
                            btnPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Checkout()));
                            },
                            txt: 'تنفيذ الطلب',
                          ),
                        ),
                          SizedBox(
                          height: 10,
                        ),
                          Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: CustomButton(
                            backgroundColor: Colors.red[800],
                            textColor: MyColor.whiteColor,
                            btnPressed: () {
                              showDialog(context: context,
                              builder: (ctx)=>Directionality(textDirection: TextDirection.rtl,
                               child:AlertDialog(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10)
                                 ),
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                     Row(
                                       children: <Widget>[
                                         Text('هل تريد حذف جميع المشتريات ؟'),
                                       ],
                                     ),
                                       SizedBox(height: 30,),
                                     Row(textDirection: TextDirection.ltr,
                                     children: <Widget>[
                                       RaisedButton(onPressed: (){
                                      clearCart(ctx);
                                      dismissDialog(ctx);

                                       },
                                       textColor: Colors.green[600],
                                       child: Text('نعم'),
                                       ),
                                       SizedBox(width: 10,),
                                        RaisedButton(onPressed: (){
                                         dismissDialog(ctx);

                                       },
                                       textColor: Colors.red[800],
                                       child: Text('رجوع'),
                                       )
                                     ],
                                     )
                                   ],
                                 ),
                               ))
                              );
                            //  clearCart(context);
                            },
                            txt: 'حذف المشتريات',
                          ),
                        ),
                 
                      ],
                    ),
                  );
        }
        return Container();
      },
    );
  
  }
}
