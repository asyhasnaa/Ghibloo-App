import 'package:flutter/material.dart';
import 'package:ghibloo_app/screens/bookmark_screen.dart';
import 'package:ghibloo_app/screens/home_screen.dart';
import 'package:ghibloo_app/screens/search_screen.dart';
import 'package:ghibloo_app/screens/setting_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.bookmark),
                text: "Bookmark",
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: "Setting",
              ),
            ],
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Color(0xff999999),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            BookmarkScreen(),
            SettingScreen(),
          ],
        ),
      ),
    );
  }
}
