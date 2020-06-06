import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/interactor/base/transformable.dart';

class PostsListResponse implements Transformable<List<PostMessage>> {
  final List<PostMessage> posts;

  PostsListResponse({
    this.posts,
  });

  PostsListResponse.fromJson(Map<String, dynamic> json)
      : posts = _parsePosts(json['message']['result'] as List<dynamic>);


  static List<PostMessage> _parsePosts(List<dynamic> rawPosts) {
    return rawPosts.map((rawPost) => PostMessage.fromJson(rawPost)).toList();
  }

  @override
  List<PostMessage> transform() => posts;


}