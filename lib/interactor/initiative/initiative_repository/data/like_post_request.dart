import 'package:flutter/material.dart';

class LikePostRequest {
  final String postId;


  LikePostRequest({
    @required this.postId,
  });

  Map<String, dynamic> get json => {
    'post': postId,
  };
}