import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/leader.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/leader_details_screen_component.dart';
import 'leader_details_wm.dart';

class LeaderDetailsScreen extends MwwmWidget<LeaderDetailsScreenComponent> {
  LeaderDetailsScreen({
    WidgetModelBuilder widgetModelBuilder =
        createLeaderDetailsScreenWidgetModel,
    String leaderId,
  }) : super(
          dependenciesBuilder: (context) =>
              LeaderDetailsScreenComponent(context, leaderId),
          widgetStateBuilder: () => _LeaderDetailsScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _LeaderDetailsScreenState
    extends WidgetState<LeaderDetailsScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackground,
      key: Injector.of<LeaderDetailsScreenComponent>(context)
          .component
          .scaffoldKey,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return EntityStateBuilder<Leader>(
        streamedState: wm.dataState,
        child: (context, leader) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: HeaderSliverDelegate(wm, leader),
              ),
            ],
          );
        });
  }
}

class HeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  final LeaderDetailsScreenWidgetModel wm;
  final Leader leader;

  HeaderSliverDelegate(this.wm, this.leader);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Header(wm, leader);
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 300;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class Header extends StatelessWidget {
  final LeaderDetailsScreenWidgetModel wm;
  final Leader leader;

  Header(this.wm, this.leader);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: blue1,
            boxShadow: [
              BoxShadow(
                blurRadius: 60,
                offset: Offset(0, 20),
                color: Color(0xFFA5B3CE),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Image.asset(
                leader.avatar,
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                leader.firstName + ' ' + leader.lastName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: blue2),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Рейтинг:',
                    style: TextStyle(
                        color: white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SvgPicture.asset(icStar),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    leader.voices + ' голосов',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                        color: yellow1,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(icStarOutlined),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Отдать голос',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: orange,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaderItem extends StatelessWidget {
  final Leader leader;
  final int place;
  final LeaderDetailsScreenWidgetModel wm;

  LeaderItem(this.leader, this.place, this.wm);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: blue2, width: 1))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: LeaderItemAvatar(place, leader.avatar),
              ),
              SizedBox(
                width: 26,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 28,
                  ),
                  Text(
                    leader.firstName + ' ' + leader.lastName,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blue1,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(icStar),
                      Text(
                        leader.voices + ' голосов',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: orange,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                        color: yellow1,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(icStarOutlined),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Отдать голос',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: orange,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderItemAvatar extends StatelessWidget {
  final int place;
  final String avatar;

  LeaderItemAvatar(this.place, this.avatar);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 68,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 30,
              child: Image.asset(avatar),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: ShapeDecoration(
              color: orange,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    offset: Offset(0, 10),
                    blurRadius: 10)
              ],
            ),
            child: Center(
              child: Text(
                place.toString(),
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
