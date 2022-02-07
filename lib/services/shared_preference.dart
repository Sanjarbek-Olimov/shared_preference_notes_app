import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static storeNotes(listofNotes) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("notes", listofNotes);
  }

  static Future<String?> loadNotes() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("notes");
  }
}