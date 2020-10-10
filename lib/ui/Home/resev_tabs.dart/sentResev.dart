import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/ui/Home/Order/orderListItem.dart';

import '../../../Locale/appLocalization.dart';

class SentReservations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
        var local = AppLocalizations.of(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("reservations")
          .where('client_id', isEqualTo: userProvider.userModel.userToken)
          .where('status', isEqualTo: 'sent')
          .orderBy('time_stamp', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapSHot) {
        if (snapSHot.hasError) {
          print(snapSHot.error);
          return new Text('${local.translate('Error')}: ${snapSHot.error}');
        }
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
                    child: Text((local.locale.languageCode=="en")?"No reservations":'لا يوجد حجوزات'),
                  )
                : ListView.separated(
                    separatorBuilder: (ctx, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: snapSHot.data.docs.length,
                    itemBuilder: (ctx, index) {
                      ReservationModel model = ReservationModel.fromJson(
                          id: snapSHot.data.docs[index].id,
                          json: snapSHot.data.docs[index].data());
   
                      return OrderListItem(
                        index: snapSHot.data.docs.length - index,
                        orderModel: model,
                      );
                    },
                  );
        }
        return Container();
      },
    );
  }
}
