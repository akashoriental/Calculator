import 'package:shared_preferences/shared_preferences.dart';
class UserPreferences{
  static SharedPreferences? prefs;
  static Future init() async{
    prefs= await SharedPreferences.getInstance();
  }
  static Future setval(String ans) async{
    return await prefs!.setString("answer", ans);
}
  static Future getval()async{
    return prefs?.getString("answer")??'0';
  }

}