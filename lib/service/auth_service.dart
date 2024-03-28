import 'package:chatapp_firebase/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //register
  Future registerUser(String fullName, String email, String password) async {
try{
 UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
 User user = userCredential.user!;


 if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
} on FirebaseAuthException catch(e){
return e.message;
}
}
}