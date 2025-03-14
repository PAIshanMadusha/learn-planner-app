import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/helpers/app_helpers.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/models/note_model.dart';
import 'package:learn_planner/services/firestore_database/note_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:learn_planner/widgets/custom_button.dart';
import 'package:learn_planner/widgets/custom_input_field.dart';
import 'package:image_picker/image_picker.dart';

class AddNewNotePage extends StatefulWidget {
  final CourseModel course;
  const AddNewNotePage({super.key, required this.course});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _noteTitleController = TextEditingController();

  final TextEditingController _noteDescriptionController =
      TextEditingController();

  final TextEditingController _noteSectionController = TextEditingController();

  final TextEditingController _noteReferencesController =
      TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _selectedImage;

  //Pick Image from Gallery
  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _selectedImage = image;
    });
  }

  //Add Note
  void _addNote(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        //Create a New Note Object
        final NoteModel note = NoteModel(
          id: "",
          title: _noteTitleController.text,
          section: _noteSectionController.text,
          description: _noteDescriptionController.text,
          references: _noteReferencesController.text,
          imageData: _selectedImage != null ? File(_selectedImage!.path) : null,
        );
        await NoteService().createNote(widget.course.id, note);
        if(context.mounted) {
          AppHelpers.showSnackBar(context, "Note Added Successfully!");
        }
        
        await Future.delayed(Duration(seconds: 1));

        if(context.mounted) {
          GoRouter.of(context).pop();
        }
      } catch (error) {
        if(context.mounted) {
          AppHelpers.showSnackBar(context, "Failed to Add Successfully!");
        }
      }
    }
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
          "Add a New Note",
          style: AppTextStyle.kMainTitleStyle.copyWith(
            fontSize: 28,
            color: AppColors.kYellowColor,
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
              Text(
                "Fill in the details below and add a new Note related to your course and start managing your learn planner.",
                style: AppTextStyle.kNormalTextStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Divider(color: AppColors.kBlueGrey, thickness: 1),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInputField(
                      controller: _noteTitleController,
                      labelText: "Note Title",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter a Note Title";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    CustomInputField(
                      controller: _noteSectionController,
                      labelText: "Note Section",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter Note Section";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    CustomInputField(
                      controller: _noteDescriptionController,
                      labelText: "Note Description",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter Note Description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    CustomInputField(
                      controller: _noteReferencesController,
                      labelText: "Note References",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter Note References";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Divider(color: AppColors.kBlueGrey, thickness: 1),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Upload a Note Image for your better understanding and quick revision",
                      style: AppTextStyle.kBottemLabelStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: AppColors.kWhiteColor),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.kBlueGrey,
                        ),
                      ),
                      onPressed: _pickImage,
                      label: Text(
                        "Upload a Note Image",
                        style: AppTextStyle.kBottemLabelStyle.copyWith(
                          color: AppColors.kBlackColor,
                        ),
                      ),
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: AppColors.kBlackColor,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue * 2),
                    _selectedImage != null
                        ? Column(
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
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  height: 540,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        )
                        : SvgPicture.asset(
                          "assets/emptydatapic.svg",
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                    SizedBox(height: AppConstance.kSizedBoxValue * 2),
                    CustomButton(
                      textLabel: "Add Note",
                      icon: Icons.task_alt_sharp,
                      onPressed: () => _addNote(context),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
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
