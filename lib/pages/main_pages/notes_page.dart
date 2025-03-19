import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_planner/models/note_model.dart';
import 'package:learn_planner/services/firestore_database/note_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  Future<Map<String, List<NoteModel>>> _fetchNotes() async {
    return await NoteService().getNotesByCourseName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Page", style: AppTextStyle.kMainTitleStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstance.kPaddingValue),
        child: FutureBuilder(
          future: _fetchNotes(),
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
                        "No Notes are available!",
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
            final notesMap = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.only(bottom: AppConstance.kPaddingValue * 2),
              itemCount: notesMap.keys.length,
              itemBuilder: (context, index) {
                final courseName = notesMap.keys.elementAt(index);
                final notes = notesMap[courseName]!;
                return ExpansionTile(
                  collapsedIconColor: AppColors.kNoteCardColor1,
                  iconColor: AppColors.kNoteCardColor1,
                  leading: Icon(
                    Icons.task,
                    size: 30,
                    color: AppColors.kNoteCardColor1,
                  ),
                  title: Text(
                    courseName.toUpperCase(),
                    style: AppTextStyle.kNormalTextStyle.copyWith(
                      fontSize: 21,
                      color: AppColors.kNoteCardColor1,
                    ),
                  ),
                  children:
                      notes.map((note) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: AppConstance.kPaddingValue,
                          ),
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
                                    SizedBox(
                                      height: AppConstance.kSizedBoxValue,
                                    ),
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
                                    SizedBox(
                                      height: AppConstance.kSizedBoxValue,
                                    ),
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
                        );
                      }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
