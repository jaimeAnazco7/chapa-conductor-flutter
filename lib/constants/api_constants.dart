class ApiConstants {
  // Base URL de la API
  static const String baseUrl = 'https://inflablespr.com/chapa-api-v2/api/chapa';
  
  // Endpoints de autenticación
  static const String loginEndpoint = '/driver/login';
  static const String registerEndpoint = '/driver/register';
  static const String checkStatusEndpoint = '/driver/status';
  
  // Endpoints de documentos
  static const String uploadDocumentEndpoint = '/documents/driver';
  static const String getDocumentsEndpoint = '/documents/driver';
  static const String checkDocumentsStatusEndpoint = '/documents/driver';
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Timeouts
  static const int connectTimeout = 30000; // 30 segundos
  static const int receiveTimeout = 30000; // 30 segundos
}
