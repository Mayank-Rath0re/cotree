import 'dart:io';

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/main.dart';

class FileHandling {
  Future<String> uploadFile(String uploadDesc, File file) async {
    var uploadDescription = await client.file.getUploadDescription(uploadDesc);
    print("upload description: $uploadDescription");
    if (uploadDescription != null) {
      var uploader = FileUploader(uploadDescription);
      final fileStream = file.openRead();
      final fileLength = await file.length();
      // Upload the file as a stream
      await uploader.upload(fileStream, fileLength);
      var success = await client.file.verifyUpload(uploadDesc);
      print("Upload success: $success");
      if (success) {
        // Get the public URL as a String
        print("File Uploaded Successfully");
        final url = await client.file.getPublicUrl(uploadDesc);
        return url ?? '';
      }
      return '';
    }
    return '';
  }
}
