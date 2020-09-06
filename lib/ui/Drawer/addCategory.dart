import 'package:flutter/material.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';

import '../colors.dart';

class AddCategory extends StatelessWidget {
  TextEditingController catNameController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.customColor,
          title: Text('اضافة قسم جديد'),
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 
                  CustomTextField(
                    controller: catNameController,
                    txtLablel: 'اسم القسم',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'اضافة صورة',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                    //height: (placeImgs.length == 0) ? 50 : 80,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: MyColor.customColor,
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //    getImage();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 80,
                                  color: Colors.white,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.all(9),
                                          child: Container()
                                          /* Image.file(
                                            placeImgs[index],
                                            fit: BoxFit.cover,
                                          )*/

                                          ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.red[800],
                                            child: InkWell(
                                              onTap: () {
                                                /* setState(() {
                                                  placeImgs
                                                      .removeAt(index);
                                                });*/
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
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    backgroundColor: Colors.grey[200],
                    btnPressed: (){
                         /*showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                content: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          MyColor.customColor),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Saving')
                                  ],
                                ),
                              );
                            });

                        //Upload place images
                          await uploadPlaceImages(placeImgs).then((myList) {
                          print('Data:$myList');

                          //Convert location to Map
                          List<Map<String, dynamic>> locationsMap = [];
                          locations.forEach((loc) {
                            locationsMap.add(loc.toMap());
                          });

                          //UploadToFireStore
                          PlaceModel placeModel = PlaceModel(
                              adminMail: (adminModel == null)
                                  ? null
                                  : adminModel.mail,
                              category: category,
                              description: descriptionController.text,
                              dislikesCount: 0,
                              facebookUrl: facebookController.text,
                              id: '',
                              imagesURL: myList,
                              likesCount: 0,
                              name: placeNameController.text,
                              okayCount: 0,
                              phoneNumber: phoneController.text,
                              twitterUrl: twitterController.text,
                              websiteUrl: websiterController.text,
                              locationModels: locationsMap);

                          insertPlace(placeModel).then((v) {
                            print('Done inserted place...');
                            viewSnackBar('Place successfully inserted !');
                            //EmptyScreen
                            setState(() {
                              category = null;
                              placeNameController.clear();
                              phoneController.clear();
                              facebookController.clear();
                              twitterController.clear();
                              websiterController.clear();
                              descriptionController.clear();
                              placeImgs.clear();
                              locationsMap.clear();
                              locations.clear();
                            });
                          }).catchError((e) {
                            print('ErrorInsertPlace:$e');
                            viewSnackBar(e.toString());
                          });
                        }).catchError((e) {
                          viewSnackBar(e.toString());
                          print('ErrorUploadImages:$e');
                        });
                        Navigator.pop(context);*/

                    },
                    textColor: MyColor.customColor,
                    txt: 'تأكيد',
                  ),
               ],
              ),
            ),
          ),
        ));
  
  }
}