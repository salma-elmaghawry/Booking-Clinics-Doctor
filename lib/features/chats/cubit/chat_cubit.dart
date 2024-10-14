import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final FirebaseFirestore _firestore;
  final String currentUserId;

  ChatCubit(this._firestore, this.currentUserId) : super(ChatInitial());

  void listenToChats() {
    emit(ChatLoading());

    _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .listen((snapshot) {
      List<Map<String, dynamic>> chatDocs = snapshot.docs
          .map((doc) => {
                'chatId': doc.id,
                'lastMessage': doc['lastMessage'],
                'lastMessageTime': doc['lastMessageTime'],
                'participants': doc['participants'],
              })
          .toList();

      emit(ChatLoaded(chats: chatDocs));
    }).onError((error) {
      emit(ChatError(error: error.toString()));
    });
  }
}
