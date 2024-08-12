import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';

class WatchedTab extends StatelessWidget {
  const WatchedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, 
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              vertical: 10, horizontal: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: homeColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(61, 0, 0, 0),
                      blurRadius: 3,
                      offset: Offset(0, 3))
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 11,left: 20),
              child: ListTile(
                leading: const Icon(Icons.slideshow,color: themeTextColor,size: 45,),
                title: Text(
                  'tutorial $index',
                  style: accountPagetextStyle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
