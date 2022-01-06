// To parse this JSON data, do
//
//     final imagesChatResponse = imagesChatResponseFromJson(jsonString);

import 'dart:convert';

ImagesChatResponse imagesChatResponseFromJson(String str) => ImagesChatResponse.fromJson(json.decode(str));

String imagesChatResponseToJson(ImagesChatResponse data) => json.encode(data.toJson());

class ImagesChatResponse {
    ImagesChatResponse({
        required this.ok,
        required this.message,
    });

    bool ok;
    List<Message> message;

    factory ImagesChatResponse.fromJson(Map<String, dynamic> json) => ImagesChatResponse(
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
        required this.from,
        required this.to,
        required this.message,
        required this.viewedby,
        required this.fecha,
        required this.id,
    });

    String from;
    String to;
    String message;
    List<Viewedby> viewedby;
    DateTime fecha;
    String id;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        viewedby: List<Viewedby>.from(json["viewedby"].map((x) => Viewedby.fromJson(x))),
        fecha: DateTime.parse(json["fecha"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "viewedby": List<dynamic>.from(viewedby.map((x) => x.toJson())),
        "fecha": fecha.toIso8601String(),
        "id": id,
    };
}

class Viewedby {
    Viewedby({
        required this.id,
        required this.fecha,
    });

    String id;
    DateTime fecha;

    factory Viewedby.fromJson(Map<String, dynamic> json) => Viewedby(
        id: json["_id"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fecha": fecha.toIso8601String(),
    };
}
