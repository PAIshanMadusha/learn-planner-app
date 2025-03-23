import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/services/firestore_database/course_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstance.kPaddingValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Lottie.asset(
                      "assets/animations/Animation1.json",
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "Learn Planner",
                        style: AppTextStyle.kMainTitleStyle,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                Text(
                  "Your Learn Planner app helps you to keep track of education progress and manage your time efficiently.",
                  style: AppTextStyle.kNormalTextStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                Center(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      side: WidgetStatePropertyAll(
                        BorderSide(color: AppColors.kWhiteColor, width: 1),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.kYellowColor,
                      ),
                    ),
                    onPressed: () {
                      GoRouter.of(context).push("/add-new-course");
                    },
                    label: Text(
                      "Add a Course",
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        color: AppColors.kBlackColor,
                      ),
                    ),
                    icon: Icon(
                      Icons.add,
                      size: 28,
                      color: AppColors.kBlackColor,
                    ),
                  ),
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                Text(
                  "Your Courses",
                  style: AppTextStyle.kMainTitleStyle.copyWith(
                    fontSize: 26,
                    color: AppColors.kBlueColor,
                  ),
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                Text(
                  "Below appear your running courses right now, and by selecting a course, you can add notes and assignments related to the course.",
                  style: AppTextStyle.kBottemLabelStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                StreamBuilder(
                  stream: CourseService().courses,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kYellowColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: AppTextStyle.kBottemLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: AppConstance.kSizedBoxValue * 8),
                            SvgPicture.asset(
                              "assets/emptydatapic.svg",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: AppConstance.kSizedBoxValue),
                            SizedBox(
                              width: 280,
                              child: Text(
                                "No courses are available! You can add courses by clicking the add a course button.",
                                style: AppTextStyle.kLabelTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final courses = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: AppConstance.kPaddingValue,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppConstance.kRoundCornerValue,
                              ),
                              gradient: AppColors.kCourseCardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.kWhiteColor,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).push("/single-course", extra: course);
                              },
                              leading: Icon(
                                Icons.school,
                                size: 40,
                                color: AppColors.kYellowColor,
                              ),
                              title: Text(
                                course.name,
                                style: AppTextStyle.kNormalTextStyle.copyWith(
                                  color: AppColors.kBlackColor,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.duration,
                                    style: AppTextStyle.kBottemLabelStyle
                                        .copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    course.description,
                                    style: AppTextStyle.kLabelTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
