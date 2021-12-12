// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.ok,
        required this.usuario,
    });

    bool ok;
    List<Usuario> usuario;

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        required this.ingreso,
        required this.id,
        required this.nombre,
        required this.edad,
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
    DateTime ingreso;
    String id;
    String nombre;
    String edad;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        permisos: List<String>.from(json["permisos"].map((x) => x)),
        empresa: json["empresa"],
        estado: json["estado"],
        online: json["online"],
        theme: json["theme"],
        name: json["name"],
        email: json["email"],
        password: json["password"] == null ? null : json["password"],
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
        ingreso: DateTime.parse(json["ingreso"]),
        id: json["id"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        edad: json["edad"] == null ? null : json["edad"],
    );

    Map<String, dynamic> toJson() => {
        "permisos": List<dynamic>.from(permisos.map((x) => x)),
        "empresa": empresa,
        "estado": estado,
        "online": online,
        "theme": theme,
        "name": name,
        "email": email,
        "password": password == null ? null : password,
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
        "ingreso": ingreso.toIso8601String(),
        "id": id,
        "nombre": nombre == null ? null : nombre,
        "edad": edad == null ? null : edad,
    };
}
