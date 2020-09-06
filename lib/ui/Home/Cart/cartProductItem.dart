import 'package:flutter/material.dart';

import 'package:qutub_clinet/API/cart.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/ui/Home/Product/productDetails.dart';

import '../../colors.dart';


class CartProductItem extends StatelessWidget {
  ProductModel productModel;
CartProductItem({this.productModel});
  @override
  Widget build(BuildContext context) {
      return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (ctx)=>ProductDetails(productModel)));
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Opacity(
                    opacity: .5,
                                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network("",
                         // productModel.imgPaths[0],
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text("",
               //   productModel.name,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: MyColor.customColor),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Text('ريال',
                      style: TextStyle(
                          color: Colors.red[800], fontWeight: FontWeight.w600)),
                  SizedBox(
                    width: 5,
                  ),
                  Text("",
                   // '${int.parse(productModel.price)*productModel.quaintity}',
                    style: TextStyle(
                        color: Colors.red[800], fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          )

          ,SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           textDirection: TextDirection.ltr,
            children: <Widget>[
            Row(
              textDirection: TextDirection.ltr,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    // if(productModel.quaintity==1){
                    //   deleteProductFromCart(
                    //      productModel.id,
                    //      context
                    //   );
                    // }else{
                    //   decrementProductCart(
                    //     productID: productModel.id
                    //   );
                    // }
                  },
                  child: Icon(Icons.remove_circle,color: Colors.grey,size: 25,)),
                SizedBox(width: 8,),
                Text(
                  "",
               //   productModel.quaintity.toString(),
                  style: TextStyle(
                  fontSize: 18,
                  color: MyColor.customColor
                ),),
                SizedBox(width: 8,),
              InkWell(
                onTap: (){
                  addProductToCart(
                     productModel,
                 1,
                    context
                  );
                },
                child: Icon(Icons.add_circle,color: Colors.red[800],size: 25,)),
                
              ],
            ),

            RaisedButton(onPressed: (){
               deleteProductFromCart(
                       productModel.id,
                       context
                      );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.red[800]
              )
            ),
            color:Colors.transparent,
            elevation: 0,
            textColor: Colors.red[800],
            child: Text('حذف'),
            )

            ],
          )
        ],
      ),
    );
  
  }
}