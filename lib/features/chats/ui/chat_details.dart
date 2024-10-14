import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/message_card.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  final String chatPartnerName;
  final String chatPartnerId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.chatPartnerName,
    required this.chatPartnerId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chatPartnerName)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chats')
                    .doc(widget.chatId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages yet'));
                  }

                  return ListView(
                    reverse: true,
                    children: snapshot.data!.docs.map((doc) {
                      var messageData = doc.data() as Map<String, dynamic>;
                      String content = messageData['content'];
                      String senderId = messageData['senderId'];
                      bool isMe = senderId == _auth.currentUser!.uid;

                      return MessageTile(content: content, isMe: isMe);
                    }).toList(),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(hintText: 'Type a message...'),
            ),
          ),
          SizedBox(width: 2.w),
          IconButton(
            iconSize: 3.5.h,
            icon: const Icon(Icons.send_rounded, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    String message = _messageController.text;
    String userId = _auth.currentUser!.uid;

    await _firestore
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add({
      'senderId': userId,
      'content': message,
      'timestamp': Timestamp.now(),
    });

    // Update last message and timestamp in chat document
    await _firestore.collection('chats').doc(widget.chatId).update({
      'lastMessage': message,
      'lastMessageTime': Timestamp.now(),
    });

    _messageController.clear();
  }
}

// class ChatDetailScreen extends StatefulWidget {
//   final String chatId;
//   final String chatPartnerName;
//   final String chatPartnerId;
//
//   const ChatDetailScreen({
//     super.key,
//     required this.chatId,
//     required this.chatPartnerName,
//     required this.chatPartnerId,
//   });
//
//   @override
//   State<ChatDetailScreen> createState() => _ChatDetailScreenState();
// }
//
// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.chatPartnerName)),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 5),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('chats')
//                     .doc(widget.chatId)
//                     .collection('messages')
//                     .orderBy('timestamp', descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(child: Text('No messages yet'));
//                   }
//
//                   return ListView(
//                     reverse: true,
//                     children: snapshot.data!.docs.map((doc) {
//                       var messageData = doc.data() as Map<String, dynamic>;
//                       String content = messageData['content'];
//                       String senderId = messageData['senderId'];
//
//                       bool isMe = senderId == _auth.currentUser!.uid;
//
//                       return ListTile(
//                         title: Align(
//                           alignment: isMe
//                               ? Alignment.centerRight
//                               : Alignment.centerLeft,
//                           child: Container(
//                             width: 80.w,
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: isMe ? Colors.blue : Colors.grey[200],
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Text(
//                               content,
//                               style: TextStyle(
//                                 color: isMe ? Colors.white : Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             ),
//             _buildMessageInput(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             flex: 6,
//             child: TextField(
//               controller: _messageController,
//               decoration: const InputDecoration(hintText: 'Type a message...'),
//             ),
//           ),
//           SizedBox(width: 2.w),
//           IconButton(
//             iconSize: 3.5.h,
//             icon: const Icon(Icons.send_rounded, color: MyColors.blue),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _sendMessage() async {
//     if (_messageController.text.isEmpty) return;
//
//     String message = _messageController.text;
//     String userId = _auth.currentUser!.uid;
//
//     await _firestore
//         .collection('chats')
//         .doc(widget.chatId)
//         .collection('messages')
//         .add({
//       'senderId': userId,
//       'content': message,
//       'timestamp': Timestamp.now(),
//     });
//
//     // Update last message and timestamp in chat document
//     await _firestore.collection('chats').doc(widget.chatId).update({
//       'lastMessage': message,
//       'lastMessageTime': Timestamp.now(),
//     });
//
//     _messageController.clear();
//   }
// }
