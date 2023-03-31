import 'dart:developer' as devtools;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// It is the class that handle the writing on the file about what is coming in.
class FileHanlder {
  /// directory in which the application saves the files
  Directory? documentDir;
  FileHanlder() {
    _setTempDir();
  }
  Future<bool> _setTempDir() async {
    try {
      documentDir = await getApplicationDocumentsDirectory();
      devtools.log(
          "The path on which the file is saved is: ${documentDir?.path}",
          name: runtimeType.toString());
      return true;
    } catch (exc) {
      devtools.log(exc.toString());
      return false;
    }
  }
}
