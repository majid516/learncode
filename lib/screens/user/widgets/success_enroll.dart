import 'package:flutter/material.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:lottie/lottie.dart';

class SuccessEnroll extends StatefulWidget {
  const SuccessEnroll({super.key});
  @override
  State<SuccessEnroll> createState() => _SuccessEnrollState();
}

class _SuccessEnrollState extends State<SuccessEnroll> {
  @override
  void initState() {
    enrollSuccess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: SizedBox(
          width: ScreenSize.widthMed * 0.85,
          height: ScreenSize.heightMed * 0.5,
          child: Column(
            children: [
              Lottie.asset('asset/json/Animation - 1724510477167.json',
                  repeat: false, fit: BoxFit.fill),
              const Text('Selected course successfully added')
            ],
          ),
        ),
      )),
    );
  }

  Future<void> enrollSuccess() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
