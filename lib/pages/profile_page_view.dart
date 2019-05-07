import 'package:flutter/material.dart';
import 'package:flutter_responsive_ui/common/two_line_item.dart';
import 'package:flutter_responsive_ui/model/profile.dart';

class ProfilePageView extends StatefulWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final double opacity = 0.2;

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _slideAnimation;
  Animation _fadeAnimation;
  int currentIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _slideAnimation = TweenSequence([
      TweenSequenceItem<Offset>(
          weight: 10, tween: Tween(begin: Offset(0, 0), end: Offset(0, 1))),
      TweenSequenceItem<Offset>(
          weight: 90, tween: Tween(begin: Offset(0, 1), end: Offset(0, 0))),
    ]).animate(_controller);
    _fadeAnimation = TweenSequence([
      TweenSequenceItem<double>(weight: 10, tween: Tween(begin: 1, end: 0)),
      TweenSequenceItem<double>(weight: 9, tween: Tween(begin: 0, end: 1)),
    ]).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          itemCount: profiles.length,
          controller: widget._pageController,
          pageSnapping: true,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
              _controller.reset();
              _controller.forward();
            });
          },
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  profiles[index].imagePath,
                  fit: BoxFit.cover,
                  color: Colors.black,
                  colorBlendMode: BlendMode.hue,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(widget.opacity),
                        Colors.white.withOpacity(widget.opacity),
                        Colors.black.withOpacity(widget.opacity),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: ProfileDetails(
            index: currentIndex,
            slideAnimation: _slideAnimation,
            fadeAnimation: _fadeAnimation,
          ),
        ),
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final int index;
  final Animation slideAnimation, fadeAnimation;

  ProfileDetails({this.index, this.slideAnimation, this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.start,
              firstText: profiles[index].following.toString(),
              secondText: 'following',
            ),
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.center,
              firstText: profiles[index].posts.toString(),
              secondText: 'posts',
            ),
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.end,
              firstText: profiles[index].followers.toString(),
              secondText: 'followers',
            ),
          ],
        ),
      ),
    );
  }
}
