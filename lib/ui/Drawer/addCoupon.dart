import 'package:flutter/material.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';

import '../colors.dart';

class AddCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: MyColor.customColor,
          title: Text('اضافة كوبون خصم'),
          centerTitle: true,
        ),
       body: Container(
        margin: EdgeInsets.all(20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
             
              CustomTextField(
                txtLablel: 'اضف كوبون',
              ),
              SizedBox(height: 20,),
              
              CustomTextField(
                txtLablel: 'نسبة الخصم %',
                isNumber: true,
              ),
              SizedBox(height: 20,),
              CustomTextField(
                txtLablel: 'وصف الكوبون',
                lineCount: 2,
              ),
            
              SizedBox(
                height: 30,
              ),
              CustomButton(
                backgroundColor: Colors.grey[200],
                textColor: MyColor.customColor,
                txt: 'اضافة كوبون جديد',
                btnPressed: () {},
              )
            ],
          ),
        ),
      ),
  );
  }
}