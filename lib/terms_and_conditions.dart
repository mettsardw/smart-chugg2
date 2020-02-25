import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  static const routeName = '/tNC';
  //kasih listener untuk ganti screen setelah OTP diterima
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Text(
                "Terms and Conditions",
            ),
            SizedBox(height: 20),
            Divider(
                color: Colors.black,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text:'YMM built the Smart Shopping Assistant app as a Free app. This SERVICE is provided by YMM at no cost and is intended for use as is. This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Smart Shopping Assistant unless otherwise defined in this Privacy Policy.'),
                  TextSpan(text:'Information Collection and Use',style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text:'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Device ID, Camera Access. The information that I request will be retained on your device and is not collected by me in any way. The app does use third party services that may collect information used to identify you. Link to privacy policy of third party service providers used by the app.'),
                ],
              ),
            ),
          ],
        ),
    );
  }
}