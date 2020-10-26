import 'dart:io';

import 'package:buddy/services/alert.service.dart';
import 'package:buddy/services/createpost.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../global_widgets/circular_image.dart';
import '../../views/settings/widgets/icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File image;
  final picker = ImagePicker();
  bool busy = false;

  final br = 8.0;

  String userName;
  String userPhoto;
  String userId;

  TextEditingController details = TextEditingController();
  TextEditingController tag1 = TextEditingController();
  TextEditingController tag2 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future getUserDetails() async {
    User user = auth.currentUser;
    userName = user.displayName;
    userPhoto = user.photoURL;
    userId = user.uid;
  }

  Future captureImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );

    setState(() {
      image = File(pickedFile.path);
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    setState(() {
      image = File(pickedFile.path);
    });
  }

  Widget imagePreview() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      height: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(br),
          topLeft: Radius.circular(br),
        ),
        image: DecorationImage(
          image: FileImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  void openMedia() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5.0,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              InkWell(
                onTap: captureImage,
                child: IconTile(
                  icon: FlutterIcons.camera_fea,
                  title: "Camera",
                ),
              ),
              InkWell(
                onTap: getImage,
                child: IconTile(
                  icon: FlutterIcons.ios_images_ion,
                  title: "Gallery",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    tag1.dispose();
    tag2.dispose();
    details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext conext) {
    final userDetails = Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircularImage(
          image: userPhoto,
        ),
        title: Text(userName),
        subtitle: Text(
          "Feeling: ☺️",
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
        ),
      ),
    );

    final input = Container(
      child: TextField(
        controller: details,
        decoration: InputDecoration(
          hintText: "What's on your mind?",
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyText2.color,
            fontSize: 23.0,
          ),
          border: InputBorder.none,
        ),
        cursorColor: Theme.of(context).primaryColor,
      ),
    );

    final tagRow = Row(
      children: [
        SizedBox(
          width: 25,
        ),
        Container(
          width: 120,
          child: TextField(
            controller: tag1,
            decoration: InputDecoration(
              hintText: "Tag-1",
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText2.color,
                fontSize: 15,
              ),
              border: InputBorder.none,
            ),
            cursorColor: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        Container(
          width: 120,
          child: TextField(
            controller: tag2,
            decoration: InputDecoration(
              hintText: "Tag-2",
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText2.color,
                fontSize: 15.0,
              ),
              border: InputBorder.none,
            ),
            cursorColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );

    return busy
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text(
                "Create Post",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    setState(() {
                      busy = true;
                    });
                    await CreatePost().createPost(
                      details: details.text,
                      file: image,
                      userName: userName,
                      userId: userId,
                      userPhoto: userPhoto,
                      tag1: tag1.text,
                      tag2: tag2.text,
                    );

                    setState(() {
                      busy = false;
                    });
                    Navigator.of(context).pop();
                    AlertService().show(
                        message: "Posted Sucessfully",
                        type: AlertType.success,
                        context: context);
                    details.clear();
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                openMedia();
              },
              child: Icon(
                FlutterIcons.photo_fou,
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
              child: Column(
                children: [
                  userDetails,
                  input,
                  tagRow,
                  SizedBox(
                    height: 20,
                  ),
                  if (image != null) ...{imagePreview()}
                ],
              ),
            ),
          );
  }
}
