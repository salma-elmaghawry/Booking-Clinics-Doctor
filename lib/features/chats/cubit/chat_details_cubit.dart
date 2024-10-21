import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_details_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  final FirebaseFirestore _firestore;
  final String chatId;

  ChatDetailCubit(this._firestore, this.chatId) : super(ChatDetailInitial());

  void listenToMessages() {
    emit(ChatDetailLoading());

    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      List<Map<String, dynamic>> messages = snapshot.docs.map((doc) => doc.data()).toList();

      emit(ChatDetailLoaded(messages: messages));
    }).onError((error) {
      emit(ChatDetailError(error: error.toString()));
    });
  }

  Future<void> sendMessage(String message, String senderId) async {
    if (message.isEmpty) return;

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'content': message,
      'timestamp': Timestamp.now(),
    });

    // Update last message in the chat document
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': message,
      'lastMessageTime': Timestamp.now(),
    });
  }
}
