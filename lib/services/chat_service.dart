import 'package:flutter/cupertino.dart';
import 'package:reilak_app/global/environment.dart';
import 'package:reilak_app/models/chat_response.dart';
import 'package:http/http.dart' as http;
import 'package:reilak_app/models/images_chat_response.dart';
import 'package:reilak_app/models/members_chat.dart';
import 'package:reilak_app/models/messageResponse.dart';
import 'package:reilak_app/models/user_response.dart';
import 'package:reilak_app/services/auth_service.dart';

class ChatService extends ChangeNotifier{

  Chat? chatSelecionado;

    Future<List<Chat>> getChats() async {
    final uri = Uri.parse('${Environment.apiUrl}/chat');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final chatResponse = chatResponseFromJson(resp.body);
    return chatResponse.chat;
  }

  Future getChat(String chatId)async{
    final uri = Uri.parse('${Environment.apiUrl}/chat/message/${chatId}');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final messageResp = messageResponseFromJson(resp.body);

    return messageResp.message;
  }

    Future getMembersChat(String chatId)async{
    final uri = Uri.parse('${Environment.apiUrl}/chat/miembros/${chatId}');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final messageResp = membersChatResponseFromJson(resp.body);

    return messageResp.miembros;
  }


      Future getImgChat(String chatId)async{
    final uri = Uri.parse('${Environment.apiUrl}/chat/images/${chatId}');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });
    print('es este: ${resp.body}');

    final messageResp = imagesChatResponseFromJson(resp.body);

    return messageResp.message;
  }

        Future getVideoChat(String chatId)async{
    final uri = Uri.parse('${Environment.apiUrl}/chat/videos/${chatId}');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });
    print('es este: ${resp.body}');

    final messageResp = imagesChatResponseFromJson(resp.body);

    return messageResp.message;
  }

          Future getUsers()async{
    final uri = Uri.parse('${Environment.apiUrl}/user');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });
    print('es este: ${resp.body}');

    final messageResp = userResponseFromJson(resp.body);

    return messageResp.usuario;
  }


}