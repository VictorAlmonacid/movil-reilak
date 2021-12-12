
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:reilak_app/global/environment.dart';
import 'package:reilak_app/models/calendar_response.dart';
import 'package:reilak_app/services/auth_service.dart';

class CalendarService extends ChangeNotifier {


    Future<List<Evento>> getEvents() async {
    final uri = Uri.parse('${Environment.apiUrl}/event');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final eventResponse = calendarResponseFromJson(resp.body);
    return eventResponse.eventos;
  }
}