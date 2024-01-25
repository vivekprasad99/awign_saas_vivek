import 'dart:io';

import 'package:awign_saas/core/utils/app_log.dart';
import 'package:simple_s3/simple_s3.dart';

import '../../model/aws_upload_result.dart';

class RemoteStorageRepository {
  // static const s3bucketName = 'awign-staging';
  static const poolID = 'ap-south-1:a61d854c-29af-4c19-a568-cae38ac5ff74';
  // static const s3FolderPath = 'hrms';
  // static const s3FileBaseURL = 'https://awign-staging.s3.ap-south-1.amazonaws.com/';
  late SimpleS3 _simpleS3;
  bool isUploading = false;

  RemoteStorageRepository() {
    _simpleS3 = SimpleS3();
  }

  Stream getUploadPercentageStream() {
    return _simpleS3.getUploadPercentage;
  }

  void close() {}

  Future<AWSUploadResult?> uploadFile(
      File file, String fileName, String s3bucketName, String s3FolderPath) async {
    try {
      if (isUploading) {
        return null;
      }
      isUploading = true;
      String url = await _simpleS3.uploadFile(
          file, s3bucketName, poolID, AWSRegions.apSouth1,
          fileName: fileName, s3FolderPath: s3FolderPath);
      AppLog.i('Upload success URL::::: $url');
      isUploading = false;
      return AWSUploadResult(url: url);
    } catch (e, st) {
      AppLog.e('uploadFile : ${e.toString()} \n${st.toString()}');
      isUploading = false;
      rethrow;
    }
  }
}