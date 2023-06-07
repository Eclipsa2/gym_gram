import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/utils/utils.dart';
import 'package:gym_gram/widgets/AddPostScreen.dart';

import 'SearchScreen.dart';
import 'WorkoutScreen.dart';
import 'MyProfileScreen.dart';
import 'FeedScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/HomePage';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _page = 0;
  late PageController pageController;
  List<Widget> homeScreenItems = [
    FeedScreen(),
    SearchScreen(),
    AddPostScreen(),
    MyWorkoutsPage(),
    MyProfile(uid: FirebaseAuth.instance.currentUser!.uid),
    // const SearchScreen(),
    // const AddPostScreen(),
    // const Text('notifications'),
    // ProfileScreen(
    //   uid: FirebaseAuth.instance.currentUser!.uid,
    // ),
  ];

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: PageView(
          children: homeScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.transparent,
        height: 60,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 8),
              child: Icon(
                size: 40,
                Icons.home,
                color: (_page == 0) ? Colors.blue : Colors.grey,
              ),
            ),
            label: '',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 8),
              child: Icon(
                size: 40,
                Icons.search,
                color: (_page == 1) ? Colors.blue : Colors.grey,
              ),
            ),
            label: '',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 8),
              child: Icon(
                size: 40,
                Icons.add,
                color: (_page == 2) ? Colors.blue : Colors.grey,
              ),
            ),
            label: '',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 8),
              child: Icon(
                size: 40,
                Icons.list,
                color: (_page == 3) ? Colors.blue : Colors.grey,
              ),
            ),
            label: '',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 8),
              // alignment: Alignment.center,
              child: Icon(
                size: 40,
                Icons.person,
                color: (_page == 4) ? Colors.blue : Colors.grey,
              ),
            ),
            label: '',
            backgroundColor: Colors.grey,
          )
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
