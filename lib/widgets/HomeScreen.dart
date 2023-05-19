import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WorkoutScreen.dart';
import 'ProfileScreen.dart';
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
    MyWorkoutsPage(),
    Profile(uid: FirebaseAuth.instance.currentUser!.uid),
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
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? Colors.blue : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: (_page == 1) ? Colors.blue : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 2) ? Colors.blue : Colors.grey,
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
