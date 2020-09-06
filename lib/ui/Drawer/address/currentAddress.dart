import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/Providers/addressProvider.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/addressModel.dart';
import 'package:qutub_clinet/ui/Drawer/address/currentAddressItem.dart';
import 'package:qutub_clinet/ui/Drawer/address/selectedAddress.dart';

class CurrentAddress extends StatelessWidget {
  var addressKey;
  var addressProvider;
  CurrentAddress({this.addressKey,this.addressProvider});
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance
          .collection(MyCollections.userCollection)
          .doc(userProvider.userModel.userToken)
          .collection(MyCollections.address)
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
                    child: Text('لا يوجد عناوين'),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    itemCount: snapSHot.data.docs.length,
                    itemBuilder: (ctx, index) {
                      AddressModel addressModel = AddressModel.fromJson(
                          id: snapSHot.data.docs[index].id,
                          json: snapSHot.data.docs[index].data());
                        if(addressModel.isEnabled==true){
                         SelectedAddress.addressModel=addressModel;
                        }
                      return CurrentAddressItem(
                        addressModel: addressModel,
                        addressKey: addressKey,
                      );
                    });
        }
        return Container();
      },
    );
  }
}
