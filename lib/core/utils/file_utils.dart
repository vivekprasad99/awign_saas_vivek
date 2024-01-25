import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUtils {
  static void downloadFile(BuildContext context, String url) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!FlutterDownloader.initialized) {
      await FlutterDownloader.initialize(
          debug: true // optional: set false to disable printing logs to console
          );
    }
    TargetPlatform? platform = Theme.of(context).platform;
    final hasGranted = await checkStoragePermission(platform);
    if (hasGranted) {
      String? localPath = await _prepareSaveDir();
      if (localPath != null) {
        requestDownload(url, localPath);
      }
    }
  }

  static Future<bool> download(
      BuildContext context, String url, String? name) async {
    TargetPlatform? platform = Theme.of(context).platform;
    bool hasPermission = await checkStoragePermission(platform);
    if (!hasPermission) return false;

    Dio dio = Dio();
    String? localPath = await _prepareSaveDir();
    // You should put the name you want for the file here.
    // Take in account the extension.
    String? filename;
    if (url.contains('pdf')) {
      filename = '$name.pdf';
    } else if (url.contains('jpg')) {
      filename = '$name.jpg';
    } else if (url.contains('jpeg')) {
      filename = '$name.jpeg';
    }else if(url.contains('jpeg'))
      {
        filename = '$name.png';
      }
    await dio.download(url, "$localPath/$filename",
        onReceiveProgress: (received, total) {
      int progress = (((received / total) * 100).toInt());
      AppLog.i('Download Progress: $progress');
    });
    return true;
  }

  static Future<String?> _prepareSaveDir() async {
    String? localPath = (await _findLocalPath());
    if (localPath != null) {
      final savedDir = Directory(localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      return localPath;
    } else {
      return null;
    }
  }

  static Future<String?> _findLocalPath() async {
    try {
      var externalStorageDirPath;
      if (defaultTargetPlatform == TargetPlatform.android) {
        try {
          externalStorageDirPath = await AndroidPathProvider.downloadsPath;
        } catch (e) {
          final directory = await getExternalStorageDirectory();
          externalStorageDirPath = directory?.path;
        }
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        externalStorageDirPath =
            (await getApplicationDocumentsDirectory()).absolute.path;
      }
      return '$externalStorageDirPath/Hrms';
    } catch (e, stacktrace) {
      AppLog.e('_findLocalPath : ${e.toString()} \n${stacktrace.toString()}');
    }
    return null;
  }

  static Future<bool> checkStoragePermission(TargetPlatform? platform) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) return true;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (platform == TargetPlatform.android &&
        androidInfo.version.sdkInt! <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  static Future<int> getFileSizeInBytes(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return 0;
    return bytes;
  }

  static (String uploadedSizeInBytes, String totalSizeInBytes) getFileUploadedSizeAndTotalSize(
      String filePath, int totalSizeInBytes, int percentage) {
    double uploadedSizeInBytes = (percentage / 100) * totalSizeInBytes;
    return (getReadableFileSize(uploadedSizeInBytes.toInt()),
        getReadableFileSize(totalSizeInBytes.toInt()));
  }

  /// A method returns a human readable string representing a file _size
  static String getReadableFileSize(int size, [int round = 2]) {
    /**
     * [size] can be passed as number or as string
     *
     * the optional parameter [round] specifies the number
     * of digits after comma/point (default is 2)
     */
    var divider = 1024;
    int _size;
    try {
      _size = int.parse(size.toString());
    } catch (e) {
      throw ArgumentError('Can not parse the size parameter: $e');
    }

    if (_size < divider) {
      return '$_size B';
    }

    if (_size < divider * divider && _size % divider == 0) {
      return '${(_size / divider).toStringAsFixed(0)} KB';
    }

    if (_size < divider * divider) {
      return '${(_size / divider).toStringAsFixed(round)} KB';
    }

    if (_size < divider * divider * divider && _size % divider == 0) {
      return '${(_size / (divider * divider)).toStringAsFixed(0)} MB';
    }

    if (_size < divider * divider * divider) {
      return '${(_size / divider / divider).toStringAsFixed(round)} MB';
    }

    if (_size < divider * divider * divider * divider && _size % divider == 0) {
      return '${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB';
    }

    if (_size < divider * divider * divider * divider) {
      return '${(_size / divider / divider / divider).toStringAsFixed(round)} GB';
    }

    if (_size < divider * divider * divider * divider * divider &&
        _size % divider == 0) {
      num r = _size / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} TB';
    }

    if (_size < divider * divider * divider * divider * divider) {
      num r = _size / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} TB';
    }

    if (_size < divider * divider * divider * divider * divider * divider &&
        _size % divider == 0) {
      num r = _size / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} PB';
    } else {
      num r = _size / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} PB';
    }
  }

  static void requestDownload(String url, String localPath) async {
    try {
      String? result = await FlutterDownloader.enqueue(
        url: url,
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: localPath,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
      AppLog.i('result : $result');
    } catch (e, stacktrace) {
      AppLog.e('requestDownload : ${e.toString()} \n${stacktrace.toString()}');
    }
  }

  static Future<String?> getImageFilePath(BuildContext context) async {
    TargetPlatform? platform = Theme.of(context).platform;
    final hasGranted = await checkStoragePermission(platform);
    if (hasGranted) {
      String? filePath = await _prepareSaveDir();
      if (filePath != null) {
        return '$filePath/Image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
