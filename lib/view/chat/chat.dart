import 'dart:io';

import 'package:flutter/material.dart';
import './chat_view.dart';
import 'chat_android.dart';

class Chat extends StatefulWidget {
  @override
  createState() => !Platform.isIOS ? ChatView() : ChatViewAndroid();
}
