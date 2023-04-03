import 'dart:developer' as devtools;

import 'package:flutter/material.dart';

class RecordingFileWidget extends StatelessWidget {
  final String fileName;
  final String fileCreationDate;

  const RecordingFileWidget({
    Key? key,
    required this.fileName,
    required this.fileCreationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 70,
        ),
        color: const Color(0x99999999),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 90),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Text(
                    "Name: $fileName",
                    overflow: TextOverflow.clip,
                  ),
                ),
                Container(
                  height: 70,
                  width: 1,
                  color: Colors.black,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text("Created on: $fileCreationDate",
                      overflow: TextOverflow.clip),
                ),
                Container(
                  height: 70,
                  width: 1,
                  color: Colors.black,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () => devtools.log("Delete recording"),
                icon: const Icon(Icons.delete_outlined),
                iconSize: 30,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
