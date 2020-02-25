import 'package:flutter/material.dart';
import 'package:webapp_super/list_barang.dart';
import 'package:webapp_super/scan_keranjang.dart';

class Boarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0,0.7,1],
          colors: [
            Colors.white,
            Colors.white,
            Colors.lime
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      body:Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:150),
              Image.asset('assets/images/logo.png',height: 100),
              SizedBox(height:20),
              Text(
                'smart shopping assistant',
                style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: 20,fontWeightDelta: 20),
                /*
                 GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.body2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,),
                */
              ),
              SizedBox(height: 100),
              RaisedButton(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.lime,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Scan Keranjang',
                    style: Theme.of(context).textTheme.subhead.apply(color: Colors.white,fontWeightDelta: 20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ScanKeranjang.routeName);
                },
              ),
              SizedBox(height: 180),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    Navigator.pushNamed(context, ListBarang.routeName);
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
    ),
    );
  }
}