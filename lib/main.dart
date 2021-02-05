import 'package:flutter/material.dart';

import 'landingpage.dart';
import 'chooseplan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.yellow[800],
        // backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new LandingPage(),
        '/chooseplan': (BuildContext context) => new ChoosePlan(),
      },
      initialRoute: '/',
    );
  }
}
