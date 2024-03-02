import 'dart:convert';

import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/src/auth/data/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';

abstract class AuthenticationRemoteSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUser();
}

//var createNewUserEndpoint = 'https://65bcd326b51f9b29e9325b60.mockapi.io/test-users/users';
var getUserEndpoint = '/test-users/users';

var createNewUserEndpoint = '/test-users/users';

class AuthenticationRemoteSourceImpl implements AuthenticationRemoteSource {
  final http.Client _httpClient;

  AuthenticationRemoteSourceImpl(this._httpClient);

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _httpClient.post(
          Uri.parse('https://$kBaseUrl$createNewUserEndpoint'),
          body: jsonEncode(
              {'createdAt': createdAt, 'name': name, 'avatar': avatar}));
        print('1 : $kBaseUrl$createNewUserEndpoint');
      if (response.statusCode != 200 && response.statusCode != 202) {
        print('2 : $kBaseUrl$createNewUserEndpoint');
        throw ServerExceptions(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ServerExceptions {
      print('3 : $kBaseUrl$createNewUserEndpoint');
      rethrow;
    } catch (e) {
      print('4 : $kBaseUrl$createNewUserEndpoint');
      throw ServerExceptions(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    try{
      final response =
      await _httpClient.get(Uri.https(kBaseUrl, getUserEndpoint));

      print('KbaseUrl : $kBaseUrl$getUserEndpoint');

      if(response.statusCode!=200){
        throw ServerExceptions(message: response.body, statusCode: response.statusCode);
    }

      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();

    }on ServerExceptions {
      rethrow;
    } catch (e) {
      throw ServerExceptions(message: e.toString(), statusCode: 505);
    }

  }
}
