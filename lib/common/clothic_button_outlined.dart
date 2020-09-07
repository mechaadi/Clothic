import 'package:flutter/material.dart';

class ClothicButtonOutlined extends StatefulWidget {
  final String text;
  final Color color;
  final Function onClick;
  final double height;
  final double fontSize;
  @override
  _ClothicButtonOutlinedState createState() => _ClothicButtonOutlinedState();
  const ClothicButtonOutlined(
      {Key key,
      @required this.text,
      @required this.color,
      @required this.height,
      @required this.fontSize,
      @required this.onClick})
      : super(key: key);
}

class _ClothicButtonOutlinedState extends State<ClothicButtonOutlined> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        child: InkWell(
          onTap: widget.onClick,
          child: Container(
            height: widget.height,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: widget.fontSize),
              ),
            ),
            decoration: BoxDecoration(

                // color: widget.color,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: widget.color, width: 2)),
          ),
        ),
      ),
    );
  }
}
