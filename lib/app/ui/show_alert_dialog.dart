import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  @required String defaultActionText,
}) async {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text(defaultActionText),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); //Dismiss dialog
                }),
          ],
        );
      },
    );
  }
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
              child: Text(defaultActionText),
              onPressed: () {
                Navigator.of(dialogContext).pop(); //Dismiss dialog
              }),
        ],
      );
    },
  );
}
