import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/user_details_db.dart';
import 'package:lottie/lottie.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    goGetstarted(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: ScreenSize.widthMed,
      height: ScreenSize.heightMed,
      child: Lottie.asset('asset/json/Flow 1.json',
          repeat: false, fit: BoxFit.fill),
    ));
  }

  Future<void> goGetstarted(BuildContext ctx) async {
    await Future.delayed(const Duration(seconds: 2));
    checkUserDetails(ctx);
  }
}


