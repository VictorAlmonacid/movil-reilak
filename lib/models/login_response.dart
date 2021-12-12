// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.ok,
        this.uid,
        this.name,
        this.email,
        this.segundoNombre,
        this.apellidoPaterno,
        this.apellidoMaterno,
        this.area,
        this.fono,
        required this.nacimiento,
        required this.ingreso,
        this.rol,
        required this.permisos,
        this.empresa,
        this.cargo,
        this.rut,
        this.imgusuario,
        this.theme,
        required this.token,
    });

    bool? ok;
    String? uid;
    String? name;
    String? email;
    String? segundoNombre;
    String? apellidoPaterno;
    String? apellidoMaterno;
    String? area;
    String? fono;
    DateTime nacimiento;
    DateTime ingreso;
    String? rol;
    List<String> permisos;
    String? empresa;
    String? cargo;
    String? rut;
    String? imgusuario;
    String? theme;
    String token;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        segundoNombre: json["segundoNombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        area: json["area"],
        fono: json["fono"],
        nacimiento: DateTime.parse(json["nacimiento"]),
        ingreso: DateTime.parse(json["ingreso"]),
        rol: json["rol"],
        permisos: List<String>.from(json["permisos"].map((x) => x)),
        empresa: json["empresa"],
        cargo: json["cargo"],
        rut: json["rut"],
        imgusuario: json["imgusuario"],
        theme: json["theme"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "uid": uid,
        "name": name,
        "email": email,
        "segundoNombre": segundoNombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "area": area,
        "fono": fono,
        "nacimiento": nacimiento.toIso8601String(),
        "ingreso": ingreso.toIso8601String(),
        "rol": rol,
        "permisos": List<dynamic>.from(permisos.map((x) => x)),
        "empresa": empresa,
        "cargo": cargo,
        "rut": rut,
        "imgusuario": imgusuario,
        "theme": theme,
        "token": token,
    };
}
