import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reilak_app/global/environment.dart';
import 'package:reilak_app/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
   LoginResponse? usuario;
  bool _autenticado = false;

  final _storage = FlutterSecureStorage();

  bool get getAutenticando => this._autenticado;
  set setAutenticando(bool valor) {
    this._autenticado = valor;
    notifyListeners();
  }

  // getters del token de forma estatica
  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token.toString();
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.setAutenticando = true;
    final data = {'email': email, 'password': password};
    final uri = Uri.parse('${Environment.apiUrl}/auth');
    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.setAutenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse;
      _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final uri = Uri.parse('${Environment.apiUrl}/auth/renew');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': token.toString()
    });

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
