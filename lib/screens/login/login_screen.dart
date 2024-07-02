import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_bloc.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_events.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_state.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/images.dart';
import 'package:network_issue_handle/constants/strings.dart';
import 'package:network_issue_handle/constants/styles.dart';
import 'package:network_issue_handle/widgets/button_widget.dart';
import 'package:network_issue_handle/widgets/common_appbar.dart';
import 'package:network_issue_handle/widgets/common_divider.dart';
import 'package:network_issue_handle/widgets/common_text_field.dart';
import 'package:network_issue_handle/widgets/tap_outside.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<LoginScreen>{

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController captchaController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode captchaFocus = FocusNode();
  bool buttonColorChange = false;
  Random random = Random();
  int firstValue = 0;
  int secondValue = 0;
  LoginBloc? loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    generateCaptchaValue();
    super.initState();
  }

  generateCaptchaValue(){
    firstValue = random.nextInt(100);
    secondValue = random.nextInt(100);
    loginBloc!.add(LoginEvents.updateState);
  }


  @override
  Widget build(BuildContext context) {

   return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return Scaffold(
            appBar: const CommonAppbar(),
            body: TapOutsideUnFocus(
              child: SingleChildScrollView(
                padding:  EdgeInsets.all(10.sp),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Images.homeFinance),
                      SizedBox(height: 20.h,),
                      Text(Strings.appName,style: AppTextStyle.headerMedium,),
                      SizedBox(height: 20.h,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.welcome,style: AppTextStyle.header,),
                          CommonDivider(dividerColor: Colors.grey[300],),
                          SizedBox(height: 10.h,),
                          CommonTextField(
                            textFieldTitle: Strings.userName,
                            controller: userNameController,
                            hintText: Strings.userNameHint,
                            onChanged: (val){
                              enableButton();
                            },
                            onSubmitted: (val){
                              passwordFocus.requestFocus();
                            },
                            focusNode: userNameFocus,
                          ),
                          SizedBox(height: 18.h,),
                          CommonTextField(
                            textFieldTitle: Strings.password,
                            controller: passwordController,
                            hintText: Strings.passwordHint,
                            onChanged: (val){
                              enableButton();
                            },
                            onSubmitted: (val){
                              captchaFocus.requestFocus();
                            },
                            focusNode: passwordFocus,
                          ),
                          SizedBox(height: 18.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("$firstValue + $secondValue = ",style: AppTextStyle.bodyRegular,),
                              Expanded(
                                child: CommonTextField(
                                  textFieldTitle: "",
                                  controller: captchaController,
                                  hintText: Strings.answer,
                                  maxLength: 3,
                                  onChanged: (val){
                                    enableButton();
                                  },
                                  onSubmitted: (val){
                                    captchaFocus.unfocus();
                                  },
                                  focusNode: captchaFocus,
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              IconButton(
                                onPressed: (){
                                  captchaController.clear();
                                  enableButton();
                                  generateCaptchaValue();
                                },
                                icon: const Icon(Icons.refresh_sharp),
                                color: AppColor.primary,
                              ),
                              Expanded(child: Container(),)
                            ],
                          ),
                          SizedBox(height: 18.h,),
                          CommonButton(
                            buttonText: Strings.login,
                            onPressed: (){},
                            borderColor: buttonColorChange ?  AppColor.primary : AppColor.disabledColor.withOpacity(0.7),
                            buttonColor: buttonColorChange ?  AppColor.primary : AppColor.disabledColor.withOpacity(0.7),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        );
  }

  enableButton(){
    buttonColorChange = userNameController.text.isNotEmpty && passwordController.text.isNotEmpty && captchaController.text.isNotEmpty;
    loginBloc!.add(LoginEvents.updateState);
  }

}