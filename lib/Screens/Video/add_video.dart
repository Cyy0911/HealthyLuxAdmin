import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/alert_dialog.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';
import 'package:healthy_lux_admin/Screens/Video/Delete/dlt_abdominal.dart';
import 'package:healthy_lux_admin/Screens/Video/Delete/dlt_arm.dart';
import 'package:healthy_lux_admin/Screens/Video/Delete/dlt_back.dart';
import 'package:healthy_lux_admin/Screens/Video/Delete/dlt_leg.dart';
import 'package:healthy_lux_admin/Screens/Video/Delete/dlt_pectoral.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddVideo extends StatefulWidget {
  const AddVideo({Key? key}) : super(key: key);

  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  final fb = firebase_database.FirebaseDatabase.instance
      .reference()
      .child("VideoLink");
  List<String> itemList = [];
  FirebaseAuth mAuth = FirebaseAuth.instance;

  Future uploadVideo(String fileName) async {
    var uuid = const Uuid();
    dynamic id = uuid.v1();
    final _picker = ImagePicker();

    try {
      mAuth.signInAnonymously().then((value) async {
        // ignore: deprecated_member_use
        PickedFile? file = await _picker.getVideo(source: ImageSource.gallery);
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child(fileName)
            .child(id);
        var imageFile = File(file!.path);
        firebase_storage.UploadTask uploadTask = ref.putFile(imageFile,
            firebase_storage.SettableMetadata(contentType: 'video/mp4'));
        var storageTaskSnapshot = await uploadTask;
        var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        final String url = downloadUrl.toString();
        BuildAlertDialog().buildOKAlertDialog(context, "Upload Video",
            "The video has been uploaded successfully.", "OK");
        fb.child(id).set({
          "id": id,
          "link": url,
        }).then((value) {
          // ignore: avoid_print
          print("Done");
        });
      });
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFF005AA7), Color(0xFFFdfdfd)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Scaffold(
          backgroundColor: AppTheme.transparentColor,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: BuildAppBar(
              title: 'Video',
              backButton: true,
              action: false,
              folder: false,
            ),
          ),
          body: videoBody()),
    );
  }

  Widget videoBody() {
    return ListView(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
      children: [
        buildVideoButton(false, "videoAbdominal",
            'Upload Training Abdominal Video', AppTheme.greenColor),
        buildVideoButton(true, const DeleteAbdominal(),
            'Delete Training Abdominal Video', AppTheme.greenColor),
        buildVideoButton(
            false, "videoArm", 'Upload Arm Video', AppTheme.blueColor),
        buildVideoButton(
            true, const DeleteArm(), 'Delete Arm Video', AppTheme.blueColor),
        buildVideoButton(
            false, "videoLeg", 'Upload Leg Video', AppTheme.orangeColor),
        buildVideoButton(
            true, const DeleteLeg(), 'Delete Leg Video', AppTheme.orangeColor),
        buildVideoButton(
            false, "videoBack", 'Upload Back Video', AppTheme.purpleColor),
        buildVideoButton(true, const DeleteBack(), 'Delete Back Video',
            AppTheme.purpleColor),
        buildVideoButton(false, "videoPectoral", 'Upload Pectoral Video',
            AppTheme.blackColor),
        buildVideoButton(true, const DeletePectoral(), 'Delete Pectoral Video',
            AppTheme.blackColor),
      ],
    );
  }

  buildVideoButton(bool delete, screen, String buttonText, Color color) {
    return Padding(
      padding: delete
          ? const EdgeInsets.only(bottom: 25.0)
          : const EdgeInsets.only(bottom: 10.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: color,
        padding: delete
            ? const EdgeInsets.fromLTRB(0, 20, 0, 20)
            : const EdgeInsets.fromLTRB(0, 40, 0, 40),
        onPressed: delete
            ? () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => screen));
              }
            : () {
                uploadVideo(screen);
              },
        child: Text(buttonText,
            textAlign: TextAlign.center,
            style: delete
                ? AppTheme.defaultTextStyle18White(true)
                : AppTheme.defaultTextStyle20White(true)),
      ),
    );
  }
}
