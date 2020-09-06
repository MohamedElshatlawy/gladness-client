import 'package:flutter/material.dart';
import 'package:qutub_clinet/models/NotificationModel.dart';

class NotificationListItem extends StatelessWidget {
  NotificationModel model;
  NotificationListItem({this.model});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: (model.imgPath == null)
                ? Image.asset(
                    'assets/not.jpg',
                    fit: BoxFit.fill,
                    
                  )
                : Image.network(
                    model.imgPath,
                    fit: BoxFit.fill,
                  ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                   Text(model.title,textAlign: TextAlign.right,),
            SizedBox(
              height: 10,
            ),
            Text(
              model.body,textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey),
            )
              ],
            ),
          )
       
        ],
      ),
    );
  }
}
