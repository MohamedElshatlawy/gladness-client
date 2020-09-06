import 'package:flutter/material.dart';
import 'package:qutub_clinet/models/categoryModel.dart';
import 'package:qutub_clinet/ui/Home/Product/categoryProducts.dart';
import 'package:qutub_clinet/ui/Home/vendors/categoryVendors.dart';
import 'package:qutub_clinet/ui/colors.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  int index;
  CategoryItem({this.categoryModel,this.index});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (ctx) => CategoryProducts(
          //               categoryModel: categoryModel,
          //             ))); 
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => CategoryVendors(
                        categoryModel: categoryModel,
                      )));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          height: MediaQuery.of(context).size.height*.2,
          child: Row(
            textDirection: (index%2==0)?TextDirection.rtl:TextDirection.ltr,
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  categoryModel.imgPath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              )),
              Expanded(
                  child: Center(
                child: Text(
                  'اسم الفئة: ' + categoryModel.name,
                    textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColor.customColor,
                        ),
                ),
              ))
            ],
          ),
        )
        
        
        // Container(
        //   decoration: BoxDecoration(
        //       color: Colors.grey[600], borderRadius: BorderRadius.circular(10)),
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: <Widget>[
        //       Opacity(
        //           opacity: .5,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(10),
        //             child: Image.network(
        //               categoryModel.imgPath,
        //               fit: BoxFit.cover,
        //             ),
        //           )),
        //       Align(
        //         alignment: Alignment.centerLeft,
        //         child: RotatedBox(
        //           quarterTurns: -1,
        //           child: Container(
        //             width: 90,
        //             height: 30,
        //             decoration: BoxDecoration(
        //                 color: Colors.red[800],
        //                 borderRadius: BorderRadius.only(
        //                     bottomRight: Radius.circular(10),
        //                     bottomLeft: Radius.circular(10))),
        //             child: Center(
        //               child: Text(
        //                 categoryModel.name,
        //                 textAlign: TextAlign.center,
        //                 overflow: TextOverflow.ellipsis,
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
