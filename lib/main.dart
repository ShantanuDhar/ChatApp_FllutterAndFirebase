import 'package:chatapp_firebase/firebase_options.dart';
import 'package:chatapp_firebase/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' ;
import 'secrets.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: constants.apiKey, appId: constants.appId, messagingSenderId: constants.messagingSenderId, projectId: constants.projectId)
);
  }
  else{
    await Firebase.initializeApp();
  
  }
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}