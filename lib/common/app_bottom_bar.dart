import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      padding: const EdgeInsets.only(
        bottom: 32.0,
        left: 24.0,
        right: 24.0,
        top: 24.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.library_books, color: Colors.black),
          Icon(Icons.search, color: Colors.black),
          Icon(Icons.add, color: Colors.black),
          Icon(Icons.alarm, color: Colors.black),
          Icon(Icons.chat, color: Colors.black),
        ],
      ),
    );
  }
}
