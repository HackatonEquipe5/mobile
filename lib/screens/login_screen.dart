import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:mobile/services/services_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/colors.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  final ThemeData _theme = ThemeData(
    primaryColor: AppColors.primary,
  );

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      final response = await ApiService().connectUser(data.name, data.password);
      if (response == null) {
        return 'Nom d\'utilisateur ou mot de passe incorrect';
      }
      final preferences = await SharedPreferences.getInstance();
      preferences.setString('token', response);
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    return Future.delayed(loginTime).then((_) async {
      if (data.name == null || data.password == null) {
        return 'Veuillez remplir tous les champs';
      }

      final name = data.name!;
      final password = data.password!;

      await ApiService().createUser(name, password);
      return await ApiService().connectUser(name, password);
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return 'Password recovery not yet implemented';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme,
      home: Scaffold(
        body: FlutterLogin(
          onLogin: _authUser,
          onSignup: _signupUser,
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
          },
          onRecoverPassword: _recoverPassword,
          messages: LoginMessages(
            userHint: 'Nom d\'utilisateur',
            passwordHint: 'Mot de passe',
          ),
          userType: LoginUserType.name,
          hideForgotPasswordButton: true,
          userValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Le nom d\'utilisateur ne peut pas être vide';
            }
            return null;
          },
          passwordValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Le mot de passe ne peut pas être vide';
            }
            return null;
          },
        ),
      ),
    );
  }
}