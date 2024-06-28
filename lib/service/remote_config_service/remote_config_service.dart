
import 'dart:convert';

import 'package:network_issue_handle/model/remote_config/app_config.dart';

enum AppEnvironment{
  dev,
  staging,
  prod
}

class RemoteConfigService {
  AppConfig _appConfig =  AppConfig(
      appName: "icici",
      baseUrl: "",
      firebaseNotificationKey: ""
  );

  AppEnvironment? _appEnvironment;
  AppEnvironment? get appEnvironment => _appEnvironment;

  AppConfig get config {
    return _appConfig;
  }

  setConfig(String value, AppEnvironment appEnvironment) {
    _appConfig = AppConfig.fromJson(jsonDecode(value));
    _appEnvironment = appEnvironment;
  }
}



