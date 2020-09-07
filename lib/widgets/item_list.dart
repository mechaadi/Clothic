import 'package:clothic/model/donation.dart';
import 'package:clothic/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  final int category;
  final String categoryName;
  @override
  _ItemListState createState() => _ItemListState();

  const ItemList(
      {Key key, @required this.category, @required this.categoryName})
      : super(key: key);
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<List<Donation>>(context);

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.categoryName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.arrow_forward_ios),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 130,
              child: Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => Container(
                            child: itemProvider[i].cloth_type == widget.category
                                ? ItemWidget(
                                    image: itemProvider[i].image,
                                    name: itemProvider[i].name,
                                  )
                                : Container(),
                          ),
                      itemCount: itemProvider.length)))
        ],
      ),
    );
  }
}
