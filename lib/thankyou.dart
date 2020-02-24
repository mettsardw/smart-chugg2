import 'package:flutter/material.dart';

class Thankyou extends StatelessWidget {
  static const routeName = '/thankyou';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            SizedBox(height: 50),
            Text(
                "Thank you!!!!!!!!!!!!!!!!!!!!!",
                style: Theme.of(context).textTheme.display4,
            ),
            SizedBox(height: 20),
            Divider(
                color: Colors.black,
            ),
          ],
        ),
      )
    );
    //jalanin function reset all value
  }
}