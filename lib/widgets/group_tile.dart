import 'package:chatapp_firebase/pages/chat_page.dart';
import 'package:chatapp_firebase/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatefulWidget {
 final String userName;
 final String groupName;
 final String groupId;

   const GroupTile({super.key, 
   required this.groupId,
   required this.groupName,
   required this.userName
   
   });

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        nextScreen(context, ChatPage());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(backgroundColor: Theme.of(context).primaryColor ,
          radius: 30,
          child: Text(
            widget.groupName.substring(0,1).toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          )
          )

          
          
          ),
          title: Text(widget.groupName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
          ),
          subtitle: Text("Join the conversation as ${widget.userName}",
          style: TextStyle(
            fontSize: 13
          ),
          )
        ),
      ),
    );
  }
}