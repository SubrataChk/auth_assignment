import 'package:auth_assignment/src/global/global.dart';
import 'package:auth_assignment/src/view/auth/login.dart';
import 'package:auth_assignment/src/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: double.infinity, child: Lottie.asset("assets/home.json")),
          CustomButton(
              onTap: () async {
                await firebaseAuth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              title: "Log Out")
        ],
      )),
    );
  }
}
