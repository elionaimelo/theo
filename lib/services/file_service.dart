import 'dart:io' as io;
import 'dart:typed_data';

import 'package:storage_client/src/fetch.dart';
import 'package:supabase/supabase.dart' as sup;
import 'package:theo/core/constants/file_consts.dart';
import 'package:theo/core/dot_env.dart';
import 'package:theo/models/file.dart';

import 'api_client.dart';

class FileService {
  FileService(this.client);

  final APIClient client;

  Future<StorageResponse<Uint8List>> downloadFile(File file) async {
    var response = await client.supabase.storage
        .from(DotEnv.SUPABASE_BUCKET_NAME!)
        .download(file.name ?? '');

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response;
  }

  Future<sup.PostgrestResponse?> createUploadFiles({
    required List<String> filesPath,
    required String storyId,
  }) async {
    var ioFiles = filesPath.map((e) => io.File(e)).toList();
    var newFiles = ioFiles
        .map((e) => File(ext: e.path.split('.').last, storyId: storyId))
        .toList();

    var fileResponse = await client.supabase
        .from('files')
        .insert([...newFiles.map((e) => e.toJson(withId: false))]).execute();

    if (fileResponse.error != null) {
      throw Exception(fileResponse.error!.message);
    }

    newFiles = (fileResponse.data as List<dynamic>)
        .map((e) => File.fromJson(e)!)
        .toList();

    var uploadResponse = await Future.wait(newFiles.map((e) async {
      var index = newFiles.indexOf(e);

      return await client.supabase.storage
          .from(DotEnv.SUPABASE_BUCKET_NAME!)
          .upload(e.bucketPath!, ioFiles[index]);
    }));

    var responseWithError = uploadResponse.firstWhere(
      (element) => element.error != null,
      orElse: () => StorageResponse(error: null),
    );

    if (responseWithError.error != null) {
      throw Exception(responseWithError.error!.message);
    }

    return fileResponse;
  }

  Future<String?> getFileSignedUrl(
    File file, {
    int secondsActive = FileConsts.ONE_DAY_IN_SECONDS,
  }) async {
    var response = client.supabase.storage
        .from(DotEnv.SUPABASE_BUCKET_NAME!)
        .getPublicUrl(file.bucketPath!);

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response.data;
  }
}
