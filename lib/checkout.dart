import 'dart:async';

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
  var dur = Duration(seconds:7);
  bool mauBalik = false;
  Timer _timer;
  var _otp = '';
  var subt='';
  var _gotPymt = false;
  @override
  Widget build(BuildContext context) {
    final Args args = ModalRoute.of(context).settings.arguments;
    
    void _alertThankYouPopup(gotPy){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: gotPy? new Text("Purchase Finished"):new Text("Purchase Cancelled"),
            content: gotPy? new Text("Payment has been done, thank you for visiting! We hope it was an enjoyable shopping experience."):new Text("Payment has been cancelled, thank you for visiting! We are sorry for any inconvenience caused."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.pushNamed(context,Thankyou.routeName);
                },
              ),
            ],
          );
        },
      );
    }

    checkStatus(context,{txnID:11}) async{
      SelfClient sc = new SelfClient();
      var m = await sc.getTxStatus(txnID);
      subt= m['subtotal'].toString();
      if (m["status"]=="closed") {
        _gotPymt=true;
        setState(() {
          _gotPymt=true;
          _timer.cancel();
          _alertThankYouPopup(_gotPymt);
        });
      }else if (m["status"]=="cancel"){
        _timer.cancel();
        _alertThankYouPopup(_gotPymt);
      }
    }
    _getOTPfromTxn({txnID: 11}) async{
      if(mauBalik){
        return '';
      }else{
        print("GETOTPNYA MAU BALIK: "+mauBalik.toString());
        SelfClient sc = SelfClient();
        String otp;
        try{
          var m = await sc.getOTP(txnID);
          otp = m["OTP"];
          print("INI OTPNYA: " + otp);
          _otp = otp;
        }catch(e){
            print(e.toString());
            print("Gak berhasil dapet OTPnya");
        }
        
        return otp;
      }
    }

    _cancelCheckout({txnID: 7}) async{
      mauBalik=true;
      print(mauBalik);
      SelfClient sc = SelfClient();
      try{
        var m = await sc.cancelCheckout(txnID);
        if(m['status']=='ok'){
          _timer.cancel();
          Navigator.of(context).pop(true);
          print("uda ke cancel tuh checkoutnya");
        }
      }catch(e){
          print(e.toString());
      }
    }

    _trueBuild(){
      print("Pas masuk trueBuild "+mauBalik.toString());
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
              "Thank you for shopping with us!",
              style: Theme.of(context).textTheme.subhead,
            ),
            Text(
              "Your subtotal is:",
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 20),
            Text(
                'Rp. ' +(subt==''? args.subtotal.toString():subt.toString()),
                style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: 5,fontWeightDelta: 20),
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
            SizedBox(height: 40),
            Text(
              "Please wait while the cashier",
              style: Theme.of(context).textTheme.subhead,
            ),
            Text(
              "helps with the checkout.",
              style: Theme.of(context).textTheme.subhead,
            ),
            /*
            //hack button
            SizedBox(height: 100),
            
            FlatButton(
              onPressed: _alertThankYouPopup,
              child: Text(
                  "Proceed to THANKYOU",
                  style: Theme.of(context).textTheme.overline,
                ),
            ),*/
          ],
        ),
      )
      );
    }

    

    return WillPopScope(
      onWillPop: () => _cancelCheckout(txnID: args.txnID),
      child:FutureBuilder(
        future: _getOTPfromTxn(txnID: args.txnID),
        builder: (context,_otp){
          if(_otp.hasData){
            return _trueBuild();
          }else{
            if (_timer==null || !_timer.isActive) {
              _timer = new Timer.periodic(dur, (Timer t)=> checkStatus(context,txnID:args.txnID));
            }
            mauBalik=false;
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 50.0,
                      width: 50.0,
                    ),
                  ],
                ),
              )
            );
            /*
            return Center(child: Container(
                width: double.infinity,
                height: double.infinity,
                //margin: const EdgeInsets.all(10.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            );
            */
          }
        },
      )
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