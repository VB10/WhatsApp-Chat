import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whatchats/core/init/service/network_service.dart';
import 'package:whatchats/screen/chat/model/user_chat.dart';
import './chat.dart';

abstract class ChatViewModel extends State<Chat> {
  // Add your state and logic here

  Dio dio = NetworkService.instance.dio;

  Future<List<UserChat>> getAllChatData() async {
    final response = await dio.get("chats");
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseData = response.data;
        if (responseData is List) {
          return responseData.map((e) => UserChat.fromJson(e)).toList();
        } else {
          return Future.error(response.statusMessage);
        }
        break;
      default:
        return Future.error(response.statusMessage);
    }
  }
}
