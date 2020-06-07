import 'package:flutter/material.dart';

import 'leader_details_screen.dart';

class LeaderDetailsScreenRoute extends MaterialPageRoute {
  LeaderDetailsScreenRoute({
    @required String leaderId,
}) : super(builder: (ctx) => LeaderDetailsScreen(leaderId: leaderId));
}
