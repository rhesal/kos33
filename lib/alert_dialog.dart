import 'package:flutter/material.dart';

enum DialogAction { yes, cancel }

class AlertDialogs {
  static Future<DialogAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
              child: Text(
                'No',
                style: TextStyle(
                    color: Colors.amber[900], fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: Text(
                'Yes',
                style: TextStyle(
                    color: Colors.amber[900], fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.cancel;
  }
}
