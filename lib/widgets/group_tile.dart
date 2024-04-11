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
    return ListTile(
      title: Text(widget.groupName),
      subtitle: Text(widget.groupId),

    );
  }
}