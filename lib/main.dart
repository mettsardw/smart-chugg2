import 'package:flutter/material.dart';
import 'package:webapp_super/args.dart';
import 'package:webapp_super/boarding.dart';
import 'package:webapp_super/checkout.dart';
import 'package:webapp_super/extract_subtotal_args.dart';
import 'package:webapp_super/list_barang.dart';
import 'package:webapp_super/privacy_policy.dart';
import 'package:webapp_super/scan_keranjang.dart';
import 'package:webapp_super/terms_and_conditions.dart';
import 'package:webapp_super/thankyou.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings){
        if(settings.name==Checkout.routeName){
          final Args args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => Checkout(),
            settings: RouteSettings(
              arguments: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context){
              return Checkout();
            }
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) =>Boarding(),
        '/scanKeranjang':(context) => ScanKeranjang(),
        //Checkout.routeName:(context) =>Checkout(), //checkout page di OnGenerateRoute
        '/thankyou':(context) =>Thankyou(),
        TermsAndConditions.routeName:(context) => TermsAndConditions(),
        PrivacyPolicy.routeName:(context) => PrivacyPolicy(),
        ListBarang.routeName:(context) => ListBarang(),
      },
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
    );
  }
}