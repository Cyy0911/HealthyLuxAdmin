import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BuildAlertDialog {
  buildOKAlertDialog(
      BuildContext context, String title, String content, String buttonText) {
    Widget okButton = TextButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  buildYesNoAlertDialog(BuildContext context, String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(
          child: const Text("Yes"),
          onPressed: () => Navigator.pop(context, true),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          child: const Text("No"),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
