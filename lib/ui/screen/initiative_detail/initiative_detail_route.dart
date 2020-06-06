import 'package:flutter/material.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/initiative_detail_screen.dart';

class InitiativeDetailScreenRoute extends MaterialPageRoute {
  InitiativeDetailScreenRoute({
    @required String postId,
  }) : super(builder: (ctx) => InitiativeDetailScreen(postId: postId));
}
