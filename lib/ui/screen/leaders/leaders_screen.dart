import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/leader.dart';
import 'package:pika_pika_app/ui/common/widgets/bottom_navigation.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/leaders_screen_component.dart';
import 'leaders_wm.dart';

class LeadersScreen extends MwwmWidget<LeadersScreenComponent> {
  LeadersScreen([
    WidgetModelBuilder widgetModelBuilder = createLeadersScreenWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => LeadersScreenComponent(context),
          widgetStateBuilder: () => _LeadersScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _LeadersScreenState extends WidgetState<LeadersScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackground,
      key: Injector.of<LeadersScreenComponent>(context).component.scaffoldKey,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
                pinned: true, delegate: HeaderSliverDelegate(wm)),
            SliverPadding(padding: EdgeInsets.only(top: 5)),
            EntityStateBuilder<List<Leader>>(
              streamedState: wm.leadersState,
              loadingChild: SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorChild: SliverToBoxAdapter(
                child: Container(),
              ),
              child: (context, leaders) {
                return SliverList(
                  delegate: SliverChildListDelegate(_getItems(leaders)),
                );
              },
            )
          ],
        ),
        BottomNavigation(HomeTab.leaders)
      ],
    );
  }

  List<Widget> _getItems(List<Leader> leaders) {
    final items = <Widget>[];
    final leaderItems = <Widget>[];

    for (var i = 0; i < leaders.length; i++) {
      leaderItems.add(LeaderItem(leaders[i], i + 1, wm));
    }

    items.addAll(leaderItems);
    items.add(Container(
      height: 115,
    ));
    return items;
  }
}

class HeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  final LeadersScreenWidgetModel wm;

  HeaderSliverDelegate(this.wm);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Header(wm);
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class Header extends StatelessWidget {
  final LeadersScreenWidgetModel wm;

  Header(this.wm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFE2E8F4),
                    offset: Offset(0, 10),
                    blurRadius: 30)
              ]),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    child: Image.asset(imgAvatar),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Здравствуйте, Максим',
                          style: TextStyle(
                              color: blue1,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Рейтинг лидеров:',
                          style: TextStyle(
                              color: text1,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(icSearch),
                  SizedBox(width: 10),
                  SvgPicture.asset(icQrCode),
                  SizedBox(width: 10),
                  SvgPicture.asset(icSettings),
                ],
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
  final LeadersScreenWidgetModel wm;

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
                child: LeaderItemAvatar(place),
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
                      decoration: TextDecoration.underline
                    ),
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
                            decoration: TextDecoration.underline
                        ),
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
  final avatars = <String>[
    imgUserAvatar1,
    imgUserAvatar2,
    imgUserAvatar3,
  ];
  final random = Random();

  LeaderItemAvatar(this.place);

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
              child: Image.asset(avatars[random.nextInt(avatars.length)]),
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
