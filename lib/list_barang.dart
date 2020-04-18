import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webapp_super/args.dart';
import 'package:webapp_super/bar_bawah.dart';
import 'package:webapp_super/barang.dart';
import 'package:webapp_super/barang_manager.dart';
import 'package:webapp_super/privacy_policy.dart';
import 'package:webapp_super/scan_keranjang.dart';

class ListBarang extends StatefulWidget {
  static const routeName = '/listBarang';
  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  //List<Barang> _barangs = [new Barang(1,"IyemIyem", 1, 2000)];
  List<Barang> _barangs = [];
  //int _subtotal = 3999;
  int _subtotal = 0;
  int _txnID;// = 1;
  var dur = Duration(seconds:5);
  Timer _timer;
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
      int idx = _barangs.length;
      Barang baru = new Barang(idx+1, "Iyem-"+idx.toString(), 1, idx*1010);
      bool isExistID = false;
      for (var _barang in _barangs) {
        if (baru.id==_barang.id) {
          isExistID = true;
          if (isExistID) {
            _barang.addQty();
          }
          break;
        }
      }
      if (!isExistID) {
        _barangs.add(baru);
      }
      _subtotal = _subtotalBaru();
      /*
      _counter++;
      _dataBarang.add(_counter.toString());
      _dataPrice.add((_counter*1000));
      _subtotal+=(_counter*1000);
      */
    });
  }
  bool _alertDeleteBarang(int idx){
    bool flag=false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Are you sure you want to delete?"),
            content: new Text("Quantity will decrease and you have to remove item from cart."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  //_deleteBarang(idx);
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  _deleteBarang(idx);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    return flag;
  }
  void _deleteBarang(int idx) {
    BarangManager bm = BarangManager();
    if(_barangs[idx].qty==1){
      var id = _barangs[idx].id;
      bm.delBarang(id,txnID:_txnID);
      _barangs.removeAt(idx);
      setState(() {
        
      });
    }else{
      var id = _barangs[idx].id;
      _barangs[idx].removeBarang();
      var qtyUpd = _barangs[idx].qty;
      bm.updBarang(id,qtyUpd,txnID:_txnID);
      setState(() {
        
      });
    }
    _subtotal = _subtotalBaru();
  }

  callIsiBarang(context) async{
    BarangManager bm = BarangManager();
    _barangs = await bm.isiBarangs(txnID:_txnID);
    _subtotal = _subtotalBaru();
    setState(() {
      
    });
  }
  /*
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)=>callIsiBarang(context));
  }*/

  @override
  Widget build(BuildContext context) {
    final Args args = ModalRoute.of(context).settings.arguments;
    _txnID=int.parse(args.txnID);
    if (_timer==null) {
      _timer = new Timer.periodic(dur, (Timer t)=> callIsiBarang(context));
    }else if(!_timer.isActive){
      _timer = new Timer.periodic(dur, (Timer t)=> callIsiBarang(context));
    }

    truBuild(){
        return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Shopping List"),
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
                    value: Text('2'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ScanKeranjang.routeName);
                      },
                      child: Text('Change Cart')
                      ),
                  ),
                  /*
                  PopupMenuItem<Text>(
                    value: Text('3'),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, TermsAndConditions.routeName);
                      },
                      child: Text('Terms & Conditions')
                      ),
                  ),*/
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
              title: Text(_barangs[i].nama),
              subtitle: Text(_barangs[i].infoPrice()),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline,color: Colors.red,),
                onPressed: () => _alertDeleteBarang(i),
              ),
            );
          },
        )
      ),
      /*
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        icon: const Icon(Icons.add),
        label: const Text('Add item'),
        onPressed: _tambahBarang,
        tooltip: 'Increment',
      ),
      floatingActionButtonLocation: 
        FloatingActionButtonLocation.endFloat,
      */
      bottomNavigationBar: BarBawah(_subtotal,_txnID,_timer),
      );
    }
    
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: truBuild(),
    );
  }
}