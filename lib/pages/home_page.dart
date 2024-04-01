import 'package:chatapp_firebase/helper/helper_function.dart';
import 'package:chatapp_firebase/pages/auth/login_page.dart';
import 'package:chatapp_firebase/pages/profile_page.dart';
import 'package:chatapp_firebase/pages/search_page.dart';
import 'package:chatapp_firebase/service/auth_service.dart';
import 'package:chatapp_firebase/service/database_service.dart';
import 'package:chatapp_firebase/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = "";
  String name = "";
  AuthService auth = AuthService();
  Stream? groups;
  @override
  void initState(){
    super.initState();
    getUserDetails();
  }
  void getUserDetails() async{
    await HelperFunction.getUserEmail().then((value){
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUserName().then((value){
      setState(() {
        name = value!;
      });
    });
    await DatabaseService(uid :FirebaseAuth.instance.currentUser!.uid).getUserGroups().then((snapshot){
      setState(){
        groups = snapshot;
      };
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(context, const SearchPage());
            },
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Groups",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            const Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey,
            ),
            const SizedBox(height: 15),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Divider(
            height: 2,
          ),
          ListTile(
            onTap:(){},
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.group),
            title: const Text("Groups",style:TextStyle(color: Colors.black)),
            
            

          ),
          ListTile(
            onTap:(){
              nextScreenReplace(context, ProfilePage(
                email: email,
                userName: name,
              ));
            },
            // selectedColor: Theme.of(context).primaryColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.person),
            title: const Text("Profile",style:TextStyle(color: Colors.black)),

            

          ),
          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await auth.signout();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  });
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          )

          ],
        ),
      ),
       body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        shape: CircleBorder(
          
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        
        ),
        
    );
    
  }
   popUpDialog(BuildContext context) {
   }
  groupList(){

  }
}

  