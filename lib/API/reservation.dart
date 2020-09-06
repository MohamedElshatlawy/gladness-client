import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/models/reservation_model.dart';

Future cancelReservation({ReservationModel model}) async {
  return await FirebaseFirestore.instance.collection('reservations')
  .doc(model.firebaseID).update({
    'status':'cancel'
  });
}