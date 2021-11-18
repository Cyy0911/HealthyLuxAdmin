import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/alert_dialog.dart';
import 'package:healthy_lux_admin/Components/login_animation.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String code = "Admintesting123";
  TextEditingController myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  adminLogin() {
    if (myController.text == code) {
      myController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      BuildAlertDialog().buildOKAlertDialog(
          context, "Error", "Invalid code, please re-enter again.", "OK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.whiteColor, body: loginBody());
  }

  Widget loginBody() {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF005AA7), Color(0xFFFdfdfd)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child:
                        // LoginFadeAnimation(
                        //     1.6,
                        Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text("Admin Login",
                                  style:
                                      AppTheme.defaultTextStyle40White(true)),
                              // ),
                            )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  // LoginFadeAnimation(
                  //     1.8,
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF005AA7), Color(0xFF667db6)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: myController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Admin Code",
                                hintStyle:
                                    AppTheme.defaultTextStyle16White(false)),
                          ),
                        )
                      ],
                    ),
                    // )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // LoginFadeAnimation(
                  //   2,
                  // ignore: deprecated_member_use
                  RaisedButton(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      onPressed: adminLogin,
                      child: Text(
                        'Login',
                        style: AppTheme.defaultTextStyle20White(true),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: const Color(0xff006083)),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
