import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object> get props => [];
}

class LogInInitState extends LoginState {}

class LogInInLoading extends LoginState{}

class LogInUpdateState extends LoginState{}

class LogInInErrorState extends LoginState{}