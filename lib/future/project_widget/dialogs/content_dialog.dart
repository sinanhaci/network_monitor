import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/cupertino.dart';
import 'package:network_monitor/core/colors/colors.dart';
import 'package:network_monitor/future/project_widget/input_widgets/windows_button.dart';

customContentDialog({
  required BuildContext context,
  required String dialogTitle,
  required String dialogContent,
  required String okButtonText,
  required String cancelButtonText,
  required Function okButtonOnTap,
  required Function cancelButtonOnTap,
  Color okButtonTextColor = ProjectColor.colorWhite,
  Color cancelButtonTextColor = ProjectColor.colorWhite,
}) {
  return windows.showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return windows.ContentDialog(
        backgroundDismiss: false,
        title: Text(dialogTitle),
        content: Text(dialogContent),
        actions: [
          customWindowsButton(
              onTap: () => okButtonOnTap(),
              buttonText: okButtonText,
              textColor: okButtonTextColor),
          customWindowsButton(
              onTap: () => cancelButtonOnTap(),
              buttonText: cancelButtonText,
              textColor: cancelButtonTextColor),
        ],
      );
    },
  );
}
