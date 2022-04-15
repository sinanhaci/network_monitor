import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'services/custom_scroll_behavior.dart';
import 'window_navigation_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const NetworkMonitorApp());
}

class NetworkMonitorApp extends StatelessWidget {
  const NetworkMonitorApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (ctx1, orientation, deviceType) {
      return windows.FluentApp(
        scrollBehavior: MyCustomScrollBehavior(),
        theme: windows.ThemeData.light(),
        darkTheme: windows.ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: const WindowsNavigationView(),
      );
    });
  }
}
