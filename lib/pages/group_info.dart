import 'package:chatapp_firebase/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatefulWidget {
    final String adminName;
  final String groupName;
  final String groupId;
  const GroupInfo({super.key, required this.groupId, required this.groupName, required this.adminName});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {

  Stream? members;
  void initState(){
    super.initState();
    getMembers();
  }

  getMembers(){
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getGroupMember(widget.groupId).then((val){
      setState((){
        members = val;
      
      });
    });
   
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Group Info"),
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context,barrierDismissible: false, builder: (context){
              return AlertDialog(
                
                title: const Text("Exit"),
                        content:
                            const Text("Are you sure you exit the group? "),
                         actions:[
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon( Icons.cancel,
                          color: Colors.red,
                          )),

                          IconButton(onPressed: (){
                           


                          }, icon: Icon( Icons.done,
                          color: Colors.green,
                          ))
                         ]
                         

              );
            });
          }, icon: const Icon(Icons.exit_to_app))
        ],


      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
               padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  
            )
          ],
        ),

      )
    );
  }
}