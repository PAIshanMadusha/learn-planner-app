import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_planner/pages/main_pages/assignments_page.dart';
import 'package:learn_planner/pages/main_pages/courses_page.dart';
import 'package:learn_planner/pages/main_pages/home_page.dart';
import 'package:learn_planner/pages/main_pages/learner_profile_page.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2;

  static const List<Widget> _pages = [
    HomePage(),
    CoursesPage(),
    AssignmentsPage(),
    LearnerProfilePage(),
  ];

  void _onTapPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapPage,
        currentIndex: _selectedIndex,
        unselectedItemColor: AppColors.kYellowColor,
        selectedItemColor: AppColors.kBlueGrey,
        selectedLabelStyle: AppTextStyle.kBottemLabelStyle,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/house.svg",
              width: 25,
              height: 25,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0
                    ? AppColors.kBlueGrey
                    : AppColors.kYellowColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/graduationcap.svg",
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1
                    ? AppColors.kBlueGrey
                    : AppColors.kYellowColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Courses",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/notebookpen.svg",
              width: 25,
              height: 25,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2
                    ? AppColors.kBlueGrey
                    : AppColors.kYellowColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Assignment",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/userprofile.svg",
              width: 25,
              height: 25,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3
                    ? AppColors.kBlueGrey
                    : AppColors.kYellowColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }
}
