import 'package:auth_assignment/src/app/color.dart';
import 'package:auth_assignment/src/service/auth.dart';
import 'package:auth_assignment/src/view/auth/signup.dart';
import 'package:auth_assignment/src/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

import '../../widget/button.dart';
import '../../widget/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user!.uid.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Log In",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
            ),
            CustomTextFormField(
                controller: email,
                hintText: "Email",
                isPass: false,
                textInputType: TextInputType.emailAddress,
                icons: CupertinoIcons.mail),
            CustomTextFormField(
                controller: password,
                hintText: "Password",
                isPass: true,
                textInputType: TextInputType.text,
                icons: Icons.vpn_key),
            CustomButton(
              title: "Log In",
              onTap: () async {
                await authService.signIn(
                    email: email.text, pass: password.text, context: context);
              },
            ),
            CustomButton(
                title: "Google Sign In",
                onTap: () async {
                  signInWithGoogle();
                }),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have a account?",
                  style: TextStyle(fontSize: 12.sp),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPageScreen()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.sp),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
