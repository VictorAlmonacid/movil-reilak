// To parse this JSON data, do
//
//     final membersChatResponse = membersChatResponseFromJson(jsonString);

import 'dart:convert';

MembersChatResponse membersChatResponseFromJson(String str) => MembersChatResponse.fromJson(json.decode(str));

String membersChatResponseToJson(MembersChatResponse data) => json.encode(data.toJson());

class MembersChatResponse {
    MembersChatResponse({
        required this.ok,
        required this.miembros,
    });

    bool ok;
    List<Miembro> miembros;

    factory MembersChatResponse.fromJson(Map<String, dynamic> json) => MembersChatResponse(
        ok: json["ok"],
        miembros: List<Miembro>.from(json["miembros"].map((x) => Miembro.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "miembros": List<dynamic>.from(miembros.map((x) => x.toJson())),
    };
}

class Miembro {
    Miembro({
        required this.id,
        required this.admin,
        required this.name,
        required this.segundoNombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.imgusuario,
        required this.idusuario,
        required this.online,
    });

    String id;
    List<String> admin;
    String name;
    String segundoNombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String imgusuario;
    String idusuario;
    bool online;

    factory Miembro.fromJson(Map<String, dynamic> json) => Miembro(
        id: json["_id"],
        admin: List<String>.from(json["admin"].map((x) => x)),
        name: json["name"],
        segundoNombre: json["segundoNombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        imgusuario: json["imgusuario"],
        idusuario: json["idusuario"],
        online: json["online"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "admin": List<dynamic>.from(admin.map((x) => x)),
        "name": name,
        "segundoNombre": segundoNombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "imgusuario": imgusuario,
        "idusuario": idusuario,
        "online": online,
    };
}
