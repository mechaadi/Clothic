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
    console.log(change.after.data, " NOTIFACTION DATA", context, " CONTEXT DATA");
    const payload = {
        notification: {
            title: 'New message!',
            body: 'Click to view'
        },
        data: {
            remoteUser: context.params.remoteUserID
        }
    };

    admin.firestore().collection('users').doc(context.params.userID).get().then(user => {
        console.log(user.data(), " USER DATA");
        admin.messaging().sendToDevice(user.data().token, payload)
        return 'done'
    }).catch(c => console.log(c));
})

exports.helloWorld = functions.https.onRequest((request, response) => {
    functions.logger.info("Hello logs!", {
        structuredData: true
    });
    const payload = {
        notification: {
            title: 'You have been invited to a trip.',
            body: 'Tap here to check it out!'
        }
    };

    admin.messaging().sendToDevice('dGYkcAdXQ5e_J2kWUgMN6E:APA91bFlaqEscyi0tAiHTbMs5zBmcMRCQJQZWAfjAAFO-wmVJglxQjReRO5lgu4B_oGYalNuI28FP_OybKR90xRdlNdmoVASLL1XjatwUZZYtDrAPud8awKOMn7H6xNi8kLq2NeFvMHp', payload)

    response.send("Hello from Firebase!");
});

exports.helloWorld2 = functions.https.onRequest((request, response) => {
    functions.logger.info("Hello logs!", {
        structuredData: true
    });
    response.send("Hello from Firebase!");
});