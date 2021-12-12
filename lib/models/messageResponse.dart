// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
    MessageResponse({
        required this.ok,
        required this.message,
    });

    bool ok;
    List<Message> message;

    factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
        ok: json["ok"],
        message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
    };
}

class Message {
    Message({
        required this.id,
        required this.from,
        required this.to,
        required this.message,
        required this.fecha,
        required this.name,
        required this.segundoNombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.imgusuario,
    });

    String id;
    String from;
    String to;
    String message;
    DateTime fecha;
    String name;
    String segundoNombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String imgusuario;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        from: json["from"],
        to: json["to"],
        message: json["message"],
        fecha: DateTime.parse(json["fecha"]),
        name: json["name"],
        segundoNombre: json["segundoNombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        imgusuario: json["imgusuario"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "from": from,
        "to": to,
        "message": message,
        "fecha": fecha.toIso8601String(),
        "name": name,
        "segundoNombre": segundoNombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "imgusuario": imgusuario,
    };
}
