import 'package:hive_flutter/adapters.dart';
import 'package:network_monitor/future/project_constants/hive_constants.dart';
import 'package:network_monitor/models/device_model.dart';

import 'icache_manager.dart';

class DeviceCacheManager extends ICacheManager<DeviceModel> {
  DeviceCacheManager(String key) : super(key);
  
  @override
  Future<void> addItems(List<DeviceModel> items) async {
    await box?.addAll(items);
  }

  
  @override
  Future<void> addItem(DeviceModel item) async {
    await box?.add(item);
  }

  @override
  Future<void> putItems(List<DeviceModel> items) async {
    await box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.deviceId, e))));
  }

  @override
  DeviceModel? getItem(String key) {
    return box?.get(key);
  }

  @override
  Future<void> putItem(String key, DeviceModel item) async {
    await box?.put(key, item);
  }

  
  @override
  Future<void> putItemIndex(int index, DeviceModel item) async{
     await box?.putAt(index, item);
  }

  @override
  Future<void> removeItem(int index) async {
    await box?.deleteAt(index);
  }

  @override
  List<DeviceModel>? getValues() {
    return box?.values.toList();
  }



  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.deviceTypeId)) {
      Hive.registerAdapter(DeviceModelAdapter());
    }
  }

  @override
  Future<void>? removeAll() {
    return box?.deleteFromDisk();
  }

 


}