import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constant_chat.dart';

class DataBaseService {


  getChatMessages(String senderId, String receiverId) async{
    print("qauwednjksd");
  //  return await Firestore.instance.collection("chat_room")
//            .where('senderId', isEqualTo: receiverId)
//        .where('toUserId', isEqualTo: senderId)
      //  .orderBy('timestamp', descending: true)
      //  .getDocuments();
      //  .snapshots();

        QuerySnapshot messagestoQuerySnapshot = await Firestore.instance.collection("chat_room")
        .where('senderId', isEqualTo: receiverId)
        .where('toUserId', isEqualTo: senderId)
      //  .orderBy('timestamp', descending: true)
        .getDocuments();

        messagestoQuerySnapshot.documents.forEach((doc) {
      print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"+doc.documentID);
      print(doc.documentID);
   //   messages.add(Message.fromDoc(doc));
    });
  }

  sendChatMessage(message) {
    String _userId;
    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;

      Firestore.instance
          .collection("chat_room").add(message);
        //  .document(user.uid).collection("sender").add(message);
//          .setData(message);
    });

  }
}




