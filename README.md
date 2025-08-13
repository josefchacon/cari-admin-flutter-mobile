# Cari Admin Flutter

Aplicación móvil para visualizar los resultados de las encuestas de Cari.

## Configuración

1. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Configurar Firebase:**
   - Ve a Firebase Console
   - Agrega una nueva app iOS/Android
   - Descarga `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
   - Colócalos en las carpetas correspondientes
   - Actualiza el `projectId` en `lib/services/firebase_service.dart`

3. **Ejecutar la app:**
   ```bash
   flutter run
   ```

## Funcionalidades

- ✅ Ver estadísticas generales (completadas, no interesados, total)
- ✅ Lista de encuestas completadas
- ✅ Lista de razones de no interés
- ✅ Filtros por plataformas
- ✅ Actualización en tiempo real

## Estructura del proyecto

```
lib/
├── main.dart
├── models/
│   └── survey_data.dart
├── screens/
│   └── dashboard_screen.dart
└── services/
    └── firebase_service.dart
```

## Próximos pasos

1. Configurar Firebase para iOS/Android
2. Agregar iconos y splash screen
3. Implementar autenticación (opcional)
4. Agregar exportación de datos
5. Mejorar UI/UX