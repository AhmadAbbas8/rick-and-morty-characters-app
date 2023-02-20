import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/api/dio_helper.dart';
import 'package:rick_and_morty/prsentation/screens/characters.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:CharactersScreen(),
    );
  }
}
