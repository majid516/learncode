// import 'package:flutter/material.dart';
// import 'package:learncode/buttons/backbutton.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/screens/user/widgets/playlist_list.dart';

// class PlayListSample extends StatefulWidget {
//   static final palyListTitleController = TextEditingController();
//   static List<String> playlistList= [];
//   const PlayListSample({super.key});
  

//   @override
//   State<PlayListSample> createState() => _PlayListSampleState();
// }
// class _PlayListSampleState extends State<PlayListSample> {
  
//   @override
//   void dispose() {
//    PlayListSample.playlistList.add(PlayListSample.palyListTitleController.text);
//    print('\nplayList list is disposed\n');

//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(children: [
//           Stack(
//             children: [
//               Container(
//                 width: ScreenSize.widthMed,
//                 height: ScreenSize.widthMed * 0.65,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(
//                           'asset/image/5 Tips To Create Awesome Slideshows.jpeg'),
//                       fit: BoxFit.cover),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 35, left: 35),
//                 child: CustomBackButton(
//                   buttonColor: buttonPurple,
//                   iconColor: whiteColor,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: PlaylistTab(),
//           ),
//         ]),
//       ),
//     );
//   }
// }
