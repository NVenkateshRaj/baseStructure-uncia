

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/styles.dart';
import 'package:searchfield/searchfield.dart';

class CommonTextField extends StatelessWidget{
  final String? textFieldTitle;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? validator;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isNumberPad;
  final bool isDecimalPad;
  final bool isTextOnly;
  final bool isAlphaNumeric;
  final int maxLength;
  final bool isReadOnly;
  final bool isSearchField;
  final List<String>? suggestions;

  const CommonTextField({
    super.key,
    required this.textFieldTitle,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.isDecimalPad = false,
    this.isNumberPad = false,
    this.isTextOnly = false,
    this.isAlphaNumeric = false,
    this.maxLength = 15,
    this.isReadOnly = false,
    this.isSearchField = false,
    this.suggestions,
  });



  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatList = [];
    if(isNumberPad){
      inputFormatList.add(FilteringTextInputFormatter.digitsOnly);
    }
    if(isDecimalPad){
      inputFormatList.add(FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")));
    }
    if(isAlphaNumeric){
      inputFormatList.add(FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")));
    }
    if(isTextOnly){
      inputFormatList.add(FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]")));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textFieldTitle!,style: AppTextStyle.bodyRegular,),
        SizedBox(height: 3.h,),
        !isSearchField ? TextFormField(
          controller: controller,
          keyboardType: isNumberPad|| isDecimalPad ? TextInputType.number :  TextInputType.name,
          obscureText: obscureText,
          maxLength: maxLength,
          readOnly: isReadOnly,
          style: AppTextStyle.bodyRegular,
         cursorColor: Colors.black,
          inputFormatters: inputFormatList,
          decoration: InputDecoration(
              hintText: hintText,
             hintStyle: AppTextStyle.hintTextStyle,
             prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: AppColor.borderColor)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: AppColor.borderColor)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: AppColor.borderColor)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: AppColor.redColor)
              ),
            counterText: ""
          ),
          validator: validator!= null ? (val) => validator!.call(val!) : null,
          onChanged: (val)=> onChanged.call(val),
          onFieldSubmitted: (val)=> onSubmitted.call(val),
        ) : SearchField(
          hint: hintText,
          searchStyle: AppTextStyle.bodyRegular,
          suggestions: suggestions!
              .map(SearchFieldListItem<String>.new)
              .toList(),
          suggestionState: Suggestion.expand,
          inputFormatters: inputFormatList,
          suggestionAction: SuggestionAction.next,
          suggestionStyle: AppTextStyle.bodyRegular,
          searchInputDecoration: InputDecoration(
              hintStyle: AppTextStyle.hintTextStyle,
              hintText: hintText,
              suffixIcon: const Icon(Icons.search),
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: AppColor.borderColor)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: AppColor.borderColor)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: AppColor.borderColor)
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: AppColor.redColor)
              ),
              counterText: ""
          ),
          validator: validator!= null ? (val) => validator!.call(val!) : null,
        )
      ],
    );
  }



}
