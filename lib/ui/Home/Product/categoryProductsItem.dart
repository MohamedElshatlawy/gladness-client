import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qutub_clinet/API/products.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/ui/Home/Product/productDetails.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customModalButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';


class CategoryProductItem extends StatelessWidget {
  ProductModel productModel;
  int index;
  CategoryProductItem({this.productModel, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: InkWell(
        onTap: (){
          showDialog(context: context,
          builder: (ctx)=>AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(15),
            contentPadding: EdgeInsets.all(0),
            content: Column(
              children: [
                Expanded(
                                    child: Image.network(productModel.galleryPaths[index],
              width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: RaisedButton(onPressed: (){
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  textColor: Colors.red[800],
                  child: Text('رجوع'),
                  ),
                )
               ,  SizedBox(height: 10,),
              ],
            ),
          )
          );
        },
       child: Container(
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:  CachedNetworkImage(
                      imageUrl: productModel.galleryPaths[index],
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                             ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Container(
                            width: 100,
                            height: 100,
                            child: Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  
                  ),
              //   Align(
              //     alignment: Alignment.centerLeft,
              //     child: RotatedBox(
              //       quarterTurns: -1,
              //       child: Container(
              //         width: 90,
              //         height: 30,
              //         decoration: BoxDecoration(
              //             color: Colors.red[800],
              //             borderRadius: BorderRadius.only(
              //                 bottomRight: Radius.circular(10),
              //                 bottomLeft: Radius.circular(10))),
              //         child: Center(
              //           child: Text(
              //             productModel.priceList.values.toList()[index],
              //             textAlign: TextAlign.center,
              //             overflow: TextOverflow.ellipsis,
              //             style: TextStyle(
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
