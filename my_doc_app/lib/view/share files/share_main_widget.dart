import 'package:flutter/material.dart';

class ShareMainWidget extends StatefulWidget {
  const ShareMainWidget({Key? key}) : super(key: key);

  @override
  State<ShareMainWidget> createState() => _ShareMainWidgetState();
}

class _ShareMainWidgetState extends State<ShareMainWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          "In order to see the file you must access it form the File Explorer of your phone, or you have to share it to a more powerful device"),
    );
  }
}
