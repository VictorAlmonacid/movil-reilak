// To parse this JSON data, do
//
//     final calendarResponse = calendarResponseFromJson(jsonString);

import 'dart:convert';

CalendarResponse calendarResponseFromJson(String str) => CalendarResponse.fromJson(json.decode(str));

String calendarResponseToJson(CalendarResponse data) => json.encode(data.toJson());

class CalendarResponse {
    CalendarResponse({
        required this.ok,
        required this.eventos,
    });

    bool ok;
    List<Evento> eventos;

    factory CalendarResponse.fromJson(Map<String, dynamic> json) => CalendarResponse(
        ok: json["ok"],
        eventos: List<Evento>.from(json["eventos"].map((x) => Evento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "eventos": List<dynamic>.from(eventos.map((x) => x.toJson())),
    };
}

class Evento {
    Evento({
      this.reunion,
        required this.titulo,
        required this.descripcion,
        required this.start,
        required this.end,
        required this.tipo,
        required this.fecha,
        required this.usuario,
        required this.id,
    });

    List<String>? reunion;
    String titulo;
    String descripcion;
    DateTime start;
    DateTime end;
    String tipo;
    DateTime fecha;
    String usuario;
    String id;

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        reunion: List<String>.from(json["reunion"].map((x) => x)),
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        tipo: json["tipo"],
        fecha: DateTime.parse(json["fecha"]),
        usuario: json["usuario"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "reunion": List<dynamic>.from(reunion!.map((x) => x)),
        "titulo": titulo,
        "descripcion": descripcion,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "tipo": tipo,
        "fecha": fecha.toIso8601String(),
        "usuario": usuario,
        "id": id,
    };
}
