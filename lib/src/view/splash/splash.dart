import 'dart:async';

import 'package:auth_assignment/src/global/global.dart';
import 'package:auth_assignment/src/view/auth/login.dart';
import 'package:auth_assignment/src/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  setTimer() {
    Timer(Duration(seconds: 3), () {
      if (firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "welcome",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
