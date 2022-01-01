import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../user_model.dart';
import 'constants.dart';

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
      headers: {'x-auth': UserPref.xAuth, 'Content-Type': 'application/json'},
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

Future<Map<String, Object>> stageOneVPStatus(BuildContext context) async {
  try {
    var xAuth = UserPref.xAuth;
    var userId = UserPref.userKey;

    var response = await http.get(
      Constants.getAuthUri('users/$userId/stage_one_vp'),
      headers: {'x-auth': xAuth},
    );

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

Future<Map<String, Object>> stageTwoVPStatus(BuildContext context) async {
  try {
    var xAuth = UserPref.xAuth;
    var userId = UserPref.userKey;

    var response = await http.get(
      Constants.getAuthUri('users/$userId/stage_two_vp'),
      headers: {'x-auth': xAuth},
    );

    var decode = jsonDecode(response.body);

    if (decode['status'] == 'success') {
      var body = decode['data']['profile'];
      var comments = (body['comments']) ?? [];
      var status = body['status'] ?? "incomplete";

      var eyeTest = body['eye_test_result'] ?? "";
      var ecgTest = body['ecg_test_result'] ?? "";
      var urineTest = body['urine_test_result'] ?? "";
      var haematologyTest = body['hermatology_test_result'] ?? "";

      return {
        'error': '',
        'comments': comments,
        'status': status,
        'eye_test_result': eyeTest,
        'ecg_test_result': ecgTest,
        'urine_test_result': urineTest,
        'hermatology_test_result': haematologyTest
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

Future<String> uploadDocument1(
    {required String passport,
    required String clearanceCertificate,
    required String healthCenterBioData,
    required BuildContext context}) async {
  try {
    var xAuth = UserPref.xAuth;
    var userId = UserPref.userKey;

    var body = {
      "passport": passport,
      "health_center_bio_data": healthCenterBioData,
      "clearance_certificate": clearanceCertificate,
    };

    var response = await http.put(
        Constants.getAuthUri('users/$userId/stage_one_vp'),
        headers: {'x-auth': xAuth, 'Content-Type': 'application/json'},
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      await http.post(Constants.getAuthUri('users/$userId/stage_one_vp/submit'),
          headers: {'x-auth': xAuth});

      return "success";
    } else {
      return 'Error in uploading files';
    }
  } on SocketException {
    return 'no internet connection';
  } catch (e) {
    return e.toString();
  }
}

Future<String> uploadDocument2(
    {required String eyeTest,
    required String ecgTest,
    required String urineTest,
    required BuildContext context,
    required String haematologyTest}) async {
  try {
    var xAuth = UserPref.xAuth;
    var userId = UserPref.userKey;

    var body = {
      'eye_test_result': eyeTest,
      'ecg_test_result': ecgTest,
      "urine_test_result": urineTest,
      "hermatology_test_result": haematologyTest,
    };

    var response = await http.put(
        Constants.getAuthUri('users/$userId/stage_two_vp'),
        headers: {'x-auth': xAuth, 'Content-Type': 'application/json'},
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      await http.post(Constants.getAuthUri('users/$userId/stage_two_vp/submit'),
          headers: {'x-auth': xAuth});

      return "success";
    } else {
      return 'Error in uploading files';
    }
  } on SocketException {
    return 'no internet connection';
  } catch (e) {
    return e.toString();
  }
}

/*
   await showDialog(
          context: context,
          builder: (ctx) {
            return Container(
              padding: const EdgeInsets.all(15),
              child: Material(
                child: Text(
                  ''
                  'Body is ${body.toString()}'
                  '\n\n'
                  'x-auth  is ${xAuth}'
                  '\n\n'
                  'user id   is ${userId}'
                  '\n\n'
                  'responce   is ${summitResponse.body}',
                ),
              ),
            );
          });
 */
