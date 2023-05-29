import 'package:toktik/domain/entities/video_post.dart';

abstract class VideoPostDataSource {
  Future<List<VideoPost>> getFavouriteVideosByUser(int userId);

  Future<List<VideoPost>> getTrendingVideosByPage(int page);
}
