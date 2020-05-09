import 'package:flutter/material.dart';

import '../chat/chat.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 5, child: buildScaffoldBody());
  }

  Scaffold buildScaffoldBody() => Scaffold(
        body: TabBarView(children: [
          Container(),
          Container(),
          Container(),
          Chat(),
          Container(),
        ]),
        bottomNavigationBar: buildBottomAppBar(),
      );

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black12,
          indicatorColor: Colors.transparent,
          labelPadding: EdgeInsets.zero,
          tabs: [
            Tab(icon: Icon(Icons.phone), text: "Status"),
            Tab(icon: Icon(Icons.phone), text: "Status"),
            Tab(icon: Icon(Icons.phone), text: "Status"),
            Tab(icon: Icon(Icons.chat), text: "Chat"),
            Tab(icon: Icon(Icons.phone), text: "Status"),
          ]),
    );
  }
}
