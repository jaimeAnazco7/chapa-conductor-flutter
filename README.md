# Chapa Conductor Flutter

Aplicación móvil para conductores de taxi desarrollada en Flutter, compatible con iOS y Android.

## 🚀 Características

- **Autenticación**: Login y registro de conductores
- **Gestión de Documentos**: Subida de documentos requeridos (DNI, Licencia, SOAT, etc.)
- **Estado de Cuenta**: Visualización del estado de aprobación
- **Interfaz Moderna**: Diseño con esquema de colores gris profesional
- **Multiplataforma**: Compatible con iOS y Android

## 📱 Pantallas

1. **Login**: Inicio de sesión para conductores
2. **Registro**: Registro de nuevos conductores
3. **Inicio**: Dashboard principal con información del conductor
4. **Documentos**: Gestión de documentos requeridos
5. **Cuenta**: Perfil y configuración del conductor

## 🛠️ Tecnologías

- **Flutter**: Framework de desarrollo móvil
- **Provider**: Gestión de estado
- **HTTP**: Comunicación con API
- **Shared Preferences**: Almacenamiento local
- **Image Picker**: Selección de imágenes
- **Path Provider**: Manejo de archivos

## 📋 Requisitos

- Flutter SDK 3.7.2 o superior
- Dart 3.0 o superior
- iOS 11.0 o superior (para iOS)
- Android API 21 o superior (para Android)

## 🚀 Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone <repository-url>
   cd app_conductor_flutter
   ```

2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar en iOS**:
   ```bash
   flutter run -d ios
   ```

4. **Ejecutar en Android**:
   ```bash
   flutter run -d android
   ```

## 🔧 Configuración

### API
La aplicación se conecta a la API v2 de Chapa Tu Taxi:
- **Base URL**: `https://inflablespr.com/chapa-api-v2/api/chapa`

### Permisos iOS
La aplicación requiere los siguientes permisos:
- **Cámara**: Para tomar fotos de documentos
- **Galería**: Para seleccionar imágenes de documentos

## 📱 Funcionalidades

### Autenticación
- Login con email y contraseña
- Registro de nuevos conductores
- Verificación de estado de cuenta
- Manejo de restricciones de acceso

### Documentos
- Subida de documentos requeridos
- Visualización del estado de documentos
- Progreso de documentación
- Validación de tipos de archivo

### Estado de Conductor
- **Sin Aprobar**: Pendiente de aprobación del administrador
- **Activo**: Cuenta aprobada y funcional
- **Bloqueado**: Cuenta suspendida

## 🎨 Diseño

La aplicación utiliza un esquema de colores gris profesional:
- **Primario**: #2C3E50 (Gris oscuro)
- **Secundario**: #95A5A6 (Gris medio)
- **Fondo**: #F8F9FA (Gris claro)
- **Éxito**: #27AE60 (Verde)
- **Advertencia**: #F39C12 (Naranja)
- **Error**: #E74C3C (Rojo)

## 📦 Estructura del Proyecto

```
lib/
├── constants/          # Constantes de la aplicación
├── models/            # Modelos de datos
├── providers/         # Gestión de estado
├── screens/           # Pantallas de la aplicación
├── services/          # Servicios de API
└── main.dart         # Punto de entrada
```

## 🚀 Compilación

### Debug
```bash
flutter build apk --debug
flutter build ios --debug
```

### Release
```bash
flutter build apk --release
flutter build ios --release
```

## 📝 Notas

- La aplicación está configurada para funcionar con la API v2 de Chapa Tu Taxi
- Los conductores deben ser aprobados por un administrador antes de poder usar la aplicación
- Los documentos se suben a la API y son verificados por el administrador
- La aplicación maneja automáticamente las restricciones de acceso según el estado del conductor

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.