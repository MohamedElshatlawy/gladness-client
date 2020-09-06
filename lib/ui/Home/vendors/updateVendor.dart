import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/vendors.dart';
import 'package:qutub_clinet/models/categoryModel.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';

class UpdateVendor extends StatefulWidget {
  VendorModel model;
  TextEditingController venderNameController = TextEditingController();

  TextEditingController venderMailController = TextEditingController();

  TextEditingController venderPhoneController = TextEditingController();

  TextEditingController venderPhone2Controller = TextEditingController();

  TextEditingController commRecordController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  File img;
  var addVendorKey = GlobalKey<ScaffoldState>();
  CategoryModel selectedCategoryModel;

  UpdateVendor(this.model) {
    venderNameController.text = model.name;
    venderMailController.text = model.email;
    venderPhoneController.text = model.phone;
    venderPhone2Controller.text = model.optionalPhone;
    commRecordController.text = model.commRec;
    bioController.text = model.bio;

    selectedCategoryModel =
        CategoryModel(name: model.categoryName, id: model.categoryID);
  }
  @override
  _AddVendorState createState() => _AddVendorState();
}

class _AddVendorState extends State<UpdateVendor> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var updateVendorKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: updateVendorKey,
        backgroundColor: MyColor.customGreyColor,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: MyColor.customColor,
              ),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: MyColor.whiteColor,
          title: Text(
            'تعديل بيانات التاجر',
            style: TextStyle(color: MyColor.customColor),
          ),
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(
                    controller: TextEditingController(
                        text: widget.selectedCategoryModel.name),
                    txtLablel: 'القسم',
                    isEdit: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.venderNameController,
                    txtLablel: 'اسم التاجر',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.venderMailController,
                    txtLablel: 'البريد الألكتروني',
                    isMail: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.venderPhoneController,
                    txtLablel: 'رقم الهاتف',
                    isNumber: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.venderPhone2Controller,
                    txtLablel: 'رقم هاتف اضافي ( اختياري ) ',
                    isNumber: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.commRecordController,
                    txtLablel: 'رقم السجل التجاري',
                    isNumber: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.bioController,
                    txtLablel: 'نبذة مختصرة عن التاجر',
                    lineCount: 3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'اضف صورة التاجر',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'التنسيقات المدعومة هي jpeg و jpg و png. يجب ألا تتجاوز كل صورة 5 ميغابايت',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: (widget.img == null && widget.model.imgPath == null)
                        ? 50
                        : 75,
                    //height: 75,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: MyColor.customColor,
                          child: IconButton(
                            icon: Icon(
                              (widget.img == null &&
                                      widget.model.imgPath == null)
                                  ? Icons.add
                                  : Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              getImage().then((value) {
                                setState(() {
                                  widget.img = value;
                                  widget.model.imgPath = null;
                                });
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        (widget.img == null && widget.model.imgPath == null)
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            content: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: (widget.img == null)
                                                  ? Image.network(
                                                      widget.model.imgPath,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.file(
                                                      widget.img,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ));
                                },
                                child: Container(
                                  width: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: (widget.img == null)
                                                ? Image.network(
                                                    widget.model.imgPath,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    widget.img,
                                                    fit: BoxFit.cover,
                                                  )),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.red[800],
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget.img = null;
                                                  widget.model.imgPath = null;
                                                });
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    backgroundColor: MyColor.customColor,
                    btnPressed: () async {
                      if (validateInput()) {
                        showMyDialog(
                            context: context, msg: 'جاري تعديل بيانات التاجر');

                        await updateVendor(
                            img: widget.img,
                            vendorModel: VendorModel(
                              id: widget.model.id,
                              imgPath: widget.model.imgPath,
                              bio: widget.bioController.text,
                              categoryID: widget.selectedCategoryModel.id,
                              categoryName: widget.selectedCategoryModel.name,
                              commRec: widget.commRecordController.text,
                              email: widget.venderMailController.text,
                              name: widget.venderNameController.text,
                              optionalPhone: widget.venderPhone2Controller.text,
                              phone: widget.venderPhoneController.text,
                            )).then((value) {
                          dismissDialog(context);
                          Navigator.pop(context);
                        }).catchError((e) {
                          dismissDialog(context);
                          print('ErrorUpdateVendor:$e');
                        });
                      }
                    },
                    textColor: MyColor.whiteColor,
                    txt: 'تعديل',
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  bool validateInput() {
    if (widget.selectedCategoryModel == null) {
      showSnackbarError(
          msg: 'من فضلك قم بأختيار القسم', scaffoldKey: updateVendorKey);
      return false;
    }
    if (widget.venderNameController.text.isEmpty ||
        widget.venderMailController.text.isEmpty ||
        widget.venderPhoneController.text.isEmpty ||
        widget.commRecordController.text.isEmpty ||
       widget. bioController.text.isEmpty) {
      showSnackbarError(
          msg: 'ادخل بيانات التاجر كاملة', scaffoldKey: updateVendorKey);
      return false;
    } else if (widget.img == null&&widget.model.imgPath==null) {
      showSnackbarError(
          msg: 'قم بأرفاق صورة التاجر', scaffoldKey: updateVendorKey);
      return false;
    }

    return true;
  }
}
