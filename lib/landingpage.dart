import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _initializeTimer() {
    Timer(const Duration(seconds: 5),
    () => Navigator.pushReplacementNamed(context, "/chooseplan"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            'assets/imgs/metrohyp_logo.png',
            width: 150,
          ),
        )
      ),
    );
  }
}
