import 'package:equatable/equatable.dart';
import 'package:network_issue_handle/model/login/login_response.dart';
import 'package:network_issue_handle/model/login/user_details_dummy.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object> get props => [];
}

class LogInInitState extends LoginState {}

class LogInInLoading extends LoginState{}

class LogInUpdateState extends LoginState{}

class LogInInErrorState extends LoginState{}


class LogInInSuccessState extends LoginState{
  final LoginResponse loginResponse;
  LogInInSuccessState({required this.loginResponse});
}

class LogInInUserDetailsState extends LoginState{
  final UserDetails userDetails;
  LogInInUserDetailsState({required this.userDetails});
}