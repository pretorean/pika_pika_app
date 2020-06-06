import 'package:flutter/material.dart';

class PostRequest {
  final String postId;


  PostRequest({
    @required this.postId,
  });

  Map<String, dynamic> get json => {
    'id': postId,
  };
}