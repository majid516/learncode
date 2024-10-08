import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AccountCard extends StatelessWidget {
  final String titleText;
  final Icon icon;
  final VoidCallback onPressed;
  const AccountCard(
      {super.key,
      required this.titleText,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: LayoutBuilder(builder: (context, constraints) {
        bool isMobile = constraints.minWidth < 600;

        double containerSize = isMobile ? ScreenSize.widthMed *0.12: ScreenSize.widthMed*0.25;
     
        return SizedBox(
          width: containerSize,
          height: containerSize,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 20,
                    child: icon,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(titleText)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
