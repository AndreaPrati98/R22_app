// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_doc_app/model/bluetooth/ble_device_connector.dart';
import 'package:my_doc_app/model/bluetooth/ble_device_interactor.dart';
import 'package:my_doc_app/model/bluetooth/ble_logger.dart';
import 'package:my_doc_app/model/bluetooth/ble_scanner.dart';
import 'package:my_doc_app/model/bluetooth/ble_status_monitor.dart';
import 'package:my_doc_app/view/bluettooth%20connection%20view/device_list.dart';

import 'package:my_doc_app/view/recording%20screen/recording_main_widget.dart';
import 'package:my_doc_app/view/share%20files/share_main_widget.dart';
import 'package:provider/provider.dart';

/// Entry point of the application.
///
/// It runs the [WidgetsFlutterBinding.ensureInitialized] function and a series of simple
/// variables useful for being part of the state of the application.
void main() {
  // This is important to be sure that everything is initialized.
  // check on internet to know more about this line;
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing some variables that will be used according to the Provider logic.
  // The idea is, indeed, to share these variables among all the widget tree, so that
  // without too much effort we can share the results and keep the screen updated.
  // Could be usefult to look at teh Provider documentation
  final _ble = FlutterReactiveBle();
  final _bleLogger = BleLogger(ble: _ble);
  final _scanner = BleScanner(ble: _ble, logMessage: _bleLogger.addToLog);
  final _monitor = BleStatusMonitor(_ble);
  final _connector = BleDeviceConnector(
    ble: _ble,
    logMessage: _bleLogger.addToLog,
  );
  final _serviceDiscoverer = BleDeviceInteractor(
    bleDiscoverServices: _ble.discoverServices,
    readCharacteristic: _ble.readCharacteristic,
    writeWithResponse: _ble.writeCharacteristicWithResponse,
    writeWithOutResponse: _ble.writeCharacteristicWithoutResponse,
    subscribeToCharacteristic: _ble.subscribeToCharacteristic,
    logMessage: _bleLogger.addToLog,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: _scanner),
        Provider.value(value: _monitor),
        Provider.value(value: _connector),
        Provider.value(value: _serviceDiscoverer),
        Provider.value(value: _bleLogger),
        StreamProvider<BleScannerState?>(
          create: (_) => _scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
        StreamProvider<BleStatus?>(
          create: (_) => _monitor.state,
          initialData: BleStatus.unknown,
        ),
        StreamProvider<ConnectionStateUpdate>(
          create: (_) => _connector.state,
          initialData: const ConnectionStateUpdate(
            deviceId: 'Unknown device',
            connectionState: DeviceConnectionState.disconnected,
            failure: null,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

/// [MyApp] is the [Scaffold] that contains the whole application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Project R22'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// List of widget accessible from the [NavigationBar]
  final List<Widget> _widgetList = [
    const DeviceListScreen(),
    const RecordingMainWidget(),
    const ShareMainWidget(),
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    devtools.log("Changing index -> $index", name: runtimeType.toString());
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _widgetList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth_sharp),
            label: 'Bluetooth',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outlined),
            label: 'Recordings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share_outlined),
            label: 'Share',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
