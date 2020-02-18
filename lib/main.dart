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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Image.asset('assets/images/logo.png',height: 100),
              ),
              SizedBox(height:20),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Text('smart shopping assistant'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/scanKeranjang');
                },
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Scan Keranjang"),
                )
              ),
              SizedBox(height: 200),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    Navigator.pushNamed(context, '/listBarang');
                  },
                ),
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
