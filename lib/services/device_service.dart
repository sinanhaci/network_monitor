import 'package:network_monitor/models/device_model.dart';

class DeviceCrudService {
  static Future<DeviceModel> createSelectedDeviceModel({
    required DeviceModel? selectedDeviceModel,
    required String deviceName,
    required String deviceIpAddress,
    required bool deviceStatus,
    double offsetDx = 100,
    double offsetDy = 100
  }) async {
    selectedDeviceModel = DeviceModel(
      deviceId: selectedDeviceModel!.deviceId,
      deviceIp: deviceIpAddress,
      nickName: deviceName,
      deviceImagePath: selectedDeviceModel.deviceImagePath,
      deviceStatus: deviceStatus,
      devicesNetworkStatus: selectedDeviceModel.devicesNetworkStatus,
      deviceName: selectedDeviceModel.deviceName,
      offsetDx: offsetDx,
      offsetDy: offsetDy
    );
    return selectedDeviceModel;
  }

  static deleteSelectedDeviceModel({
    required DeviceModel? selectedDeviceModel,
  }) async {
    selectedDeviceModel = DeviceModel(
      deviceId: "",
      deviceImagePath: "",
      deviceIp: "",
      deviceName: "",
      nickName: "",
    );
  }
}
