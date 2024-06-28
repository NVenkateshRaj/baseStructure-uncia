import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_events.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_repo.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_state.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/routes/router.dart';

class LoginBloc extends Bloc<LoginEvents,LoginState>{

  final LogInRepository logInRepo;
  dynamic body;
  int loginId = 0;
  bool isLoading = false;

  LoginBloc({required this.logInRepo}): super(LogInInitState()){
    on<LoginEvents>((events,emit) async{
      if(events == LoginEvents.alreadyLogin){
        await checkLoginDetails();
      } else if(events == LoginEvents.loginButtonTap){
        await loginButtonTapped(emit);
      }
      else if(events == LoginEvents.registerButtonTap){
        await registerButtonTapped(emit);
      }else{

      }
    });
  }

  checkLoginDetails(){
    Future.delayed(const Duration(milliseconds: 5000),(){
      navigationService.pushNamed(Routes.dashboard);
    });
  }

  loginButtonTapped(Emitter<LoginState> emit)async{}

  registerButtonTapped(Emitter<LoginState> emit)async{

  }


}