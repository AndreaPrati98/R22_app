import 'dart:developer' as devtools;
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// It is the class that handle the writing on the file about what is coming in.
class FileHanlder {
  static final FileHanlder instance = FileHanlder._init();

  /// directory in which the application saves the files
  final Future<Directory> _documentDir = getApplicationDocumentsDirectory();
  Directory? _recordingDir;

  /// Prefix used for all the recordings
  ///
  /// Each recording will be
  final String recording_prefix = 'rec_';

  /// Object which allow to retrieve the count of files we have in the folder.
  late SharedPreferences _preferences;

  /// [_preferences] looks for the key 'numberOfFiles', in case there is no value associated
  /// with that key it will return 0.
  ///
  /// This value is used to give the names to the files for saving them.
  int get numOfFiles => _preferences.getInt('numerOfFiles') ?? 0;
  set numOfFiles(int number) => _preferences.setInt('numberOfFiles', number);

  /// Folder used to save files
  Future<String> get documentDirectory async => (await _documentDir).path;

  /// Folder used to store recordings
  String? get recordingsDirectory => _recordingDir?.path;

  FileHanlder._init() {
    _asyncOperations();
    devtools.log('Creation of the class', name: runtimeType.toString());
  }

  /// Auxiliar method used to give an execution order to the async methods of the class.
  ///
  /// It was necessary because it's not possible to use them from the constructor of the class.
  void _asyncOperations() async {
    await _getDirectories();
    // don't care the order of execution of the two following method
    _mockFiles();
    _getSharedPreferences();
    //-----------------------
  }

  /// Gets the directories for the application document and for the recordings. If the directories
  /// don't exist it will create them.
  Future<bool> _getDirectories() async {
    // the two directories are not `null` if the method works.
    try {
      _recordingDir = Directory('${(await _documentDir).path}/recordings')
        ..createSync();
      devtools.log(
          "The path on which the file is saved is: ${_recordingDir?.path}",
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

  /// Creates mock files to test if the folder is working
  void _mockFiles() async {
    try {
      File newFile = File('${_recordingDir?.path}/trial_file_1.csv');
      await newFile.writeAsString("title,count\n",
          mode: FileMode.writeOnlyAppend);
    } catch (err) {
      devtools.log(
        "Something went wrong during the creation/writing of the file",
        name: runtimeType.toString(),
      );
      devtools.log(err.toString());
    }
  }

  /// [fileToDelete] = name of the file to be deleted
  void delete_recording(String fileToDelete) {
    File('${_recordingDir?.path}/$fileToDelete').deleteSync();
  }

  Future<List<File>> get listRecordings async {
    List<File> recList = [];
    if (_recordingDir != null) {
      await for (var el in _recordingDir!.list()) {
        // want to list only the files
        if (el is File) {
          recList.add(el);
        }
      }
    } else {
      devtools.log(
        "Tried to access a folder which is null",
        name: runtimeType.toString(),
      );
    }
    return recList;
  }
}
