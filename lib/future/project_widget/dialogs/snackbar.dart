import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:network_monitor/future/project_constants/constants_widgets.dart';

customSnackBar(BuildContext context, String title) {
  return windows.showSnackbar(
    context,
    windows.Snackbar(
      content: windows.Padding(
        padding: ConstantsWidgets.allPadding_8,
        child: Text(title),
      ),
    ),
  );
}
