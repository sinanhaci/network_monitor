import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:network_monitor/core/colors/colors.dart';
import 'package:network_monitor/core/constants/asset_constants.dart';
import 'package:network_monitor/core/fonts/fonts.dart';
import 'core/constants/device_information.dart';
import 'pages/device_add_page/device_add_page.dart';
import 'pages/device_configuration_page/device_configuration_page.dart';
import 'pages/network_monitoring_page/network_monitoring_page.dart';

int addItemBadge = 0;
class WindowsNavigationView extends StatefulWidget {
  const WindowsNavigationView({Key? key}) : super(key: key);
  

  @override
  _WindowsNavigationViewState createState() => _WindowsNavigationViewState();
}

class _WindowsNavigationViewState extends State<WindowsNavigationView> {

  static int _activeIndex = 0;
  static const String _networkMonitoring = "Network Monitoring";
  static const String _deviceConfiguration = "Device Configuration";
  static const String _deviceAdd = "Device Add";


  @override
  Widget build(BuildContext context) {
    DeviceInformation.getDeviceSizeInfo(MediaQuery.of(context).size);
    return windows.NavigationView(
      contentShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      pane: windows.NavigationPane(
        onChanged: (i) => setState(() => _activeIndex = i),
        displayMode: windows.PaneDisplayMode.compact,
        selected: _activeIndex,
        items: [
          _paneItem(
            _networkMonitoring,
            AssetsImage.iconMonitoring,
          ),
          _paneItem(
            _deviceConfiguration,
            AssetsImage.iconConfiguration,
          ),
          _paneItem(
            _deviceAdd,
            AssetsImage.iconAdd,
          ),
        ],
      ),
      content: windows.NavigationBody(
        index: _activeIndex,
        children: const [
          NetworkMonitoringPage(),
          DeviceConfigurationPage(),
          DeviceAddPage(),
          
        ],
      ),
    );
  }

  _paneItem(String title, String assetPath) {
    return windows.PaneItem(
      icon: windows.SizedBox(
        width: 18,
        child: Image.asset(
          assetPath,
          fit: BoxFit.fill,
        ),
      ),
      title: Text(title,
          style: CustomTextStyle.boldFont12(ProjectColor.colorBlack)),
    );
  }
}
