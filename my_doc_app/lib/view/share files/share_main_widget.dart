import 'package:flutter/material.dart';
import 'package:my_doc_app/model/file_handler.dart';

/// It is the less developed [Widget] of the application.  \
/// The purpose has to be: offering an interface from which the user can share the recordings.
///
/// For reason of time it has not been implemented.
class ShareMainWidget extends StatefulWidget {
  const ShareMainWidget({Key? key}) : super(key: key);

  @override
  State<ShareMainWidget> createState() => _ShareMainWidgetState();
}

class _ShareMainWidgetState extends State<ShareMainWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
              "In order to share the file, please, go to the following folder and look for the file you want to share and share them manually."),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            FileHanlder.instance.recordingsDirectory ??
                'folder not created yet. (open first the "Recordings" interface, otherwise the application doesn\'t create the folder yet)',
          ),
        ),
      ],
    );
  }
}
