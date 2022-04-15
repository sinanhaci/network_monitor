import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_monitor/future/project_constants/constants_widgets.dart';

customTextBox(TextEditingController controller, String header,
    String placeHolder, FocusNode focusNode,
    {List<TextInputFormatter>? inputFormatter}) {
  return Padding(
    padding: ConstantsWidgets.allPadding_8,
    child: windows.TextBox(
      textInputAction: TextInputAction.next,
      controller: controller,
      header: header,
      placeholder: placeHolder,
      focusNode: focusNode,
      inputFormatters: inputFormatter ?? []
    ),
  );
}
