import 'package:flutter/material.dart';
import 'package:webapp_super/privacy_policy.dart';
import 'package:webapp_super/scan_keranjang.dart';
import 'package:webapp_super/scanner.dart';
import 'package:webapp_super/terms_and_conditions.dart';

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
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor,
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
              Image.asset('assets/images/icon.png',height: 100),
              SizedBox(height:20),
              Text(
                'Smart Shopping Assistant',
                style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: 5,fontWeightDelta: 20),
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
                    'Start Shopping',
                    style: Theme.of(context).textTheme.subhead.apply(color: Colors.white,fontWeightDelta: 20),
                  ),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, Scanner.routeName);
                  Navigator.pushNamed(context, ScanKeranjang.routeName);
                },
              ),
              SizedBox(height: 180),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    Navigator.pushNamed(context, PrivacyPolicy.routeName);
                  },
                ),
              )
          ],
        )
      ),
    ),
    );
  }
}