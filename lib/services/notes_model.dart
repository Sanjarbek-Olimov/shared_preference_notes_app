import 'dart:convert';

class Note {
  String? date;
  String? notes;
  bool isSelected;

  Note({this.date, this.notes, this.isSelected=false});

  Note.fromJson(Map<String, dynamic> json)
      : date = json["date"],
        notes = json["notes"],
        isSelected = json["isSelected"];

  Map<String, dynamic> toJson() => {
        "date": date,
        "notes": notes,
        "isSelected":isSelected,
      };

  static String encode(List<Note> notes) => json.encode(
        notes.map<Map<String, dynamic>>((note) => note.toJson()).toList());

  static List<Note> decode(String notes) =>
      json.decode(notes).map<Note>((item) => Note.fromJson(item)).toList();
}
