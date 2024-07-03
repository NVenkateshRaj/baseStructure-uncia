import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_events.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_repo.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_state.dart';
import 'package:network_issue_handle/constants/end_points.dart';
import 'package:network_issue_handle/constants/strings.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/routes/router.dart';
import 'package:network_issue_handle/service/api_service/storage_service.dart';

class LoginBloc extends Bloc<LoginEvents,LoginState>{

  final LogInRepository logInRepo;
  dynamic body;
  int loginId = 0;
  bool isLoading = false;

  LoginBloc({required this.logInRepo}): super(LogInInitState()){
    on<LoginEvents>((events,emit) async{
      if(events == LoginEvents.updateState){
        emit(LogInInErrorState());
        emit(LogInUpdateState());
      }
      if(events == LoginEvents.alreadyLogin){
        await checkLoginDetails();
      } else if(events == LoginEvents.loginButtonTap){
        await loginButtonTapped(emit);
      } else if (events == LoginEvents.fetchData){
        await fetchData(emit);
      }
    });
  }

  checkLoginDetails(){
    Future.delayed(const Duration(milliseconds: 5000),(){
      navigationService.pushNamed(Routes.login);
    });
  }

  loginButtonTapped(Emitter<LoginState> emit)async{
    try{
      isLoading = true;
      emit(LogInInLoading());
      String subUrl = EndPoints.auth+EndPoints.login;
      var loginResponse = await logInRepo.login(subUrl, body);
      if(loginResponse.token!.isNotEmpty){
        print("Auth token called ${loginResponse.token!}");
        await SecureStorageService.addValue(Strings.token, loginResponse.token!);
      }

      isLoading = false;
      emit(LogInInErrorState());
      emit(LogInInSuccessState(loginResponse: loginResponse));
    }catch(e){
      errorHandle(e,emit);
    }
  }

  fetchData(Emitter<LoginState> emit)async{
    try{
      isLoading = true;
      emit(LogInInLoading());
      String subUrl = EndPoints.auth+EndPoints.me;
      var userResponse = await logInRepo.fetchUserDetails(subUrl);
      isLoading = false;
      print("Response Value is");
      print(userResponse.toJson());
      emit(LogInInErrorState());
      emit(LogInInUserDetailsState(userDetails: userResponse));
    }catch(e){
      errorHandle(e,emit);
    }
  }


  errorHandle(dynamic e,Emitter<LoginState> emit){
    isLoading = false;
    emit(LogInInErrorState());
  }
}