import 'package:encrypt/encrypt.dart';

class EncryptionService{

  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);

}