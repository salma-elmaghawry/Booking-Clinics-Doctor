abstract class ChatDetailState {}

class ChatDetailInitial extends ChatDetailState {}

class ChatDetailLoading extends ChatDetailState {}

class ChatDetailLoaded extends ChatDetailState {
  final List<Map<String, dynamic>> messages;

  ChatDetailLoaded({required this.messages});
}

class ChatDetailError extends ChatDetailState {
  final String error;

  ChatDetailError({required this.error});
}
