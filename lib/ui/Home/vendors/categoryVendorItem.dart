import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/vendors.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/Home/Product/categoryProducts.dart';
import 'package:qutub_clinet/ui/Home/vendors/updateVendor.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';

class CategoryVendorItem extends StatelessWidget {
  VendorModel vendorModel;
  int index;
  CategoryVendorItem({this.vendorModel,this.index});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: InkWell(
       
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute( 
                  builder: (ctx) => CategoryProducts(
                    
                        vendorModel: vendorModel,
                      )));
        },
        child:Container(
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
                child:  CachedNetworkImage(
                        imageUrl: vendorModel.imgPath,
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
              )),
              Expanded(
                  child: Center(
                child: Text(
                  vendorModel.name,
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
        
      
      ),
    );
  }
}
