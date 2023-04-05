import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

Future alertBox(
    {required BuildContext context,
    required String error,
    void Function()? onButtonTap}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Error"),
      content: Text(error),
      actions: <Widget>[
        TextButton(
          onPressed: onButtonTap,
          child: Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.all(14),
            child: const Text(
              "Exit",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
