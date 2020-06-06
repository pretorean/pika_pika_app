import 'package:flutter/material.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/initiative_detail_screen.dart';

class InitiativeDetailRoute extends MaterialPageRoute {
  InitiativeDetailRoute({
    @required String postId,
  }) : super(builder: (ctx) => InitiativeDetail(postId: postId));
}
