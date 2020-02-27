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
      body:
      SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            SizedBox(height: 20),
            Text(
                "Terms and Conditions",
                style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 20),
            Divider(
                color: Colors.black,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body2,
                children: <TextSpan>[
                  TextSpan(text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Viverra tellus in hac habitasse platea dictumst vestibulum rhoncus. Cursus risus at ultrices mi tempus imperdiet nulla malesuada pellentesque. At in tellus integer feugiat scelerisque. Aenean sed adipiscing diam donec adipiscing tristique. Fermentum dui faucibus in ornare quam viverra. Et netus et malesuada fames ac turpis egestas integer eget. Amet venenatis urna cursus eget nunc. Mauris ultrices eros in cursus. Consequat nisl vel pretium lectus quam id. Metus aliquam eleifend mi in nulla posuere. Condimentum lacinia quis vel eros donec ac odio. Enim lobortis scelerisque fermentum dui faucibus. Orci eu lobortis elementum nibh tellus molestie nunc. Tempor orci eu lobortis elementum nibh tellus molestie nunc non. Odio facilisis mauris sit amet massa vitae tortor condimentum lacinia. Cursus risus at ultrices mi tempus imperdiet nulla malesuada. Et tortor at risus viverra. Sit amet aliquam id diam maecenas ultricies mi. Ultrices gravida dictum fusce ut placerat orci nulla.'),
                  TextSpan(text:'\nInformation Collection and Use\n',style: Theme.of(context).textTheme.subhead,),
                  TextSpan(text:'Nunc mi ipsum faucibus vitae aliquet nec. Enim nulla aliquet porttitor lacus. Viverra orci sagittis eu volutpat. Potenti nullam ac tortor vitae purus. Pulvinar etiam non quam lacus suspendisse faucibus. Aenean sed adipiscing diam donec adipiscing tristique. Urna molestie at elementum eu facilisis sed. Id consectetur purus ut faucibus pulvinar elementum. Convallis a cras semper auctor neque vitae tempus quam pellentesque. Nec ultrices dui sapien eget mi proin. Nibh mauris cursus mattis molestie a iaculis at erat. Fusce ut placerat orci nulla. Pharetra pharetra massa massa ultricies mi quis. Neque vitae tempus quam pellentesque nec nam aliquam. Eu lobortis elementum nibh tellus. Ultrices dui sapien eget mi. Amet luctus venenatis lectus magna fringilla urna porttitor rhoncus.'),
                  TextSpan(text: 'Tortor aliquam nulla facilisi cras fermentum odio. Donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Consectetur adipiscing elit ut aliquam purus. Sem integer vitae justo eget magna fermentum iaculis eu. Varius duis at consectetur lorem donec massa. Bibendum ut tristique et egestas. Egestas maecenas pharetra convallis posuere morbi. Tortor at risus viverra adipiscing at in tellus integer feugiat. Tempus urna et pharetra pharetra massa. Tellus id interdum velit laoreet. Aliquet lectus proin nibh nisl condimentum id venenatis. Dignissim enim sit amet venenatis urna cursus eget. Commodo viverra maecenas accumsan lacus vel facilisis volutpat. Pharetra vel turpis nunc eget lorem dolor sed. Ultrices vitae auctor eu augue.'),
                  TextSpan(text: 'Et ligula ullamcorper malesuada proin libero nunc consequat interdum. Tempus egestas sed sed risus. Convallis a cras semper auctor neque vitae tempus. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Neque volutpat ac tincidunt vitae semper quis lectus nulla at. Curabitur gravida arcu ac tortor dignissim convallis. Tortor vitae purus faucibus ornare. Elementum sagittis vitae et leo duis ut. Vitae justo eget magna fermentum. Dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu.'),
                  TextSpan(text: 'Laoreet sit amet cursus sit. Quis eleifend quam adipiscing vitae. Tortor id aliquet lectus proin nibh. Rhoncus aenean vel elit scelerisque mauris pellentesque. Rhoncus dolor purus non enim. Non quam lacus suspendisse faucibus interdum. Vel turpis nunc eget lorem dolor sed. Est ullamcorper eget nulla facilisi. Nisl condimentum id venenatis a. Varius quam quisque id diam vel. Imperdiet nulla malesuada pellentesque elit eget gravida cum sociis natoque. Semper quis lectus nulla at volutpat diam. Ultricies integer quis auctor elit sed vulputate mi sit.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}