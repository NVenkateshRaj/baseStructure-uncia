import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/service/remote_config_service/remote_config_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';


class FirebaseRemoteHelper {

  final RemoteConfigService remoteConfigService = locator<RemoteConfigService>();

  Future<void> configure() async {

    FirebaseRemoteConfig remoteConfig =  FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setConfigSettings(
          RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 60),
        minimumFetchInterval: Duration.zero,
          )
      );
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      String configKey;

      AppEnvironment appEnvironment;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      if (packageInfo.packageName.contains("dev")){

        appEnvironment = AppEnvironment.dev;
        configKey = "app_dev";
      } else if (packageInfo.packageName.contains("uat")){
        appEnvironment = AppEnvironment.staging;
        configKey = "app_stag";
      } else {
        appEnvironment = AppEnvironment.prod;
        configKey = "app_prod";
      }


      remoteConfigService.setConfig(remoteConfig.getString(configKey), appEnvironment);


    } catch (e) {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)){
        // locator<NavigationService>().pushNamed(Routes.no_network);

       // Fluttertoast.showToast(msg: "No Network Connection. Please Enable Internet and Try Again.", toastLength: Toast.LENGTH_LONG,backgroundColor:AppColor.black.withOpacity(0.8),textColor:AppColor.white);
      }

    }
  }

}
