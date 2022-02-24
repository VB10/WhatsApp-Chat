import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './chat.dart';
import '../../core/constants/app_string_constants.dart';
import '../../core/init/network/network_manager.dart';
import 'model/chat_model.dart';

abstract class ChatViewModel extends State<Chat> {
  // Add your state and logic here
  Dio? dio = NetworkManager.instance!.dio;
  AppStringConstants? appStringConstants = AppStringConstants.instance;

  Future<List<ChatModel>> getChatAllData() async {
    final response = await dio!.get("chats");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        if (responseBody is List) {
          return responseBody.map((e) => ChatModel.fromJson(e)).toList();
        }
        return Future.error("Hata");
        break;

      default:
        return Future.error(response.statusMessage!);
    }
  }
}
