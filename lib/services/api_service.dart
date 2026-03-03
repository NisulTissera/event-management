import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class ApiService {

  static const String baseUrl =
      "https://69a2f04fbe843d692bd28e27.mockapi.io/login";
  static Future<bool> login(String userName, String password) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List users = jsonDecode(response.body);

        final user = users.firstWhere(
              (u) =>
          u["userName"] == userName &&
              u["password"] == password,
          orElse: () => null,
        );

        return user != null;
      } else {
        return false;
      }
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  // ================= SIGN UP =================
  static Future<bool> signUp(String userName, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userName": userName,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        return true; // Created successfully
      } else {
        return false;
      }
    } catch (e) {
      print("Signup Error: $e");
      return false;
    }
  }

  // ================= FETCH EVENTS =================
  static Future<List<Event>> fetchEvents() async {
    try {
      final response = await http.get(
        Uri.parse("https://69a31bdbbe843d692bd2f79c.mockapi.io/events"),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load events");
      }
    } catch (e) {
      print("Fetch Events Error: $e");
      throw Exception("Error loading events");
    }
  }
}