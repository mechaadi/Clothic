import 'package:flutter/material.dart';

class ClothicButton extends StatefulWidget {
  final String text;
  final Color color;
  final Function onClick;
  @override
  _ClothicButtonState createState() => _ClothicButtonState();
  const ClothicButton({Key key, @required this.text, @required this.color, @required this.onClick})
      : super(key: key);
}

class _ClothicButtonState extends State<ClothicButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        child: InkWell(
          onTap: widget.onClick,
          child: Container(
            height: 40,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
      ),
    );
  }
}
