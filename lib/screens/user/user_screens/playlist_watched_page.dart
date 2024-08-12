import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/screens/user/widgets/playlist_list.dart';
import 'package:learncode/screens/user/widgets/user_watched_tutorials.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: ScreenSize.widthMed,
                  height: ScreenSize.widthMed * 0.65,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'asset/image/5 Tips To Create Awesome Slideshows.jpeg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 35),
                  child: CustomBackButton(
                    buttonColor: buttonPurple,
                    iconColor: whiteColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.transparent,
              child: TabBar(
                dividerHeight: 0,
                controller: _tabController,
                indicator: BoxDecoration(
                  color: themeTextColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                labelColor: whiteColor,
                labelStyle: const TextStyle(
                    color: blackColor, fontWeight: FontWeight.w600),
                unselectedLabelStyle: const TextStyle(
                    color: blackColor, fontWeight: FontWeight.w600),
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const Text('PlayList'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const Text('Watched'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const PlaylistTab(),
                  WatchedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
