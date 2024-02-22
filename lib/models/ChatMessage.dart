import 'package:flutter/material.dart';

class ChatMessage{
  String messageContent;
  String messageType;
  String created_at;
  String group_id;
  ChatMessage({required this.messageContent, required this.messageType , required this.created_at , required this.group_id});
}