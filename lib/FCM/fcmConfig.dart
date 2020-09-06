import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

Future<dynamic>getFcmToken()async{
  FirebaseMessaging firebaseMessaging=FirebaseMessaging();
  String token=await firebaseMessaging.getToken();

  User user= FirebaseAuth.instance.currentUser;

 FirebaseFirestore.instance.collection(MyCollections.userCollection)
  .doc(user.uid)
  .update({'fcm_token':token});

}

Future<dynamic> seenNotification() async {
  User user= FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance.collection(MyCollections.userCollection)
  .doc(user.uid)
  .collection(MyCollections.notification)
  .get().then((value) => value.documents.forEach((element) { 
    element.reference.update({
      'seen':true
    });

  }));
}


Future<dynamic> sendDashboardNotification() async {
  
  await FirebaseFirestore.instance
      .collection(MyCollections.dashBoardUsers)
      .get()
      .then((value) async {
    Future.forEach(value.docs, (element) async {
      if (element.data['fcm_token'] != null) {
        print('Token:${element.data['fcm_token'] }');
        await sendToAllClients(element.data['fcm_token'], 'طلب جديد');
      
      }
    });
   
  });
}

sendToAllClients(String userToken, String title) async {
  final String serverToken = MyCollections.serverToken;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false),
  );

  await post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': '', 'title': title},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': userToken,
      },
    ),
  );
}