import 'package:get_storage/get_storage.dart';

class StorageServices {
  static final session = GetStorage();

  static const String userSessionKey = 'userSession';

  static dynamic userSession = session.read(userSessionKey);
}
