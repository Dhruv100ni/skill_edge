import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future login(String email, String password) async {
    final userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    String uid = userCredential.user!.uid;
    final docRef = db.collection("users").doc(uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        //CurrentUser.login(data["username"], data["email"], data["branch"], data["field"]);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future signup(String username, String email, String password, String branch,
      String field) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = userCredential.user!.uid;

      await db.collection("users").doc(uid).set({
        "username": username,
        "email": email,
        "branch": branch,
        "field": field,
      }).onError((e, _) => print("Error writing document: $e"));
    } on FirebaseAuthException catch (e) {
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
