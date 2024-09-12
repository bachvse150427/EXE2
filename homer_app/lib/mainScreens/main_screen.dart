import 'package:flutter/material.dart';

import 'package:homer_app/tabPages/earning_tab.dart';
import 'package:homer_app/tabPages/home_tab.dart';
import 'package:homer_app/tabPages/profile_tab.dart';
import 'package:homer_app/tabPages/ratings_page.dart';

class MainScreen extends StatefulWidget{

  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen>with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index){
                            setState(() {
                                          selectedIndex = index;
                                          tabController!.index = selectedIndex;
                            });
  }

  @override
  void initState(){
                    // ToDO: implement initState
                    super.initState();
                    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: const[
                                    HomeTabPage(),
                                    EarningsTabPage(),
                                    RatingTabPage(),
                                    ProfileTabPage(),

                        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
                                                    items: const[
                                                              BottomNavigationBarItem(
                                                                                        icon: Icon(Icons.home),
                                                                                        label: 'Home',),
                                                              BottomNavigationBarItem(
                                                                                        icon: Icon(Icons.credit_card),
                                                                                        label: 'Thu Nhập',),
                                                              BottomNavigationBarItem(
                                                                                        icon: Icon(Icons.star),
                                                                                        label: 'Đánh Giá',),
                                                              BottomNavigationBarItem(
                                                                                        icon: Icon(Icons.person),
                                                                                        label: 'Tài Khoản',),

                                                                  ],
                                                      unselectedItemColor: Colors.white54,
                                                      selectedItemColor: Colors.black,
                                                      backgroundColor: Colors.blue,
                                                      type: BottomNavigationBarType.fixed,
                                                      selectedLabelStyle: const TextStyle(fontSize: 15),
                                                      showUnselectedLabels: true,
                                                      currentIndex: selectedIndex,
                                                      onTap: onItemClicked,
                                                  ),
              );

  }
}