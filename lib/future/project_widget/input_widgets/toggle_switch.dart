import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool toggleStatus;
  final String trueText;
  final String falseText;
  final String title;
  final Function(bool) onChanged;

  const CustomToggleSwitch(
      {Key? key,
      required this.onChanged,
      required this.title,
      required this.toggleStatus,
      required this.trueText,
      required this.falseText})
      : super(key: key);

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return windows.Column(
      children: [
         Text(widget.title),
        const SizedBox(
          height: 3,
        ),
        windows.ToggleSwitch(
          checked: widget.toggleStatus,
          onChanged:widget.onChanged, 
          content: Text(widget.toggleStatus ? widget.trueText : widget.falseText),
        ),
      ],
    );
  }
}
