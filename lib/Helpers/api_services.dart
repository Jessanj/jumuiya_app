import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import "package:jumuiya_app/Helpers/api_URL.dart";
import 'package:jumuiya_app/models/event.dart';
import 'package:jumuiya_app/models/group.dart';
import 'package:jumuiya_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/attendance.dart';

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

 static Future<List<UserModel>> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUsers);
      var u = Uri.parse("https://jsonplaceholder.typicode.com/albums");

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwt_token');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Cookie" : 'jwt=$token'
        },
      );
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        print(jsonResponse);
        return jsonResponse.map((data) => UserModel.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected error occured!');
      }


    } catch (e) {
      print('oi');
      log(e.toString());
      throw Exception('Failed to load users');
    }

  }

  static Future registerUser(Map<String, dynamic> userDetail) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.regUsers);
      var jsonBody = json.encode(userDetail);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonBody);

      var body = json.decode(response.body);

      if(response.statusCode == 200){
        return body;
      }else{
        return body;
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
        'phone' : username,
        'password' : password
      });

      var response = await http.post(url,headers: {"Content-Type": "application/json"}, body:  formData);

      if (response.statusCode == 200) {
        final body =  json.decode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        // Save an token strings key.
        print(body['user']['id'].toString() + " id fetch");
        await prefs.setString('jwt_token', body['jwt']);
        await prefs.setInt('userId', body['user']['id']);

        print(prefs.getInt('userId').toString());

        return true;

      } else {
        final body = json.decode(response.body);
        return body['detail'];
      }

    } catch (e) {
      log(e.toString());
      if(e.toString() == 'Connection time out'){
        return 'Connection time out';
      }
      return 'System Error : Please try again';
    }
  }

  static Future<Object> resetPassword(String newPassword) async{
    try {

      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginUser);

      var formData   =  json.encode({
        'new_password' : newPassword
      });

      var response = await http.post(url,headers: {"Content-Type": "application/json"}, body:  formData);

      if (response.statusCode == 200) {
        final body =  json.decode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        // Save an token strings key.
        await prefs.setString('jwt_token', body['jwt']);
        await prefs.setInt('userId', body['user']['id']);

        return true;

      } else {
        final body = json.decode(response.body);
        return body['detail'];
      }

    } catch (e) {
      log(e.toString());
      if(e.toString() == 'Connection time out'){
        return 'Connection time out';
      }
      return 'System Error : Please try again';
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    return token != null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token');
  }

  static Future<Object?> addEvent(eventDetail) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.addEvent);
      var jsonBody = json.encode(eventDetail);
      print(jsonBody);
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

  static Future<List<Event>> getEvents() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getEvent);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwt_token');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Cookie" : 'jwt=$token'
        },
      );
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        // print(jsonResponse);

        return jsonResponse.map((data) => Event.fromJson(data)).toList();

      } else {
        throw Exception('Unexpected error occured!');
      }

    } catch (e) {

      throw Exception('Failed to load events');
    }

  }

  static  getUserGroup(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUserGroup+ id.toString());
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Cookie" : 'jwt=$token'
        },
      );

      if (response.statusCode == 200) {

        var jsonResponse = json.decode(response.body);
        if(response.body.isEmpty){
          await prefs.setString('jumuiya_detail', jsonResponse.toString());
          return jsonResponse.map((data) => Group.fromJson(data)).toList();
         }else{
           return 'no_group';
          // return Group(id: 0, group_name: 'null', group_number: 'null', created_at: 'null', created_by: 0, updated_at: 'null');
        }


      }else{
        return 'failed';
      }
    } catch(e) {
      print(e);
      throw Exception('Failed to load groups');
    }

  }

  static Future<Object> SaveGroup(groupDetail) async {

    try {
      final prefs = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.saveGroup);
      var jsonBody = jsonEncode(groupDetail);
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Cookie" : 'jwt=$token'
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {

        var jsonResponse = json.decode(response.body);
        await prefs.setString('jumuiya_detail', jsonResponse.toString());
        print(jsonResponse);
        return true;

      } else {
        return false;
      }
    } catch(e) {
      throw Exception(e);
    }

  }

  static Future getPublicGroups() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getGroups);
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Cookie" : 'jwt=$token'
        },
      );
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        var returnBody = jsonResponse.map((data) => Group.fromJson(data)).toList();
        return  returnBody;
      } else {
        return  'failed';

      }
    } catch(e) {
      print('we fail before get body');
      throw Exception(e);
    }

  }

  static Future getSearchGroup(String groupNo) async {
    try{
      print('get 1');
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.searchGroup}$groupNo');
      print(url);
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Cookie" : 'jwt=$token'
        },
      );


      if(response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        var groupJson = Group.fromJson(jsonResponse);
        return groupJson;
      }
      else if(response.statusCode == 403){

        return  'data_not_found';
      }else{
        return 'failed';
      }
    } catch(e) {

      return Exception(e);
    }
  }

  static Future joinGroup(String userID , int groupId) async {
     try {
       final url = Uri.parse('${ApiConstants.baseUrl}/group/$groupId${ApiConstants.joinGroup}');
       final jsonBody = jsonEncode({
         'user_id' : userID,
       });
       var response = await http.post(
         url,
         headers: {
           "Content-Type": "application/json",
           // "Cookie" : 'jwt=$token'
         },
         body: jsonBody
       );

       final jsonResponse = json.decode(response.body);

       if(response.statusCode == 200){
          return jsonResponse;
       }else{
          return 'failed';
       }

     } catch (e){
       return Exception(e);
     }
  }

  static Future<List<UserModel>> getGroupMembers (int groupID) async {

    try {
      // final url = Uri.parse('${ApiConstants.baseUrl}/group/$groupID${ApiConstants.joinGroup}');
      final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUsers);
      var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            // "Cookie" : 'jwt=$token'
          },
      );

      final jsonResponse = json.decode(response.body);
      if(response.statusCode == 200){
        return jsonResponse.map((data) => UserModel.fromJson(data)).toList();
      }else{
        throw Exception('Unexpected error occured!');
      }

    } catch (e){
      throw Exception(e);
    }
  }

  static Future addAttendance(attendance) async {
    try {
      final url = Uri.parse(ApiConstants.baseUrl+ApiConstants.addAttendance);
      var response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            // "Cookie" : 'jwt=$token'
          },
          body: attendance
      );
      print(attendance);
      print('add_attendance sent');

      final jsonResponse = json.decode(response.body);

      if(response.statusCode == 200){
        return jsonResponse;
      }else{
        return 'failed';
      }

    } catch (e){
      return Exception(e);
    }
  }

  static Future getAttendance(event_id) async {
    try {
      final url = Uri.parse(ApiConstants.baseUrl+ApiConstants.getAttendance+'2'+'/'+event_id);

      print(url);
      var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            // "Cookie" : 'jwt=$token'
          },
      );

      // print(response.body.toString());

      final jsonResponse = json.decode(response.body);

      // print(jsonResponse);

      if(response.statusCode == 200){
        return jsonResponse;
      }else{
        return 'failed';
      }

    } catch (e){
      return Exception(e);
    }
  }

  static Future getMonthEvent() async {
    try {
      final url = Uri.parse(ApiConstants.baseUrl+ApiConstants.getMonthEvents);

      print(url);
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Cookie" : 'jwt=$token'
        },
      );

      final jsonResponse = json.decode(response.body);

      if(response.statusCode == 200){
        return jsonResponse;
      }else{
        return 'failed';
      }

    } catch (e){
      return Exception(e);
    }
  }

  static Future getUser(user_id) async {
    try {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUser + user_id.toString());
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        // "Cookie" : 'jwt=$token'
      },
    );
    print(response);
    final jsonResponse = json.decode(response.body);

    if(response.statusCode == 200){
      return jsonResponse;
    }else{
      return 'failed';
    }

    } catch (e){
      return Exception(e);
    }

  }

  static Future updateUser(Map<String, dynamic> userDetail) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.updateUser);
      var jsonBody = json.encode(userDetail);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonBody);

      var body = json.decode(response.body);

      print(body);

      if(response.statusCode == 200){
        return true;;
      }else{
        return false;
      }

    } catch (e) {
      log(e.toString());
      return 'System Error';
    }

  }

  // Future<void> uploadImageToApi() async {
  //   final pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile == null) {
  //     return; // User canceled or failed to pick image
  //   }
  //
  //   final bytes = await pickedFile.readAsBytes();
  //
  //   // Prepare image data (e.g., resize, compress)
  //
  //   final uri = Uri.parse('https://your-api-endpoint');
  //   final request = http.MultipartRequest('POST', uri);
  //   request.fields['description'] = 'My picture';
  //   request.files.add(
  //     http.MultipartFile.fromBytes('image', bytes, filename: 'image.jpg'),
  //   );
  //
  //   final response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully!');
  //   } else {
  //     print('Error uploading image: ${response.statusCode}');
  //   }
  // }






}
