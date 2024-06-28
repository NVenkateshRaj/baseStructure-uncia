import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/routes/router.dart';

class ConnectivityService{
  bool isConnected = false;
  init(){
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result){
      if(result.contains(ConnectivityResult.none)){
        navigationService.pushNamed(Routes.noNetwork);
        isConnected = true;
      }else if(result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile)){
        if(isConnected) {
          navigationService.pop();
          isConnected = false;
        }
      }
    }
    );
  }

}