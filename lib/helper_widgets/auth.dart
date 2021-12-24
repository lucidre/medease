import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:medease/helper_widgets/constants.dart';
import 'package:medease/user_model.dart';

Future<String> signUp({
  required String firstName,
  required String lastName,
  required String registrationNumber,
  required String password,
}) async {
  try {
    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "registrationNumber": registrationNumber
    };
    Response response = await http.post(
      Constants.getAuthUri("users"),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    var decode = jsonDecode(response.body);

    if (decode['status'] == 'success' && response.statusCode == 201) {
      return '--';
    } else {
      return decode['message'];
    }

    // decode = decode['errors'][0]['head'];
/*    print(decode);
    if (decode == 'Class:CustomerRepository->createCustomer; emailExist returned exist = exist') {
      return 'email already exist';
    } else if (decode ==
        "Class:CustomerRepository->createCustomer; phoneExist returned 'exist' = exist") {
      return "phone number exist";
    } else {
      return true;
    }*/

  } on SocketException {
    return 'No internet connection.';
  } catch (e) {
    return e.toString();
  }
}

Future<String> login(
    {required String registration, required String password}) async {
  var body = {"registrationNumber": registration, "password": password};
  try {
    var response = await http.post(
      Constants.getAuthUri('users/auth'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    var decode = jsonDecode(response.body);

    if (decode['status'] == 'success' && response.statusCode == 200) {
      var userData = decode['data']['user'];
      final userId = userData['_id'];
      final registrationNumber = userData['registrationNumber'];
      final firstName = userData['firstName'];
      final lastName = userData['lastName'];
      final xAuth = decode['data']['token'];

      await UserPref.setUserLoggedInStatus(
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          registrationNo: registrationNumber,
          xAuth: xAuth);
      //log in successful
      return '--';
    } else if (decode['status'] == 'Invalid password') {
      //login error
      return 'Password is invalid please check for errors';
    } else {
      //other errors
      return decode['message'];
    }
  } on SocketException {
    return 'No internet connection';
  } catch (e) {
    return e.toString();
  }
}

Future logOut() async {
  await UserPref.setUserLoggedInStatus(
      userId: '', firstName: '', lastName: '', registrationNo: '', xAuth: '');
}

Future<String> resetPassword({required String newPassword}) async {
  var body = {"password": newPassword};
  try {
    var response = await http.post(
      Uri.parse('http://localhost:3000/users/resetpassword'),
      body: jsonEncode(body),
      headers: {
        'x-auth':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjE2MjMzMTYiLCJyZWdObyI6IjEyMzQiLCJlbWFpbCI6ImhhbW1lZG93b2xhYmkyMDAxQGdtYWlsLmNvbSIsImlhdCI6MTYzOTA0MTc0OX0.fkYaO9EAOZVCNkyiloKoAEEZiRP79gKQ1WvLjm4oyek'
      },
    );

    var decode = jsonDecode(response.body);
    return decode['status'];
    //log in user again

  } on SocketException {
    return 'No internet connection';
  } catch (e) {
    return e.toString();
  }
}

Future<Map<String, Object>> stageOneVPStatus() async {
  try {
    var xAuth = UserPref.xAuth;
    var userId = UserPref.userKey;

    var response = await http.get(
      Constants.getAuthUri('users/$userId/stage_one_vp'),
      headers: {'x-auth': xAuth},
    );
/*
{"status":"success","message":"Profile","data":{"profile":{"_id":"61b97c120ef9931ab2aed7ff","status":"in review","comments":[],"user":{"_id":"61b97c120ef9931ab2aed7fd","firstName":"Temitope","lastName":"Oti","registrationNumber":"CSC/2018/149","role":"user"},"__v":0,"passport":"https://res.cloudinary.com/kikks/image/upload/v1640298627/medease/oaomwws712e2u3mkihf9.png","clearance_certificate":"https://res.cloudinary.com/kikks/image/upload/v1640298627/medease/oaomwws712e2u3mkihf9.png"}}}
 {"status":"success","message":"Profile","data":{"profile":{"_id":"61b9d2af8b3dcc8645211dc2","status":"declined","comments":["Are you kidding me? Fifa??!!! as your passport????","Select a clearer passport picture"],"user":{"_id":"61b9d2af8b3dcc8645211dc0","firstName":"Samuel","lastName":"Olufemi","registrationNumber":"CSC/2018/135","role":"user"},"__v":0,"clearance_certificate":"https://via.placeholder.com/728x90.png?text=Clearance+certificate","health_center_bio_data":"https://via.placeholder.com/728x90.png?text=Health+center+Biodata","passport":"https://res.cloudinary.com/kikks/image/upload/v1639873249/medease/cgqswkec6btbuig7uzei.jpg"}}}

in review, declined , incomplete , complete
 */

    var decode = jsonDecode(response.body);

    if (decode['status'] == 'success') {
      var body = decode['data']['profile'];
      var comments = (body['comments']) ?? [];
      var status = body['status'] ?? "incomplete";
      var clearanceCertificate = body['clearance_certificate'] ?? "";
      var passport = body['passport'] ?? "";
      var healthCenterBioData = body['health_center_bio_data'] ?? "";

      return {
        'error': '',
        'comments': comments,
        'status': status,
        'clearanceCertificate': clearanceCertificate,
        'passport': passport,
        'healthCenterBioData': healthCenterBioData
      };
    } else {
      return {'error': decode['message']};
    }
  } on SocketException {
    return {'error': 'no internet connection'};
  } catch (e) {
    return {'error': e.toString()};
  }
}

Future<String> uploadDocument(
    {required String passport,
    required String clearanceCertificate,
    required String healthCenterBioData}) async {
  try {
    var xAuth = UserPref.xAuth;
    var userId = UserPref.userKey;

    var body = {
      'passport': passport,
      "health_center_bio_data": healthCenterBioData,
      "clearance_certificate": clearanceCertificate,
    };
    var response = await http.post(
        Constants.getAuthUri('users/$userId/stage_one_vp/submit'),
        headers: {'x-auth': xAuth},
        body: body);

    var decode = jsonDecode(response.body);

    return decode['message'];
  } on SocketException {
    return 'no internet connection';
  } catch (e) {
    return e.toString();
  }
}
