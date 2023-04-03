import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_doc_app/model/file_handler.dart';
import 'package:my_doc_app/view/recording%20screen/recording_file.dart';
import 'package:path/path.dart' as p;

/// It display the list of files in the folder 'recording'. \
class RecordingList extends StatefulWidget {
  const RecordingList({Key? key}) : super(key: key);

  @override
  State<RecordingList> createState() => _RecordingListState();
}

class _RecordingListState extends State<RecordingList> {
  late List<File> recordingLists;
  bool isLoading = false;

  @override
  void initState() async {
    super.initState();
    recordingLists = await FileHanlder.instance.listRecordings;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        File el = recordingLists[index];
        return RecordingFileWidget(
          fileName: p.basename(el.path),
          fileCreationDate: el.lastModifiedSync().toIso8601String(),
        );
      },
    );
  }
}
