import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webapp_super/args.dart';
import 'package:webapp_super/list_barang.dart';
import 'package:webapp_super/self_client.dart';

class Scanner extends StatefulWidget {
  static const routeName = '/scanner';
  //static ScanState ss = new ScanState();
  @override
  ScanState createState() => new ScanState();
}

class ScanState extends State<Scanner> {
  String barcode = "";
  String txnID = "";
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoad = false;

    itfBuild(){
      return Scaffold(
        appBar: new AppBar(
          title: new Text('Scan Shopping Cart'),
        ),
        body: FutureBuilder<void>(
          future: scan(isLoad),
          builder: (context,barcode){
          if(!isLoad){
            //Navigator.pushNamed(context,ListBarang.routeName,arguments: Args.passTxnID(txnID));
          }else{
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 50.0,
                      width: 50.0,
                    ),
                  ],
                ),
              )
            );
          }},
        ),/*new Center(
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
        )*/
        );
    }
    
    return itfBuild();
    //return isLoad? CircularProgressIndicator(): itfBuild();
  }

  Future scan(isLoad) async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(
        () => this.barcode = barcode
      );
      var dptCart = await _fetchData(isLoad,noID:barcode);
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
      Navigator.of(context).pop(true);
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything.)');
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