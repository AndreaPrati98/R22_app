import 'package:flutter/material.dart';
import 'package:my_doc_app/model/bluetooth_controller.dart';
import 'package:my_doc_app/view/device_preview_widget.dart';

class DeviceListWidget extends StatefulWidget {
  const DeviceListWidget({Key? key}) : super(key: key);

  @override
  State<DeviceListWidget> createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      Expanded(
          child: ListView(
        children: const <Widget>[
          DevicePreviewWidget(),
          DevicePreviewWidget(),
          DevicePreviewWidget(),
          DevicePreviewWidget(),
          DevicePreviewWidget(),
          DevicePreviewWidget(),
          DevicePreviewWidget(),
          DevicePreviewWidget(),
        ],
      ))
    ]);
  }
}
