import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_doc_app/model/file_handler.dart';
import 'package:my_doc_app/view/recording%20screen/recording_file.dart';
import 'package:path/path.dart' as p;

/// It display the list of files in the folder 'recording'. \
class RecordingListWidget extends StatefulWidget {
  const RecordingListWidget({Key? key}) : super(key: key);

  @override
  State<RecordingListWidget> createState() => _RecordingListWidgetState();
}

class _RecordingListWidgetState extends State<RecordingListWidget> {
  List<File> recordingLists = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _retrieveListFile();
  }

  void _retrieveListFile() async {
    recordingLists = await FileHanlder.instance.listRecordings;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        // primary: false,
        children: recordingLists
            .map(
              (e) => RecordingFileWidget(
                fileName: p.basename(e.path),
                fileCreationDate: e.lastModifiedSync().toIso8601String(),
              ),
            )
            .toList(),
      ),
    );
    // ListView.builder(
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) {
    //     return RecordingFileWidget(
    //         fileName: p.basename(recordingLists[index].path),
    //         fileCreationDate:
    //             recordingLists[index].lastModifiedSync().toIso8601String());
    //   },
    // );
  }
}
