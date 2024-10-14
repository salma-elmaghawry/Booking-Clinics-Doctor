class ChatModel {
  final String chatId;
  final String chatPartnerName;
  final String chatPartnerId;

  ChatModel({
    required this.chatId,
    required this.chatPartnerName,
    required this.chatPartnerId,
  });

  factory ChatModel.fromMap(Map<String, dynamic> data) {
    return ChatModel(
      chatId: data['chatId'],
      chatPartnerName: data['chatPartnerName'],
      chatPartnerId: data['chatPartnerId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'chatPartnerName': chatPartnerName,
      'chatPartnerId': chatPartnerId,
    };
  }
}
