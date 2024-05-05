import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }
  Future getUserData(String email) async{
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
  Future getUserGroups() async{
   return userCollection.doc(uid).snapshots();
  }
  Future createGroup(String userName,String id,String groupName) async{
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
//update members
    await groupDocumentReference.update({
      "members":FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id

    });

    DocumentReference userDocumentReference=  userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups": FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
    
  }
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }
  Future getGroupMember(String groupId) async{
    return groupCollection.doc(groupId).snapshots();

  }
  Future searchByName(String rs){
    return groupCollection.where("groupName",isEqualTo: rs).get();
  }
Future<bool> isUserJoined(String groupName, String groupId, String userName) async{
DocumentReference dr = userCollection.doc(uid);
 DocumentSnapshot documentSnapshot = await dr.get();
   List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
}

Future toggleGroupJoin(String groupId, String userName,String groupName) async{
  DocumentReference ur= userCollection.doc(uid);
  DocumentReference gr= groupCollection.doc(uid);

  DocumentSnapshot userSnapshot = await ur.get();
  DocumentSnapshot groupSnapshot = await gr.get();
  List<dynamic> groups = await userSnapshot['groups'];
  
  if(groups.contains("${groupId}_${groupName}")){
    await ur.update({
      "groups":FieldValue.arrayRemove(["${groupId}_${groupName}"]),
    });
    await gr.update({
      "members":FieldValue.arrayRemove(["${uid}_$userName"]),
    });
  
  }
  else{
    await ur.update({
      "groups":FieldValue.arrayUnion(["${groupId}_${groupName}"]),
    });
    await gr.update({
      "members":FieldValue.arrayUnion(["${uid}_$userName"]),
    });
  }

}

}