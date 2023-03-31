import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:my_doc_app/view/recording%20screen/recording_animated_widget.dart';

class RecordingMainWidget extends StatefulWidget {
  const RecordingMainWidget({Key? key}) : super(key: key);

  @override
  State<RecordingMainWidget> createState() => _RecordingMainWidgetState();
}

class _RecordingMainWidgetState extends State<RecordingMainWidget> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.2)),
          alignment: AlignmentDirectional.center,
          child: const Text(
            "Record your data here",
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 40),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => devtools.log("Started the recording..."),
          icon: const Icon(Icons.play_arrow_outlined),
          label: const Text("Start recording"),
        ),
        RecordingAnimatedWidget(),
      ],
    );
  }
}
