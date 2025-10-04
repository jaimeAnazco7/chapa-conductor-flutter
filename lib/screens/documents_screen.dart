import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/document_provider.dart';
import '../constants/app_colors.dart';
import '../models/document.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final documentProvider = Provider.of<DocumentProvider>(context, listen: false);
      documentProvider.loadDocuments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
      ),
      body: Consumer<DocumentProvider>(
        builder: (context, documentProvider, child) {
          if (documentProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con progreso
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Documentos Requeridos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.info,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Sube todos los documentos requeridos para activar tu cuenta',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Barra de progreso
                        LinearProgressIndicator(
                          value: documentProvider.uploadedDocuments / documentProvider.totalDocuments,
                          backgroundColor: AppColors.borderLight,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${documentProvider.uploadedDocuments} de ${documentProvider.totalDocuments} documentos subidos',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Lista de documentos
                Expanded(
                  child: ListView.builder(
                    itemCount: DocumentType.values.length,
                    itemBuilder: (context, index) {
                      final documentType = DocumentType.values[index];
                      final document = documentProvider.getDocumentByType(documentType);
                      
                      return DocumentItem(
                        documentType: documentType,
                        document: document,
                        onUpload: () => _showUploadDialog(documentType),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showUploadDialog(DocumentType documentType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Subir ${documentType.displayName}'),
        content: Text('Selecciona una imagen o PDF para subir'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _uploadDocument(documentType);
            },
            child: Text('Subir', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _uploadDocument(DocumentType documentType) async {
    final documentProvider = Provider.of<DocumentProvider>(context, listen: false);
    await documentProvider.uploadDocument(documentType);
  }
}

class DocumentItem extends StatelessWidget {
  final DocumentType documentType;
  final DocumentData? document;
  final VoidCallback onUpload;

  const DocumentItem({
    super.key,
    required this.documentType,
    this.document,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icono del documento
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getDocumentIcon(),
                color: _getStatusColor(),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Información del documento
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    documentType.displayName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    documentType.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStatusText(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (document != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          'Subido: ${_formatDate(document!.fechaSubida)}',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Botón de acción
            IconButton(
              onPressed: onUpload,
              icon: Icon(
                document == null ? Icons.upload : Icons.refresh,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (document == null) {
      return AppColors.textSecondary;
    }
    
    switch (document!.estado.toLowerCase()) {
      case 'aprobado':
        return AppColors.success;
      case 'pendiente':
        return AppColors.warning;
      case 'rechazado':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getStatusText() {
    if (document == null) {
      return 'PENDIENTE';
    }
    
    switch (document!.estado.toLowerCase()) {
      case 'aprobado':
        return 'APROBADO';
      case 'pendiente':
        return 'PENDIENTE';
      case 'rechazado':
        return 'RECHAZADO';
      default:
        return 'DESCONOCIDO';
    }
  }

  IconData _getDocumentIcon() {
    switch (documentType) {
      case DocumentType.dni:
        return Icons.credit_card;
      case DocumentType.licencia:
        return Icons.card_membership;
      case DocumentType.soat:
        return Icons.security;
      case DocumentType.tarjetaPropiedad:
        return Icons.description;
      case DocumentType.fotoVehiculo:
        return Icons.car_rental;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
