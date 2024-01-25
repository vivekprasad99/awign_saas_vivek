import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static pickMedia(
      Function(FilePickerResult) onMediaPicked) async {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
        if (result != null) {
          onMediaPicked(result);
        }
    }
  }

