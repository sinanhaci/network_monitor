import 'package:flutter/material.dart';

class CustomInputMenu extends StatelessWidget {
  final bool menuOpen;
  final Widget menuWidget;
  const CustomInputMenu(
      {required this.menuWidget, required this.menuOpen, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: menuOpen
          ? menuWidget
          : Container(
              key: const ValueKey<int>(0),
            ),
      switchInCurve: Curves.linear,
      switchOutCurve: Curves.fastLinearToSlowEaseIn,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            animation,
          ),
          child: child,
        );
      },
    );
  }
}
