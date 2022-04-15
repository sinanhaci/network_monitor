import 'dart:convert';
import 'dart:typed_data';
import 'package:dart_ping/dart_ping.dart';
import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network_tools/network_tools.dart';
import 'package:sizer/sizer.dart';
import 'services/custom_scroll_behavior.dart';
import 'window_navigation_view.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:lan_scanner/lan_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  test1();
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

test()async{
  String ip = '192.168.1.107';
  // or You can also get ip using network_info_plus package
  // final String? ip = await (NetworkInfo().getWifiIP());
  final String subnet = ip.substring(0, ip.lastIndexOf('.'));
  final stream = HostScanner.discover(subnet,
      progressCallback: (progress) {
    //print('Progress for host discovery : $progress');
  });

  stream.listen((host) {
    //Same host can be emitted multiple times
    //Use Set<ActiveHost> instead of List<ActiveHost>
    print('Found device: ${host}');
  }, onDone: () {
    print('Scan completed');
  }); 
}

test1()async{
  LanScanner scanner = LanScanner(debugLogging: true);
  final stream = scanner.icmpScan('192.168.1', progressCallback: (progress) {
    print('Progress: $progress');
});

stream.listen((HostModel device) {
    print("Found host: ${device.ip}");
});
}

