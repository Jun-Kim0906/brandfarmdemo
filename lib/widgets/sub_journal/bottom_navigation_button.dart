import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _title;

  BottomNavigationButton({Key key, VoidCallback onPressed, @required String title})
      : _onPressed = onPressed,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 72,
      child: RaisedButton(
        color: Color(0xFF2F80ED),
        child: SizedBox(
          height: height * 0.04,
          width: width * 0.333,
          child: FittedBox(
            child: Text(
              _title ?? '다음',
              style: TextStyle(color: Colors.white, fontSize: 21.6),
            ),
          ),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}