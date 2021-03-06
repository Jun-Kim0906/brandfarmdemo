import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final bool _isValid;

  LoginButton({Key key, VoidCallback onPressed, bool isValid})
      : _onPressed = onPressed,
        _isValid = isValid,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        padding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: _onPressed,
        child: Container(
          decoration: _isValid?BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xff27D878),
                Color(0xff5AC8E0),
              ]
            )
          ) : null,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text(
            '로그인',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
