import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/models/categoryModel.dart';

import '../../Locale/appLocalization.dart';
import 'Category/customHomeCategoriesItem.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        var local = AppLocalizations.of(context);

     return StreamBuilder<QuerySnapshot>(
        stream:
    FirebaseFirestore.instance.collection(MyCollections.categories).snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapSHot) {
    if (snapSHot.hasError) return new Text('${local.translate('Error')}: ${snapSHot.error}');
    switch (snapSHot.connectionState) {
      case ConnectionState.waiting:
        return Center(
          child: CircularProgressIndicator(),
        );

      case ConnectionState.none:
        return Center(
          child: Text(local.translate('no_internet')),
        );
      case ConnectionState.active:

      case ConnectionState.done:
        return (snapSHot.data.docs.isEmpty)
            ? Center(
                child: Text(local.translate('cat_not_found')),
              )
            : ListView.separated(
              separatorBuilder: (ctx,index)=>SizedBox(height: 15,),
                
                itemCount: snapSHot.data.docs.length,
                itemBuilder: (ctx, index) {
                
                  CategoryModel model = CategoryModel(
                      id: snapSHot.data.docs[index].id,
                      name: snapSHot.data.docs[index].data()['name'],
                      imgPath:  
                          snapSHot.data.docs[index].data()['imgPath']);
                  return CategoryItem(  
                    categoryModel: model,
                    index: index,
                  );
                },
              );
    }
    return Container();
        },
      );
 
  
  
  }
}
