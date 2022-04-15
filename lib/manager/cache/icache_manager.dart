import 'package:hive_flutter/hive_flutter.dart';
import 'package:network_monitor/models/device_model.dart';

abstract class ICacheManager<T> {
  final String key;
  Box<DeviceModel>? box;

  ICacheManager(this.key);

  Future<void> init() async {
    registerAdapters();
    if (!(box?.isOpen ?? false)) {
      box = await Hive.openBox(key);
    }
  }

  void registerAdapters();

  Future<void> clearAll() async {
    await box?.clear();
  }

  Future<void> addItems(List<T> items);
  Future<void> addItem(T item);
  Future<void> putItems(List<T> items);
  

  T? getItem(String key);
  List<T>? getValues();

  Future<void> putItem(String key, T item);
  Future<void> putItemIndex(int index, T item);
  Future<void> removeItem(int index);
  Future<void>? removeAll();

}