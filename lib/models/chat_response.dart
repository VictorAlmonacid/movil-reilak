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
        required this.fecha,
        required this.tipo,
        required this.id,
        this.name,
        this.img,
        this.descripcion,
        this.privacidad,
    });

    List<User> user;
    List<String> members;
    List<String>? admin;
    List<Lastmessage>? lastmessage;
    DateTime fecha;
    String tipo;
    String id;
    String? name;
    String? img;
    String? descripcion;
    String? privacidad;

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        members: List<String>.from(json["members"].map((x) => x)),
        admin: List<String>.from(json["admin"].map((x) => x)),
        lastmessage: List<Lastmessage>.from(json["lastmessage"].map((x) => Lastmessage.fromJson(x))),
        fecha: DateTime.parse(json["fecha"]),
        tipo: json["tipo"],
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
        img: json["img"] == null ? null : json["img"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        privacidad: json["privacidad"] == null ? null : json["privacidad"],
    );

    Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
        "members": List<dynamic>.from(members.map((x) => x)),
        "admin": List<dynamic>.from(admin!.map((x) => x)),
        "lastmessage": List<dynamic>.from(lastmessage!.map((x) => x.toJson())),
        "fecha": fecha.toIso8601String(),
        "tipo": tipo,
        "id": id,
        "name": name == null ? null : name,
        "img": img == null ? null : img,
        "descripcion": descripcion == null ? null : descripcion,
        "privacidad": privacidad == null ? null : privacidad,
    };
}

class Lastmessage {
    Lastmessage({
        this.viewedby,
        required this.id,
        required this.from,
        required this.to,
        required this.message,
        required this.fecha,
        required this.v,
    });

    List<String>? viewedby;
    String id;
    String from;
    String to;
    String message;
    DateTime fecha;
    int v;

    factory Lastmessage.fromJson(Map<String, dynamic> json) => Lastmessage(
        viewedby: List<String>.from(json["viewedby"].map((x) => x)),
        id: json["_id"],
        from: json["from"],
        to: json["to"],
        message: json["message"],
        fecha: DateTime.parse(json["fecha"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "viewedby": List<dynamic>.from(viewedby!.map((x) => x)),
        "_id": id,
        "from": from,
        "to": to,
        "message": message,
        "fecha": fecha.toIso8601String(),
        "__v": v,
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
         this.nombre,
        required this.segundoNombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.area,
        required this.cargo,
        required this.fono,
        required this.nacimiento,
        required this.email,
        required this.emailp,
        required this.imgusuario,
        required this.name,
        required this.password,
        required this.rol,
        required this.rut,
        required this.edad,
        required this.ingreso,
    });

    List<String> permisos;
    String empresa;
    String estado;
    bool online;
    String theme;
    String id;
    String? nombre;
    String segundoNombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String area;
    String cargo;
    String fono;
    DateTime nacimiento;
    String email;
    String emailp;
    String imgusuario;
    String name;
    String password;
    String rol;
    String rut;
    String edad;
    DateTime ingreso;

    factory User.fromJson(Map<String, dynamic> json) => User(
        permisos: List<String>.from(json["permisos"].map((x) => x)),
        empresa: json["empresa"],
        estado: json["estado"],
        online: json["online"],
        theme: json["theme"],
        id: json["_id"],
        nombre: json["nombre"],
        segundoNombre: json["segundoNombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        area: json["area"],
        cargo: json["cargo"],
        fono: json["fono"],
        nacimiento: DateTime.parse(json["nacimiento"]),
        email: json["email"],
        emailp: json["emailp"],
        imgusuario: json["imgusuario"],
        name: json["name"],
        password: json["password"],
        rol: json["rol"],
        rut: json["rut"],
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
        "nombre": nombre,
        "segundoNombre": segundoNombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "area": area,
        "cargo": cargo,
        "fono": fono,
        "nacimiento": nacimiento.toIso8601String(),
        "email": email,
        "emailp": emailp,
        "imgusuario": imgusuario,
        "name": name,
        "password": password,
        "rol": rol,
        "rut": rut,
        "edad": edad,
        "ingreso": ingreso.toIso8601String(),
    };
}
