import 'package:flutter/material.dart';


class DepartmentBadge extends StatefulWidget {
  DepartmentBadge({this.department});

  final String department;

  @override
  _DepartmentBadgeState createState() => _DepartmentBadgeState();
}

class _DepartmentBadgeState extends State<DepartmentBadge> {
  Color _badgeColor;

  String _department;

  @override
  Widget build(BuildContext context) {
    switch(widget.department){
      case 'field':
        _badgeColor = Theme.of(context).primaryColor;
        _department = '필드';
        break;
      case 'office':
        _badgeColor = Color(0xFFFFD231);
        _department = 'OM';
        break;
      case 'shed' :
        _badgeColor = Color(0xFFFFD231);
        _department = '쉐드';
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        color: _badgeColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0),
        child: Text(
          _department,
          style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
        ),
      )
    );
  }
}
