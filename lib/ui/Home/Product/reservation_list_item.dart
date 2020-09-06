import 'package:flutter/material.dart';
import 'package:qutub_clinet/models/productModel.dart';

class ReservationListItem extends StatefulWidget {
  ProductModel productModel;
  Map<int,bool> selectedPriceList = {};
  int index;
  ReservationListItem(this.productModel, this.selectedPriceList, this.index);
  @override
  _ReservationListItemState createState() => _ReservationListItemState();
}

class _ReservationListItemState extends State<ReservationListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title:
              Text(widget.productModel.priceList.keys.toList()[widget.index]),
          subtitle: Text(
            widget.productModel.priceList.values.toList()[widget.index] +
                " ريال",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          trailing: Checkbox(
              value: widget.selectedPriceList[widget.index],
              onChanged: (v) {
                widget.selectedPriceList[widget.index]=v;
              //  widget.selectedProducts[widget.productModel].values.elementAt(widget.index) = v;
                setState(() {});
              })),
    );
  }
}
