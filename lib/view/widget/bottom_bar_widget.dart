import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ghibloo_app/view/screen/bookmark/bookmark_screen.dart';
import 'package:ghibloo_app/view/screen/home/home_screen.dart';
import 'package:ghibloo_app/view/screen/ai_implement/ghiblian_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentTab = 0;
  final List<Widget> screens = const [
    HomeScreen(),
    BookmarkScreen(),
    GhiblianScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Color activeColor = Colors.black;
    Color inactiveColor = Colors.grey;

    TextStyle activeTextStyle = TextStyle(
      fontSize: 14,
      color: activeColor,
      fontWeight: FontWeight.bold,
    );

    TextStyle inactiveTextStyle = TextStyle(
      fontSize: 14,
      color: inactiveColor,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: kbackgroundColor,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 0;
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentTab == 0 ? Iconsax.home5 : Iconsax.home,
                    color: currentTab == 0 ? activeColor : inactiveColor,
                  ),
                  Text(
                    "Home",
                    style:
                        currentTab == 0 ? activeTextStyle : inactiveTextStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 1;
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentTab == 1 ? Iconsax.bookmark5 : Iconsax.bookmark,
                    color: currentTab == 1 ? activeColor : inactiveColor,
                  ),
                  Text(
                    "Bookmark",
                    style:
                        currentTab == 1 ? activeTextStyle : inactiveTextStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 2;
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentTab == 2 ? Iconsax.message5 : Iconsax.message,
                    color: currentTab == 2 ? activeColor : inactiveColor,
                  ),
                  Text(
                    "Ghiblian AI",
                    style:
                        currentTab == 2 ? activeTextStyle : inactiveTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
