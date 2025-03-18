import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:mobile/services/services_api.dart';
import '../themes/colors.dart';
import '../themes/icons.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  final ThemeData _theme = ThemeData(
    primaryColor: AppColors.primary,
  );

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      return await ApiService().connectUser(data.name, data.password);
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) async {
      if (data.name == null || data.password == null) {
        return 'Veuillez remplir tous les champs';
      }
      final name = data.name;
      final password = data.password;
      final user = await ApiService().createUser(name!, password!);
      if (user == null) {
        return await ApiService().connectUser(name, password);
      } else {
        return "Erreur lors de la création de l'utilisateur";
      }
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
            userHint: 'Username',
            passwordHint: 'Password',
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