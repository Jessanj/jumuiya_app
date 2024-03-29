import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppConstants {
  AppConstants._();

  static OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(
      width: 2,
      color: AppColors.lightNavyBlue,
    ),
  );

  static InputDecoration get inputDecoration => InputDecoration(
    border: inputBorder,
    disabledBorder: inputBorder,
    errorBorder: inputBorder.copyWith(
      borderSide: BorderSide(
        width: 2,
        color: AppColors.red,
      ),
    ),
    enabledBorder: inputBorder,
    focusedBorder: inputBorder,
    focusedErrorBorder: inputBorder,
    hintText: "Event Title",
    hintStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    labelStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    helperStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    errorStyle: TextStyle(
      color: AppColors.red,
      fontSize: 12,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
  );
  static InputDecoration get inputDecorationLogin => InputDecoration(
    border: inputBorder,
    disabledBorder: inputBorder,
    errorBorder: inputBorder.copyWith(
      borderSide: BorderSide(
        width: 2,
        color: AppColors.red,
      ),
    ),
    enabledBorder: inputBorder,
    focusedBorder: inputBorder,
    focusedErrorBorder: inputBorder,
    hintText: "Username",
    hintStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    labelStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    helperStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    errorStyle: TextStyle(
      color: AppColors.red,
      fontSize: 12,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
  );
  static InputDecoration get inputDecorationForms => InputDecoration(
    border: inputBorder,
    disabledBorder: inputBorder,
    errorBorder: inputBorder.copyWith(
      borderSide: BorderSide(
        width: 2,
        color: AppColors.red,
      ),
    ),
    enabledBorder: inputBorder,
    focusedBorder: inputBorder,
    focusedErrorBorder: inputBorder,
    hintStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    labelStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    helperStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    errorStyle: TextStyle(
      color: AppColors.red,
      fontSize: 12,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
  );
  static InputDecoration get inputDecorationGroupID => InputDecoration(
    border: inputBorder,
    disabledBorder: inputBorder,
    errorBorder: inputBorder.copyWith(
      borderSide: BorderSide(
        width: 2,
        color: AppColors.red,
      ),
    ),
    enabledBorder: inputBorder,
    focusedBorder: inputBorder,
    focusedErrorBorder: inputBorder,
    hintStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    labelStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    helperStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    errorStyle: TextStyle(
      color: AppColors.red,
      fontSize: 12,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
  );
  static InputDecoration get inputDecorationGroupType => InputDecoration(
    border: inputBorder,
    disabledBorder: inputBorder,
    errorBorder: inputBorder.copyWith(
      borderSide: BorderSide(
        width: 2,
        color: AppColors.red,
      ),
    ),
    enabledBorder: inputBorder,
    focusedBorder: inputBorder,
    focusedErrorBorder: inputBorder,
    hintText: "Group Type",
    hintStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    labelStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    helperStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
    ),
    errorStyle: TextStyle(
      color: AppColors.red,
      fontSize: 12,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 5,
    ),
  );
}

class BreakPoints {
  static const double web = 800;
}