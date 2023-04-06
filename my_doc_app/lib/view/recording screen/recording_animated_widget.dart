import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:my_doc_app/model/file_handler.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class RecordingAnimatedWidget extends StatefulWidget {
  const RecordingAnimatedWidget({Key? key}) : super(key: key);

  @override
  State<RecordingAnimatedWidget> createState() =>
      _RecordingAnimatedWidgetState();
}

class _RecordingAnimatedWidgetState extends State<RecordingAnimatedWidget> {
  bool _isRecording = false;

  final double _rippleRadius = 5;
  final double _dividerWidth = 200;

  @override
  void dispose() {
    devtools.log("Disposing", name: runtimeType.toString());
    /* 
    Fundamental to remember that if accidentally we change
    screen the widget is disposed. 
    We will need to deal with the saving of the recording
    */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // here we handle the request to create the recording file
        if (!_isRecording) {
          // case the user want to start the recording
          // asking if the user is sure
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Create registration"),
                content: const Text(
                    'By starting the registration you will create a new file.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      devtools.log("Cancel", name: runtimeType.toString());
                      _exitDialog();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      devtools.log("Confirm", name: runtimeType.toString());
                      FileHanlder.instance.startRecording();
                      _exitDialog();
                    },
                    child: const Text('Confirm'),
                  )
                ],
              );
            },
          );
        } else {
          // case the user want to stop the recording
          // asking if the user is sure
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Stop registration"),
                content: const Text(
                    'Are you sure you want to stop the registration?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      devtools.log("Cancel", name: runtimeType.toString());
                      _exitDialog();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      devtools.log("Confirm", name: runtimeType.toString());
                      _exitDialog();
                    },
                    child: const Text('Confirm'),
                  )
                ],
              );
            },
          );
        }
        // setState(() {
        //   _isRecording = !_isRecording;
        // });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(
          children: [
            _localDevider(_dividerWidth),
            _isRecording
                ? const Text("The device is recording...")
                : const Text("The recording is stopped"),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x99999999), width: 3),
                  shape: BoxShape.circle),
              child: Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
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
                  child: Icon(
                    _isRecording
                        ? Icons.pause_circle_filled_sharp
                        : Icons.play_circle_filled_sharp,
                    color: Colors.white,
                    size: 40,
                    key: ValueKey<bool>(_isRecording),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _rippleRadius + 35,
            ),
            _conditionalRippleAnimation(),
            SizedBox(
              height: _rippleRadius + 35,
            ),
            _localDevider(_dividerWidth),
          ],
        ),
      ),
    );
  }

  SizedBox _localDevider(double width) =>
      SizedBox(width: width, child: const Divider(thickness: 2));

  /// method for exiting from the dialog interface updating the
  void _exitDialog() {
    setState(() {
      _isRecording = !_isRecording;
    });

    Navigator.pop(context);
  }

  Widget _conditionalRippleAnimation() {
    return _isRecording
        ? RippleAnimation(
            minRadius: 5,
            ripplesCount: 40,
            color: Colors.redAccent,
            repeat: true,
            child: Container(),
          )
        : const SizedBox(
            height: 1,
          );
  }
}
