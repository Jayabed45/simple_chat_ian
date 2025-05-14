import 'package:flutter/material.dart';
import '../controllers/chat_controller.dart';
import '../controllers/auth_controller.dart';
import '../models/message_model.dart';

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = ChatController();
  final AuthController _authController = AuthController();
  final TextEditingController _messageController = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = _authController.currentUser?.email ?? 'Guest';

    return Scaffold(
      backgroundColor: const Color(0xFF1B1A2F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF292A4D),
        title: const Text(
          'SimpleChat',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatController.getMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  );
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[messages.length - index - 1];
                    final isCurrentUser = msg.userEmail == currentUserEmail;

                    return Align(
                      alignment:
                          isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isCurrentUser
                                  ? Colors.deepPurpleAccent.withOpacity(0.8)
                                  : Colors.indigo.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.text,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              msg.userEmail,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: const Color(0xFF292A4D),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(
                        Icons.message_rounded,
                        color: Colors.white54,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF3A3B63),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    final text = _messageController.text.trim();
                    final email = _authController.currentUser?.email ?? 'Guest';
                    if (text.isNotEmpty) {
                      _chatController.sendMessage(text, email);
                      _messageController.clear();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
