import 'package:BrandFarm/widgets/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  AnimateIconController controller;

  @override
  void initState() {
    controller = AnimateIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimateIcons(
                startIcon: SvgPicture.asset('assets/svg_icon/journal_icon.svg'),
                endIcon: SvgPicture.asset('assets/svg_icon/close_icon.svg'),
                size: 100.0,
                controller: controller,
                // add this tooltip for the start icon
                startTooltip: 'Icons.add_circle',
                // add this tooltip for the end icon
                endTooltip: 'Icons.add_circle_outline',
                onEndIconPress: () {
                  return true;
                },
                onStartIconPress: () {
                  return true;
                },
                duration: Duration(milliseconds: 600),
                clockwise: true,
                color: Colors.deepPurple,
              ),
              IconButton(
                iconSize: 50.0,
                icon: Icon(
                  Icons.play_arrow,
                ),
                onPressed: () {
                  if (controller.isStart()) {
                    controller.animateToEnd();
                  } else if (controller.isEnd()) {
                    controller.animateToStart();
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
