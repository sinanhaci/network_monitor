import 'dart:convert';
import 'dart:io';

import 'package:dart_ping/dart_ping.dart';
import 'package:fluent_ui/fluent_ui.dart' as windows;
import 'package:flutter/material.dart';
import 'package:network_monitor/core/colors/colors.dart';
import 'package:network_monitor/core/fonts/fonts.dart';
import 'package:network_monitor/future/project_constants/constants_widgets.dart';
import 'package:network_monitor/future/project_constants/device_list.dart';
import 'package:network_monitor/future/project_constants/hive_constants.dart';
import 'package:network_monitor/future/project_widget/dialogs/content_dialog.dart';
import 'package:network_monitor/future/project_widget/dialogs/snackbar.dart';
import 'package:network_monitor/future/project_widget/input_widgets/custom_input_menu/custom_input_menu.dart';
import 'package:network_monitor/future/project_widget/input_widgets/custom_text_field.dart';
import 'package:network_monitor/future/project_widget/input_widgets/toggle_switch.dart';
import 'package:network_monitor/future/project_widget/input_widgets/windows_button.dart';
import 'package:network_monitor/manager/cache/device_cache_manager.dart';
import 'package:network_monitor/manager/cache/icache_manager.dart';
import 'package:network_monitor/models/device_model.dart';
import 'package:network_monitor/services/device_service.dart';
import 'package:network_monitor/services/drag_and_drop_widget.dart';
import 'package:network_monitor/services/input_formatters_service/input_formatters_service.dart';
import 'package:sizer/sizer.dart';

class NetworkMonitoringPage extends windows.StatefulWidget {
  const NetworkMonitoringPage({Key? key}) : super(key: key);

  @override
  windows.State<NetworkMonitoringPage> createState() =>
      _NetworkMonitoringPageState();
}

class _NetworkMonitoringPageState extends windows.State<NetworkMonitoringPage> {
  late final ICacheManager<DeviceModel> cacheManager;
  List<DeviceModel>? allDevices;
  static int _selectedIndex = 0;
  static DeviceModel? _selectedDeviceModel = DeviceModel.getBlankModel();

  final TextEditingController _deviceNickNameController =
      TextEditingController();
  final FocusNode _deviceNickNameFocusNode = FocusNode();

  final TextEditingController _deviceIpAddressController =
      TextEditingController();
  final FocusNode _deviceIpAddressFocusNode = FocusNode();

  static bool _toggleDeviceStatus = false;
  static bool deviceAddPanel = false;
  static bool deviceUpdatePanel = false;
  static String _selectedDeviceId = "";

  @override
  void initState() {
    super.initState();
    initCacheManager();
  }

  Future<void> initCacheManager() async {
    cacheManager = DeviceCacheManager(HiveConstants.allDeviceKey);
    await cacheManager.init();
    cacheManager.registerAdapters();
    _getCacheDevicesList();
    setState(() {});
  }

  List<DeviceModel>? _getCacheDevicesList() {
    allDevices = cacheManager.getValues();
    setState(() {});
    pingMetod(allDevices);
  }

  @override
  Widget build(BuildContext context) {
    
    return windows.ScaffoldPage(
      content: allDevices == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  for (var index = 0; index < allDevices!.length; index++)
                    DragAndDropDevice(
                      deviceInfo: allDevices![index],
                      child: _deviceInStack(allDevices![index], index),
                      cacheManager: cacheManager,
                      index: index,
                    ),
                  Positioned(
                    right: 18,
                    bottom: 0,
                    child: FloatingActionButton(
                      onPressed: () {
                        _textFieldClear();
                        deviceAddPanel = !deviceAddPanel;
                        setState(() {});
                      },
                      backgroundColor: ProjectColor.colorBlackBackground,
                      child: const Icon(
                        Icons.add,
                        color: ProjectColor.colorWhite,
                        size: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: CustomInputMenu(
                      menuOpen: deviceUpdatePanel,
                      menuWidget: _deviceInfoAndUpdateWidget(),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: CustomInputMenu(
                      menuOpen: deviceAddPanel,
                      menuWidget: _deviceAddPanel(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _deviceAddPanel() {
    return Container(
      color: ProjectColor.colorBlackBackground,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: ConstantsWidgets.allPadding_18,
            child: Row(
              children: [
                Text(
                  MonitoringPageConstants.deviceAdd,
                  style: CustomTextStyle.boldFont10(ProjectColor.colorWhite),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    deviceAddPanel = false;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.clear,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Padding(
            padding: ConstantsWidgets.onlyLeftRightPadding_18,
            child: Text(
              MonitoringPageConstants.selectedDeviceType,
              style: CustomTextStyle.boldFont8(ProjectColor.colorWhite),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          SizedBox(
            height: 6.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: DeviceList.deviceList.length,
              itemBuilder: (context, index) {
                var deviceInfo = DeviceList.deviceList[index];
                return _deviceHorizontalListWidget(deviceInfo, index);
              },
            ),
          ),
          _selectedDeviceId == ""
              ? const SizedBox()
              : Column(
                  children: [
                    Padding(
                      padding: ConstantsWidgets.allPadding_18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MonitoringPageConstants.deviceInfo,
                            style: CustomTextStyle.boldFont10(
                              ProjectColor.colorWhite,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          customTextBox(
                            _deviceNickNameController,
                            MonitoringPageConstants.deviceName,
                            MonitoringPageConstants.enterDeviceName,
                            _deviceNickNameFocusNode,
                          ),
                          customTextBox(
                              _deviceIpAddressController,
                              MonitoringPageConstants.ipAddress,
                              MonitoringPageConstants.enterIpAddress,
                              _deviceIpAddressFocusNode,
                              inputFormatter:
                                  InputFormatterService.ipAddressInputFilter()),
                          Padding(
                            padding: ConstantsWidgets.allPadding_8,
                            child: CustomToggleSwitch(
                              title: MonitoringPageConstants.deviceStatus,
                              toggleStatus: _toggleDeviceStatus,
                              falseText: MonitoringPageConstants.ofToggle,
                              trueText: MonitoringPageConstants.onToggle,
                              onChanged: (v) => setState(
                                () => _toggleDeviceStatus = v,
                              ),
                            ),
                          ),
                          Padding(
                            padding: ConstantsWidgets.allPadding_8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                customWindowsButton(
                                  buttonText: MonitoringPageConstants.add,
                                  onTap: () async {
                                    await DeviceCrudService
                                        .createSelectedDeviceModel(
                                      deviceIpAddress:
                                          _deviceIpAddressController.text,
                                      deviceName:
                                          _deviceNickNameController.text,
                                      deviceStatus: _toggleDeviceStatus,
                                      selectedDeviceModel: _selectedDeviceModel,
                                    ).then(
                                      (value) async {
                                        await cacheManager.addItem(value);
                                        _getCacheDevicesList();
                                        _deviceAddVariableClear();
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
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
    );
  }

  _deviceHorizontalListWidget(DeviceModel deviceInfo, int index) {
    return GestureDetector(
      onTap: () {
        if (_selectedDeviceId == deviceInfo.deviceId) {
          _selectedDeviceId = "";
          DeviceCrudService.deleteSelectedDeviceModel(
              selectedDeviceModel: _selectedDeviceModel);
        } else {
          _selectedDeviceId = deviceInfo.deviceId!;
          _selectedDeviceModel = deviceInfo;
        }
        setState(() {});
      },
      child: Padding(
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
            height: 6.h,
            width: 6.h,
            margin: ConstantsWidgets.allPadding_8,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    deviceInfo.deviceImagePath!,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      deviceInfo.deviceName!,
                      style: CustomTextStyle.boldFont6(
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

  _deviceInfoAndUpdateWidget() {
    return Container(
      color: ProjectColor.colorBlackBackground,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .25,
      child: Padding(
        padding: ConstantsWidgets.allPadding_18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  MonitoringPageConstants.deviceInfo,
                  style: CustomTextStyle.boldFont10(ProjectColor.colorWhite),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    deviceUpdatePanel = false;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.clear,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            customTextBox(
              _deviceNickNameController,
              MonitoringPageConstants.deviceName,
              _selectedDeviceModel!.nickName!,
              _deviceNickNameFocusNode,
            ),
            customTextBox(
              _deviceIpAddressController,
              MonitoringPageConstants.ipAddress,
              _selectedDeviceModel!.deviceIp!,
              _deviceIpAddressFocusNode,
            ),
            Padding(
              padding: ConstantsWidgets.allPadding_8,
              child: CustomToggleSwitch(
                title: MonitoringPageConstants.deviceStatus,
                toggleStatus: _toggleDeviceStatus,
                falseText: MonitoringPageConstants.ofToggle,
                trueText: MonitoringPageConstants.onToggle,
                onChanged: (v) => setState(() => _toggleDeviceStatus = v),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                customWindowsButton(
                  buttonText: MonitoringPageConstants.update,
                  onTap: () async {
                    await DeviceCrudService.createSelectedDeviceModel(
                      selectedDeviceModel: _selectedDeviceModel,
                      deviceName: _deviceNickNameController.text,
                      deviceIpAddress: _deviceIpAddressController.text,
                      deviceStatus: _toggleDeviceStatus,
                      offsetDx: _selectedDeviceModel!.offsetDx,
                      offsetDy: _selectedDeviceModel!.offsetDy,
                    ).then((value) async {
                      await cacheManager.putItemIndex(_selectedIndex, value);
                      _deviceUpdateVariableClear();
                      _getCacheDevicesList();
                      customSnackBar(
                          context, MonitoringPageConstants.updateSuccess);
                      setState(() {});
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .005,
                ),
                customWindowsButton(
                  buttonText: MonitoringPageConstants.delete,
                  textColor: Colors.red,
                  onTap: () async {
                    customContentDialog(
                        context: context,
                        dialogTitle: MonitoringPageConstants.deleteDevice,
                        dialogContent:
                            MonitoringPageConstants.deleteDeviceContent,
                        cancelButtonOnTap: () => Navigator.pop(context),
                        cancelButtonText:
                            MonitoringPageConstants.deleteCancelButtonTxt,
                        okButtonText: MonitoringPageConstants.deleteOkButtonTxt,
                        okButtonTextColor: Colors.red,
                        okButtonOnTap: () async {
                          _selectedDeviceModel = DeviceModel.getBlankModel();
                          await cacheManager.removeItem(_selectedIndex);
                          deviceUpdatePanel = false;
                          _getCacheDevicesList();
                          Navigator.pop(context);
                          customSnackBar(context,
                              MonitoringPageConstants.deleteDialogContent);
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _deviceInStack(DeviceModel deviceInfo, int index) {
    return Stack(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: GestureDetector(
            onTap: () {
              deviceAddPanel = false;
              if (_selectedDeviceModel == deviceInfo) {
                _selectedIndex = 0;
                _selectedDeviceModel = DeviceModel.getBlankModel();
                deviceUpdatePanel = false;
              } else {
                deviceUpdatePanel = true;
                _selectedIndex = index;
                _selectedDeviceModel = deviceInfo;
                _toggleDeviceStatus = deviceInfo.deviceStatus!;
                _deviceNickNameController.text =
                    _selectedDeviceModel!.nickName!;
                _deviceIpAddressController.text =
                    _selectedDeviceModel!.deviceIp!;
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 18 : 0,
                right: index == DeviceList.deviceList.length - 1 ? 18 : 0,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: ConstantsWidgets.borderRadiusAll_10,
                ),
                color: _selectedDeviceModel == deviceInfo
                    ? ProjectColor.colorGreyBackground
                    : ProjectColor.colorBlackOpacity,
                elevation: _selectedDeviceModel == deviceInfo ? 5 : 1,
                child: Container(
                  height: 10.h,
                  width: 10.h,
                  margin: ConstantsWidgets.allPadding_8,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Image.asset(
                          deviceInfo.deviceImagePath!,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: windows.Center(
                          child: Text(
                            deviceInfo.nickName!,
                            style: CustomTextStyle.boldFont6(
                              _selectedDeviceModel == deviceInfo
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
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: deviceInfo.deviceStatus!
                  ? ProjectColor.colorGreen
                  : ProjectColor.colorRed,
            ),
          ),
        ),
      ],
    );
  }

  _deviceAddVariableClear() {
    _selectedDeviceModel = DeviceModel.getBlankModel();
    _selectedDeviceId = "";
    _deviceIpAddressController.text = "";
    _deviceNickNameController.text = "";
    deviceAddPanel = false;
  }

  _deviceUpdateVariableClear() {
    deviceUpdatePanel = false;
    _selectedDeviceModel = DeviceModel.getBlankModel();
  }

  _textFieldClear() {
    _deviceNickNameController.text = "";
    _deviceIpAddressController.text = "";
    _toggleDeviceStatus = false;
  }
}

pingMetod(List<DeviceModel>? allDevices) async {
  
    allDevices!.forEach((element) {
      final ping = Ping(
        element.deviceIp!,
      );

      ping.stream.listen((event) {
        //print(event);
        element.deviceName;
      });
    });
  

  // List<InternetAddress> addr = await InternetAddress.lookup(ping);
  // addr.forEach((v){

  // });
}

class MonitoringPageConstants {
  static const String add = "Add";
  static const String deviceName = "Device Name";
  static const String ipAddress = "Ip Address";
  static const String deviceStatus = "Device Status";
  static const String onToggle = "On";
  static const String ofToggle = "Off";
  static const String update = "Update";
  static const String delete = "Delete";
  static const String updateSuccess = "Update Successful";
  static const String deleteDevice = "Delete Device?";
  static const String deleteDeviceContent =
      "Are you sure you want to delete devicename.";
  static const String deleteOkButtonTxt = "Delete Device";
  static const String deleteCancelButtonTxt = "Cancel";
  static const String deleteDialogContent =
      "Device has been deleted successfully";
  static const String enterDeviceName = "Enter device name";
  static const String enterIpAddress = "Enter ip address";
  static const String deviceInfo = "Device Information";
  static const String addDeviceSuccess = "Add device successful.";
  static const String deviceAdd = "Device Add";
  static const String selectedDeviceType = "Selected Device Type";
}
