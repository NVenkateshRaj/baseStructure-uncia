
import 'package:flutter/material.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/font_size.dart';
import 'package:network_issue_handle/constants/strings.dart';


class AppStyle {

  static const String fontFamily = Strings.interFontFamily;

  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColor.primary,
    useMaterial3: true,
    primaryColorDark: AppColor.primaryDark,
    primarySwatch: AppColor.primaryColor,
    dividerColor: AppColor.divider,
    canvasColor: AppColor.white,
    indicatorColor: AppColor.primaryDark,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor:  AppColor.primaryColor,
      selectionColor: AppColor.primaryColor.withOpacity(0.3),
      selectionHandleColor:  AppColor.primaryColor,
    ),
    primaryIconTheme: const IconThemeData.fallback().copyWith(
        color: AppColor.black
    ),
    appBarTheme: const AppBarTheme().copyWith(
      iconTheme: const IconThemeData(
        color: AppColor.black,
      ),
      titleSpacing: 0,
      centerTitle: false,
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColor.borderColor;
        }
        return AppColor.primary;
      }),
      splashRadius: 3,
      materialTapTargetSize: MaterialTapTargetSize.padded
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.primary
    ),
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AppColor.background,
  );

  static final List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black.withOpacity(0.08), spreadRadius:0, blurRadius:4),
  ];

  static const Widget customDivider =  SizedBox(height: 1,child: Divider(color: AppColor.primaryDivider, thickness:1.2,),);


  static final List<BoxShadow> mildCardShadow = [
    BoxShadow(color: AppColor.black.withOpacity(0.2), spreadRadius: 0.5, blurRadius: 1),
  ];

  static List<Shadow> textShadow = const  <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Colors.black12,
    ),
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Colors.black12,
    ),
  ];

}


class AppTextStyle {
  
  static TextStyle bold = TextStyle(
      fontSize: AppFontSize.dp24,
      fontWeight: FontWeight.w700,
      color: AppColor.text
  );

  static TextStyle headerMedium = TextStyle(
      fontSize: AppFontSize.dp20,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );

  static TextStyle regular = TextStyle(
      fontSize: AppFontSize.dp20,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );

  static TextStyle medium = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w500,
      color: AppColor.text
  );

  static TextStyle button = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w700,
      color: AppColor.white
  );


  static TextStyle bodyRegular = TextStyle(
    fontWeight:FontWeight.w500,
    fontSize: AppFontSize.dp14,
    color: AppColor.text,
  );

  static TextStyle subtitleBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.dp20,
    color: AppColor.titleBlack,
  );

  static TextStyle hintTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.dp14,
    color: AppColor.secondaryText,
  );

  static TextStyle breadCrumbUnSelect = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.dp14,
    color: AppColor.white,
  );

  static TextStyle breadCrumbSelect = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.dp14,
    color: AppColor.white,
  );

}