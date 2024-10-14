import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageTile extends StatelessWidget {
  final String content;
  final bool isMe;

  const MessageTile({
    super.key,
    required this.content,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 75.w),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
