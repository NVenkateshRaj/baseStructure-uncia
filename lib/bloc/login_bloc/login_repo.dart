import 'package:network_issue_handle/model/login/login_response.dart';
import 'package:network_issue_handle/model/login/user_details_dummy.dart';
import 'package:network_issue_handle/service/api_service/api_service.dart';

abstract class LogInRepository{
  Future<LoginResponse> login(String path,dynamic body);
  Future<UserDetails> fetchUserDetails(String path);
}

class LoginRepoService extends LogInRepository{

  @override
  Future<LoginResponse> login(String path, body) async{
    var response = await ApiService().post(path,body);
    LoginResponse loginResponse = LoginResponse.fromJson(response);
    return loginResponse;
  }

  @override
  Future<UserDetails> fetchUserDetails(String path) async{
    var response = await ApiService().get(path);
    UserDetails userDetails = UserDetails.fromJson(response);
    return userDetails;
  }

}