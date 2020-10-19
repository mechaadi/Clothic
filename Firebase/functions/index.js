const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

exports.donationFunction = functions.firestore
    .document('donations/{donationID}').onWrite((change, context) => {
        console.log(change.after.data, " NOTIFACTION DATA", context, " CONTEXT DATA");

        const payload = {

            notification: {
                click_action: "FLUTTER_NOTIFICATION_CLICK",
                title: 'New Item added',
                body: 'Click to view'
            },
            data: {
                notificationID: 'donation',
                donationID: context.params.donationID
            }
        };
        admin.messaging().sendToTopic('newDonations', payload)
    });

exports.chatFunction = functions.firestore.document('chats/{userID}/users/{remoteUserID}/messages/{msgDocID}').onWrite((change, context) => {
    console.log(change.after.data(), " NOTIFACTION DATA", context, " CONTEXT DATA");
    

    admin.firestore().collection('users').doc(context.params.userID).get().then(async user => {
        
        const res = await admin.firestore().collection('users').doc(context.params.remoteUserID).get();
        let rusername = res.data().name;
        const payload = {
            notification: {
                click_action: "FLUTTER_NOTIFICATION_CLICK",
                title: `${rusername} sent a message`,
                body: `${change.after.data().message}`
            },
            data: {
                notificationID: 'chat',
                remoteUser: context.params.remoteUserID
            }
        };

        console.log("SENDING NOTIFICATION")
        admin.messaging().sendToDevice(user.data().token, payload)
        return 'done'
    }).catch(c => console.log(c));
})


exports.helloWorld = functions.https.onRequest((request, response) => {
    functions.logger.info("Hello logs!", {
        structuredData: true
    });
    response.send("Hello from Clothic!");
});