import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String username = "";
  String email = "";
  String branch = "";
  String field = "";

  void logout() {
    username = "";
    email = "";
    branch = "";
    field = "";
    notifyListeners();
  }

  void compLogin(String username, String email, String branch, String field) {
    this.username = username;
    this.email = email;
    this.branch = branch;
    this.field = field;
    notifyListeners();
  }

  Future custLogin(String email, String password) async {
    final userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    String uid = userCredential.user!.uid;
    final docRef = db.collection("users").doc(uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        compLogin(
            data["username"], data["email"], data["branch"], data["field"]);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
