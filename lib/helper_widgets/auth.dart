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

      await UserPref.setUserLoggedInStatus(
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          registrationNo: registrationNumber);
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
      userId: '', firstName: '', lastName: '', registrationNo: '');
}
