import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import "package:jumuiya_app/Helpers/api_URL.dart";
import 'package:jumuiya_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<String?> getToken() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.testPost);
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
      return '';
    }
  }

  static Future<UserModel?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUsers);
      var u = Uri.parse("https://jsonplaceholder.typicode.com/users");

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwt_token');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Cookie" : 'jwt=$token'
        },
      );
      if (response.statusCode == 200) {
          print(response.body.toString());
          UserModel model = UserModel.fromJson(json.decode(response.body));
          return model;
      }
    } catch (e) {
      print('oi');
      log(e.toString());
    }

  }

  Future<Object?> registerUser(Map<String, dynamic> userDetail) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.regUsers);
      var jsonBody = json.encode(userDetail);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonBody);

      var body = json.decode(response.body);
      print(body.toString());


      if(response.statusCode == 200){
        return 'true';
      }else{
        return  'false';
      }

    } catch (e) {
      log(e.toString());
      return 'System Error';
    }

  }

  Future<Object?> sendContribution(Map<String, dynamic> trxData) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.testPost);
      var jsonBody = json.encode(trxData);
      var response = await http.post(url, headers: {"Content-Type": "application/json"},
          body: jsonBody);

      print(response.body);

      return response;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<Object> logInRequest(String username, String password) async {
    try {

      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginUser);

      var formData   =  json.encode({
        'email' : username,
        'password' : password
      });

      var response = await http.post(url,headers: {"Content-Type": "application/json"}, body:  formData);

      if (response.statusCode == 200) {
        final body =  json.decode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // Save an token strings key.
        await prefs.setString('jwt_token', body['jwt']);

        return true;
      } else {
        final body = json.decode(response.body);
        return body['detail'];
      }

    } catch (e) {
      log(e.toString());
      return 'System Error : Please try again';
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    return token != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token');
  }


}
