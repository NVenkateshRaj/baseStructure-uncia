import 'package:flutter/material.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/styles.dart';
import 'package:network_issue_handle/widgets/common_divider.dart';

class HeaderWidget extends StatelessWidget{
  final String title;

  const HeaderWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,style: AppTextStyle.bold,),
        const CommonDivider(dividerColor: AppColor.divider,),
      ],
    );
  }

}