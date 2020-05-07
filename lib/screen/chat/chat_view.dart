import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatchats/screen/chat/model/user_chat.dart';
import './chat_view_model.dart';

class ChatView extends ChatViewModel {
  bool isChatAppBarClosed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildFutureChats(),
    );
  }

  Widget buildFutureChats() {
    return FutureBuilder<List<UserChat>>(
      future: getAllChatData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<UserChat>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              return buildNestedScrollViewBody(snapshot.data);
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

  NestedScrollView buildNestedScrollViewBody(List<UserChat> chats) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            buildAppBarTop(innerBoxIsScrolled),
            buildSliverAppBarChats(context),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: chats.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildHeader(chats[index]);
            } else
              return buildUserCard(chats[index]);
          },
        ));
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

  Column buildHeader(UserChat chat) {
    return Column(
      children: [
        Column(
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildAutoSizeText("Broadcast List"),
                buildAutoSizeText("New Group")
              ],
            ),
            Divider(),
          ],
        ),
        buildUserCard(chat),
      ],
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

  ListTile buildUserCard(UserChat chat) {
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
                .headline5
                .copyWith(color: Theme.of(context).splashColor),
          ),
          Spacer()
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 5,
                  child: AutoSizeText(
                    chat.message,
                    maxLines: 2,
                  )),
              Expanded(
                child: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).splashColor,
                ),
              )
            ],
          ),
          Divider()
        ],
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
