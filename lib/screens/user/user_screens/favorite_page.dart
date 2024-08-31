import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/modules/admin_sub_tutorial_detail_pade.dart';
import 'package:learncode/screens/user/provider/favourite_provider.dart';

class FavoritePage extends StatefulWidget {
  
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    getAllEnrolledCourse();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = FavouriteProvider.of(context);
    final favoriteList = favoriteProvider.favouritePlaylist;
    getAllFavoritePlaylist();
    return SafeArea(
      child: Scaffold(
       
        backgroundColor: whiteColor,
        body: Column(
          children: [
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
                      'My Enrolled Course',
                      style: tutorialPageTitletextStyle,
                    ),
                    SizedBox(width: 30,)
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                 final playlistData = favoriteList[index];
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => AdminSubTutorialDetailPage(
                                   playlist: playlistData,
                                   playlistId: playlistData.playlistId,
                                    subVideo: playlistData.subCourseDetails!.subCourseVideo,
                                   subcourseId: playlistData.subCourseId,
                                    tutorialTitle: playlistData.playListTitle,
                                    subCourseindex: playlistData.subCourseId,
                                    playlistIndex: playlistData.playlistId,
                                    playListName: playlistData.playListTitle,
                                    isAdmin: false,
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 11, left: 10),
                          child: ListTile(
                            leading: const Icon(
                              Icons.slideshow,
                              color: themeTextColor,
                              size: 45,
                            ),
                            title: Text(
                              playlistData.playListTitle,
                              style: accountPagetextStyle,
                            ),
                            trailing: IconButton(onPressed: (){
                             favoriteList.removeAt(index);
                             setState(() {
                               
                             });
                            }, icon:const Icon(Icons.delete,color:  Color.fromARGB(255, 217, 28, 15),)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: favoriteList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
