import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qutub_clinet/API/addresses.dart';
import 'package:qutub_clinet/models/addressModel.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

class CurrentAddressItem extends StatelessWidget {
  AddressModel addressModel;
  var addressKey;
  CurrentAddressItem({this.addressModel,this.addressKey});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 25,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    addressModel.address,
                    style: TextStyle(),
                  ),
                  Text(
                    addressModel.phone,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (addressModel.isEnabled == true)
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green[600],
                        size: 25,
                      )
                    : InkWell(
                        onTap: () async {
                          showMyDialog(
                              context: context,
                              msg: 'جاري تغيير العنوان الأفتراضي');
                          await setDefaulsAddress(addressModel.id)
                              .then((value) {
                            dismissDialog(context);
                          }).catchError((e) {
                            dismissDialog(context);
                            print('ErrorChangeDefautAddress:$e');
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              color: Colors.transparent),
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    showDialog(context: context,
                    
                    builder: (context)=>Directionality(
                      textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                        
                        content: Text('هل تريد حذف العنوان ؟'),
                      actions: <Widget>[
                        RaisedButton(onPressed: (){
                          dismissDialog(context);
                          removeAddress(addressModel.id);

                          if(addressModel.isEnabled==true){
                            showSnackbarError(
                              msg: 'قم بتحديد عنوان للتوصيل',
                              scaffoldKey: addressKey
                            );
                          }
                        },
                        textColor: Colors.green[600],
                        color: MyColor.whiteColor,
                        child: Text('نعم'),
                        ),
                         RaisedButton(onPressed: (){
                           dismissDialog(context);
                         },
                        textColor: Colors.red[800],
                        color: MyColor.whiteColor,
                        child: Text('لا'),
                        )
                      ],
                      ),
                    ),

                    );
                  },
                                  child: Text(
                    'حذف',
                    style: TextStyle(color: Colors.red[800]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
