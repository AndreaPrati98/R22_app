import 'package:flutter_blue/flutter_blue.dart';

/// ___Singleton___ class. Handles all the bluetooth connection logic.
class BluetoothController {
  static final BluetoothController instance = BluetoothController._init();

  /// [FlutterBlue] instance
  FlutterBlue fb = FlutterBlue.instance;

  BluetoothController._init();
}
