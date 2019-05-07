import 'package:flutter/material.dart';
import 'package:flutter_responsive_ui/common/app_bottom_bar.dart';
import 'package:flutter_responsive_ui/pages/profile_page_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.90;
  double expandedHeightFactor = 0.75;
  bool isAnimationCompleted = false;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor)
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onBottomPartTap() {
    setState(() {
      if (isAnimationCompleted) {
        _controller.fling(velocity: -1);
      } else {
        _controller.fling(velocity: 1);
      }

      isAnimationCompleted = !isAnimationCompleted;
    });
  }

  Widget getWidget() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: _heightFactorAnimation.value,
          child: ProfilePageView(),
        ),
        GestureDetector(
          onTap: onBottomPartTap,
          onVerticalDragUpdate: _handleVerticalUpdate,
          onVerticalDragEnd: _handleVerticalEnd,
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 1.05 - _heightFactorAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _handleVerticalUpdate(DragUpdateDetails updateDetails) {
    double fractionDragged = updateDetails.primaryDelta / screenHeight;
    _controller.value = _controller.value - 5 * fractionDragged;
  }

  _handleVerticalEnd(DragEndDetails endDetails) {
    if (_controller.value >= 0.5) {
      _controller.fling(velocity: 1);
    } else {
      _controller.fling(velocity: -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      bottomNavigationBar: AppBottomBar(),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return getWidget();
        },
      ),
    );
  }
}
