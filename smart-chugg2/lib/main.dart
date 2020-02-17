import 'package:flutter/material.dart';
import 'package:webapp_super/checkout.dart';
import 'package:webapp_super/list_barang.dart';
import 'package:webapp_super/scan_keranjang.dart';
import 'package:webapp_super/thankyou.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) =>MyHomePage(),
        '/listBarang':(context) =>ListBarang(),
        '/scanKeranjang':(context) => ScanKeranjang(),
        '/checkout':(context) =>Checkout(),
        '/thankyou':(context) =>Thankyou()
      },
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 100.0),
                child: Text("Yuk Belanja!"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/scanKeranjang');
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Scan Keranjang"),
                )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                child: Text("Terms & Conditions"),
              )
          ],
        )
        /*
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
        */
      ),
    );
  }
}
