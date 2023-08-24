import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import "package:jumuiya_app/Helpers/api_URL.dart";
import 'package:jumuiya_app/models/event.dart';
import 'package:jumuiya_app/models/group.dart';
import 'package:jumuiya_app/models/user.dart';
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

  static Future<Object?> registerUser(Map<String, dynamic> userDetail) async {
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
        print(jsonResponse);
        return jsonResponse.map((data) => Event.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected error occured!');
      }

    } catch (e) {
      print('oi');
      log(e.toString());
      throw Exception('Failed to load users');
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
        await prefs.setString('jumuiya_detail', jsonResponse.toString());
        return jsonResponse.map((data) => Group.fromJson(data)).toList();

      }else{
        return 'false';
      }
    } catch(e) {
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
      print('get body');
      if (response.statusCode == 200) {

        print(response.body);

        // var v  = [
        //   {
        //     "id": 4,
        //     "name": "Coding Club",
        //     "group_type": "Study",
        //     "group_location": "Seattle",
        //     "members": ["Alice", "Bob", "Charlie"],
        //     "description": "This is a group for people who enjoy coding.",
        //     "group_number": "1234567891",
        //     "created_at": "2023-08-17T10:45:00Z",
        //     "created_by": 4,
        //     "updated_at": "2023-08-17T11:00:00Z"
        //   },
        //   {
        //     "id": 5,
        //     "name": "Book Club",
        //     "group_type": "Social",
        //     "group_location": "Chicago",
        //     "members": ["David", "Eve", "Frank"],
        //     "description": "This is a group for people who enjoy reading books.",
        //     "group_number": "9876543211",
        //     "created_at": "2023-08-17T11:15:00Z",
        //     "created_by": 5,
        //     "updated_at": "2023-08-17T11:30:00Z"
        //   },
        //   {
        //     "id": 6,
        //     "name": "Game Night",
        //     "group_type": "Social",
        //     "group_location": "Austin",
        //     "members": ["George", "Henry", "Ian"],
        //     "description": "This is a group for people who enjoy playing games.",
        //     "group_number": "0987654322",
        //     "created_at": "2023-08-17T11:45:00Z",
        //     "created_by": 6,
        //     "updated_at": "2023-08-17T12:00:00Z"
        //   },
        //   {
        //     "id": 7,
        //     "name": "Hiking Club",
        //     "group_type": "Outdoors",
        //     "group_location": "Denver",
        //     "members": ["Jack", "Jill", "John"],
        //     "description": "This is a group for people who enjoy hiking.",
        //     "group_number": "1234567892",
        //     "created_at": "2023-08-17T12:15:00Z",
        //     "created_by": 7,
        //     "updated_at": "2023-08-17T12:30:00Z"
        //   },
        //   {
        //     "id": 8,
        //     "name": "Volunteer Group",
        //     "group_type": "Community",
        //     "group_location": "Miami",
        //     "members": ["Kevin", "Larry", "Mary"],
        //     "description": "This is a group for people who enjoy volunteering.",
        //     "group_number": "9876543212",
        //     "created_at": "2023-08-17T12:45:00Z",
        //     "created_by": 8,
        //     "updated_at": "2023-08-17T13:00:00Z"
        //   }
        // ];

        print(jsonResponse);
        print('hi');
        // List<Group> returnBody = jsonResponse.map((data) => Group.fromJson(data)).cast<Group>();
        var returnBody = jsonResponse.map((data) => Group.fromJson(data)).toList();
        print(returnBody[1].group_name);
        print('print after body');
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


}
