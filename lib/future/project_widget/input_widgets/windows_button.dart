import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:network_monitor/core/colors/colors.dart';
import 'package:network_monitor/core/fonts/fonts.dart';

customWindowsButton({required Function onTap, required String buttonText,Color textColor = ProjectColor.colorWhite}) {
  return windows.Button(
    child: Padding(
      padding:const  EdgeInsets.only(
        left: 8,
        right: 8,
        top: 4,
        bottom: 4,
      ),
      child: Text(
        buttonText,
        style: CustomTextStyle.normalFont7(textColor),
      ),
    ),
    onPressed: () => onTap(),
  );
}
