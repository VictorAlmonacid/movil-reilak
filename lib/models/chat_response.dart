// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromJson(jsonString);

import 'dart:convert';

ChatResponse chatResponseFromJson(String str) => ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
    ChatResponse({
        required this.ok,
        required this.chat,
    });

    bool ok;
    List<Chat> chat;

    factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
        ok: json["ok"],
        chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
    };
}

class Chat {
    Chat({
        required this.user,
        required this.members,
        this.admin,
        this.lastmessage,
        this.name,
        this.img,
        this.descripcion,
        this.privacidad,
       this.tipo,
        required this.fecha,
        required this.id,
    });

    List<User> user;
    List<String> members;
    List<String>? admin;
    List<Lastmessage>? lastmessage;
    String? name;
    String? img;
    String? descripcion;
    String? privacidad;
    String? tipo;
    DateTime fecha;
    String id;

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        members: List<String>.from(json["members"].map((x) => x)),
        admin: List<String>.from(json["admin"].map((x) => x)),
        lastmessage: List<Lastmessage>.from(json["lastmessage"].map((x) => Lastmessage.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
        img: json["img"] == null ? null : json["img"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        privacidad: json["privacidad"] == null ? null : json["privacidad"],
        tipo: json["tipo"],
        fecha: DateTime.parse(json["fecha"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
        "members": List<dynamic>.from(members.map((x) => x)),
        "admin": List<dynamic>.from(admin!.map((x) => x)),
        "lastmessage": List<dynamic>.from(lastmessage!.map((x) => x.toJson())),
        "name": name == null ? null : name,
        "img": img == null ? null : img,
        "descripcion": descripcion == null ? null : descripcion,
        "privacidad": privacidad == null ? null : privacidad,
        "tipo": tipo,
        "fecha": fecha.toIso8601String(),
        "id": id,
    };
}

class Lastmessage {
    Lastmessage({
        required this.id,
        required this.from,
        required this.to,
        required this.message,
        required this.viewedby,
        required this.fecha,
        required this.v,
    });

    String id;
    String from;
    String to;
    String message;
    List<Viewedby> viewedby;
    DateTime fecha;
    int v;

    factory Lastmessage.fromJson(Map<String, dynamic> json) => Lastmessage(
        id: json["_id"],
        from: json["from"],
        to: json["to"],
        message: json["message"],
        viewedby: List<Viewedby>.from(json["viewedby"].map((x) => Viewedby.fromJson(x))),
        fecha: DateTime.parse(json["fecha"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "from": from,
        "to": to,
        "message": message,
        "viewedby": List<dynamic>.from(viewedby.map((x) => x.toJson())),
        "fecha": fecha.toIso8601String(),
        "__v": v,
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

class User {
    User({
        required this.permisos,
        required this.empresa,
        required this.estado,
        required this.online,
        required this.theme,
        required this.id,
        required this.name,
        required this.email,
        required this.password,
        required this.v,
        required this.apellidoMaterno,
        required this.apellidoPaterno,
        required this.area,
        required this.cargo,
        required this.emailp,
        required this.fono,
        required this.nacimiento,
        required this.rol,
        required this.rut,
        required this.segundoNombre,
        required this.imgusuario,
        required this.edad,
        required this.ingreso,
    });

    List<String> permisos;
    String empresa;
    String estado;
    bool online;
    String theme;
    String id;
    String name;
    String email;
    String password;
    int v;
    String apellidoMaterno;
    String apellidoPaterno;
    String area;
    String cargo;
    String emailp;
    String fono;
    DateTime nacimiento;
    String rol;
    String rut;
    String segundoNombre;
    String imgusuario;
    String edad;
    DateTime ingreso;

    factory User.fromJson(Map<String, dynamic> json) => User(
        permisos: List<String>.from(json["permisos"].map((x) => x)),
        empresa: json["empresa"],
        estado: json["estado"],
        online: json["online"],
        theme: json["theme"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
        apellidoMaterno: json["apellidoMaterno"],
        apellidoPaterno: json["apellidoPaterno"],
        area: json["area"],
        cargo: json["cargo"],
        emailp: json["emailp"],
        fono: json["fono"],
        nacimiento: DateTime.parse(json["nacimiento"]),
        rol: json["rol"],
        rut: json["rut"],
        segundoNombre: json["segundoNombre"],
        imgusuario: json["imgusuario"],
        edad: json["edad"],
        ingreso: DateTime.parse(json["ingreso"]),
    );

    Map<String, dynamic> toJson() => {
        "permisos": List<dynamic>.from(permisos.map((x) => x)),
        "empresa": empresa,
        "estado": estado,
        "online": online,
        "theme": theme,
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "__v": v,
        "apellidoMaterno": apellidoMaterno,
        "apellidoPaterno": apellidoPaterno,
        "area": area,
        "cargo": cargo,
        "emailp": emailp,
        "fono": fono,
        "nacimiento": nacimiento.toIso8601String(),
        "rol": rol,
        "rut": rut,
        "segundoNombre": segundoNombre,
        "imgusuario": imgusuario,
        "edad": edad,
        "ingreso": ingreso.toIso8601String(),
    };
}
