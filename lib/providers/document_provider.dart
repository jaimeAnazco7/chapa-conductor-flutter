import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/document.dart';
import '../services/document_service.dart';
import '../services/storage_service.dart';

class DocumentProvider with ChangeNotifier {
  final DocumentService _documentService = DocumentService();
  final StorageService _storageService = StorageService();
  final ImagePicker _imagePicker = ImagePicker();
  
  List<DocumentData> _documents = [];
  bool _isLoading = false;
  String? _error;
  int _totalDocuments = 0;
  int _uploadedDocuments = 0;

  List<DocumentData> get documents => _documents;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalDocuments => _totalDocuments;
  int get uploadedDocuments => _uploadedDocuments;

  DocumentProvider() {
    _totalDocuments = DocumentType.values.length;
  }

  Future<void> loadDocuments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await _storageService.getUserData();
      if (user != null) {
        final response = await _documentService.getDriverDocuments(user.id);
        if (response.success) {
          _documents = response.data;
          _uploadedDocuments = _documents.length;
        } else {
          _error = response.message;
        }
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  DocumentData? getDocumentByType(DocumentType type) {
    try {
      return _documents.firstWhere(
        (doc) => doc.tipoDocumento == type.value,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> uploadDocument(DocumentType documentType) async {
    try {
      // Seleccionar archivo
      final XFile? file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (file == null) return;

      final user = await _storageService.getUserData();
      if (user == null) {
        _error = 'No hay datos de usuario';
        notifyListeners();
        return;
      }

      _isLoading = true;
      notifyListeners();

      final result = await _documentService.uploadDocument(
        user.id,
        documentType,
        File(file.path),
      );

      if (result['success']) {
        // Recargar documentos
        await loadDocuments();
      } else {
        _error = result['message'];
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshDocuments() async {
    await loadDocuments();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
