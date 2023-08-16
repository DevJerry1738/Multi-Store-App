import 'package:flutter/cupertino.dart';

class MyDialog {
  void showDialogBox(
      {required BuildContext context,
      required String title,
      required String content,
      required Function() tapNo,
      required Function() tapYes}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                  child: Text('No'),
                  isDefaultAction: true,
                  onPressed: tapNo,
                ),
                CupertinoDialogAction(
                  child: Text('Yes'),
                  isDefaultAction: true,
                  onPressed: tapYes,
                )
              ],
            ));
  }
}
