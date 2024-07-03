import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorageService{
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static IOSOptions _getIOSOptions() => const IOSOptions(
    accountName:  "icicihcfIosUncia@2024",
  );

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static addValue(String key,String value)async{
    await secureStorage.write(key: key, value: value,aOptions:_getAndroidOptions(),iOptions: _getIOSOptions());
  }

  static getValue(String key)async{
    String value = await secureStorage.read(key: key,aOptions:_getAndroidOptions(),iOptions: _getIOSOptions()) ?? '';
    return value;
  }

}
