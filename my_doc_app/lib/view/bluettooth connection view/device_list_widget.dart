import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:my_doc_app/model/bluetooth_controller.dart';
import 'package:my_doc_app/view/bluettooth%20connection%20view/device_details.dart';
import 'package:my_doc_app/view/bluettooth%20connection%20view/device_preview_widget.dart';

class DeviceListWidget extends StatefulWidget {
  const DeviceListWidget({Key? key}) : super(key: key);

  @override
  State<DeviceListWidget> createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BluetoothController.instance.fb
          .startScan(timeout: const Duration(seconds: 10)),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: Container(
                width: double.maxFinite,
                height: 100,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 29, 29, 29),
                    backgroundBlendMode: BlendMode.colorBurn),
                child: Center(
                  child: Text(
                    'Bluetooth devices',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
            const Text('Scroll this screen to start the bluetooth scan'),
            StreamBuilder<List<ScanResult>>(
              stream: BluetoothController.instance.fb.scanResults,
              initialData: const [],
              builder: (context, snapshot) => Column(
                children: snapshot.data!
                    .map(
                      //  For each Bluetooth LE device, show the ScanResultTile widget when tapped
                      (r) => DevicePreviewWidget(
                        scanResult: r,
                        onTap: () {
                          devtools.log("ciao");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const DeviceDetails(),
                          ));
                        },
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
