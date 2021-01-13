import 'package:flutter/material.dart';


class DepartmentBadge extends StatelessWidget {
  DepartmentBadge({this.department});

  final String department;

  Color _badgeColor;
  String _department;

  @override
  Widget build(BuildContext context) {
    switch(department){
      case 'field':
        _badgeColor = Theme.of(context).primaryColor;
        _department = '필드';
        break;
      case 'office':
        break;
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
