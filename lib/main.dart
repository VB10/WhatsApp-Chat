import 'package:flutter/material.dart';
import 'package:whatchats/core/init/theme/theme.dart';
import 'package:whatchats/screen/chat/chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: myTheme,
      home: Chat(),
    );
  }
}
