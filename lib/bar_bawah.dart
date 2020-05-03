import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webapp_super/args.dart';
import 'package:webapp_super/list_barang.dart';

import 'checkout.dart';

class BarBawah extends StatelessWidget {
  int _subtotal;
  int _txnID;
  var cur = NumberFormat.currency(locale: "id",symbol:"Rp. ",decimalDigits: 0);
  //var _timer;
  BarBawah(int _subtotal,int _txnID){
    this._subtotal=_subtotal;
    this._txnID=_txnID;
    //this._timer = ListBarang.listtimer;
  }

  @override
  Widget build(BuildContext context) {
    void _alertYakinCheckout(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Checkout"),
            content: new Text("Are you sure you want to finalize purchase?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                color: Colors.lime,
                textColor: Colors.white,
                child: new Text("Yes"),
                onPressed: () {
                  ListBarang.listtimer.cancel();
                  //Navigator.pushNamed(context, '/checkout');
                  Navigator.pushNamed(context,Checkout.routeName,arguments: Args(_subtotal,_txnID.toString()));
                },
              ),
            ],
          );
        },
      );
    }
    return BottomAppBar(
      color: Colors.lime,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            child: Text(
              "Subtotal: "+cur.format(_subtotal).toString(),
              style: Theme.of(context).textTheme.subhead.apply(fontWeightDelta: 20,fontSizeDelta: 1),
              ),
            padding: EdgeInsets.all(12.0),
          ),
          Padding(
              child: FlatButton(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.white),
                      left: BorderSide(width: 1.0, color: Colors.white),
                      right: BorderSide(width: 1.0, color: Colors.white),
                      bottom: BorderSide(width: 1.0, color: Colors.white),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Checkout',
                    style: Theme.of(context).textTheme.subhead.apply(fontWeightDelta: 10,color:Theme.of(context).textTheme.body1.color),
                  ),
                ),
                onPressed: _alertYakinCheckout,
              ),
            padding: EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }
  /*
  //menu checkout 2 baris
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                child: Text("Subtotal: "),
                padding: EdgeInsets.all(8.0),
              ),
              Padding(
                child: Text(_subtotal.toString()),
                padding: EdgeInsets.all(8.0),
              ),
              /*Padding(
                child: RaisedButton(
                onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  child: Text("Checkout"),
                ),
                padding: EdgeInsets.all(8.0),
              ),*/
            ],
          ),
          BarCheckout(),
        ]
      ),
    );
  }
  */
}