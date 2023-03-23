import 'dart:developer' as devtools;

import 'package:flutter/material.dart';

class DevicePreviewWidget extends StatelessWidget {
  const DevicePreviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        child: Container(
          constraints: const BoxConstraints(minHeight: 100),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const Icon(Icons.monitor_heart_outlined, size: 35),
                ),
              ),
              const Flexible(
                flex: 3,
                child: Text('Device...'),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () => devtools.log(
                      "Connect",
                      name: runtimeType.toString(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
