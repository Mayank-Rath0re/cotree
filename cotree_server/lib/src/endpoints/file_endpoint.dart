import 'package:serverpod/serverpod.dart';

class FileEndpoint extends Endpoint {
  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  Future<bool> verifyUpload(Session session, String path) async {
    bool success = await session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: path,
    );
    print(success);
    return success;
  }

  Future<String?> getPublicUrl(Session session, String path) async {
    var uri = await session.storage.getPublicUrl(
      storageId: 'public',
      path: path,
    );
    return uri?.toString();
  }
}
