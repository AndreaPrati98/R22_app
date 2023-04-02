import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:my_doc_app/model/file_handler.dart';
import 'package:my_doc_app/view/recording%20screen/recording_animated_widget.dart';
import 'package:my_doc_app/view/recording%20screen/recording_file.dart';

class RecordingMainWidget extends StatefulWidget {
  const RecordingMainWidget({Key? key}) : super(key: key);

  @override
  State<RecordingMainWidget> createState() => _RecordingMainWidgetState();
}

class _RecordingMainWidgetState extends State<RecordingMainWidget> {
  var recordingDirectory = FileHanlder.instance.recordingsDirectory;

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Path to the folder with the recordings:",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(recordingDirectory ?? 'Not initialized...'),
        ),
        const RecordingAnimatedWidget(),
        RecordingFileWidget(),
      ],
    );
  }
}
