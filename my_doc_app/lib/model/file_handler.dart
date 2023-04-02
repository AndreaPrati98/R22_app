import 'dart:developer' as devtools;
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// It is the class that handle the writing on the file about what is coming in.
class FileHanlder {
  static final FileHanlder instance = FileHanlder._init();

  /// directory in which the application saves the files
  Directory? _documentDir;
  Directory? _recordingDir;

  /// Object which allow to retrieve the count of files we have in the folder.
  late SharedPreferences _preferences;

  /// [_preferences] looks for the key 'numberOfFiles', in case there is no value associated
  /// with that key it will return 0.
  ///
  /// This value is used to give the names to the files for saving them.
  int get numOfFiles => _preferences.getInt('numerOfFiles') ?? 0;
  set numOfFiles(int number) => _preferences.setInt('numberOfFiles', number);

  /// Folder used to save files
  String? get documentDirectory => _documentDir?.path;

  /// Folder used to store recordings
  String? get recordingsDirectory => _recordingDir?.path;

  FileHanlder._init() {
    _getTempDir();
    _getSharedPreferences();
  }

  Future<bool> _getTempDir() async {
    // the two directories are not `null` if the method works.
    try {
      _documentDir = (await getApplicationDocumentsDirectory());
      _recordingDir = Directory('${_documentDir!.path}/recordings')
        ..createSync();
      devtools.log(
          "The path on which the file is saved is: ${_documentDir?.path}",
          name: runtimeType.toString());
      return true;
    } catch (exc) {
      devtools.log(
        exc.toString(),
        name: runtimeType.toString(),
      );
      return false;
    }
  }

  Future<void> _getSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }
}
