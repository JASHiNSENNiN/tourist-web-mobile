import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/user.dart';
import 'package:flutter_application_2/providers/user_provider.dart';
import 'package:flutter_application_2/screens/Home/home_screen.dart';
import 'package:flutter_application_2/utilities/constants.dart';
import 'package:flutter_application_2/utilities/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  })async{
    try{
      User user = User(
        id: '', 
        name: name, 
        email: email, 
        password: password, 
        role: 'tourist', 
        token: ''
      );

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: (){
          showSnackBar(
            context, 
            'Account created! Login with the same credentials',
          );
        },
      );
    }catch (e){
      showSnackBar(context, e.toString());
    }
  }

Future<void> signInUser({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    http.Response res = await http.post(
      Uri.parse('${Constants.uri}/api/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userProvider.setUser(res.body);
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}

Future<bool> verifyOtp(String email, String otp) async {
  try {
    final response = await http.post(
      Uri.parse('${Constants.uri}/api/verify-otp'),
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['success']; // Check based on your API response
    } else {
      throw Exception('Failed to verify OTP');
    }
  } catch (e) {
    print('OTP verification error: $e');
    return false;
  }
}



Future<void> sendOtpEmail(String email, String otp) async {
    try {
        final response = await http.post(
          Uri.parse('${Constants.uri}/send-email'), // Replace with your server IP
          body: jsonEncode({
            'to': email,
            'subject': 'Your OTP Code',
            'text': 'Your OTP code is $otp',
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );


        if (response.statusCode != 200) {
            throw Exception('Failed to send OTP email: ${response.body}');
        }
    } catch (e) {
        print('Error in sendOtpEmail: $e');
        throw Exception('Failed to send OTP email');
    }
}

Future<void> resetPassword(String email, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.uri}/api/reset-password'),
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to reset password');
      }
    } catch (e) {
      print('Password reset error: $e');
      // Handle the error appropriately
    }
  }

// Function to retrieve session duration
Future<Duration> getSessionDuration() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? loginTimeString = prefs.getString('loginTime');
  
  if (loginTimeString != null) {
    DateTime loginTime = DateTime.parse(loginTimeString);
    Duration sessionDuration = DateTime.now().difference(loginTime);
    return sessionDuration;
  } else {
    // If no login time is stored, assume no session
    return Duration.zero;
  }
}
}