import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/Providers/addressProvider.dart';
import 'package:qutub_clinet/ui/colors.dart';

import 'addAddress.dart';
import 'currentAddress.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

TabController controller;

class _MyAddressesState extends State<MyAddresses>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    addressProvider = Provider.of<AddressProvider>(context, listen: false);
  }

  var addressKey = GlobalKey<ScaffoldState>();
  var addressProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: addressKey,
      appBar: AppBar(
        title: Text('عناوين التوصيل'),
        centerTitle: true,
        backgroundColor: MyColor.customColor,
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TabBar(
                  indicatorColor: MyColor.customColor,
                  controller: controller,
                  labelColor: MyColor.customColor,
                  unselectedLabelColor: Color.fromRGBO(155, 155, 155, 1),
                  tabs: [
                    Tab(
                      child: Text(
                        'العناوين المتاحة',
                        style: TextStyle(),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'اضافة عنوان',
                        style: TextStyle(),
                      ),
                    )
                  ]),
              Expanded(
                  child: TabBarView(controller: controller, children: [
                CurrentAddress(
                  addressKey: addressKey,
                  addressProvider: addressProvider,
                ),
                AddAddress(addressKey)
              ]))
            ],
          )),
    );
  }
}
