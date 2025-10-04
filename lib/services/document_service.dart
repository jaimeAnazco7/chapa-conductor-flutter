import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/document.dart';

class DocumentService {
  static final DocumentService _instance = DocumentService._internal();
  factory DocumentService() => _instance;
  DocumentService._internal();

  Future<DocumentListResponse> getDriverDocuments(int driverId) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getDocumentsEndpoint}/$driverId');
      
      final response = await http.get(
        url,
        headers: ApiConstants.defaultHeaders,
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectTimeout),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DocumentListResponse.fromJson(data);
      } else {
        final data = jsonDecode(response.body);
        return DocumentListResponse(
          success: false,
          data: [],
          message: data['message'] ?? 'Error al obtener documentos',
        );
      }
    } catch (e) {
      return DocumentListResponse(
        success: false,
        data: [],
        message: 'Error de conexión: ${e.toString()}',
      );
    }
  }

  Future<DocumentStatusResponse> checkDocumentStatus(int driverId) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.checkDocumentsStatusEndpoint}/$driverId/status');
      
      final response = await http.get(
        url,
        headers: ApiConstants.defaultHeaders,
      ).timeout(
        const Duration(milliseconds: ApiConstants.connectTimeout),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DocumentStatusResponse.fromJson(data);
      } else {
        final data = jsonDecode(response.body);
        return DocumentStatusResponse(
          success: false,
          totalDocuments: 0,
          uploadedDocuments: 0,
          approvedDocuments: 0,
          pendingDocuments: 0,
          rejectedDocuments: 0,
          allDocumentsComplete: false,
          message: data['message'] ?? 'Error al verificar estado de documentos',
        );
      }
    } catch (e) {
      return DocumentStatusResponse(
        success: false,
        totalDocuments: 0,
        uploadedDocuments: 0,
        approvedDocuments: 0,
        pendingDocuments: 0,
        rejectedDocuments: 0,
        allDocumentsComplete: false,
        message: 'Error de conexión: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> uploadDocument(
    int driverId,
    DocumentType documentType,
    File file,
  ) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.uploadDocumentEndpoint}/$driverId');
      
      var request = http.MultipartRequest('POST', url);
      request.fields['tipo_documento'] = documentType.value;
      request.files.add(await http.MultipartFile.fromPath('documento', file.path));

      final streamedResponse = await request.send().timeout(
        const Duration(milliseconds: ApiConstants.connectTimeout),
      );
      
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Documento subido exitosamente',
          'data': data['data'],
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Error al subir documento',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }
}
