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
  //static ScanState ss = new ScanState();
  @override
  ScanState createState() => new ScanState();
}

class ScanState extends State<ScanKeranjang> {
  String barcode = "";
  String txnID = "";
  var isOKIntr = false;
  var isLoad = false;
  @override
  initState() {
    super.initState();
    void _intro(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Scan QR code"),
            content: new Text("Please aim your camera to the QR Code on your cart."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  //isOKIntr=true;
                  Navigator.of(context).pop();
                  scan(true);
                  setState(() {
                    isLoad=true;
                  });
                },
              ),
            ],
          );
        },
      );
    }
    paint() {
      return new Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          new Positioned.fill(
            child: new Opacity(
              opacity: 0.3,
              child: Text("Please align to QR Code on your cart."),
            ),
          ),
        ],
      );
    }

    Future.delayed(Duration.zero, () async {
      _intro();
      /*
      if(isOKIntr){
        scan(true);
        setState(() {
          isLoad=true;
        });
      }*/
    });
  }
  @override
  Widget build(BuildContext context) {

    itfBuild(){
      return Scaffold(
        appBar: new AppBar(
          title: new Text('Scan Shopping Cart'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /*
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
              ),*/    
              ],
          ),
        ));
    }

    circleProgress(){
      return Scaffold(
        appBar: new AppBar(
          title: new Text('Scan Shopping Cart'),
        ),body:Container(
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
            )
      );
    }
    
    return isLoad?circleProgress():itfBuild();
  }

  Future scan(isLoad) async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(
        () => this.barcode = barcode
      );
      var dptCart = await _fetchData(isLoad,noID:barcode);
      if(dptCart=="ok"){//jika get trx ID dah existing,
        print("sudah dpt status yaitu: "+dptCart);
        print("dan txn ID: "+txnID);

        Navigator.pushNamed(context,ListBarang.routeName,arguments: Args.passTxnID(txnID));
      }else{//jk belom existing,
        var sc = SelfClient();
        print("lagi recreate si cart: "+barcode);
        var _m = await sc.recreateTrID(barcode);
        setState(() {
          isLoad=false;
        });
        txnID = _m["txnId"];
        print("dapet new txn: "+txnID);
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