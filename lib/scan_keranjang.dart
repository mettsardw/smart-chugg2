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
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class ScanKeranjang extends StatefulWidget {
  static const routeName = '/scanKeranjang';
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanKeranjang> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoad = false;
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Scan Keranjang Belanja'),
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
                    onPressed: () => _fetchData(isLoad),
                    child: const Text('START CAMERA SCAN')
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
      String barcode = await BarcodeScanner.scan();
      _fetchData(isLoad);
      setState(() => this.barcode = barcode
      //Navigator.pushNamed(context, '/listBarang');
      );
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

  _fetchData(isLoad) async{
      setState(() {
        isLoad=true;
      });
      var response;
      var url ="http://192.168.43.10:6969/getTransactionID";
      Map<String,String> headers = {'Content-type':'application/json'};
      String body='{"cartId":"1"}';
      try{
        response = await http.post(url,headers: headers, body:body);
        if (response.statusCode==200) {
          Map s = json.decode(response.body) as Map;
          setState(() {
            isLoad=false;
          });
          final logger = Logger();
          for (var i = 0; i < s.length; i++) {
            logger.i(s.keys.elementAt(i).toString()+":"+s.values.elementAt(i).toString());
          }
        }else{
          throw Exception('failed to show HAHAHAHAHA');
        }
      }on Exception{
        print(Exception().toString());
      }
      
    }
}