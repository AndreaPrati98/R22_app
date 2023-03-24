import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DevicePreviewWidget extends StatelessWidget {
  /// From it we can retrieve a lot of information about the device itself
  final ScanResult scanResult;
  final VoidCallback onTap;

  const DevicePreviewWidget({
    Key? key,
    required this.scanResult,
    required this.onTap,
  }) : super(key: key);

  Widget _buildTitle(BuildContext context) {
    if (scanResult.device.name.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            scanResult.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            scanResult.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(scanResult.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.caption,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String? getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String? getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(scanResult.rssi.toString()),
      trailing: ElevatedButton(
        onPressed: (scanResult.advertisementData.connectable) ? onTap : null,
        child: const Text('CONNECT'),
      ),

      ///  Display the device's name, power level, manufacturer data, service UUIDs and service data
      children: <Widget>[
        _buildAdvRow(context, 'Complete Local Name',
            scanResult.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level',
            '${scanResult.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(
            context,
            'Manufacturer Data',
            getNiceManufacturerData(
                    scanResult.advertisementData.manufacturerData) ??
                'N/A'),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (scanResult.advertisementData.serviceUuids.isNotEmpty)
                ? scanResult.advertisementData.serviceUuids
                    .join(', ')
                    .toUpperCase()
                : 'N/A'),
        _buildAdvRow(
            context,
            'Service Data',
            getNiceServiceData(scanResult.advertisementData.serviceData) ??
                'N/A'),
      ],
    );
  }
}
