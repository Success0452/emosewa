import 'package:emosewa/pages/cart/cart_history.dart';
import 'package:emosewa/pages/home/main_page.dart';
import 'package:emosewa/utlis/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  List pages = [
    const MainPage(),
    Container(child: Center(child: Text("Next Page")),),
    const CartHistory(),
    Container(child: Center(child: Text("Next next next Page")),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.redAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedPage,
        onTap: (int index){
          setState(() {
            _selectedPage= index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
            label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive),
            label: "archive",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
            label: "cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
