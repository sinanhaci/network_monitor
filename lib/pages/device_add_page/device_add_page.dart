// ignore_for_file: unused_field

import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:network_monitor/core/colors/colors.dart';
import 'package:network_monitor/core/constants/device_information.dart';
import 'package:network_monitor/core/fonts/fonts.dart';
import 'package:network_monitor/future/project_constants/constants_widgets.dart';
import 'package:network_monitor/future/project_constants/device_list.dart';
import 'package:network_monitor/future/project_constants/hive_constants.dart';
import 'package:network_monitor/future/project_widget/dialogs/dialogs.dart';
import 'package:network_monitor/future/project_widget/input_widgets/custom_text_field.dart';
import 'package:network_monitor/future/project_widget/input_widgets/windows_button.dart';
import 'package:network_monitor/manager/cache/device_cache_manager.dart';
import 'package:network_monitor/manager/cache/icache_manager.dart';
import 'package:network_monitor/models/device_model.dart';
import 'package:network_monitor/services/input_formatters_service/input_formatters_service.dart';
import 'package:sizer/sizer.dart';

class DeviceAddPage extends windows.StatefulWidget {
  const DeviceAddPage({Key? key}) : super(key: key);

  @override
  windows.State<DeviceAddPage> createState() => _DeviceAddPageState();
}

class _DeviceAddPageState extends windows.State<DeviceAddPage> {
  final TextEditingController _deviceNameController = TextEditingController();
  static const String _devicesNameTitle = "Devices Name";
  static const String _devicesNamePlaceHolder = "Enter device name";
  final FocusNode _deviceNameFocusNode = FocusNode();

  final TextEditingController _deviceIpController = TextEditingController();
  static const String _devicesIpAddressTitle = "Ip Address";
  static const String _devicesIpAddressPlaceHolder = "Enter ip adress";
  final FocusNode _devicesIpFocusNode = FocusNode();

  static const String _deviceAddTitle = "Device Information";

  late final ICacheManager<DeviceModel> cacheManager;

  static String _selectedDeviceId = "";
  static DeviceModel? _selectedDeviceModel;
  @override
  void initState() {
    super.initState();
    initCacheManager();
  }

  Future<void> initCacheManager() async {
    cacheManager = DeviceCacheManager(HiveConstants.allDeviceKey);
    await cacheManager.init();
    cacheManager.registerAdapters();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return windows.ScaffoldPage(
      content: SizedBox(
        height: DeviceInformation.deviceHeight,
        width: DeviceInformation.deviceWidth,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: DeviceList.deviceList.length,
                itemBuilder: (context, index) {
                  var deviceInfo = DeviceList.deviceList[index];
                  return _deviceListWidget(deviceInfo, index);
                },
              ),
            ),
            _selectedDeviceId == ""
                ? const SizedBox()
                : windows.Column(
                    children: [
                      windows.Padding(
                        padding: ConstantsWidgets.allPadding_18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _deviceAddTitle,
                              style: CustomTextStyle.boldFont10(
                                ProjectColor.colorWhite,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                customTextBox(
                                    _deviceNameController,
                                    _devicesNameTitle,
                                    _devicesNamePlaceHolder,
                                    _deviceNameFocusNode),
                                customTextBox(
                                    _deviceIpController,
                                    _devicesIpAddressTitle,
                                    _devicesIpAddressPlaceHolder,
                                    _devicesIpFocusNode,
                                    inputFormatter: InputFormatterService.ipAddressInputFilter()),
                              ],
                            ),
                            windows.Padding(
                              padding: ConstantsWidgets.allPadding_8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  customWindowsButton(
                                      buttonText: "Update",
                                      onTap: () async {
                                        _addModelCreate();
                                        await cacheManager
                                            .addItem(_selectedDeviceModel!);
                                        CustomDialogs().getOkDialog(
                                          context,
                                          "Device Added",
                                          "To complete the configuration of the device, go to the configuration screen.",
                                        );
                                        _clearScreen();
                                        print(cacheManager.getValues());
                                        setState(() {});
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  _deviceListWidget(DeviceModel deviceInfo, int index) {
    return GestureDetector(
      onTap: () {
        if (_selectedDeviceId == deviceInfo.deviceId) {
          _selectedDeviceId = "";
          _selectedDeviceModel = DeviceModel(
            deviceId: "",
            deviceImagePath: "",
            deviceIp: "",
            deviceName: "",
            nickName: "",
          );
        } else {
          _selectedDeviceId = deviceInfo.deviceId!;
          _selectedDeviceModel = deviceInfo;
        }
        setState(() {});
      },
      child: windows.Padding(
        padding: EdgeInsets.only(
          left: index == 0 ? 18 : 0,
          right: index == DeviceList.deviceList.length - 1 ? 18 : 0,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: ConstantsWidgets.borderRadiusAll_10,
          ),
          color: _selectedDeviceId == deviceInfo.deviceId
              ? ProjectColor.colorGreyBackground
              : ProjectColor.colorBlackOpacity,
          elevation: _selectedDeviceId == deviceInfo.deviceId ? 5 : 1,
          child: Container(
            height: 10.h,
            width: 10.h,
            margin: ConstantsWidgets.allPadding_8,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    deviceInfo.deviceImagePath!,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: windows.Center(
                    child: Text(
                      deviceInfo.deviceName!,
                      style: CustomTextStyle.boldFont7(
                        _selectedDeviceId == deviceInfo.deviceId
                            ? ProjectColor.colorBlackBackground
                            : ProjectColor.colorWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addModelCreate() {
    _selectedDeviceModel = DeviceModel(
      deviceId: _selectedDeviceModel!.deviceId,
      deviceIp: _deviceIpController.text,
      nickName: _deviceNameController.text,
      deviceImagePath: _selectedDeviceModel!.deviceImagePath,
      deviceStatus: _selectedDeviceModel!.deviceStatus,
      devicesNetworkStatus: _selectedDeviceModel!.devicesNetworkStatus,
      deviceName: _selectedDeviceModel!.deviceName,
    );
  }

  _clearScreen() {
    _selectedDeviceId = "";
    _deviceIpController.text = "";
    _deviceNameController.text = "";
  }
}
