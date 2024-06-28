import 'package:flutter/material.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/styles.dart';

class CommonButton extends StatelessWidget{

  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color borderColor;
  final bool isOutLine;
  final TextStyle? textStyle;
  final Function(bool value)? onHover;
  final VoidCallback? longPress;

  const CommonButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor = AppColor.background,
    this.borderColor = AppColor.borderColor,
    this.isOutLine = false,
    this.textStyle,
    this.onHover,
    this.longPress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.buttonWithOpacity.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: (){
          onPressed();
        },
        onHover:onHover!=null ? (hover)=>  onHover!.call(hover) : null,
        onLongPress: longPress!=null ? ()=> longPress!() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: AppColor.primary,
              width: 1.0,
            ),
          ),
        ),
        child: Text(buttonText,style: textStyle ?? AppTextStyle.button),
      ),
    );
  }

}