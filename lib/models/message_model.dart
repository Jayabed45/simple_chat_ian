class Message {
  final String text;
  final String userEmail;
  Message({required this.text, required this.userEmail});
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(text: map['text'], userEmail: map['userEmail']);
  }
  Map<String, dynamic> toMap() {
    return {'text': text, 'userEmail': userEmail};
  }
}
