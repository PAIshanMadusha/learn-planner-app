import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/models/note_model.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class SingleNotePage extends StatelessWidget {
  final NoteModel note;
  const SingleNotePage({super.key, required this.note});

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
            color: AppColors.kBlueGrey,
          ),
        ),
        title: Text(
          "Your Note Details",
          style: AppTextStyle.kMainTitleStyle.copyWith(
            fontSize: 28,
            color: AppColors.kBlueGrey,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstance.kPaddingValue),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/notebook.svg",
                width: 180,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Divider(color: AppColors.kBlueGrey, thickness: 1),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Container(
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
                    Text(
                      "Note Title:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      note.title,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Note Section:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      note.section,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Note Description:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      note.description,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Note References:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      note.references,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    if (note.imageUrl != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Image View",
                            style: AppTextStyle.kNormalTextStyle,
                          ),
                          SizedBox(height: AppConstance.kSizedBoxValue),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppConstance.kRoundCornerValue,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.kBlueGrey,
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppConstance.kRoundCornerValue,
                              ),
                              child: Image.network(
                                note.imageUrl!,
                                height: 540,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Image View",
                            style: AppTextStyle.kNormalTextStyle,
                          ),
                          SizedBox(height: AppConstance.kSizedBoxValue),
                          Center(
                            child: SvgPicture.asset(
                              "assets/emptydatapic.svg",
                              width: 180,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
