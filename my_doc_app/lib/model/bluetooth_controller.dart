import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// ___Singleton___ class. Handles all the bluetooth connection logic.
class BluetoothController {
  static final BluetoothController instance = BluetoothController._init();

  /// [FlutterBlue] instance

  FlutterBluePlus fb = FlutterBluePlus.instance;

  BluetoothController._init();
}
