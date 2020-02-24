import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webapp_super/scan_keranjang.dart';

class Boarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:150),
              Image.asset('assets/images/logo.png',height: 100),
              SizedBox(height:20),
              Text(
                'smart shopping assistant',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.body2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100),
              RaisedButton(
                child: Text("Scan Keranjang"),
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