import 'package:network_monitor/core/constants/asset_constants.dart';
import 'package:network_monitor/models/device_model.dart';

class DeviceList {
  static const String nameISP = "Internet Service Provider";
  static const String nameSwitch = "Network Switch";
  static const String nameFirewall = "Firewall";
  static const String nameServer = "Server";
  static const String nameNAS = "Network Attached Storage";
  static const String nameCamera = "Camera-DVR";
  static const String namePrinter = "Printer";
  static const String namePc = "Computer";
  static const String nameMobile = "Mobile";
  static const String nameOther = "Other";

  static List<DeviceModel> deviceList = [
    DeviceModel(
        deviceId: "01",
        deviceName: nameISP,
        deviceImagePath: AssetsImage.iconInternet,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "02",
        deviceName: nameSwitch,
        deviceImagePath: AssetsImage.iconSwitch,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "03",
        deviceName: nameFirewall,
        deviceImagePath: AssetsImage.iconFirewall,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "04",
        deviceName: nameServer,
        deviceImagePath: AssetsImage.iconServer,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "05",
        deviceName: nameNAS,
        deviceImagePath: AssetsImage.iconNas,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "06",
        deviceName: nameCamera,
        deviceImagePath: AssetsImage.iconCamera,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "07",
        deviceName: namePrinter,
        deviceImagePath: AssetsImage.iconPrinter,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "08",
        deviceName: namePc,
        deviceImagePath: AssetsImage.iconPc,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "09",
        deviceName: nameMobile,
        deviceImagePath: AssetsImage.iconMobile,
        deviceIp: "",
        nickName: ""),
    DeviceModel(
        deviceId: "10",
        deviceName: nameOther,
        deviceImagePath: AssetsImage.iconOther,
        deviceIp: "",
        nickName: ""),
  ];
}
