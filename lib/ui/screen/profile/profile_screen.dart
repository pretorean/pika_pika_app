import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/voice_way_step.dart';
import 'package:pika_pika_app/ui/common/widgets/bottom_navigation.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
import 'package:pika_pika_app/ui/screen/profile/profile_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/profile_screen_component.dart';

class ProfileScreen extends MwwmWidget<ProfileScreenComponent> {
  ProfileScreen([
    WidgetModelBuilder widgetModelBuilder = createProfileScreenWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => ProfileScreenComponent(context),
          widgetStateBuilder: () => _ProfileScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _ProfileScreenState extends WidgetState<ProfileScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackground,
      key: Injector.of<ProfileScreenComponent>(context).component.scaffoldKey,
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
            EntityStateBuilder<List<VoiceWayStep>>(
              streamedState: wm.voiceWayState,
              loadingChild: SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorChild: SliverToBoxAdapter(
                child: Container(),
              ),
              child: (context, steps) {
                return SliverList(
                  delegate: SliverChildListDelegate(_getItems(steps)),
                );
              },
            )
          ],
        ),
        BottomNavigation(HomeTab.profile)
      ],
    );
  }

  List<Widget> _getItems(List<VoiceWayStep> steps) {
    final items = <Widget>[];
    final leaderItems = <Widget>[];

    for (var i = 0; i < steps.length; i++) {
      leaderItems.add(StepItem(steps[i], wm, (i + 1) % 2 == 0));
    }

    items.addAll(leaderItems);
    items.add(Container(
      height: 115,
    ));
    return items;
  }
}

class HeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  final ProfileScreenWidgetModel wm;

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
  final ProfileScreenWidgetModel wm;

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
                    blurRadius: 10)
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
                          'Ваш путь голоса:',
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

class StepItem extends StatelessWidget {
  final VoiceWayStep voiceWayStep;
  final ProfileScreenWidgetModel wm;
  final bool isEven;
  final bool isOdd;

  StepItem(this.voiceWayStep, this.wm, this.isEven) : isOdd = !isEven;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center, children: getChildren()),
    );
  }

  List<Widget> getChildren() {
    final widgets = <Widget>[];

    if (isOdd) {
      widgets.add(SvgPicture.asset(icStepArrowRight));
      widgets.add(SizedBox(
        width: 40,
      ));
    }

    widgets.add(Row(
      children: <Widget>[
        Image.asset(
          voiceWayStep.toUserAvatar,
          width: 60,
          height: 60,
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              voiceWayStep.toUserName,
              style: TextStyle(
                  fontSize: 12,
                  color: blue1,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: BoxDecoration(
                  color: blue1,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [BoxShadow(
                    color: Color.fromRGBO(124, 145, 186, 0.39),
                    offset: Offset(0, 10),
                    blurRadius: 20
                  )]),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(icComment),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Комментарий',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: blue2,
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));

    if (isEven) {
      widgets.add(SizedBox(
        width: 40,
      ));
      widgets.add(SvgPicture.asset(icStepArrowLeft));
    }

    return widgets;
  }
}
