enum DocumentType {
  dni,
  licencia,
  soat,
  tarjetaPropiedad,
  fotoVehiculo,
}

extension DocumentTypeExtension on DocumentType {
  String get value {
    switch (this) {
      case DocumentType.dni:
        return 'DNI';
      case DocumentType.licencia:
        return 'LICENCIA';
      case DocumentType.soat:
        return 'SOAT';
      case DocumentType.tarjetaPropiedad:
        return 'TARJETA_PROPIEDAD';
      case DocumentType.fotoVehiculo:
        return 'FOTO_VEHICULO';
    }
  }

  String get displayName {
    switch (this) {
      case DocumentType.dni:
        return 'DNI';
      case DocumentType.licencia:
        return 'Licencia de Conducir';
      case DocumentType.soat:
        return 'SOAT';
      case DocumentType.tarjetaPropiedad:
        return 'Tarjeta de Propiedad';
      case DocumentType.fotoVehiculo:
        return 'Foto del Vehículo';
    }
  }

  String get description {
    switch (this) {
      case DocumentType.dni:
        return 'Documento Nacional de Identidad';
      case DocumentType.licencia:
        return 'Licencia de conducir vigente';
      case DocumentType.soat:
        return 'Seguro Obligatorio de Accidentes de Tránsito';
      case DocumentType.tarjetaPropiedad:
        return 'Tarjeta de propiedad del vehículo';
      case DocumentType.fotoVehiculo:
        return 'Foto completa del vehículo';
    }
  }
}

class DocumentData {
  final int id;
  final int idConductor;
  final String tipoDocumento;
  final String nombreArchivo;
  final String rutaArchivo;
  final String estado;
  final DateTime fechaSubida;
  final String? observaciones;

  DocumentData({
    required this.id,
    required this.idConductor,
    required this.tipoDocumento,
    required this.nombreArchivo,
    required this.rutaArchivo,
    required this.estado,
    required this.fechaSubida,
    this.observaciones,
  });

  factory DocumentData.fromJson(Map<String, dynamic> json) {
    return DocumentData(
      id: json['id'] ?? 0,
      idConductor: json['id_conductor'] ?? 0,
      tipoDocumento: json['tipo_documento'] ?? '',
      nombreArchivo: json['nombre_archivo'] ?? '',
      rutaArchivo: json['ruta_archivo'] ?? '',
      estado: json['estado'] ?? '',
      fechaSubida: DateTime.parse(json['fecha_subida'] ?? DateTime.now().toIso8601String()),
      observaciones: json['observaciones'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_conductor': idConductor,
      'tipo_documento': tipoDocumento,
      'nombre_archivo': nombreArchivo,
      'ruta_archivo': rutaArchivo,
      'estado': estado,
      'fecha_subida': fechaSubida.toIso8601String(),
      'observaciones': observaciones,
    };
  }
}

class DocumentListResponse {
  final bool success;
  final List<DocumentData> data;
  final String? message;

  DocumentListResponse({
    required this.success,
    required this.data,
    this.message,
  });

  factory DocumentListResponse.fromJson(Map<String, dynamic> json) {
    return DocumentListResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DocumentData.fromJson(item))
          .toList() ?? [],
      message: json['message'],
    );
  }
}

class DocumentStatusResponse {
  final bool success;
  final int totalDocuments;
  final int uploadedDocuments;
  final int approvedDocuments;
  final int pendingDocuments;
  final int rejectedDocuments;
  final bool allDocumentsComplete;
  final String? message;

  DocumentStatusResponse({
    required this.success,
    required this.totalDocuments,
    required this.uploadedDocuments,
    required this.approvedDocuments,
    required this.pendingDocuments,
    required this.rejectedDocuments,
    required this.allDocumentsComplete,
    this.message,
  });

  factory DocumentStatusResponse.fromJson(Map<String, dynamic> json) {
    return DocumentStatusResponse(
      success: json['success'] ?? false,
      totalDocuments: json['totalDocuments'] ?? 0,
      uploadedDocuments: json['uploadedDocuments'] ?? 0,
      approvedDocuments: json['approvedDocuments'] ?? 0,
      pendingDocuments: json['pendingDocuments'] ?? 0,
      rejectedDocuments: json['rejectedDocuments'] ?? 0,
      allDocumentsComplete: json['allDocumentsComplete'] ?? false,
      message: json['message'],
    );
  }
}
