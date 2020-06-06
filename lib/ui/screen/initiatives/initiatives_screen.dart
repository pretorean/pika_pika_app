import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/ui/common/widgets/bottom_navigation.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
import 'package:pika_pika_app/ui/res/strings/strings.dart';
import 'package:pika_pika_app/ui/screen/initiatives/initiatives_filter.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/initiatives_screen_component.dart';
import 'initiatives_wm.dart';

class InitiativesScreen extends MwwmWidget<InitiativesScreenComponent> {
  InitiativesScreen([
    WidgetModelBuilder widgetModelBuilder = createInitiativesScreenWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => InitiativesScreenComponent(context),
          widgetStateBuilder: () => _InitiativesScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _InitiativesScreenState
    extends WidgetState<InitiativesScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBE8FF),
      key: Injector.of<InitiativesScreenComponent>(context)
          .component
          .scaffoldKey,
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
            EntityStateBuilder<List<PostMessage>>(
                streamedState: wm.initiativesState,
                loadingChild: SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                child: (context, posts) {
                  return SliverList(
                    delegate: SliverChildListDelegate(_getItems(posts)),
                  );
                })
          ],
        ),
        BottomNavigation(HomeTab.initiatives)
      ],
    );
  }

  List<Widget> _getItems(List<PostMessage> posts) {
    final items = <Widget>[];
    final initiativeItems =
        posts.map((post) => InitiativeItem(post, wm)).toList();
    items.addAll(initiativeItems);
    items.add(Container(
      height: 115,
    ));
    return items;
  }
}

class HeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  final InitiativesScreenWidgetModel wm;

  HeaderSliverDelegate(this.wm);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Header(wm);
  }

  @override
  double get maxExtent => 135;

  @override
  // TODO: implement minExtent
  double get minExtent => 135;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class InitiativeItem extends StatelessWidget {
  final PostMessage initiative;
  final InitiativesScreenWidgetModel wm;

  InitiativeItem(this.initiative, this.wm);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: GestureDetector(
        onTap: () {
          wm.openDetailAction.accept(initiative.id);
        },
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 32),
                child: Container(
                  width: 3,
                  color: blue1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 23, right: 23, top: 20, bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xFF63FF8F)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              initiative.type,
                              style: TextStyle(
                                  color: text1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          icShare,
                          height: 36,
                          width: 36,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${initiative.firstName} ${initiative.lastName}',
                      style: TextStyle(
                          color: blue1,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 6),
                    Text(
                      initiative.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: text1,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(icLikes),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          initiative.likes.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: text2),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(icViews),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          initiative.views.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: text2),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          initiative.createDate,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: text2),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final InitiativesScreenWidgetModel wm;

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
                          initiativesScreenTitle,
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
              SizedBox(
                height: 10,
              ),
              StreamedStateBuilder<InitiativesFilter>(
                streamedState: wm.filterState,
                builder: (context, filter) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterButton(initiativesFilterButtonActive,
                          filter == InitiativesFilter.active, () {
                        wm.filterAction.accept(InitiativesFilter.active);
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      FilterButton(initiativesFilterButtonSolved,
                          filter == InitiativesFilter.solved, () {
                        wm.filterAction.accept(InitiativesFilter.solved);
                      }),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String title;
  final bool checked;
  final Function onPressed;

  FilterButton(this.title, this.checked, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(minHeight: 35, minWidth: 110),
        decoration: BoxDecoration(
          color: checked ? yellow1 : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: checked
              ? Border.fromBorderSide(BorderSide.none)
              : Border.all(width: 1, color: Color(0xFFDBE8FF)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: checked ? Color(0xFF2D2314) : Color(0xFFDBE8FF),
            ),
          ),
        ),
      ),
    );
  }
}
