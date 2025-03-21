import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_planner/pages/main_pages/assignments_page.dart';
import 'package:learn_planner/pages/main_pages/courses_page.dart';
import 'package:learn_planner/pages/main_pages/home_page.dart';
import 'package:learn_planner/pages/main_pages/learner_profile_page.dart';
import 'package:learn_planner/pages/main_pages/notes_page.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    CoursesPage(),
    AssignmentsPage(),
    NotesPage(),
    LearnerProfilePage(),
  ];

  void _onTapPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context); 

    return Scaffold(
    bottomNavigationBar: BottomNavigationBar(
      onTap: _onTapPage,
      currentIndex: _selectedIndex,
      unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor ?? AppColors.kBlueColor,
      selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor ?? AppColors.kBlueGrey,
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
                  ? theme.bottomNavigationBarTheme.selectedItemColor ?? AppColors.kBlueGrey
                  : theme.bottomNavigationBarTheme.unselectedItemColor ?? AppColors.kBlueColor,
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
                  ? theme.bottomNavigationBarTheme.selectedItemColor ?? AppColors.kBlueGrey
                  : theme.bottomNavigationBarTheme.unselectedItemColor ?? AppColors.kBlueColor,
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
                  ? theme.bottomNavigationBarTheme.selectedItemColor ?? AppColors.kBlueGrey
                  : theme.bottomNavigationBarTheme.unselectedItemColor ?? AppColors.kBlueColor,
              BlendMode.srcIn,
            ),
          ),
          label: "Assignment",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/noteicon.svg",
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(
              _selectedIndex == 3
                  ? theme.bottomNavigationBarTheme.selectedItemColor ?? AppColors.kBlueGrey
                  : theme.bottomNavigationBarTheme.unselectedItemColor ?? AppColors.kBlueColor,
              BlendMode.srcIn,
            ),
          ),
          label: "Notes",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/userprofile.svg",
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(
              _selectedIndex == 4
                  ? theme.bottomNavigationBarTheme.selectedItemColor ?? AppColors.kBlueGrey
                  : theme.bottomNavigationBarTheme.unselectedItemColor ?? AppColors.kBlueColor,
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
