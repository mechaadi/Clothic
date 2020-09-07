import 'package:flutter/material.dart';

class ClothicInput extends StatefulWidget {
  final String hint;
  final Function onChange;
  final int maxLines;
  final bool isPassword;
  @override
  _ClothicInputState createState() => _ClothicInputState();
  const ClothicInput(
      {Key key,
      @required this.hint,
      @required this.onChange,
      @required this.maxLines,
      @required this.isPassword})
      : super(key: key);
}

class _ClothicInputState extends State<ClothicInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: TextField(
          maxLines: widget.maxLines,
          obscureText: widget.isPassword,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintText: widget.hint,
            fillColor: Color(0xff2a2a2a),
            contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          ),
          onChanged: widget.onChange,
        ),
      ),
      padding: EdgeInsets.only(top: 4, bottom: 4),
    );
  }
}
