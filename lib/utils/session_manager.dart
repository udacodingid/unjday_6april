import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{

  int? value;
  String? idUser;
  String? username;
  String? fullname;

  Future savePref(int val, String id, String username, String fullname) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("value", val);
    prefs.setString("id", id);
    prefs.setString("username", username);
    prefs.setString("fullname", fullname);

  }

  Future getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    username = pref.getString("username");
    fullname = pref.getString("fullname");
    idUser = pref.getString("id");
    return value;
  }

  //untuk logout --> clear session
  Future clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
SessionManager sessionManager = SessionManager();