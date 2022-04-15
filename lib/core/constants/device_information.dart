import 'package:flutter/material.dart';

class DeviceInformation{
  static double deviceHeight = 0.0;
  static double deviceWidth = 0.0;

  static getDeviceSizeInfo(Size mediaQueryData){
    deviceHeight = mediaQueryData.height;
    deviceWidth = mediaQueryData.width;
  }
}