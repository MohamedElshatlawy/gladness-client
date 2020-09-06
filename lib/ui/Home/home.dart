import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
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
  var homeKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var bottomNavProvider = Provider.of<BottomNavProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var cartCountProvider = Provider.of<CartCounterProvider>(context);
   
    return Scaffold(
      key: homeKey,
      backgroundColor: MyColor.customGreyColor,
        appBar: (bottomNavProvider.selectedIndex==2)?null:AppBar(
          backgroundColor: MyColor.whiteColor,
          elevation: 5,
          title: Text(bottomNavProvider.getTabName(),style: TextStyle(
            color: MyColor.customColor
          ),),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.menu,color: MyColor.customColor,), onPressed: (){
              homeKey.currentState.openEndDrawer();
            })
          ],
          leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => Profile(
                            userModel: userProvider.userModel,
                          )));
            },
            child: Container(
                margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: MyColor.customColor)),
                child: ClipOval(
                    child: (userProvider.userModel==null||userProvider.userModel.profileImg==null)
                        ? Image.asset(
                            'assets/profile.png',
                            color: MyColor.customColor,
                            scale: 4,
                          )
                        : Image.network(
                            userProvider.userModel.profileImg,
                            fit: BoxFit.cover,
                          ))),
          ),
        ),
        
        endDrawer: MyDrawer(), 
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
                  icon: Icon(Icons.date_range), title: Text('الحجوزات')),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.favorite), title: Text('المفضلة')),
              // BottomNavigationBarItem(
              //     icon: Container(
              //       width: 30,
              //       height: 22,
              //       child: Stack(
              //         fit: StackFit.expand,
              //         children: <Widget>[
              //           Icon(Icons.shopping_cart),
              //           (cartCountProvider.count==0)?
              //           Container():
              //           Align(
              //             alignment: Alignment.topRight,
              //             child: Container(
              //               width: 13,
              //               height: 13,
              //               decoration: BoxDecoration(
              //                 color: Colors.red,
              //                 shape: BoxShape.circle,
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   cartCountProvider.count.toString(),
              //                   style:
              //                       TextStyle(color: Colors.white, fontSize: 9),
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //     title: Text('المشتريات')),
          
          
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  title: Text(
                    'التصنيفات',
                  )),
                    BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('الرئيسية')),
            ]),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              margin:(bottomNavProvider.selectedIndex==2)?null: EdgeInsets.all(10), 
              child: bottomNavProvider.selectedIndex == 2

                  ?
                  Welcome(
                    homeKey: homeKey,
                  ):(bottomNavProvider.selectedIndex == 1)?
                   HomeTab()  
                  // : bottomNavProvider.selectedIndex == 1
                  //     ? FavouriteTab()
                  //     : bottomNavProvider.selectedIndex == 2
                  //         ? CartTab()
                          : OrderTab()),
        ));
  }
}
