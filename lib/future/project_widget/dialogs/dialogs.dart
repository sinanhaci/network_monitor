import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';

class CustomDialogs{
  getOkDialog(BuildContext context,String title,String content) {
  return windows.showDialog(
      context: context,
      builder: (context) {
        return windows.ContentDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            windows.Button(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      });
}
}