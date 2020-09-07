import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final String image;
  final String name;
  @override
  _ItemWidgetState createState() => _ItemWidgetState();

  const ItemWidget({Key key, @required this.image, @required this.name})
      : super(key: key);
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 8, top: 0, bottom: 4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xff2a2a2a),
            boxShadow: [
              BoxShadow(
                color: Color(0xff2a2a2a),
                offset: Offset(0.0, 2.0), 
                blurRadius: 2.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                child: FittedBox(
                  child: Image.network(
                    widget.image,
                    height: 80,
                    width: 80,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(widget.name),
            ],
          ),
        ));
  }
}
