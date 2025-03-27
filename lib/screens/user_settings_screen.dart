import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {

  static const String userNameKey = 'username';
  static const String userAgeKey = 'user_age';
  static const String userCountry = 'user_country';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString(userNameKey) ?? "";
      _ageController.text = prefs.getInt(userAgeKey).toString();
      _countryController.text = prefs.getString(userCountry) ?? "";
    });
  }

  void _saveUserData() async {
    String username = _nameController.text;
    int age = int.tryParse(_ageController.text) ?? 0;
    String country = _countryController.text;

    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(userAgeKey, age);
    await preferences.setString(userNameKey, username);
    await preferences.setString(userCountry, country);
  }

  void _cleanUserData() async {
    _ageController.clear();
    _countryController.clear();
    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Configurações do Usuário')),
        body: _buildUserSettingScreenBody(),
    );
  }
  
  _buildUserSettingScreenBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Idade'),
              ),
              TextField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'País'),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(onPressed: _saveUserData, child: Text("Salvar")),
                  SizedBox(width: 40),
                  ElevatedButton(onPressed: _loadUserData, child: Text("Carregar")),
                  SizedBox(width: 40),
                  ElevatedButton(onPressed: _cleanUserData, child: Text("Limpar")),
                ],
              )
            ]
          )
        )
      ],
    );
  }
}

