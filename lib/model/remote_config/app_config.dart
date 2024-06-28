class AppConfig {
  String? appName;
  String? baseUrl;
  String? firebaseNotificationKey;
  String? googleApiKey;
  Android? android;
  Android? ios;

  AppConfig(
      {this.appName,
        this.baseUrl,
        this.firebaseNotificationKey,
        this.googleApiKey,
        this.android,
        this.ios});

  AppConfig.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'] ?? "";
    baseUrl = json['base_url'] ?? "";
    firebaseNotificationKey = json['firebase_notification_key'] ?? "";
    googleApiKey = json['google_api_key'] ?? "";
    android = json['android'] != null ? Android.fromJson(json['android']) : null;
    ios = json['ios'] != null ? Android.fromJson(json['ios']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['base_url'] = baseUrl;
    data['firebase_notification_key'] = firebaseNotificationKey;
    data['google_api_key'] = googleApiKey;
    data['android'] = android?.toJson();
    data['ios'] = ios?.toJson();
    return data;
  }
}

class Android {
  String? url;
  double? version;
  bool? forceUpdate;

  Android({this.url, this.version, this.forceUpdate});

  Android.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    version = json['version'];
    forceUpdate = json['force_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['version'] = version;
    data['force_update'] = forceUpdate;
    return data;
  }
}