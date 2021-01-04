import 'package:brandfarmdemo/models/user/user_model.dart';

class UserUtil {
  static User _user;
  static void setUser(User user) async {
    _user = user;
  }

  static User getUser() {
    return _user;
  }
}
