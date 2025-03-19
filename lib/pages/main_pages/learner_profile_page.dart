import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_planner/helpers/app_helpers.dart';
import 'package:learn_planner/services/user_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:learn_planner/widgets/custom_input_field.dart';

class LearnerProfilePage extends StatefulWidget {
  const LearnerProfilePage({super.key});

  @override
  State<LearnerProfilePage> createState() => _LearnerProfilePageState();
}

class _LearnerProfilePageState extends State<LearnerProfilePage> {
  final UserService _userService = UserService();

  String? _imagePath;

  //Pick an Image from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    String? imagePath = await _userService.pickImage(source);
    if (imagePath != null) {
      await _userService.saveImage(imagePath);
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  @override
  void initState() {
    _loadImage();
    _loadUserData();
    super.initState();
  }

  //Load Saved Image
  void _loadImage() async {
    String? savedImagePath = await _userService.getImage();
    setState(() {
      _imagePath = savedImagePath;
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  //Load User Data
  Future<void> _loadUserData() async {
    final userData = await UserService.getUserData();
    setState(() {
      _nameController.text = userData["name"];
      _educationController.text = userData["education"];
      _ageController.text = userData["age"].toString();
      _emailController.text = userData["email"];
    });
  }

  Future<void> _savedUserData() async {
    await UserService.saveUserData(
      _nameController.text,
      _educationController.text,
      int.tryParse(_ageController.text) ?? 0,
      _emailController.text,
    );
    if (mounted) {
      AppHelpers.showSnackBar(context, "Profile Updated!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learner Profile", style: AppTextStyle.kMainTitleStyle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 170, width: double.infinity),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        AppConstance.kRoundCornerValue * 2,
                      ),
                      topRight: Radius.circular(
                        AppConstance.kRoundCornerValue * 2,
                      ),
                    ),
                    gradient: AppColors.kProfileCardColor,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 80, width: double.infinity),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.kBlueGrey, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 90,
                    backgroundImage:
                        _imagePath != null
                            ? FileImage(File(_imagePath!)) as ImageProvider
                            : AssetImage("assets/profile.jpg"),
                  ),
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: AppColors.kWhiteColor),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.kBlueGrey,
                        ),
                      ),
                      onPressed: () => _pickImage(ImageSource.gallery),
                      label: Text(
                        "Pick",
                        style: AppTextStyle.kBottemLabelStyle.copyWith(
                          color: AppColors.kBlackColor,
                        ),
                      ),
                      icon: Icon(
                        Icons.photo,
                        size: 24,
                        color: AppColors.kBlackColor,
                      ),
                    ),
                    SizedBox(width: AppConstance.kSizedBoxValue),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: AppColors.kWhiteColor),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.kBlueGrey,
                        ),
                      ),
                      onPressed: () => _pickImage(ImageSource.camera),
                      label: Text(
                        "Take",
                        style: AppTextStyle.kBottemLabelStyle.copyWith(
                          color: AppColors.kBlackColor,
                        ),
                      ),
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 24,
                        color: AppColors.kBlackColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(AppConstance.kPaddingValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Edit Profile", style: AppTextStyle.kMainTitleStyle),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      CustomInputField(
                        controller: _nameController,
                        labelText: "Your Name",
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      CustomInputField(
                        controller: _educationController,
                        labelText: "Your Education Centre",
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      CustomInputField(
                        controller: _ageController,
                        labelText: "Your Age",
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      CustomInputField(
                        controller: _emailController,
                        labelText: "Your Email Address",
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
                        onPressed: _savedUserData,
                        label: Text(
                          "Save",
                          style: AppTextStyle.kBottemLabelStyle.copyWith(
                            color: AppColors.kBlackColor,
                          ),
                        ),
                        icon: Icon(
                          Icons.save,
                          size: 24,
                          color: AppColors.kBlackColor,
                        ),
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Text(
                        "Other Informations",
                        style: AppTextStyle.kMainTitleStyle,
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppConstance.kRoundCornerValue,
                          ),
                          gradient: AppColors.kNoteCardColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.kRedAccentColor,
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            GoRouter.of(context).push("/notification-page");
                          },
                          leading: Icon(
                            Icons.notifications,
                            size: 35,
                            color: AppColors.kBlueGrey,
                          ),
                          title: Text(
                            "Your Overdue Assignments",
                            style: AppTextStyle.kNormalTextStyle.copyWith(
                              color: AppColors.kBlueGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
