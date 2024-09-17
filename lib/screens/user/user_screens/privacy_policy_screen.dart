import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/screens/user/user_screens/contact_us_page.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
       backgroundColor: whiteColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                     Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24),
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
                    'Privacy Policy',
                    style: tutorialPageTitletextStyle,
                  ),
                   const SizedBox(
                    width: 80,
                  ),
                ],
              ),
            ),
            
            
              const SizedBox(height: 30),
              const Text(
                'Effective Date: September 8, 2024\n'
                'Welcome to Learn Code! We take your privacy seriously and are committed to safeguarding your personal information. This Privacy Policy explains how we collect, use, and protect the data we collect when you use our e-learning platform.\n',
                style:mediumSizedText,
              ),
              const Text(
                '1. Information We Collect\n',
                style: blackTextStyle,
              ),
              const Text(
                'We collect the following types of information when you use Learn Code:\n'
                '- **Personal Information**: Name, and profile picture when you create an account.\n'
                '- **Usage Data**: Information about how you interact with the app, such as enrolled courses, playlists, and progress tracking.\n',
                style:mediumSizedText,
              ),
              const Text(
                '2. How We Use Your Information\n',
                style: blackTextStyle,
              ),
              const Text(
                'We use the information we collect to:\n'
                '- Provide, maintain, and improve the app experience.\n'
                '- Track your course progress and personalize recommendations.\n'
                '- Communicate with you about updates, new features, or offers.\n',
                style:mediumSizedText,
              ),
              const Text(
                '3. Data Storage and Security\n',
                style: blackTextStyle,
              ),
              const Text(
                'We store your data securely in local databases like Hive and take reasonable precautions to protect it. However, no method of data transmission or storage is 100% secure, and we cannot guarantee absolute protection.\n',
                style:mediumSizedText,
              ),
              const Text(
                '4. Sharing of Information\n',
                style: blackTextStyle,
              ),
              const Text(
                'We do not share your personal information with third parties except to comply with the law, enforce our policies, or protect our rights.\n',
                style:mediumSizedText,
              ),
              const Text(
                '5. Your Rights\n',
                style: blackTextStyle,
              ),
              const Text(
                'You have the right to:\n'
                '- Access, update, or delete your personal information within the app settings.\n'
                '- Contact us to request more details about your data and how it is used.\n',
                style:mediumSizedText,
              ),
              const Text(
                '6. Cookies and Tracking\n',
                style: blackTextStyle,
              ),
              const Text(
                'We do not use cookies or tracking technologies in the app at this time.\n',
                style:mediumSizedText,
              ),
              const Text(
                '7. Changes to This Privacy Policy\n',
                style: blackTextStyle,
              ),
              const Text(
                'We may update this Privacy Policy from time to time. We will notify you of any changes by updating the "Effective Date" at the top of this page. Please check this page periodically for updates.\n',
                style:mediumSizedText,
              ),
              const Text(
                '8. Contact Us\n',
                style: blackTextStyle,
              ),
              const Text(
                'If you have any questions or concerns about this Privacy Policy, please contact us at the email below:\n',
                style:mediumSizedText,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const ContactUsPage()));
                  },
                  icon: const Icon(Icons.email,color: themeTextColor,),
                  label: const Text('Contact Us'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
