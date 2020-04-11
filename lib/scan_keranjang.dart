/*import 'package:flutter/material.dart';

class ScanKeranjang extends StatelessWidget {
  static const routeName = '/scanKeranjang';
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Scan Keranjang Belanja"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/listBarang');
          },
          child: Text('List Barang'),
        ),
      ),
    );
    return scaffold;
  }
}
*/

import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webapp_super/args.dart';
import 'package:webapp_super/list_barang.dart';
import 'package:webapp_super/self_client.dart';

class ScanKeranjang extends StatefulWidget {
  static const routeName = '/scanKeranjang';
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanKeranjang> {
  String barcode = "";
  String txnID = "";
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoad = false;
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Scan Shopping Cart'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: () => scan(isLoad),//_fetchData(isLoad),
                    child: const Text('Start Camera Scan')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              )
              ,
            ],
          ),
        ));
  
  }

  Future scan(isLoad) async {
    try {
      /*//TODO: coba build dulu, scanBarcode jadi noID
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode
      //Navigator.pushNamed(context, '/listBarang');
      );
      */
      var dptCart = await _fetchData(isLoad/*TODO:,barcode*/);
      if(dptCart=="ok"){
        print("sudah dpt status yaitu: "+dptCart);
        print("dan txn ID: "+txnID);

        Navigator.pushNamed(context,ListBarang.routeName,arguments: Args.passTxnID(txnID));
      }else{
        var sc = SelfClient();
        var _newTxnID = await sc.recreateTrID(txnID);
        txnID = _newTxnID;
        Navigator.pushNamed(context,ListBarang.routeName,arguments: Args.passTxnID(txnID));
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  //noID diambil dari barcode
  _fetchData(isLoad,{noID:5}) async{
      setState(() {
        isLoad=true;
      });
      Map m;
      var sc = SelfClient();
      try{
        //var response = await sc.postAfterScan(noID);
        //m = json.decode(response.body) as Map;
        print("akan getTrID");
        m = await sc.getTrID(noID);
        setState(() {
          isLoad=false;
        });
        if (m["status"].toString()=="ok") {
          print(m["txnId"].toString() + "assf");
          //TODO: txnId masukin ke no.trx -> tinggal ditest
          txnID = m["txnId"].toString();
          return m["status"].toString();
        }
      }catch(e){
        print(e.toString());
        print("Gak berhasil dapet trx ID");
      }
      return "aye";
    }
}