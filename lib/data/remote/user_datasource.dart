import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class UserDatasource {
  Future<SBUser?> login(String email, String pw);
}

@Injectable(as: UserDatasource)
class UserDatasourceImpl implements UserDatasource {
  late Dio dio;

  UserDatasourceImpl() {
    dio = Dio();

    dio.options.baseUrl =
        'https://my-json-server.typicode.com/vborbely/SimuBank';
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors
        .add(LogInterceptor(responseBody: true, responseHeader: true));
  }

  @override
  Future<SBUser?> login(String email, String pw) async {
    if (email == 'test@example.com' && pw == 'password1234') {
      final response = await dio.get('/users');
      debugPrint('__DS__, response: $response');
      List users = response.data;
      Map firstUserData = users[0];
      return SBUser.fromJson(firstUserData);
    } else {
      throw BadCredentialsException();
    }
  }
}

class BadCredentialsException implements Exception {}

class SBUser {
  final int id;
  final String email;
  final String name;
  final String avatarUrl;

  SBUser(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatarUrl});

  factory SBUser.fromJson(Map data) {
    return SBUser(
      id: data['id'],
      email: data['email'],
      name: data['name'],
      avatarUrl: data['profile_picture'],
    );
  }
}
