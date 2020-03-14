import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp_super/args.dart';
import 'package:webapp_super/self_client.dart';
import 'package:webapp_super/thankyou.dart';

class Checkout extends StatefulWidget {
  static const routeName = '/checkout'; 
  @override
  _CheckoutState createState() => new _CheckoutState();
}

class _CheckoutState extends State<Checkout>{
  var _otp = '';
  //kasih listener untuk ganti screen setelah OTP diterima
  @override
  Widget build(BuildContext context) {
    final Args args = ModalRoute.of(context).settings.arguments;
    var isLoad = true;
    void _alertThankYouPopup(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Purchase Finished"),
            content: new Text("Payment has been done, thank you for visiting! We hope it was an enjoyable shopping experience."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("CLOSE"),
                onPressed: () {
                  Navigator.pushNamed(context,Thankyou.routeName);
                },
              ),
            ],
          );
        },
      );
    }

    _getOTPfromTxn({txnID: 11}) async{
      SelfClient sc = SelfClient();
      String otp;
      try{
        var m = await sc.getOTP(txnID);
        otp = m["OTP"];
        print("INI OTPNYA: " + otp);
        _otp = otp;
      }catch(e){
          print(e.toString());
          print("Gak berhasil dapet trx ID");
      }
      
      return otp;
    }

    _trueBuild(){
      return Scaffold(
      appBar: AppBar(
        title: Text("Checkout")
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            SizedBox(height: 40),
            Text(
              "Thenk you for your purchase!",
              style: Theme.of(context).textTheme.subhead,
            ),
            Text(
              "Your subtotal is:",
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 20),
            Text(
                args.subtotal.toString(),
                style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 30),
            Divider(
                color: Colors.black,
            ),
            SizedBox(height: 50),
            Text(
              "Show this OTP code to the cashier:",
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 40),
            Text(
              _otp,//"1917", //masukin otp disini
              style: Theme.of(context).textTheme.display3.apply(fontWeightDelta: 10),
            ),
            //hack button
            SizedBox(height: 100),
            FlatButton(
              onPressed: _alertThankYouPopup,
              child: Text(
                  "Proceed to THANKYOU",
                  style: Theme.of(context).textTheme.overline,
                ),
            ),
          ],
        ),
      )
      );
    }

    return FutureBuilder(
      future: _getOTPfromTxn(txnID: args.txnID),
      builder: (context,_otp){
        if(_otp.hasData){
          return _trueBuild();
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    /*
    if (isLoad) {
      _getOTPfromTxn(txnID: args.txnID);
      return CircularProgressIndicator();
    }
    else{
      return Scaffold(
      appBar: AppBar(
        title: Text("Checkout")
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            SizedBox(height: 40),
            Text(
              "Thenk you for your purchase!",
              style: Theme.of(context).textTheme.subhead,
            ),
            Text(
              "Your subtotal is:",
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 20),
            Text(
                args.subtotal.toString(),
                style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 30),
            Divider(
                color: Colors.black,
            ),
            SizedBox(height: 50),
            Text(
              "Show this OTP code to the cashier:",
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 40),
            Text(
              _otp,//"1917", //masukin otp disini
              style: Theme.of(context).textTheme.display3.apply(fontWeightDelta: 10),
            ),
            //hack button
            SizedBox(height: 100),
            FlatButton(
              onPressed: _alertThankYouPopup,
              child: Text(
                  "Proceed to THANKYOU",
                  style: Theme.of(context).textTheme.overline,
                ),
            ),
          ],
        ),
      )
    );
    
    }*/
  }
}