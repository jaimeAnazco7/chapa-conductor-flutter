class User {
  final int id;
  final String nombre;
  final String apellido;
  final String email;
  final String telefono;
  final String? foto;
  final String estado;
  final String? statusMessage;
  final Restrictions? restrictions;

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    this.foto,
    required this.estado,
    this.statusMessage,
    this.restrictions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      email: json['email'] ?? '',
      telefono: json['telefono'] ?? '',
      foto: json['foto'],
      estado: json['estado'] ?? '',
      statusMessage: json['statusMessage'],
      restrictions: json['restrictions'] != null 
          ? Restrictions.fromJson(json['restrictions']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'telefono': telefono,
      'foto': foto,
      'estado': estado,
      'statusMessage': statusMessage,
      'restrictions': restrictions?.toJson(),
    };
  }
}

class Restrictions {
  final bool canLogin;
  final bool needsDocuments;
  final bool isBlocked;

  Restrictions({
    required this.canLogin,
    required this.needsDocuments,
    required this.isBlocked,
  });

  factory Restrictions.fromJson(Map<String, dynamic> json) {
    return Restrictions(
      canLogin: json['canLogin'] ?? false,
      needsDocuments: json['needsDocuments'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'canLogin': canLogin,
      'needsDocuments': needsDocuments,
      'isBlocked': isBlocked,
    };
  }
}
