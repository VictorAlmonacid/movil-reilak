import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:reilak_app/global/environment.dart';
import 'package:reilak_app/models/user_response.dart';
import 'package:reilak_app/services/auth_service.dart';

class ChatUsersService extends ChangeNotifier {
  Usuario? usuarioSeleccionado;

    Future<List<Usuario>> getUsers() async {
    final uri = Uri.parse('${Environment.apiUrl}/user');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final userResponse = userResponseFromJson(resp.body);
    return userResponse.usuario;
  }
}