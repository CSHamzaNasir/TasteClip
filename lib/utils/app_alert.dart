import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

enum ActionStyle { normal, destructive, important, importantDestructive }

class AppAlerts {
  final Color _normal = Colors.blue;
  final Color _destructive = Colors.red;

  /// show the OS Native dialog
  showOSDialog(
    BuildContext context,
    String title,
    String message,
    String firstButtonText,
    Function firstCallBack, {
    ActionStyle firstActionStyle = ActionStyle.normal,
    required String secondButtonText,
    required Function secondCallback,
    ActionStyle secondActionStyle = ActionStyle.normal,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return PopScope(
            onPopInvoked: (pop) => false,
            child: _iosDialog(
                context, title, message, firstButtonText, firstCallBack,
                firstActionStyle: firstActionStyle,
                secondButtonText: secondButtonText,
                secondCallback: secondCallback,
                secondActionStyle: secondActionStyle),
          );
        } else {
          return PopScope(
            onPopInvoked: (pop) => false,
            child: _androidDialog(
                context, title, message, firstButtonText, firstCallBack,
                firstActionStyle: firstActionStyle,
                secondButtonText: secondButtonText,
                secondCallback: secondCallback,
                secondActionStyle: secondActionStyle),
          );
        }
      },
    );
  }

  /// show the android Native dialog
  Widget _androidDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallBack,
      {ActionStyle firstActionStyle = ActionStyle.normal,
      required String secondButtonText,
      required Function secondCallback,
      ActionStyle secondActionStyle = ActionStyle.normal}) {
    List<MaterialButton> actions = [];
    actions.add(MaterialButton(
      child: Text(
        firstButtonText,
        style: TextStyle(
            color: (firstActionStyle == ActionStyle.importantDestructive ||
                    firstActionStyle == ActionStyle.destructive)
                ? _destructive
                : _normal,
            fontWeight: (firstActionStyle == ActionStyle.importantDestructive ||
                    firstActionStyle == ActionStyle.important)
                ? FontWeight.bold
                : FontWeight.normal),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        firstCallBack();
      },
    ));

    if (secondButtonText.isNotEmpty) {
      actions.add(MaterialButton(
        child: Text(secondButtonText,
            style: TextStyle(
                color: (secondActionStyle == ActionStyle.importantDestructive ||
                        firstActionStyle == ActionStyle.destructive)
                    ? _destructive
                    : _normal)),
        onPressed: () {
          Navigator.of(context).pop();
          secondCallback();
        },
      ));
    }

    return AlertDialog(
        title: Text(title),
        content: Text(
          message,
          style: const TextStyle(color: Colors.blueAccent),
        ),
        actions: actions);
  }

  /// show the iOS Native dialog
  Widget _iosDialog(
    BuildContext context,
    String title,
    String message,
    String firstButtonText,
    Function firstCallback, {
    ActionStyle firstActionStyle = ActionStyle.normal,
    required String secondButtonText,
    required Function secondCallback,
    ActionStyle secondActionStyle = ActionStyle.normal,
  }) {
    List<CupertinoDialogAction> actions = [];
    actions.add(
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context).pop();
          firstCallback();
        },
        child: Text(
          firstButtonText,
          style: TextStyle(
              color: (firstActionStyle == ActionStyle.importantDestructive ||
                      firstActionStyle == ActionStyle.destructive)
                  ? _destructive
                  : _normal,
              fontWeight:
                  (firstActionStyle == ActionStyle.importantDestructive ||
                          firstActionStyle == ActionStyle.important)
                      ? FontWeight.bold
                      : FontWeight.normal),
        ),
      ),
    );

    if (secondButtonText.isNotEmpty) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
            secondCallback();
          },
          child: Text(
            secondButtonText,
            style: TextStyle(
                color: (secondActionStyle == ActionStyle.importantDestructive ||
                        secondActionStyle == ActionStyle.destructive)
                    ? _destructive
                    : _normal,
                fontWeight:
                    (secondActionStyle == ActionStyle.importantDestructive ||
                            secondActionStyle == ActionStyle.important)
                        ? FontWeight.bold
                        : FontWeight.normal),
          ),
        ),
      );
    }

    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions,
    );
  }
}

class CustomAppAlert extends StatelessWidget {
  final String icon;
  final String title;
  final double size;

  const CustomAppAlert({
    super.key,
    required this.icon,
    required this.title,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: const Color(0xff4F5059),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
