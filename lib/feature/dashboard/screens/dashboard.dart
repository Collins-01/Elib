import 'package:elib/feature/courses/screens/search_course.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elib/feature/notice/screens/notice.dart';
import 'package:elib/feature/dashboard/screens/home.dart';
import 'package:elib/feature/settings/screens/settings.dart';
import 'package:elib/helpers/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  List<Widget> currentRender = [
    const Home(),
    const SearchCourse(),
    const Blog(),
    Settings(),
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    double displayWidth = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    Color fadeGrey = const Color(0xffC1C9C6);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFF8F8F8),
          currentIndex: _currentIndex,
          elevation: 5,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: textColor,
          unselectedLabelStyle: textStyle.copyWith(fontSize: 10.0),
          selectedLabelStyle: textStyle.copyWith(fontSize: 10.0),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  listOfIcons[0],
                  height: 21.77,
                  // color: _currentIndex == 1 ? primaryColor : fadeGrey,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  listOfIcons[1],
                  height: 21.77,
                  // color: _currentIndex == 1 ? primaryColor : fadeGrey,
                ),
                label: 'Courses'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  listOfIcons[2],
                  height: 21.77,
                  // color: _currentIndex == 1 ? primaryColor : fadeGrey,
                ),
                label: 'Notice'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  listOfIcons[3],
                  height: 21.77,
                  // color: _currentIndex == 1 ? primaryColor : fadeGrey,
                ),
                label: 'Settings'),
          ],
        ),
        body: Container(
          child: IndexedStack(
              index: _currentIndex, children: <Widget>[...currentRender]),
        )
        // )

        );
  }

  List listOfIcons = [
    "assets/dashboard/nav/1.png",
    "assets/dashboard/nav/2.png",
    "assets/dashboard/nav/4.png",
    "assets/dashboard/nav/5.png",
  ];
}
