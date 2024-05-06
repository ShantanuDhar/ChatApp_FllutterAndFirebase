import 'package:chatapp_firebase/pages/group_info.dart';
import 'package:chatapp_firebase/service/database_service.dart';
import 'package:chatapp_firebase/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getChatandAdmin();
    

  }
     getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }
  
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
              nextScreen(context, GroupInfo(
                groupId: widget.groupId,
                groupName: widget.groupName,
                adminName: admin,
              ));
            },
            icon: const Icon(Icons.more_vert, size: 33,),
          )
        ],




      ),
      body: Stack(
        children: <Widget>
        [
          // chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child:Row(
                children: [
                  Expanded(
                     child: TextFormField(
                  controller: messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Send a message...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
                ],
              ),
            ),

          )


        ],
      ),
      
    );
  }
  chatMessages(){

  }
  sendMessage(){

  }
}