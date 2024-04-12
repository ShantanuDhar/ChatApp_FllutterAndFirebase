import 'package:chatapp_firebase/pages/group_info.dart';
import 'package:chatapp_firebase/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String groupName;
  final String groupId;

  const ChatPage({super.key, required this.groupId, required this.groupName, required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String admin="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName, style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search , size: 33, ),
          ),
          IconButton(
            onPressed: (){
              nextScreen(context, GroupInfo());
            },
            icon: const Icon(Icons.more_vert, size: 33,),
          )
        ],




      ),
    );
  }
}