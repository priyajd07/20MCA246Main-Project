import 'package:flutter/material.dart';
import 'package:netflix/home_page/home.dart';
import 'package:netflix/playlist/playlist.dart';
import 'package:netflix/recommend/recomend.dart';

import '../youtubevideos/youtube_videos.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String _currentPage = 'Home';

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Home': MyHomePage(),
      'search': Recommended(),
      'Earn Money':YoutubeVideos(),
      'Tutorial': PlayList(),
      // 'course': CoursePage(),
      // 'plan1': MyHomePage(),

    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.black,
        child: BottomNavigationBar(

          unselectedFontSize: 8,
          selectedFontSize: 12,
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,

              ),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.videogame_asset_outlined),
            //
            //   label: 'Games',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_play_outlined,

              ),
              label: 'Recommend',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.play_arrow_sharp,

              ),

              label: 'YouTube',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.school,
            //     size: 20,
            //   ),
            //
            //   label: 'Course',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,

              ),

              label: 'Play List',
            ),
          ],
          backgroundColor:Colors.white.withOpacity(0.05),
          elevation: 0,
          currentIndex: tabs.keys.toList().indexOf(_currentPage),
          selectedItemColor:Colors.white,
          unselectedItemColor:Colors.grey.shade600,
          onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
