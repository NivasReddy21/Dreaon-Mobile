import 'package:buddy/constants/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alert.service.dart';

class Authentication {
  AlertService alert = new AlertService();

  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _userNamesCollectionReference =
      FirebaseFirestore.instance.collection('usernames');

  Future<void> register(
      {email, password, userName, BuildContext context}) async {
    final snapShot = await _userNamesCollectionReference.doc(userName).get();

    if (!snapShot.exists || snapShot.exists == null) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        await storeUser(result, userName);
        await result.user.sendEmailVerification();
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }).catchError((onError) {
        print(onError);
      });
    } else {
      alert.show(
          message: "Username Already Exists",
          type: AlertType.error,
          context: context);
      return null;
    }
  }

  Future<void> storeUser(result, userName) async {
    User user = result.user;

    await user.updateProfile(
      photoURL:
          "https://firebasestorage.googleapis.com/v0/b/blackfyre-f41b2.appspot.com/o/avatar_default.jpg?alt=media&token=03fbb20b-3b85-470d-8fcb-769aecf32288",
      displayName: userName,
    );

    var newUser = {
      "userName": userName,
      "uid": user.uid,
      "email": user.email,
      "profile_url":
          "https://firebasestorage.googleapis.com/v0/b/blackfyre-f41b2.appspot.com/o/avatar_default.jpg?alt=media&token=03fbb20b-3b85-470d-8fcb-769aecf32288",
      "posts": [],
      "present_feed": [],
      "games_following": [],
      "followers": 0,
      "following": 0,
      "missions_assigned": [],
      "missions_completed": [],
      "tier": "League-1"
    };
    await _usersCollectionReference.doc(user.uid).set(newUser);
    await _userNamesCollectionReference.doc(userName).set({"uid": user.uid});
  }

  Future<void> login({email, password, context}) async {
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user.emailVerified) {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setBool('loggedIn', true);

          Navigator.of(context).pushReplacementNamed(AppRoutes.tabs);
        } else {
          AlertService().show(
              message: "Please Verify Email",
              type: AlertType.warning,
              context: context);
        }
      }).catchError((e) {
        alert.show(
            message: e.toString(), type: AlertType.error, context: context);
      });
    } catch (e) {
      alert.show(
          message: e.toString(), type: AlertType.error, context: context);
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);

    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
