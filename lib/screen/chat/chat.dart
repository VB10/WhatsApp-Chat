import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatchats/screen/chat/chat_view_android.dart';
import './chat_view.dart';

class Chat extends StatefulWidget {
  @override
  createState() => !Platform.isIOS ? ChatView() : ChatViewAndroid();
}
