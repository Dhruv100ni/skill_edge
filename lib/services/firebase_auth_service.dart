import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  
  Future login(String email, String password) async {

    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future signup(String username, String email, String password, String branch, String field)  async {
    try{
      final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      print("USer to ban gaya");
      await db.collection("users").doc(uid).set({
        "username": username,
        "email": email,
        "branch": branch,
        "field": field,
      }
      
      ).onError((e, _) => print("Error writing document: $e"));

      print(userCredential.user?.uid);
      print(username +" "+ email + password + branch + field);
      
    } on FirebaseAuthException catch  (e) {
    print('Failed with error code: ${e.code}');
    print(e.message);
  }
  }

   Future logininwithgoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential myCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(myCredential);

    debugPrint(user.user?.displayName);
  }
}