import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:learncode/buttons/delete_button.dart';
import 'package:learncode/buttons/update_button.dart';
import 'package:learncode/screens/user/widgets/sub_course_tile_widget.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:video_player/video_player.dart';

class AdminTutorialMainPageDetails extends StatefulWidget {
  final String video;
  final String tutorialTitle;
  final String discription;

  const AdminTutorialMainPageDetails({
    super.key,
    required this.video,
    required this.tutorialTitle,
    required this.discription,
  });

  @override
  State<AdminTutorialMainPageDetails> createState() =>
      _AdminTutorialMainPageDetailsState();
}

class _AdminTutorialMainPageDetailsState extends State<AdminTutorialMainPageDetails> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(widget.video)
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) {
          return null;
        }),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  
                  children: [
                    CustomBackButton(
                        buttonColor: buttonGrey,
                        iconColor: themeTextColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                       const SizedBox(
                        width: 120,
                       ),
                    const Text(
                      'Details',
                      style: tutorialPageTitletextStyle,
                    ),
                   
                  ],
                ),
              ),
             const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: ScreenSize.widthMed * 0.9,
                  height: ScreenSize.heightMed * 0.26,
                  child: FlickVideoPlayer(flickManager: flickManager),
                ),
              ),
             const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tutorialTitle,
                      style:
                         const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                   const SizedBox(height: 10),
                    Text(widget.discription,style: TextStyle(fontSize: 15),),
                  const  SizedBox(height: 30),
                    GridView.builder(
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 230,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: 5,
                      itemBuilder: (ctx, index) {
                        return SubTutorialTileWidget(
                          
                          index: index,
                        );
                      },
                    ),
                    SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UpdateButton(),
                      DeleteButton()
                    ],
                   )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
