import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/app/modules/home_page.dart';
import 'package:getx_intro/app/modules/login_screen/login_controller.dart';
import 'package:getx_intro/app/modules/login_screen/login_page.dart';


class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    controller.loadUser();
    
    Future.delayed(
      const Duration(seconds: 2),
      //go home page
      () {
        if (controller.user == "") {
          Get.off(LoginPage());
        }else{
          Get.off(HomePage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Splash Screen"
            ),
          ]),
    );
  }
}