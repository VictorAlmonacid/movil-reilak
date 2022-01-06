// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    UserResponse({
        required this.ok,
        required this.usuario,
    });

    bool ok;
    List<Usuario> usuario;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        ok: json["ok"],
        usuario: List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())),
    };
}

class Usuario {
    Usuario({
        required this.permisos,
        required this.empresa,
        required this.estado,
        required this.online,
        required this.theme,
        required this.name,
        required this.email,
        required this.password,
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
        this.edad,
        required this.ingreso,
        required this.id,
    });

    List<String> permisos;
    String empresa;
    String estado;
    bool online;
    String theme;
    String name;
    String email;
    String password;
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
    String? edad;
    DateTime ingreso;
    String id;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        permisos: List<String>.from(json["permisos"].map((x) => x)),
        empresa: json["empresa"],
        estado: json["estado"],
        online: json["online"],
        theme: json["theme"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
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
        edad: json["edad"] == null ? null : json["edad"],
        ingreso: DateTime.parse(json["ingreso"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "permisos": List<dynamic>.from(permisos.map((x) => x)),
        "empresa": empresa,
        "estado": estado,
        "online": online,
        "theme": theme,
        "name": name,
        "email": email,
        "password": password,
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
        "edad": edad == null ? null : edad,
        "ingreso": ingreso.toIso8601String(),
        "id": id,
    };
}
