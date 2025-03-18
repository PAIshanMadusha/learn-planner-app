import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime dueDate;
  const CountdownTimer({super.key, required this.dueDate});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late DateTime _dueDate;
  late Duration _remainingTime;
  late Timer _timer;

  void _calculateRemainingTime() {
    setState(() {
      _remainingTime = _dueDate.difference(DateTime.now());
    });
  }

  void _updateRemainingTime() {
    if (_remainingTime.inSeconds > 0) {
      setState(() {
        _remainingTime = _dueDate.difference(DateTime.now());
      });
    } else {
      _timer.cancel();
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) {
      return "Deadline Passed!";
    }
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return "${hours}h : ${minutes}min : ${seconds}sec";
  }

  @override
  void initState() {
    super.initState();
    _dueDate = widget.dueDate;
    _calculateRemainingTime();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_) => _updateRemainingTime(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime = _formatDuration(_remainingTime);
    return Container(
      padding: EdgeInsets.all(AppConstance.kPaddingValue),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstance.kRoundCornerValue),
        gradient: AppColors.kAssignmentCardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kAssignmentCardColor2,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          formattedTime,
          style: AppTextStyle.kNormalTextStyle.copyWith(
            color: AppColors.kRedAccentColor,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
