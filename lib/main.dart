import 'package:flutter/material.dart';
import 'package:perfil_visitante_app/screens/user_settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfil de Viajante',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black,)
      ),
      home: const UserSettingsScreen(),
    );
  }
}