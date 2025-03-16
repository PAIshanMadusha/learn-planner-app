import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:learn_planner/models/notification_model.dart';
import 'package:learn_planner/services/firestore_database/notification_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Future<List<NotificationModel>> _fetchAllNotifications() async {
    return NotificationService().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 35,
            color: AppColors.kYellowColor,
          ),
        ),
        title: Text(
          "Your Overdue Assignments",
          style: AppTextStyle.kMainTitleStyle.copyWith(
            fontSize: 28,
            color: AppColors.kYellowColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstance.kPaddingValue),
        child: FutureBuilder(
          future: _fetchAllNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kYellowColor),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
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
                        "No Overdue Assignments are Available!",
                        style: AppTextStyle.kLabelTextStyle.copyWith(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Container(
                  margin: EdgeInsets.only(bottom: AppConstance.kPaddingValue),
                  padding: EdgeInsets.all(AppConstance.kPaddingValue),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppConstance.kRoundCornerValue,
                    ),
                    // ignore: deprecated_member_use
                    color: AppColors.kBlueGrey.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: AppColors.kBlackColor.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          "assets/overdue.svg",
                          width: 240,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Center(
                        child: Text(
                          notification.courseName.toUpperCase(),
                          style: AppTextStyle.kNormalTextStyle.copyWith(
                            fontSize: 21,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Text(
                        "Assignment Name:",
                        style: AppTextStyle.kBottemLabelStyle.copyWith(
                          color: AppColors.kYellowColor,
                        ),
                      ),
                      Text(
                        notification.assignmentName,
                        style: AppTextStyle.kNormalTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Text(
                        "Assignment Due Date:",
                        style: AppTextStyle.kBottemLabelStyle.copyWith(
                          color: AppColors.kYellowColor,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(notification.dueDate),
                        style: AppTextStyle.kNormalTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Text(
                        "Assignment Description:",
                        style: AppTextStyle.kBottemLabelStyle.copyWith(
                          color: AppColors.kYellowColor,
                        ),
                      ),
                      Text(
                        notification.description,
                        style: AppTextStyle.kNormalTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Text(
                        "How long has this been overdue?:",
                        style: AppTextStyle.kBottemLabelStyle.copyWith(
                          color: AppColors.kYellowColor,
                        ),
                      ),
                      Text(
                        "${(notification.dueDate.difference(DateTime.now()).inHours).abs().toString()}h",
                        style: AppTextStyle.kNormalTextStyle.copyWith(
                          fontSize: 21,
                          color: AppColors.kRedAccentColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
