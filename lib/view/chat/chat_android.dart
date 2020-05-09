import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './chat_view_model.dart';
import 'model/chat_model.dart';

class ChatViewAndroid extends ChatViewModel {
  bool isChatAppBarClosed = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WhatsApp",
            style: appBarTitleTextStyle,
          ),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
          centerTitle: false,
          backgroundColor: Colors.green,
          bottom: TabBar(
            tabs: [Tab(text: "CHATS"), Tab(text: "STATE"), Tab(text: "CALL")],
            indicatorColor: Theme.of(context).canvasColor,
            // unselectedLabelColor: Colors.red,
            labelStyle: appBarTextStyle,
          ),
        ),
        body: buildFutureChats(),
      ),
    );
  }

  TextStyle get appBarTextStyle => Theme.of(context)
      .primaryTextTheme
      .headline5
      .copyWith(fontWeight: FontWeight.w700);
  TextStyle get appBarTitleTextStyle => Theme.of(context)
      .primaryTextTheme
      .headline4
      .copyWith(fontWeight: FontWeight.w700);

  Widget buildFutureChats() {
    return FutureBuilder<List<ChatModel>>(
      future: getChatAllData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              return buildListCard(snapshot.data);
            } else {
              return Text(snapshot.error);
            }
            break;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.none:
            return Center(
              child: FlutterLogo(),
            );
          default:
            return Text(snapshot.error);
        }
      },
    );
  }

  SliverAppBar buildAppBarTop(bool isChatAppBarClosed) {
    return SliverAppBar(
      elevation: isChatAppBarClosed ? 10 : 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: buildTitleCenterText(isChatAppBarClosed),
      pinned: true,
      leading: buildEditButton(),
      actions: [buildWriteButton(context)],
    );
  }

  Widget buildListCard(List<ChatModel> chats) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return buildUserCard(chats[index]);
      },
    );
  }

  Visibility buildTitleCenterText(bool isChatAppBarClosed) {
    return Visibility(
      visible: isChatAppBarClosed,
      child: AutoSizeText(
        "Chats",
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  SliverAppBar buildSliverAppBarChats(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: false,
      title: titleText(context),
      elevation: 20,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        background:
            Align(alignment: Alignment.bottomLeft, child: searchField(context)),
      ),
    );
  }

  IconButton buildWriteButton(BuildContext context) {
    return IconButton(
        icon:
            Icon(FontAwesomeIcons.edit, color: Theme.of(context).primaryColor),
        onPressed: () {});
  }

  FlatButton buildEditButton() {
    return FlatButton(
      padding: EdgeInsets.zero,
      child: buildAutoSizeText("Edit"),
      onPressed: () {},
    );
  }

  AutoSizeText buildAutoSizeText(String text) {
    return AutoSizeText(
      text,
      style: Theme.of(context)
          .textTheme
          .headline5
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }

  ListTile buildUserCard(ChatModel chat) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chat.image),
      ),
      title: Row(
        children: [
          Text(chat.name),
          Spacer(flex: 9),
          AutoSizeText(
            chat.date,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Theme.of(context).splashColor),
          ),
          Spacer()
        ],
      ),
      subtitle: AutoSizeText(
        chat.message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget searchField(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: TextField(
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).canvasColor,
              ),
              labelText: "Search",
              labelStyle: Theme.of(context).primaryTextTheme.headline5,
              focusedBorder: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(15)),
              fillColor: Colors.grey[300],
              filled: true),
        ),
      ),
    );
  }

  Text titleText(BuildContext context) {
    return Text(
      "Chats",
      style:
          Theme.of(context).textTheme.headline1.copyWith(color: Colors.black),
    );
  }
}
