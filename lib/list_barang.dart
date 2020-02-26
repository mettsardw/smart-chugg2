import 'package:flutter/material.dart';
import 'package:webapp_super/bar_bawah.dart';
import 'package:webapp_super/barang.dart';
import 'package:webapp_super/privacy_policy.dart';
import 'package:webapp_super/scan_keranjang.dart';
import 'package:webapp_super/terms_and_conditions.dart';

class ListBarang extends StatefulWidget {
  static const routeName = '/listBarang';
  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  int _counter = 2;
  List<Barang> _barangs = [new Barang(1,"IyemIyem", 1, 2000)];
  int _subtotal = 3999;
  int _subtotalBaru(){
    int tot = _barangs.length;
    int temp = 0;
    for (var i = 0; i < tot; i++) {
      temp += _barangs[i].getPrice();
    }
    return temp;
  }
  void _tambahBarang() {
    setState(() {
      //fetch new barang item
      int idx = _barangs.length;
      Barang baru = new Barang(idx+1, "Iyem-"+idx.toString(), 1, idx*1010);
      _barangs.add(baru);
      _subtotal = _subtotalBaru();
      /*
      _counter++;
      _dataBarang.add(_counter.toString());
      _dataPrice.add((_counter*1000));
      _subtotal+=(_counter*1000);
      */
    });
  }
  bool _alertDeleteBarang(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Are you sure you want to delete?"),
            content: new Text("Quantity will decrease and you have to remove item from cart."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("YES"),
                onPressed: () {
                  return true;
                },
              ),
              new FlatButton(
                child: new Text("NO"),
                onPressed: () {
                  return false;
                },
              ),
            ],
          );
        },
      );
    return true;
  }
  void _deleteBarang(int idx) {
    //TODO: gimana caranya supaya bisa dialog boxnya jalan?
    if(_alertDeleteBarang()==true){
      if(_barangs[idx].qty==1){
        setState(() {
          _barangs.removeAt(idx);
        });
      }else{
        setState(() {
          _barangs[idx].removeBarang();
        });
      }
    }
    _subtotal = _subtotalBaru();
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
                  PopupMenuItem<Text>(
                    value: Text('1'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ScanKeranjang.routeName);
                      },
                      child: Text(
                        'Remove Item',
                      ),
                      ),
                  ),
                  PopupMenuItem<Text>(
                    value: Text('2'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ScanKeranjang.routeName);
                      },
                      child: Text('Change Cart')
                      ),
                  ),
                  PopupMenuItem<Text>(
                    value: Text('3'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, TermsAndConditions.routeName);
                      },
                      child: Text('Terms & Conditions')
                      ),
                  ),
                  PopupMenuItem<Text>(
                    value: Text('4'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PrivacyPolicy.routeName);
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
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: _barangs.length,
          itemBuilder: (context, int i){
            return new ListTile(
              //leading: FlutterLogo(size: 56.0),
              title: Text(_barangs[i].nama),
              subtitle: Text(_barangs[i].infoPrice()),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () => _deleteBarang(i),
              ),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        icon: const Icon(Icons.add),
        label: const Text('Add item'),
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