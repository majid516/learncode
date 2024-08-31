import 'package:flutter/material.dart';
import 'package:learncode/buttons/continue_btn.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/admin/admin_screens/admin_main_screen.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final adminName = 'majid';
  final adminPassword = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: ScreenSize.widthMed,
            height: ScreenSize.heightMed,
            decoration: const BoxDecoration(
              gradient: themePurple,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Login admin account',
                        style: TextStyle(color: whiteColor, fontSize: 22),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: ScreenSize.widthMed * 0.8,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0x00D9D9D9).withOpacity(0.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _nameController,
                          cursorColor: whiteColor,
                          style: const TextStyle(color: whiteColor),
                          decoration: InputDecoration(
                            errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            border: InputBorder.none,
                            hintText: 'Enter name',
                            hintStyle:
                                TextStyle(color: whiteColor.withOpacity(0.6)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: ScreenSize.widthMed * 0.8,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0x00D9D9D9).withOpacity(0.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          cursorColor: whiteColor,
                          style: const TextStyle(color: whiteColor),
                          decoration: InputDecoration(
                            errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            border: InputBorder.none,
                            hintText: 'Enter Password',
                            hintStyle:
                                TextStyle(color: whiteColor.withOpacity(0.6)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ContinueButton(
                  title: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      adminLogin(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void adminLogin(BuildContext context) {
    final name = _nameController.text.trim();
    final password = _passwordController.text.trim();
    if (name == adminName && password == adminPassword) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) =>const AdminMainScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'name and password doesn`t match ',
          style: TextStyle(color: whiteColor),
        ),
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 219, 35, 22),
      ));
    }
  }
}
