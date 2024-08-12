import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';

class AdminAppabarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AdminAppabarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: themePurple,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 10),
          child: Text(
            'admin',
            style: TextStyle(color: whiteColor),
          ),
        ),
        leading: const Align(
          alignment: Alignment(5, 1),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('asset/image/user.jpeg'),
          ),
        ),
      ),
    );
  }
}
