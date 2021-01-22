import 'package:BrandFarm/widgets/speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubHomeFAB extends StatelessWidget {
  const SubHomeFAB({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary),
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      children: [
        SpeedDialChild(
          child: SvgPicture.asset('assets/svg_icon/list_icon.svg',
              width: 24, fit: BoxFit.none),
          backgroundColor: Colors.white,
          labelWidget: Text(
            '일지목록',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          onTap: () {},
        ),

        SpeedDialChild(
          child: SvgPicture.asset(
            'assets/svg_icon/grow_icon.svg',
            width: 24,
            fit: BoxFit.none,
          ),
          backgroundColor: Colors.white,
          labelWidget: Text(
            '성장일지',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          onTap: () {},
        ),
        SpeedDialChild(
          child: SvgPicture.asset('assets/svg_icon/issue_icon.svg',
              width: 24, fit: BoxFit.none),
          backgroundColor: Colors.white,
          labelWidget: Text(
            '이슈일지',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          onTap: () {},
        ),

      ],
    );
  }
}
