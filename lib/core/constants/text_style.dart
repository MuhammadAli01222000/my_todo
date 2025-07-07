import 'package:flutter/material.dart';
import 'package:my_todo/core/constants/app_colors.dart';
import 'package:my_todo/core/constants/app_dimens.dart';
sealed class AppTextStyle{
  static final splashText=TextStyle(color: AppColors.black,fontSize: AppDimens.d14,fontWeight: FontWeight.w500);
}