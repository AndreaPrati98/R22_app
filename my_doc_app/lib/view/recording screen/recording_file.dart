import 'dart:developer' as devtools;

import 'package:flutter/material.dart';

class RecordingFileWidget extends StatelessWidget {
  const RecordingFileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 70),
        color: const Color(0x99999999),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text("Nome del file"),
                ),
                Container(
                  height: 70,
                  width: 1,
                  color: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Durata"),
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
                onPressed: () => devtools.log("Cancella registrazione"),
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
