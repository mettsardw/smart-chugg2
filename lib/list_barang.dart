import 'dart:async';

import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:webapp_super/args.dart';
import 'package:webapp_super/bar_bawah.dart';
import 'package:webapp_super/barang.dart';
import 'package:webapp_super/barang_manager.dart';
import 'package:webapp_super/privacy_policy.dart';

class ListBarang extends StatefulWidget {
  static const routeName = '/listBarang';
  static Timer listtimer;
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
  int _subtotalBaru(){
    int tot = _barangs.length;
    int temp = 0;
    for (var i = 0; i < tot; i++) {
      temp += _barangs[i].getPrice();
    }
    return temp;
  }
  bool _alertDeleteBarang(int idx){
    bool flag=false;
    Text tamp(count){
      return new Text(count.toString());
    }
    int itemCount=1;
    String cnt = '1';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          
          return StatefulBuilder(
            builder: (context,setState){
              return AlertDialog(
                title: new Text("Delete ${_barangs[idx].getNama()}?"),
                content: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Quantity will decrease and you have'),
                      Text('to remove the item from cart.\n'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: ()=>setState((){
                              if(itemCount>1){
                                itemCount--;
                                cnt = itemCount.toString();
                                print('kedelete nih');
                              }
                            })
                          ),
                        new Text(cnt),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: ()=>setState((){
                              if(itemCount<_barangs[idx].qty){
                                itemCount++;
                                cnt = itemCount.toString();
                                print('keadd nih');
                              }
                            })
                          )
                      ],
                      ),
                    ],
                  ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("No"),
                    onPressed: () {
                      //_deleteBarang(idx);
                      Navigator.pop(context);
                    },
                  ),
                  new FlatButton(
                    color: Colors.lime,
                    textColor: Colors.white,
                    child: new Text("Yes"),
                    onPressed: () {
                      _deleteBarang(idx,itemCount);
                      Navigator.pop(context);
                    },
                  ),
                  ],
                );
            }
                );
            }
          );
    return flag;
  }
  void _deleteBarang(int idx,int count) {
    BarangManager bm = BarangManager();
    var isiAkhir = _barangs[idx].qty-count;
    if(isiAkhir==0){
      var id = _barangs[idx].id;
      bm.delBarang(id,txnID:_txnID);
      _barangs.removeAt(idx);
      setState(() {
      });
    }else{
      var id = _barangs[idx].id;
      bm.updBarang(id,isiAkhir,txnID:_txnID);
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
    if (ListBarang.listtimer==null || !ListBarang.listtimer.isActive) {
      ListBarang.listtimer = Timer.periodic(dur, (Timer t)=> callIsiBarang(context));
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
      body:
        Center(
        child: _barangs.isEmpty? Center(child: Text('Cart is empty, start scanning an item. :D')) : ListView.separated(
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
      bottomNavigationBar: BarBawah(_subtotal,_txnID),
      );
    }
    
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: truBuild(),
    );
  }
}