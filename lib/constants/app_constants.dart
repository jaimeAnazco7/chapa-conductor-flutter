class AppConstants {
  // Nombres de archivos de almacenamiento local
  static const String userDataKey = 'user_data';
  static const String tokenKey = 'auth_token';
  static const String isLoggedInKey = 'is_logged_in';
  
  // Estados de conductor
  static const String estadoSinAprobar = 'sinaprobar';
  static const String estadoActivo = 'activo';
  static const String estadoBloqueado = 'bloqueado';
  
  // Estados de documentos
  static const String documentoPendiente = 'pendiente';
  static const String documentoAprobado = 'aprobado';
  static const String documentoRechazado = 'rechazado';
  
  // Tipos de archivos permitidos
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedDocumentTypes = ['jpg', 'jpeg', 'png', 'pdf'];
  
  // Tamaño máximo de archivo (5MB)
  static const int maxFileSize = 5 * 1024 * 1024;
  
  // Mensajes de la aplicación
  static const String appName = 'Chapa Conductor';
  static const String loadingMessage = 'Cargando...';
  static const String errorMessage = 'Ocurrió un error';
  static const String successMessage = 'Operación exitosa';
  
  // Mensajes de validación
  static const String emailRequired = 'El email es requerido';
  static const String passwordRequired = 'La contraseña es requerida';
  static const String invalidEmail = 'Email inválido';
  static const String passwordTooShort = 'La contraseña debe tener al menos 6 caracteres';
}
