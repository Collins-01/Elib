import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:elib/feature/dashboard/screens/dashboard.dart';
import 'package:elib/feature/onboarding/screens/sign_in/sign_in.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/keys.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:elib/helpers/util_helpers.dart';

final authServicesProvider = Provider<AuthServices>((ref) => AuthServices());

class AuthServices {
  Dio myDio = Dio();
  String baseUrl = ConstantKey.BASE_URL_LIVE;

  Future signUp(data, context) async {
    try {
      var url = Uri.parse('$baseUrl/auth/signup');
      var response = await http.post(url, body: data);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = response.body;

        final decoded = jsonDecode(response.body);
        print('Response body decoded: ${decoded['status']}');

        final msg = decoded['message'];
        defaultSnackyBar(context, msg, bluePrimaryColor);
        nextPage(context, (context) => const SignIn());
      } else {
        final decoded = jsonDecode(response.body);
        final msg = decoded['message'];
        defaultSnackyBar(context, msg, dangerColor);
      }

      return response;
    } on SocketException {
      defaultSnackyBar(context, "No Internet connection 😑", dangerColor);
    } on HttpException {
      defaultSnackyBar(context, "Couldn't find the post 😱", dangerColor);
    } on FormatException {
      defaultSnackyBar(context, "Bad response format 👎", dangerColor);
    } catch (e) {
      defaultSnackyBar(context, "An error occured", dangerColor);
    }
  }

  Future signIn(data, context) async {
    final pref = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse('$baseUrl/auth/login');
      var response = await http.post(url, body: data);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = response.body;

        final decoded = jsonDecode(response.body);
        print('Response body decoded: ${decoded['status']}');

        final msg = decoded['message'];
        defaultSnackyBar(context, msg, bluePrimaryColor);
        pref.setString("token", "${decoded['data']['token']}");

        nextPage(context, (context) => const Dashboard());
      } else {
        final decoded = jsonDecode(response.body);
        final msg = decoded['message'];
        defaultSnackyBar(context, msg, dangerColor);
      }

      return response;

      return response;
    } on SocketException {
      defaultSnackyBar(context, "No Internet connection 😑", dangerColor);
    } on HttpException {
      defaultSnackyBar(context, "Couldn't find the post 😱", dangerColor);
    } on FormatException {
      defaultSnackyBar(context, "Bad response format 👎", dangerColor);
    } catch (e) {
      defaultSnackyBar(context, "An error occured", dangerColor);
    }
  }

  Future fetchUserProfile(context) async {
    try {
      var url = Uri.parse('$baseUrl/user/verify-email-token');
      var response = await http.get(url);

      print('Response status: $response');
      // print('Response body: ${response.body}');

      return response;
    } on SocketException {
      defaultSnackyBar(context, "No Internet connection 😑", dangerColor);
    } on HttpException {
      defaultSnackyBar(context, "Couldn't find the post 😱", dangerColor);
    } on FormatException {
      defaultSnackyBar(context, "Bad response format 👎", dangerColor);
    } catch (e) {
      defaultSnackyBar(context, "An error occured", dangerColor);
    }
  }

  Future checkIfAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    // print(frst);
    return {"token": token, "email": email};
  }

  Future logoutUser(context) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.clear();
  }
}
