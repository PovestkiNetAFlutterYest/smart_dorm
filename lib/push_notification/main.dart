import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:http/http.dart" as http;
import '../auth/dto/user.dart';

Future<void> storeNotificationToken(User user) async {
  String? token = await FirebaseMessaging.instance.getToken();

  await FirebaseFirestore.instance.collection('tokens').doc(user.id).set({
    'token': token,
  });
}

Future<void> sentNotification(String title, String token) async  {
  final data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'id': 1,
    'status': 'done',
    'message': title,
  };


  try {
    http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAA2SwmlTI:APA91bHZVDsGLfKIzExZObbhJcu7UaHD0jNdolJJpbkjuWBblBGz3uKQcdPAehOi6mFYK6guOl6EUHf-bok0g8vNDrAjznkomR_NjdDTcGpF8z4z9r_M30bFq96aQx-7IJlrT9gvvqRr',
        },
        body: jsonEncode(<String, dynamic>{
          'notification': <String, dynamic>{
            'title': title,
            'body': "Simple text notification text"
          },
          'priority': 'high',
          'data': data,
          'to': token,
        }));

    if (response.statusCode == 200) {
      print("Notification is sent");
    } else {
      print("error notification: ${response.body}");
    }
  } catch (e){
      print("Error in sentNotification: ${e.toString()}");
  }
}


Future<void> grantPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}