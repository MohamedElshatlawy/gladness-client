import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/favourite.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/ui/Home/Product/productDetails.dart';

import '../../colors.dart';

class FavouriteProductItem extends StatelessWidget {
  ProductModel productModel;
  FavouriteProductItem({this.productModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ProductDetails(productModel)));
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Opacity(
                        opacity: .5,
                        child: Image.network("",
                       //   productModel.imgPaths[0],
                          fit: BoxFit.contain,
                        ),
                      )),
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
                  //productModel.name,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: MyColor.customColor),
                ),
              ),
              InkWell(
                  onTap: () {
                    removeProductFavourite(productModel);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
