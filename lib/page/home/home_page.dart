import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/page/home/main_food_page.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    MainFoodPage(),
    Container(
      child: Center(child: Text("Next page")),
    ),
    Container(
      child: Center(child: Text("Next next page")),
    ),
    Container(
      child: Center(child: Text("Next next next page")),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: Dimensions.height70,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        color: AppColors.mainColor,
        animationDuration: Duration(milliseconds: 400),
        items: <Widget>[
          Icon(Icons.home_outlined, size: Dimensions.iconSize24),
          Icon(Icons.archive_outlined, size: Dimensions.iconSize24),
          Icon(Icons.shopping_cart, size: Dimensions.iconSize24),
          Icon(Icons.person, size: Dimensions.iconSize24),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
/* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: "history",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "me",
          ),
        ],
      ),
    );
  }
  */


