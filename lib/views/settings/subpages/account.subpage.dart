import 'dart:io';

import 'package:buddy/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_storage/firebase_storage.dart';

import '../../../services/alert.service.dart';
import 'package:image_picker/image_picker.dart';

import '../../../global_widgets/circular_image_picker.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../../config/extensions.dart';

class AccountSubpage extends StatefulWidget {
  final User user;

  const AccountSubpage({Key key, @required this.user}) : super(key: key);
  @override
  _AccountSubpageState createState() => _AccountSubpageState();
}

class _AccountSubpageState extends State<AccountSubpage> {
  File _image;

  bool isBusy = false;

  Future pickImage() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 40);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  var storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController =
        new TextEditingController(text: widget.user.name);

    final image = Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: CircularImagePicker(
        assetImage: widget.user.photo,
        size: 120.0,
        showIcon: true,
        imagePy: 80.0,
        file: _image,
        onPressed: () {
          pickImage();
        },
      ),
    ).fadeIn(1);

    Future<void> updateProfile() async {
      print(userNameController.text);
      print(widget.user.name);

      if (userNameController.text == widget.user.name && _image == null) {
        AlertService().show(
          message: "Nothing to update",
          type: AlertType.warning,
          context: context,
        );
      } else if (userNameController.text == widget.user.name &&
          _image != null) {
        var imageId = widget.user.username;
        StorageTaskSnapshot snapshot = await storage
            .ref()
            .child("userpics/$imageId")
            .putFile(_image)
            .onComplete;
        if (snapshot.error == null) {
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection("users")
              .doc(widget.user.id)
              .update({"profile_url": downloadUrl});
          Auth.FirebaseAuth.instance.currentUser.updateProfile(
              displayName: userNameController.text, photoURL: downloadUrl);
        } else if (_image == null &&
            userNameController.text != widget.user.name) {
          var userDoc = await FirebaseFirestore.instance
              .collection("usernames")
              .doc(userNameController.text)
              .get();
          if (userDoc.exists) {
            AlertService().show(
              message: "Username Already Exists",
              type: AlertType.error,
              context: context,
            );
          } else {
            var dataSnap = await FirebaseFirestore.instance
                .collection("users")
                .doc(widget.user.id)
                .get();
            var data = {
              "userName": userNameController.text,
              "uid": dataSnap.data()["uid"],
              "email": dataSnap.data()["email"],
              "profile_url": widget.user.photo,
              "posts": widget.user.posts,
              "present_feed": dataSnap.data()["present_feed"],
              "games_following": dataSnap.data()["games_following"],
              "followers": dataSnap.data()["followers"],
              "following": dataSnap.data()["following"],
              "missions_assigned": dataSnap.data()["missions_assigned"],
              "missions_completed": dataSnap.data()["missions_completed"],
              "tier": dataSnap.data()["tier"],
            };
            Auth.FirebaseAuth.instance.currentUser
                .updateProfile(displayName: userNameController.text);
            FirebaseFirestore.instance
                .collection("usernames")
                .doc(widget.user.name)
                .delete();
            FirebaseFirestore.instance
                .collection("usernames")
                .doc(userNameController.text)
                .set({"uid": widget.user.id});
            FirebaseFirestore.instance
                .collection("users")
                .doc(widget.user.id)
                .update(data);
          }
        } else if (_image != null &&
            userNameController.text != widget.user.name) {
          var imageId = userNameController.text;
          print("Not Null 1");
          StorageTaskSnapshot snapshot = await storage
              .ref()
              .child("userpics/$imageId")
              .putFile(_image)
              .onComplete;
          if (snapshot.error == null) {
            print("Not Null 2");
            final String downloadUrl = await snapshot.ref.getDownloadURL();
            var userDoc = await FirebaseFirestore.instance
                .collection("usernames")
                .doc(userNameController.text)
                .get();
            if (userDoc.exists) {
              print("Not Null 3");
              AlertService().show(
                message: "Username Already Exists",
                type: AlertType.error,
                context: context,
              );
            } else {
              print("Not Null 4");
              var dataSnap = await FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.user.id)
                  .get();
              var data = {
                "userName": userNameController.text,
                "uid": dataSnap.data()["uid"],
                "email": dataSnap.data()["email"],
                "profile_url": downloadUrl,
                "posts": widget.user.posts,
                "present_feed": dataSnap.data()["present_feed"],
                "games_following": dataSnap.data()["games_following"],
                "followers": dataSnap.data()["followers"],
                "following": dataSnap.data()["following"],
                "missions_assigned": dataSnap.data()["missions_assigned"],
                "missions_completed": dataSnap.data()["missions_completed"],
                "tier": dataSnap.data()["tier"],
              };
              print("Not Null 5");
              Auth.FirebaseAuth.instance.currentUser.updateProfile(
                  displayName: userNameController.text, photoURL: downloadUrl);
              FirebaseFirestore.instance
                  .collection("usernames")
                  .doc(widget.user.name)
                  .delete();
              FirebaseFirestore.instance
                  .collection("usernames")
                  .doc(userNameController.text)
                  .set({"uid": widget.user.id});
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.user.id)
                  .set(data);
            }
          } else {
            AlertService().show(
              message: snapshot.error.toString(),
              type: AlertType.error,
              context: context,
            );
          }
        }
      }
    }

    final usernameField = CustomFormField(
      labelText: "Username",
      icon: FlutterIcons.at_mco,
      controller: userNameController,
    ).fadeIn(1.5);

    final button = CustomButton(
      text: "Update",
      onPressed: () async {
        setState(() {
          isBusy = true;
        });
        await updateProfile();
        setState(() {
          isBusy = false;
        });
        AlertService().show(
          message: "Updates Successfully",
          type: AlertType.success,
          context: context,
        );
        Navigator.of(context).pop();
      },
    ).fadeIn(4);
    return isBusy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15.0,
            ),
            child: Column(
              children: [image, usernameField, button],
            ),
          );
  }
}
