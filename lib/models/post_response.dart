// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

PostResponse postResponseFromJson(String str) => PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
    PostResponse({
        required this.ok,
        required this.publicaciones,
    });

    bool ok;
    List<Publicacione> publicaciones;

    factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        ok: json["ok"],
        publicaciones: List<Publicacione>.from(json["publicaciones"].map((x) => Publicacione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "publicaciones": List<dynamic>.from(publicaciones.map((x) => x.toJson())),
    };
}

class Publicacione {
    Publicacione({
        required this.multimedia,
        required this.reaccion,
        required this.titulo,
        required this.contenido,
        required this.fecha,
        required this.usuario,
        required this.id,
    });

    List<String> multimedia;
    List<String> reaccion;
    String titulo;
    String contenido;
    DateTime fecha;
    String usuario;
    String id;

    factory Publicacione.fromJson(Map<String, dynamic> json) => Publicacione(
        multimedia: List<String>.from(json["multimedia"].map((x) => x)),
        reaccion: List<String>.from(json["reaccion"].map((x) => x)),
        titulo: json["titulo"],
        contenido: json["contenido"],
        fecha: DateTime.parse(json["fecha"]),
        usuario: json["usuario"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "multimedia": List<dynamic>.from(multimedia.map((x) => x)),
        "reaccion": List<dynamic>.from(reaccion.map((x) => x)),
        "titulo": titulo,
        "contenido": contenido,
        "fecha": fecha.toIso8601String(),
        "usuario": usuario,
        "id": id,
    };
}
