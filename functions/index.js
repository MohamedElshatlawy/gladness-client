const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const firestore = admin.firestore();


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.reviewReservations=review;

function review() {
    
    functions.firestore.collection('reservations').get().then((snapshot) => {
        return snapshot.forEach((doc) => {
            if (doc.data()['status'] === 'confirm') {
                var currentDate = new Date();
                var docDate = new Date(doc.data()['time_stamp']);
                var Difference_In_Time = currentDate.getTime() - docDate.getTime();
                var Difference_In_hours = Difference_In_Time / (1000 * 3600);

                if (Difference_In_hours >= 24) {
                    doc.ref.set({
                        'status': 'cancel'
                    });

                    var clientID = doc.data()['client_id'];
                    firestore.collection('user_client').doc(clientID).get().then((clientDoc) => {
                        var token = clientDoc.get.data()['fcm_token'];

                        return admin.messaging().sendToDevice(token, {
                            notification: { title: 'تم الغاء الحجز', clickAction: 'FLUTTER_NOTIFICATION_CLICK' }
                        });
                    }).catch((e)=>{});


                }

            }
        });
    }).catch((e)=>{});

}


