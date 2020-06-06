import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/di/initiative_detail_screen_component.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/initiative_detail_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class InitiativeDetailScreen
    extends MwwmWidget<InitiativeDetailScreenComponent> {
  InitiativeDetailScreen({
    Key key,
    WidgetModelBuilder widgetModelBuilder =
        createInitiativeDetailScreenWidgetModel,
    String postId,
  }) : super(
          key: key,
          dependenciesBuilder: (context) => InitiativeDetailScreenComponent(
            context,
            postId,
          ),
          widgetStateBuilder: () => _InitiativeDetailScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _InitiativeDetailScreenState
    extends WidgetState<InitiativeDetailScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<InitiativeDetailScreenComponent>(context)
          .component
          .scaffoldKey,
      backgroundColor: lavenderColor,
      appBar: AppBar(
        backgroundColor: lavenderColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: EntityStateBuilder<PostMessage>(
          streamedState: wm.dataState,
          loadingChild: Center(
            child: CircularProgressIndicator(),
          ),
          child: (context, post) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildPostType(post),
                  SizedBox(height: 10),
                  _buildName(post),
                  SizedBox(height: 6),
                  _buildTitle(post),
                  SizedBox(height: 16),
                  _buildPostStatistic(post),
                  SizedBox(height: 14),
                  _buildLikeButton(),
                  SizedBox(height: 20),
                  _buildPostBody(post),
                  SizedBox(height: 10),
                  _buildMap(),
                  SizedBox(height: 10),
                  //  _buildRecipes(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostType(PostMessage post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFF63FF8F)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                post.type,
                style: TextStyle(
                    color: text1, fontSize: 12, fontWeight: FontWeight.w600),
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
    );
  }

  Widget _buildName(PostMessage post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '${post.firstName} ${post.lastName}',
        style: TextStyle(
          color: blue1,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTitle(PostMessage post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        post.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: text1,
        ),
      ),
    );
  }

  Widget _buildPostStatistic(PostMessage post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Icon(Icons.person_add, color: text2),
            SizedBox(width: 6),
            Text(
              '${post.likes} поддержали\nрешение',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: text2),
            ),
            SizedBox(width: 10),
            Icon(Icons.remove_red_eye, color: text2),
            SizedBox(width: 6),
            Text(
              post.views.toString(),
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: text2),
            ),
            SizedBox(width: 30),
            Text(
              post.createDate,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: text2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: blue1,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  SvgPicture.asset(icLike),
                  SizedBox(width: 8),
                  Text(
                    'Поддержать',
                    style: TextStyle(
                        color: blue2,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildPostBody(PostMessage post) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              post.body,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: text2),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(imgImage16),
                  Image.asset(imgImage17),
                  Image.asset(imgImage16),
                  Image.asset(imgImage17),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(imgImage18),
        ),
      ),
    );
  }

  Widget _buildRecipes() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: blue2,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Алексей Гребницкий',
                      style: TextStyle(
                        color: blue1,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Image.asset(imgSwipe),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Решение',
              style: TextStyle(
                  color: blue1, fontSize: 12, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              'Отремонтировать грунтовую дорогу и вести ее поддержку на протяжении всей стройки.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: text1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
