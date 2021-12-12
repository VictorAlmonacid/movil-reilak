import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/global/environment.dart';
import 'package:reilak_app/models/post_response.dart';
import 'package:reilak_app/models/user.dart';
import 'package:reilak_app/services/auth_service.dart';

class PostService with ChangeNotifier {
  
  final List<Publicacione> posts = [];
  final _storage = FlutterSecureStorage();
  Future<List<Publicacione>> getPosts() async {
    final uri = Uri.parse('${Environment.apiUrl}/posts');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final postResponse = postResponseFromJson(resp.body);
    return postResponse.publicaciones;
  }

  Future<bool> reaction(uid) async {
    // notifyListeners();
    final usuario = AuthService().usuario;
    final token = await this._storage.read(key: 'token');
    print(jsonEncode(uid));
    final data = uid;
    final usu = usuario?.uid;
    final uri = Uri.parse('${Environment.apiUrl}/posts/reaccion/${uid}');
    final resp = await http.put(
      uri,
      body: '',
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      },
    );
    print(resp.body);

    // getPosts();

    // if (resp.statusCode == 200) {
    //   final loginResponse = loginResponseFromJson(resp.body);
    //   this.usuario = loginResponse;
    //   _guardarToken(loginResponse.token);
    //   return true;
    // } else {
    //   return false;
    // }
    //  notifyListeners();
    return true;
  }
}
