import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  static storeMode(bool isLight) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("mode", isLight);
  }

  static Future<bool?> loadMode() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("mode");
  }

  static storeLang(lang) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", lang);
  }

  static Future<String?> loadLang() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("lang");
  }

  static storeNotes(listofNotes) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("notes", listofNotes);
  }

  static Future<String?> loadNotes() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("notes");
  }
}