import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/coffee_machine.dart';
import 'api_url.dart';

class ApiService {
  final String baseUrl = ApiUrl.domaine;

  Future<String?> postOrder(CoffeeMachine machine) async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = '${dir.path}/myOrder.wav';
      File file = File(path);

      if (!await file.exists()) {
        throw Exception("Le fichier n'existe pas : $path");
      }

      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl${ApiUrl.post_order}'));
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['id_device'] = machine.id;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(ContentType.json);
        return jsonResponse["machineId"];
      } else {
        throw Exception(
            "Erreur lors de l'envoi du fichier : ${response.body}");
      }
    } catch (e) {
      print("Erreur dans postOrder: $e");
      return null;
    }
  }

  Future<List<CoffeeMachine>> connectObject() async {
    List<CoffeeMachine> machines = [];
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');
      final response = await http.get(
        Uri.parse('$baseUrl${ApiUrl.get_machine}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        machines = await CoffeeMachine.fromJson(data);
        return machines;
      } else {
        print("Erreur lors de la connexion de l'objet : ${response.statusCode}");
        return machines;
      }
    } catch (e) {
      print("Erreur dans connectObject: $e");
      return machines;
    }
  }

  Future<bool> createUser(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiUrl.create_user}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": login, "password": password, "lastName": "Jhon", "firstName": "Doe"}),
      );

      return response.statusCode == 201;
    } catch (e) {
      print("Erreur dans createUser: $e");
      return false;
    }
  }

  Future<String?> connectUser(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiUrl.connect_user}'),
        body: jsonEncode({"email": login, "password": password}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse["token"];
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur dans connectUser: $e");
      return null;
    }
  }
}