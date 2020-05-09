import 'package:flutter/material.dart';
import './chat_view_model.dart';
import 'model/chat_model.dart';

class ChatView extends ChatViewModel {
  final backgroundColor = Colors.grey[200];
  final int listHeaderIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return NestedScrollView(
      headerSliverBuilder: (context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            backgroundColor: backgroundColor,
            title: buildVisibilityChatAppBarCenter(innerBoxIsScrolled, context),
            leading: buildFlatButtonEdit(),
            actions: [buildIconButtonCreate(context)],
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextChatHighText(context),
                  buildPaddingSearchBar()
                ],
              ),
            ),
          )
        ];
      },
      body: FutureBuilder<List<ChatModel>>(
        future: getChatAllData(),
        initialData: [],
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return buildPageListWidget(snapshot.data);
              }
              return Text(snapshot.error);

            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Text("Erro");
          }
        },
      ),
    );
  }

  Padding buildPaddingSearchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(Icons.search),
            hintText: appStringConstants.search,
            fillColor: Colors.grey[300],
            filled: true,
            border: buildOutlineInputBorder,
            enabledBorder: buildOutlineInputBorder),
      ),
    );
  }

  Text buildTextChatHighText(BuildContext context) {
    return Text(
      appStringConstants.chat,
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Visibility buildVisibilityChatAppBarCenter(
      bool innerBoxIsScrolled, BuildContext context) {
    return Visibility(
        visible: innerBoxIsScrolled,
        child: Text(
          appStringConstants.chat,
          style: Theme.of(context).textTheme.headline5,
        ));
  }

  OutlineInputBorder get buildOutlineInputBorder {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: 0.2));
  }

  IconButton buildIconButtonCreate(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.edit,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {});
  }

  FlatButton buildFlatButtonEdit() {
    return FlatButton(
      onPressed: () {},
      child: buildTextWidget(appStringConstants.edit),
      padding: EdgeInsets.zero,
    );
  }

  Text buildTextWidget(String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }

  ListView buildPageListWidget(List<ChatModel> data) {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (index == listHeaderIndex) {
          return Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTextWidget(appStringConstants.broad),
                  buildTextWidget(appStringConstants.newGroup)
                ],
              ),
              buildListChatCardWidget(data, index)
            ],
          );
        }
        return buildListChatCardWidget(data, index);
      },
    );
  }

  Widget buildListChatCardWidget(List<ChatModel> data, int index) {
    return ListTile(
      leading: buildCircleAvatarCardImage(data, index),
      title: buildRowTitleText(data, index),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(data[index].message, maxLines: 1), Divider()],
      ),
    );
  }

  CircleAvatar buildCircleAvatarCardImage(List<ChatModel> data, int index) {
    return CircleAvatar(
      backgroundImage: NetworkImage(data[index].image),
    );
  }

  Row buildRowTitleText(List<ChatModel> data, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(data[index].name), Text(data[index].date)],
    );
  }
}
