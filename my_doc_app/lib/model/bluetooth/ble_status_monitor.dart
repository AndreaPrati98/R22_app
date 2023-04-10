import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_doc_app/model/bluetooth/reactive_state.dart';

class BleStatusMonitor implements ReactiveState<BleStatus?> {
  const BleStatusMonitor(this._ble);

  final FlutterReactiveBle _ble;

  @override
  Stream<BleStatus?> get state => _ble.statusStream;
}