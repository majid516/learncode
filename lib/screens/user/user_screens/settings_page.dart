import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/user/user_screens/about_screen.dart';
import 'package:learncode/screens/user/user_screens/contact_us_page.dart';
import 'package:learncode/screens/user/user_screens/privacy_policy_screen.dart';
import 'package:learncode/screens/user/user_screens/report_page.dart';
import 'package:learncode/screens/user/user_screens/term_and_condition.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;

            double containerHieght = isMobile ? constraints.maxHeight * 0.3 : constraints.maxWidth * 0.3;

        return Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: ScreenSize.widthMed,
                    height: containerHieght,
                    decoration: BoxDecoration(
                      gradient: themePurple
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBackButton(
                            iconColor: themeTextColor,
                            buttonColor: buttonGrey,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        const Text(
                          'settings',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: whiteColor),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(
                      top: containerHieght*0.6,
                      left: ScreenSize.widthMed * 0.1,
                      right: ScreenSize.widthMed * 0.1,
                    ),
                    child: Container(
                      width: ScreenSize.widthMed * 0.8,
                      height: isMobile?containerHieght*1.7:containerHieght,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 10,
                              color: Color.fromARGB(255, 125, 125, 125))
                        ],
                      ),
                      child: Column(
                        children: [
                           SizedBox(
                          height: ScreenSize.widthMed * 0.03,
                        ),
                          Expanded(child: SettingsLists()),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
          }
        ),
      ),
    );
  }
}

var settingsListsTitles = [
  'Privacy Policy',
  'Terms and Contitions',
  "Report an Issue",
  'Contact Us',
  'About',
];
var settingsListsIcons =[
  Icons.policy_outlined,
    Icons.document_scanner_outlined,
  Icons.report_gmailerrorred,
  Icons.contact_support,
  Icons.info_outline,
];

final List<void Function(BuildContext)> navigationFunctions = [
    (context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
    ),
    (context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
    ),
    (context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportScreen()),
    ),
    (context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactUsPage()),
    ),
    (context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutScreen()),
    ),
  ];
class SettingsLists extends StatelessWidget {
  const SettingsLists({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => ListTile(
        onTap: () {
          navigationFunctions[index](ctx);
          print('object');
        },
        leading: Icon(settingsListsIcons[index]),
        title: Text(settingsListsTitles[index]),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
      itemCount: 5,
    );
  }
}
