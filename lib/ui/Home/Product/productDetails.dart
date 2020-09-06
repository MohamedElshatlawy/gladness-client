import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qutub_clinet/API/favourite.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customModalButton.dart';

import '../../colors.dart';

class ProductDetails extends StatefulWidget {
  ProductModel productModel;
  ProductDetails(this.productModel);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

PageController controller;
int myPosition = 0;

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: myPosition);
    foundProductFavourite(widget.productModel.id).then((value) {
      if (value is bool) {
        setState(() {
          favourite = value;
        });
      }
    });
  }

  bool favourite = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myPosition = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4 + 20,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(120),
                      )),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      PageView.builder(
                        onPageChanged: (v) {
                          setState(() {
                            myPosition = v;
                          });
                        },
                        itemCount: 3,//widget.productModel.imgPaths.length,
                        controller: controller,
                        itemBuilder: (ctx, index) {
                          return Opacity(
                            opacity: .8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(120),
                              ),
                              child: Image.network("",
                               // widget.productModel.imgPaths[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 15, top: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              textDirection: TextDirection.ltr,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Text("",
                           // widget.productModel.name,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 15, bottom: 15),
                          child: InkWell(
                            onTap: () {
                              if (favourite == false) {
                                addProductToFavourite(widget.productModel);
                                setState(() {
                                  favourite = true;
                                });
                              } else {
                                removeProductFavourite(widget.productModel);
                                setState(() {
                                  favourite = false;
                                });
                              }
                            },
                            child: Icon(
                              (favourite == false)
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              size: 25,
                              color: MyColor.whiteColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                DotsIndicator(
                  dotsCount: 3,//widget.productModel.imgPaths.length,
                  position: double.parse(myPosition.toString()),
                  decorator: DotsDecorator(activeColor: MyColor.customColor),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'تفاصيل المنتج',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 20, color: MyColor.customColor),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            decoration: BoxDecoration(
                                color: Colors.red[800],
                                borderRadius:
                                    BorderRadiusDirectional.circular(8)),
                            child: Row(
                              textDirection: TextDirection.ltr,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('ريال',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("",
                                  //widget.productModel.price,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text("",
                           //   widget.productModel.description,
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: CustomButton(
                    backgroundColor: MyColor.customColor,
                    textColor: MyColor.whiteColor,
                    btnPressed: () {
                    
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        builder: (context) => CustomModal(
                           widget.productModel,
                           context
                        )
                    
                     );
                    },
                    txt: 'اضف الى المشتريات',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


