import 'dart:developer' as devtools;
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
    List<File> localList = await FileHanlder.instance.listRecordings;
    setState(() {
      recordingLists = localList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: ListView(
          key: ValueKey<int>(recordingLists.length),
          shrinkWrap: true,
          // primary: false,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () => _retrieveListFile(),
                  child: const Text("Referesh the recording list")),
            ),
            ...recordingLists
                .map(
                  (e) => RecordingFileWidget(
                    fileName: p.basename(e.path),
                    fileCreationDate: e.lastModifiedSync().toIso8601String(),
                    callbackRefreshState: () => _retrieveListFile(),
                  ),
                )
                .toList()
              ..sort(
                (a, b) {
                  return DateTime.parse(b.fileCreationDate)
                      .compareTo(DateTime.parse(a.fileCreationDate));
                },
              )
          ],
        ),
      ),
    );
  }
}
