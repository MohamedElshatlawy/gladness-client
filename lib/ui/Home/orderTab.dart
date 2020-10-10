import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/orderModel.dart';
import 'package:qutub_clinet/models/reservation_model.dart';
import 'package:qutub_clinet/ui/Home/Product/reservation.dart';
import 'package:qutub_clinet/ui/Home/resev_tabs.dart/confResev.dart';
import 'package:qutub_clinet/ui/Home/resev_tabs.dart/sentResev.dart';
import 'package:qutub_clinet/ui/colors.dart';

import '../../Locale/appLocalization.dart';
import 'Order/orderListItem.dart';
import 'resev_tabs.dart/rejectResev.dart';

class OrderTab extends StatefulWidget {
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab>
    with SingleTickerProviderStateMixin {
  var tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
        var local = AppLocalizations.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: MyColor.whiteColor,
              borderRadius: BorderRadius.circular(6)),
          child: TabBar(
              controller: tabController,
              labelColor: MyColor.customColor,
              indicatorColor: MyColor.customColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: (local.locale.languageCode=="en")?"Waiting":'غير مؤكدة',
                ),
                Tab(
                  text: (local.locale.languageCode=="en")?"Accepted": 'مؤكدة',
                ),
                Tab(
                  text:  (local.locale.languageCode=="en")?"Rejected":'ملغية',
                ),
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: TabBarView(controller: tabController, children: [ 
          SentReservations(),
          ConfirmReservations(),
          CancelReservations()
        ]))
      ],
    );
  }
}
