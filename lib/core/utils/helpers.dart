import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sw8Dialog {
  static void showOkDialog(
    BuildContext context,
    String title,
    String message, {
    void Function()? onOkPressed,
  }) {
    Platform.isIOS
        ? showCupertinoDialog<void>(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: onOkPressed == null
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : () {},
                  child: const Text('Okay'),
                ),
              ],
            ),
          )
        : showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    onPressed: onOkPressed == null
                        ? () {
                            Navigator.of(context).pop();
                          }
                        : () {},
                    child: const Text('Okay'),
                  ),
                ],
              );
            },
          );
  }
}
