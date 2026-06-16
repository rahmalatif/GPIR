const admin = require("firebase-admin");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");

admin.initializeApp();

exports.sendChatNotification = onDocumentCreated(
  "notifications/{notificationId}",
  async (event) => {
    const data = event.data.data();

    const receiverId = data.receiverId;
    const senderName = data.senderName;
    const message = data.message;
    const senderId = data.senderId;

    const userDoc = await admin
      .firestore()
      .collection("users")
      .doc(receiverId)
      .get();

    if (!userDoc.exists) {
      console.log("Receiver not found");
      return;
    }

    const token = userDoc.data().fcmToken;

    if (!token) {
      console.log("No FCM Token");
      return;
    }

    await admin.messaging().send({
      token: token,
      notification: {
        title: senderName,
        body: message,
      },
      data: {
        type: "chat",
        senderId: senderId,
      },
    });

    console.log("Notification sent successfully");
  }
);