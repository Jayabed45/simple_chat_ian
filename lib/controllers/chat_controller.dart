import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class ChatController {
  final _firestore = FirebaseFirestore.instance;
  Stream<List<Message>> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList(),
        );
  }

  Future<void> sendMessage(String text, String userEmail) async {
    await _firestore.collection('messages').add({
      'text': text,
      'userEmail': userEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
