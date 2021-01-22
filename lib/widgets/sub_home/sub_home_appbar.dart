import 'package:BrandFarm/widgets/brandfarm_icons.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class SubHomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SubHomeAppBar({
    Key key, this.iconPressed, this.notificationPressed, this.settingPressed,
  }) : super(key: key);
  
  final Function iconPressed;
  final Function notificationPressed;
  final Function settingPressed;

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                iconSize: 60.0,
                icon: Image.asset('assets/brandfarm.png'),
                onPressed: iconPressed,
              ),
              Spacer(),
              Badge(
                position: BadgePosition.topEnd(top: 2, end: 8),
                badgeContent: Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                child: IconButton(
                  iconSize: 40.0,
                  icon: Icon(
                    Icons.notifications_none_sharp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: notificationPressed,
                ),
                padding: EdgeInsets.all(4.5),
              ),
              IconButton(
                  iconSize: 35.0,
                  icon: Icon(
                    BrandFarmIcons.settings,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: settingPressed)
            ],
          ),
        )
      ],
    );
  }
}