import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences preferences;

  void savelastSearchedWord({required String keyword}) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('last_word', keyword);
  }

  Future<String?> getlastSearchedWord() async {
    preferences = await SharedPreferences.getInstance();
    String? value = preferences.getString('last_word');
    return value;
  }
}
