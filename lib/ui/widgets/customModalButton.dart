import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/cart.dart';
import 'package:qutub_clinet/Providers/cartItemsCounterProvider.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/ui/colors.dart';

class CustomModal extends StatefulWidget {
  ProductModel model;
  var parentCtx;
  CustomModal(this.model, this.parentCtx);

  @override
  _CustomModalState createState() => _CustomModalState();
}

int productQuantity = 1;

class _CustomModalState extends State<CustomModal> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   productQuantity = 1;
  }

  var added;
  @override
  Widget build(BuildContext context) {
    var cartCounterProvider = Provider.of<CartCounterProvider>(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'اختر الكمية',
              style: TextStyle(color: MyColor.customColor, fontSize: 17),
            ),
            Divider(
              indent: 10,
            ),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (productQuantity != 1) {
                          setState(() {
                            productQuantity--;
                          });
                        }
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$productQuantity',
                      style:
                          TextStyle(fontSize: 20, color: MyColor.customColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          productQuantity++;
                        });
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.red[800],
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: RaisedButton(
                    onPressed: () async {
                      addProductToCart(
                              widget.model, productQuantity, widget.parentCtx)
                          .then((value) {
                        cartCounterProvider.getCount();
                      });

                      Navigator.pop(context);
                     
                    },
                    color: MyColor.whiteColor,
                    textColor: MyColor.customColor,
                    child: Text('تأكيد'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
