import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../global/common/toast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String username,
      String email, String password) async {
    try {
      //create the user
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //after creating the user, create a new document in cloud firebase called Users

      FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.user?.uid)
          .set({
        'email':credential.user!.email,
        'username' : username,
        'bio' : 'Add a bio here ...',
        'photo' : "",
        'postList':[]
        //add additional fields as needed
      });

      /*FirebaseFirestore.instance
          .collection("Users")
          .add({
        'id': credential.user?.uid,
        'email':credential.user!.email,
        'username' : username,
        'bio' : 'Add a biography here ...',
        'photo' : ""
        //add additional fields as needed
      });*/

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }
}
