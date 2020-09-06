import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';

import '../colors.dart';

class AddAboutUs extends StatelessWidget {
  var myController = TextEditingController();

  var aboutKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      key: aboutKey,
      appBar: AppBar(
         leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: MyColor.customColor,),
         onPressed: ()=>Navigator.pop(context)),
        backgroundColor: MyColor.whiteColor,
        title: Text('نبذة عنا',style: TextStyle(
          color: MyColor.customColor
        ),),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
              Text("Gladness",
          style: TextStyle(
            fontFamily: 'italy',
            fontSize: 60,
            
            color: MyColor.customColor
          ),
          ),
            Container(
                margin: EdgeInsets.all(20),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(MyCollections.aboutUs)
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
            if (snapSHot.data.docs.isNotEmpty)
              myController.text =
                  snapSHot.data.docs[0].data()['aboutus'];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(child: Text(myController.text)),
                )),
            );
                      }
                      return Container();
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
