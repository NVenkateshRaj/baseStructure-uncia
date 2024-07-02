

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/styles.dart';
import 'package:searchfield/searchfield.dart';

class CommonTextField extends StatefulWidget{
  final String textFieldTitle;
  final String hintText;
  final TextEditingController controller;
  final Function(String)? validator;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
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
    required this.focusNode,
    this.textInputAction = TextInputAction.next,
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

  
  //final StreamController<bool> checkListen = StreamController<bool>.broadcast();
  
  


  @override
  State<StatefulWidget> createState() {
    return _CommonTextFieldState();
  }

}

class _CommonTextFieldState extends State<CommonTextField>{

  List<TextInputFormatter> inputFormatList = [];
  @override
  void initState() {
    if(widget.isNumberPad){
      inputFormatList.add(FilteringTextInputFormatter.digitsOnly);
    }
    if(widget.isDecimalPad){
      inputFormatList.add(FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")));
    }
    if(widget.isAlphaNumeric){
      inputFormatList.add(FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")));
    }
    if(widget.isTextOnly){
      inputFormatList.add(FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]")));
    }

    super.initState();
  }

  final StreamController<bool> checkListen = StreamController<bool>.broadcast();


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.textFieldTitle.isNotEmpty ? Text(widget.textFieldTitle,style: AppTextStyle.headerMedium,) : Container(),
        SizedBox(height: 3.h,),
        Focus(
          onFocusChange: (hasFocus){
            checkListen.add(hasFocus);
          },
          child: StreamBuilder<bool>(
            stream: checkListen.stream,
            builder: (context, snapshot) {
              bool? isFocused = snapshot.hasData ? snapshot.data : false;
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: isFocused! ? [
                    const BoxShadow(color: AppColor.primary,blurRadius: 2,spreadRadius: 0)
                  ] : [],
                ),
                child: !widget.isSearchField ? TextFormField(
                  controller: widget.controller,
                  keyboardType: widget.isNumberPad|| widget.isDecimalPad ? TextInputType.number :  TextInputType.name,
                  obscureText: widget.obscureText,
                  maxLength: widget.maxLength,
                  readOnly: widget.isReadOnly,
                  focusNode: widget.focusNode,
                  style: AppTextStyle.bodyRegular,
                  cursorColor: Colors.black,
                  inputFormatters: inputFormatList,
                  textInputAction: widget.textInputAction,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: AppTextStyle.hintTextStyle,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon,
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: AppColor.borderColor)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: AppColor.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: AppColor.borderColor)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: AppColor.redColor)
                    ),
                    counterText: "",
                  ),
                  validator: widget.validator!= null ? (val) => widget.validator!.call(val!) : null,
                  onChanged: (val)=> widget.onChanged.call(val),
                  onFieldSubmitted: (val)=> widget.onSubmitted.call(val),
                ) : SearchField(
                  hint: widget.hintText,
                  searchStyle: AppTextStyle.bodyRegular,
                  suggestions: widget.suggestions!
                      .map(SearchFieldListItem<String>.new)
                      .toList(),
                  suggestionState: Suggestion.expand,
                  inputFormatters: inputFormatList,
                  suggestionAction: SuggestionAction.next,
                  suggestionStyle: AppTextStyle.bodyRegular,
                  searchInputDecoration: InputDecoration(
                      hintStyle: AppTextStyle.hintTextStyle,
                      hintText: widget.hintText,
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
                  validator: widget.validator!= null ? (val) => widget.validator!.call(val!) : null,
                ),
              );
            }
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    checkListen.close();
    super.dispose();
  }
}
