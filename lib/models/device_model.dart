import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:network_monitor/future/project_constants/hive_constants.dart';

part 'device_model.g.dart';

@HiveType(typeId: HiveConstants.deviceTypeId)
class DeviceModel {
  @HiveField(0)
  String? deviceId;
  @HiveField(1)
  String? deviceName;
  @HiveField(2)
  String? nickName;
  @HiveField(3)
  bool? deviceStatus;
  @HiveField(4)
  bool? devicesNetworkStatus;
  @HiveField(5)
  String? deviceImagePath;
  @HiveField(6)
  String? deviceIp;
  @HiveField(7)
  double offsetDx;
  @HiveField(8)
  double offsetDy;

  DeviceModel({
    this.deviceId,
    this.deviceName,
    this.nickName,
    this.deviceStatus = false,
    this.devicesNetworkStatus = false,
    this.deviceImagePath,
    this.deviceIp,
    this.offsetDx = 100.0,
    this.offsetDy = 100.0,
  });

  static getBlankModel() {
    return DeviceModel(
      deviceId: "",
      deviceImagePath: "",
      deviceIp: "",
      deviceName: "",
      nickName: "",
    );
  }
}
