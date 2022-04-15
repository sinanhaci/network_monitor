import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:network_monitor/core/constants/device_information.dart';
import 'package:network_monitor/future/project_constants/hive_constants.dart';
import 'package:network_monitor/manager/cache/device_cache_manager.dart';
import 'package:network_monitor/manager/cache/icache_manager.dart';
import 'package:network_monitor/models/device_model.dart';

class DeviceConfigurationPage extends StatefulWidget {
  const DeviceConfigurationPage({Key? key}) : super(key: key);

  @override
  _DeviceConfigurationPageState createState() =>
      _DeviceConfigurationPageState();
}

class _DeviceConfigurationPageState extends State<DeviceConfigurationPage> {
  late final ICacheManager<DeviceModel> cacheManager;

  @override
  void initState() {
    super.initState();
    initCacheManager();
    
  }

  Future<void> initCacheManager() async {
    cacheManager = DeviceCacheManager(HiveConstants.allDeviceKey);
    await cacheManager.init();
    cacheManager.registerAdapters();
    getCacheDevicesList();
    setState(() {});
  }

  List<DeviceModel>? getCacheDevicesList(){
    print(cacheManager.getValues());
    return cacheManager.getValues();
  }


  @override
  Widget build(BuildContext context) {
    return windows.ScaffoldPage(
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: DeviceInformation.deviceHeight * .5,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
