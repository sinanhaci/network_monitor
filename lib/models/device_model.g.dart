// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceModelAdapter extends TypeAdapter<DeviceModel> {
  @override
  final int typeId = 1;

  @override
  DeviceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceModel(
      deviceId: fields[0] as String?,
      deviceName: fields[1] as String?,
      nickName: fields[2] as String?,
      deviceStatus: fields[3] as bool?,
      devicesNetworkStatus: fields[4] as bool?,
      deviceImagePath: fields[5] as String?,
      deviceIp: fields[6] as String?,
      offsetDx: fields[7] as double,
      offsetDy: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.deviceId)
      ..writeByte(1)
      ..write(obj.deviceName)
      ..writeByte(2)
      ..write(obj.nickName)
      ..writeByte(3)
      ..write(obj.deviceStatus)
      ..writeByte(4)
      ..write(obj.devicesNetworkStatus)
      ..writeByte(5)
      ..write(obj.deviceImagePath)
      ..writeByte(6)
      ..write(obj.deviceIp)
      ..writeByte(7)
      ..write(obj.offsetDx)
      ..writeByte(8)
      ..write(obj.offsetDy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
