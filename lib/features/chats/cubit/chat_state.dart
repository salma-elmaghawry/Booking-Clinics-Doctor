import 'package:flutter/material.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Map<String, dynamic>> chats;
  ChatLoaded({required this.chats});
}

class ChatError extends ChatState {
  final String error;
  ChatError({required this.error});
}


