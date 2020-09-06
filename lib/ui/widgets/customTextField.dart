import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/Providers/counrtyCodeProvider.dart';

import '../colors.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String txtLablel;
  bool isNumber;
  bool isPassword;
  bool isMail;
  bool isEdit;
  bool isCountryCode;
  var fontSize;
  var labelColor;
  var dropDownColor;
  var txtColor;
  bool isEditForProfile;

  int lineCount;
  CustomTextField(
      {this.controller,
      this.txtLablel,
      this.isNumber,
      this.isPassword,
      this.lineCount,
      this.labelColor,
      this.txtColor,
      this.dropDownColor,
      this.isCountryCode,
      this.isEdit,
      this.isEditForProfile,
      this.isMail});
  @override
  Widget build(BuildContext context) {
    var countryCodeProvider=Provider.of<CountryCodeProvider>(context);
    return Container(
     
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        
        style: TextStyle(
          color:(txtColor==null)? Colors.grey:txtColor
        ),
        cursorColor: MyColor.customColor,
        
        enabled: (isEdit==false)?false:true,
        
        obscureText: (isPassword==true) ? true : false,
        keyboardType: (isMail==true)
            ? TextInputType.emailAddress
            : (isNumber==true) ? TextInputType.number : TextInputType.text,
        maxLines: (lineCount!=null)?lineCount:1,
        scrollController: ScrollController(),
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: (isEditForProfile==true)?Colors.grey[200]:Colors.transparent,
            alignLabelWithHint: (lineCount!=null)?true:false,
            labelText: txtLablel,
            labelStyle: TextStyle(color:(labelColor==null)? MyColor.customColor:labelColor,
            
            ),
            contentPadding: EdgeInsets.fromLTRB(8, 5, 8, 5),
            suffixStyle: TextStyle(
              color: MyColor.whiteColor
            ),
            suffixIcon: (isCountryCode==null)?Container(
              width: 10,
            ):
            DropdownButton(
              value: countryCodeProvider.countryCode,
              dropdownColor: (dropDownColor==null)?MyColor.whiteColor:MyColor.customColor,
              iconEnabledColor: (dropDownColor==null)?MyColor.customColor:MyColor.whiteColor,
              style: TextStyle(
                color:(dropDownColor==null)? MyColor.customColor:MyColor.whiteColor
              ),
              underline: Container(),
              items: [
              '+966',
              '+20'
            ].map((e) => DropdownMenuItem(child: Text(e,style: TextStyle(
             
            ),
            
            )
           ,value: e, 
            )
            
            ).toList(),
            
             onChanged: (v){
               countryCodeProvider.setCountry(v);
               
             })
            ),
      ),
    );
  }
}
