import 'dart:io';
import 'dart:typed_data';

import 'package:auth_assignment/src/app/color.dart';
import 'package:auth_assignment/src/service/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:sizer/sizer.dart';

import '../../widget/button.dart';
import '../../widget/text_field.dart';

class SignupPageScreen extends StatefulWidget {
  const SignupPageScreen({Key? key}) : super(key: key);

  @override
  State<SignupPageScreen> createState() => _SignupPageScreenState();
}

class _SignupPageScreenState extends State<SignupPageScreen> {
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ModalProgressHUD(
        inAsyncCall: isLoading,
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
              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Create New Account",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
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
                  title: "Create",
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    authService.signUp(
                        email: email.text,
                        pass: password.text,
                        context: context);

                    setState(() {
                      isLoading = false;
                    });
                  }),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have a account?",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "log In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
