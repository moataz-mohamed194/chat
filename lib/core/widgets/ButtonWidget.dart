import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback action;

  const ButtonWidget({super.key, required this.text, required this.action});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xff5C027E),
        borderRadius: BorderRadius.all(
          Radius.circular(500.0),
        ),
      ),
      child: TextButton(
          onPressed: () {
            action();
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
