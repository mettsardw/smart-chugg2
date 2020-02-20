import 'package:flutter/material.dart';
import 'package:webapp_super/bar_bawah.dart';

class ListBarang extends StatefulWidget {
  static const routeName = '/listBarang';
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
        title: Text("Keranjang Belanja"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: PopupMenuButton(
              offset: Offset.fromDirection(-100,4000000000000000.0),
              elevation: 4.0,
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<Text>>[
                  const PopupMenuItem<Text>(
                    value: Text('1'),
                    child: Text('Remove an item'),
                  ),
                  PopupMenuItem<Text>(
                    value: Text('2'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/scanKeranjang');
                      },
                      child: Text('Change Cart')
                      ),
                  ),
                  PopupMenuItem<Text>(
                    value: Text('3'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/tNC');
                      },
                      child: Text('Terms & Conditions')
                      ),
                  ),
                  PopupMenuItem<Text>(
                    value: Text('4'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pP');
                      },
                      child: Text('Privacy Policy')
                      ),
                  )
                ];
              },
            )
          ),
        ],
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
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        icon: const Icon(Icons.add),
        label: const Text('Add a task'),
        onPressed: _tambahBarang,
        tooltip: 'Increment',
      ),
      floatingActionButtonLocation: 
        FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BarBawah(_subtotal),
    );
  }
}

class BarCheckout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          child: RaisedButton(
          onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
            child: Text("Checkout"),
          ),
          padding: EdgeInsets.all(8.0),
        ),
      ],
    );
  }

}