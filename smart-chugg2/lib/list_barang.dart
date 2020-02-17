import 'package:flutter/material.dart';

class ListBarang extends StatefulWidget {
  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  int _counter = 2;
  List<String> _dataBarang = ["ASH","BIBI"];
  List<int> _dataPrice = [1000,2999];
  int _subtotal = 3999;
  void _tambahBarang() {
    setState(() {
      _counter++;
      _dataBarang.add(_counter.toString());
      _dataPrice.add((_counter*1000));
      _subtotal+=(_counter*1000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang Belanja")
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _dataBarang.length,
          itemBuilder: (context, int i){
            return new ListTile(
              //leading: FlutterLogo(size: 56.0),
              title: Text(_dataBarang[i]),
              subtitle: Text(_dataPrice[i].toString()),
              trailing: Icon(Icons.more_vert)
            );
          },
        )
      ),
      bottomNavigationBar: BarBawah(_subtotal),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahBarang,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class BarBawah extends StatelessWidget {
  int _subtotal;
  BarBawah(int _subtotal){
    this._subtotal=_subtotal;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            child: Text("Subtotal: "+_subtotal.toString()),
            padding: EdgeInsets.all(8.0),
          ),
          Padding(
            child: RaisedButton(
            onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
              child: Text("Checkout"),
            ),
            padding: EdgeInsets.all(8.0),
          ),
          /*
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
          )
          */
        ],
      ),
    );
  }
}