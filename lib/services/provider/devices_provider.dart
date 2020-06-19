import 'package:flutter/material.dart';
import 'package:home_app/models/device_model.dart';

class DeviceProvider with ChangeNotifier {
  
  Device _device = Device();
  Future<List<Device>> _devices;
  int _deviceNumber;

  int get deviceNumber => _deviceNumber;
  setDeviceNumber(int deviceNum) {
    _deviceNumber = deviceNum;
    notifyListeners();
  }

  Device get device => _device;
  setDevice(Device device) {
    this._device = device;
    notifyListeners();
  }

  Future<List<Device>> get devices => _devices;
  setDevices(Future<List<Device>> devices) {
    this._devices = devices;
    notifyListeners();
  }
}
