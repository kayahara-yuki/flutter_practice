import 'package:drawer_like_flutter/bottom_part.dart';
import 'package:drawer_like_flutter/lower_part.dart';
import 'package:drawer_like_flutter/middle_part.dart';
import 'package:drawer_like_flutter/upper_part.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home Page'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.8,
      child: Drawer(
        child: Column(
          children: [
            UpperPart(),
            Flexible(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  MiddlePart(),
                  LowerPart(),
                ],
              ),
            ),
            BottomPart(),
          ],
        ),
      ),
    );
  }
}