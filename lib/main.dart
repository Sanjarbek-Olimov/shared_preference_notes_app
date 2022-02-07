import 'package:flutter/material.dart';
import 'package:shared_preference/pages/notes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const NotesPage(),
      routes: {
        NotesPage.id: (context) => const NotesPage()
      },
    );
  }
}
