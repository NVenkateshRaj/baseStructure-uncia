import 'package:get_it/get_it.dart';
import 'package:network_issue_handle/routes/navigation_service.dart';
import 'package:network_issue_handle/service/common_service/dialog_service.dart';
import 'package:network_issue_handle/service/remote_config_service/firebase_helper.dart';
import 'package:network_issue_handle/service/common_service/network_service.dart';
import 'package:network_issue_handle/service/remote_config_service/remote_config_service.dart';

  GetIt locator = GetIt.instance;

  NavigationService get navigationService => locator<NavigationService>();
  DialogService get dialogService => locator<DialogService>();
  RemoteConfigService get appConfigService => locator<RemoteConfigService>();

  void setupLocator(){
    locator.registerLazySingleton(() => FirebaseRemoteHelper());
    locator.registerLazySingleton(() => ConnectivityService());
    locator.registerLazySingleton(() => RemoteConfigService());
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
  }