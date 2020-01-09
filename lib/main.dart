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
        '/': (context) =>MyApp(),
        '/listBarang':(context) =>ListBarang(),
        '/scanKeranjang':(context) => ScanKeranjang(),
        '/checkout':(context) =>Checkout(),
        '/thankyou':(context) =>Thankyou()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/scanKeranjang');
          },
        ),
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
