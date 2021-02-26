import 'package:flutter/material.dart';

class FieldTabBar extends StatefulWidget {
  @override
  _FieldTabBarState createState() => _FieldTabBarState();
}

class _FieldTabBarState extends State<FieldTabBar> {
  List tabNames = [
    Tab(true, '필드A'),
    Tab(false, '필드B'),
    Tab(false, '필드C'),
  ];
  int tabIndex;

  @override
  void initState() {
    super.initState();
    tabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabNames.length + 1, (index) {
        return (index < tabNames.length)
            ? _tab(tab: tabNames[index], index: index)
            : _trailingLine();
      }),
    );
  }

  void setFirstTabTrue({int index}) {
    Tab first = Tab(!tabNames[index].isTapped, tabNames[index].name);
    setState(() {
      tabNames.removeAt(index);
      tabNames.insert(index, first);
    });
  }

  Widget _tab({Tab tab, int index}) {
    return InkWell(
      onTap: () {
        Tab selectedTab = Tab(!tabNames[index].isTapped, tabNames[index].name);
        for (int i = 0; i < tabNames.length; i++) {
          Tab tmp = Tab(false, tabNames[i].name);
          setState(() {
            tabNames.removeAt(i);
            tabNames.insert(i, tmp);
          });
        }
        setState(() {
          tabNames.removeAt(index);
          tabNames.insert(index, selectedTab);
        });
      },
      child: Container(
        height: 42,
        width: 138,
        decoration: BoxDecoration(
            border: (tab.isTapped)
                ? Border(
                    bottom: BorderSide(width: 4, color: Color(0xFF15B85B)),
                  )
                : Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFDFDFDF)),
                  )),
        child: Row(
          children: [
            Text(
              '${tab.name}',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w500,
                    color: (tab.isTapped) ? Color(0xFF15B85B) : Colors.black,
                  ),
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Color(0xFF15B85B),
                child: Text(
                  '${6}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trailingLine() {
    return Expanded(
      child: Container(
        height: 42,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFFDFDFDF)),
        )),
        // child: Text(
        //   'empty',
        //   style: TextStyle(color: Colors.white),
        // ),
      ),
    );
  }
}

class Tab {
  bool isTapped;
  String name;

  Tab(this.isTapped, this.name,);
}
