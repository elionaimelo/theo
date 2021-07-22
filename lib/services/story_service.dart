import 'dart:io' as io;
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';
import 'package:storage_client/src/fetch.dart';
import 'package:supabase/supabase.dart' as sup;
import 'package:theo/core/dot_env.dart';
import 'package:theo/models/file.dart';
import 'package:theo/models/story.dart';

import 'api_client.dart';

class StoryService {
  StoryService(this.client);

  final APIClient client;

  Future<sup.PostgrestResponse?> fetchStories() async {}

  Future<sup.PostgrestResponse?> createStory(
      {required Story story, required List<String> filesPath}) async {
    var storyResponse = await client.supabase
        .from('stories')
        .insert(story.toJson(withId: false))
        .execute();

    if (storyResponse.error != null) {
      throw Exception(storyResponse.error!.message);
    }

    var storyId = Story.fromJson(storyResponse.data[0])!.id;

    var filesResponse = await client.fileService.createUploadFiles(
      filesPath: filesPath,
      storyId: storyId!,
    );

    if (filesResponse!.error != null) {
      throw Exception(filesResponse.error!.message);
    }

    storyResponse.data.first['files'] = filesResponse.data;

    return storyResponse;
  }
}
