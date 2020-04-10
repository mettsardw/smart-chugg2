import 'package:flutter/material.dart';

class Thankyou extends StatelessWidget {
  static const routeName = '/thankyou'; 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Thank you for shopping with us!',
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
                      'Back to Home',
                      style: Theme.of(context).textTheme.subhead.apply(color: Colors.white,fontWeightDelta: 20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
            ],
          )
        ),
      ),
      ),
    );
  }
}