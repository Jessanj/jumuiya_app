import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import "package:jumuiya_app/Helpers/api_URL.dart";
import 'package:jumuiya_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final token = 'MY TOKEN HERE';

  Future<String?> getToken() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getToken);
      var response = await http.get(url);
      final body = json.decode(response.body);
      final header = response.headers.values.first.toString();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save an token strings key.
      await prefs.setString('csrf_token', header.split(';').first);
      await prefs.setString('cookiee', header.split(';').elementAt(2));

      return body['csrf_token'];
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Object?> RegUser(Map<String, dynamic> userDetail) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final csrf_token = prefs.getString('csrf_token');
      final savedCookie = prefs.getString('cookie');

      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.regUsers);
      var jsonBody = JsonEncoder().convert(userDetail);

      var response = await http.post(url,
          // headers: {
          //   'cookie': '$savedCookie',
          //   'X-CSRFToken': '$csrf_token',
          // },
          body: jsonBody);

      print(response.body);

      return response.body;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Object?> SendContribution(Map<String, dynamic> trxData) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final csrf_token = prefs.getString('csrf_token');
      final savedCookie = prefs.getString('cookie');
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.testPost);
      var jsonBody = JsonEncoder().convert(trxData);
      var response = await http.post(url,
          headers: {
            'cookie': '$savedCookie',
            'X-CSRFToken': '$csrf_token',
          },
          body: jsonBody);

      print(response.body);

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Object?> LoginRequest(Map<String, dynamic> formData) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final csrf_token = prefs.getString('csrf_token');
      final savedCookie = prefs.getString('cookie');
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.testPost);
      var jsonBody = JsonEncoder().convert(formData);
      var response = await http.post(url,
          headers: {
            'cookie': '$savedCookie',
            'X-CSRFToken': '$csrf_token',
          },
          body: jsonBody);

      print(response.body);

      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
