
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/models/admin_details.dart';
import 'package:learncode/screens/admin/admin_screens/admin_account_screen.dart';

class AdminAppbarWidget extends StatelessWidget implements PreferredSizeWidget {

  AdminAppbarWidget({super.key,});

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
            blurRadius: 10,
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10),
          child: Text(
            AdminAccountScreen.adminDetails?.adminName ?? 'Admin',
            style: TextStyle(color: whiteColor),
          ),
        ),
        leading: Align(
          alignment: const Alignment(5, 1),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AdminAccountScreen.adminDetails?.adminProfile != null
                ?kIsWeb?MemoryImage(base64Decode(AdminAccountScreen.adminDetails!.adminProfile!))
                : FileImage(File(AdminAccountScreen.adminDetails!.adminProfile!))
                : const AssetImage('asset/image/user.jpeg') as ImageProvider,
          ),
        ),
      ),
    );
  }
}
