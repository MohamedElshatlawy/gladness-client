import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/Locale/appLocalization.dart';
import 'package:qutub_clinet/Providers/bottomNavProvider.dart';
import 'package:qutub_clinet/Providers/cartItemsCounterProvider.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/ui/Drawer/myDrawer.dart';
import 'package:qutub_clinet/ui/Drawer/profile.dart';
import 'package:qutub_clinet/ui/Home/cartTab.dart';
import 'package:qutub_clinet/ui/Home/favouriteTab.dart';
import 'package:qutub_clinet/ui/Home/welcome.dart';

import '../colors.dart';
import 'homeTab.dart';
import 'more.dart';
import 'orderTab.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFcmToken();
  }

  var homeKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    var bottomNavProvider = Provider.of<BottomNavProvider>(context);
   
    var local = AppLocalizations.of(context);

    print(local.translate('home_tab'));
    return Scaffold(
        key: homeKey,
        backgroundColor: MyColor.customGreyColor,
        appBar: (bottomNavProvider.selectedIndex == 0)
            ? null
            : AppBar(
                backgroundColor: MyColor.whiteColor,
                elevation: 5,
                title: Text(
                  bottomNavProvider.getTabName(local)??'',
                  style: TextStyle(color: MyColor.customColor),
                ),
                centerTitle: true,
               
              ),
        // endDrawer: MyDrawer(),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            selectedLabelStyle: TextStyle(fontSize: 16),
            currentIndex: bottomNavProvider.selectedIndex,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              bottomNavProvider.onTapClick(index);
            },
            selectedItemColor: MyColor.customColor,
            items: [
             
              
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Container()),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.menu), title: Container()),
                   BottomNavigationBarItem(
                  icon: Icon(Icons.date_range), title: Container()),
                   BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz), title: Container()),
             
            

            ]),
        body: Container(
            margin: (bottomNavProvider.selectedIndex == 0)
                ? null
                : EdgeInsets.all(10),
            child: bottomNavProvider.selectedIndex == 0
                ? Welcome(
                    homeKey: homeKey,
                  )
                : (bottomNavProvider.selectedIndex == 1)
                    ? HomeTab() 
                    // : bottomNavProvider.selectedIndex == 1
                    //     ? FavouriteTab()
                    //     : bottomNavProvider.selectedIndex == 2
                    //         ? CartTab()
                    : (bottomNavProvider.selectedIndex == 2)
                        ? OrderTab()
                        : More()));
  }
}
