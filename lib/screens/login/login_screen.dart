import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_bloc.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_events.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_state.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/images.dart';
import 'package:network_issue_handle/constants/strings.dart';
import 'package:network_issue_handle/constants/styles.dart';
import 'package:network_issue_handle/widgets/button_widget.dart';
import 'package:network_issue_handle/widgets/common_appbar.dart';
import 'package:network_issue_handle/widgets/common_text_field.dart';
import 'package:network_issue_handle/widgets/header_widget.dart';
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
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
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
            backgroundColor: AppColor.background,
            appBar: const CommonAppbar(),
            body: PopScope(
              onPopInvoked: (value){

              },
              child: TapOutsideUnFocus(
                child: SingleChildScrollView(
                  padding:  EdgeInsets.all(10.sp),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h,),
                        Image.asset(Images.homeFinance),
                        SizedBox(height: 2.h,),
                        Text(Strings.appName,style: AppTextStyle.headerMedium,),
                        SizedBox(height: 20.h,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           const HeaderWidget(title: Strings.welcome,),
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
                              validator: (val){
                                if(val.isEmpty){
                                  return Strings.userNameHint;
                                }
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
                              validator: (val){
                                if(val.isEmpty){
                                  return Strings.passwordHint;
                                }
                              },
                              focusNode: passwordFocus,
                            ),
                            SizedBox(height: 18.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("$firstValue + $secondValue = ",style: AppTextStyle.bold.copyWith(fontWeight: FontWeight.w500),),
                                Expanded(
                                  flex: 2,
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
                                    isNumberPad: true,
                                    validator: (val){
                                      if(val.isEmpty){
                                        return Strings.enterAnswer;
                                      }else if(val.isNotEmpty && (firstValue+secondValue) != int.parse(val)){
                                        return Strings.inValidAnswer;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 5.w,),
                                InkWell(
                                  onTap: (){
                                    captchaController.clear();
                                    enableButton();
                                    generateCaptchaValue();
                                  },
                                  child:  SvgPicture.asset(Images.resetIcon),
                                ),
                                Expanded(child: Container(),)
                              ],
                            ),
                            SizedBox(height: 18.h,),
                            CommonButton(
                              buttonText: Strings.login,
                              onPressed: (){
                                loginTapped();
                              },
                              borderColor:  buttonColorChange ? AppColor.primary : AppColor.buttonWithOpacity.withOpacity(0.6),
                              buttonColor: buttonColorChange ? AppColor.primary : AppColor.buttonWithOpacity.withOpacity(0.6),
                              boxShadow: [
                                 BoxShadow(color: AppColor.buttonWithOpacity.withOpacity(0.1),offset:  const Offset(0,2),blurRadius: 8)
                              ],
                            ),
                            SizedBox(height: 20.h,),
                          ],
                        )
                      ],
                    ),
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

  loginTapped(){
    if(formKey.currentState!.validate()){
      print("Called");
    }
    // loginBloc!..body = {
    //   "username": 'emilys',
    //   "password": 'emilyspass',
    //   "expiresInMins": 30
    // }..add(LoginEvents.loginButtonTap);
  }

}