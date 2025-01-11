El hecho de que el error **`EXC_BAD_ACCESS`** aparezca con mayor frecuencia a medida que desinstalas librerías indica que hay un problema subyacente en la configuración del proyecto. Esto puede deberse a referencias residuales de las librerías desinstaladas o configuraciones incompletas en el proyecto de iOS (Xcode). Aquí tienes un enfoque para resolver el problema:

---

### **1. Limpia completamente las referencias de las librerías**
Cuando desinstalas una librería en Flutter, debes asegurarte de eliminar todas las configuraciones asociadas tanto en el código Dart como en los archivos nativos de iOS.

#### **a) Elimina la dependencia del archivo `pubspec.yaml`**
- Asegúrate de eliminar completamente la librería del archivo `pubspec.yaml`.
- Ejecuta:

  ```bash
  flutter pub get
  ```

#### **b) Limpia el proyecto de Flutter**
- Borra los archivos generados por Flutter:

  ```bash
  flutter clean
  ```

#### **c) Limpia las dependencias de CocoaPods**
- Ve a la carpeta `ios` y elimina los Pods y el archivo `Podfile.lock`:

  ```bash
  cd ios
  rm -rf Pods Podfile.lock
  pod install
  cd ..
  ```

#### **d) Verifica los archivos nativos**
- Abre el proyecto en Xcode (`ios/Runner.xcworkspace`).
- Busca configuraciones residuales en:
  - **Build Phases**: Asegúrate de que las librerías desinstaladas no estén referenciadas en las secciones `Link Binary With Libraries` o `Embed Frameworks`.
  - **Info.plist**: Verifica que no queden claves relacionadas con las librerías eliminadas.
  - **AppDelegate.swift** o **AppDelegate.m**: Asegúrate de que no haya código que intente inicializar las librerías eliminadas.

---

### **2. Reconstruye el proyecto desde cero**
Si el problema persiste, reconstruir el proyecto iOS desde cero puede solucionar inconsistencias profundas.

#### **Pasos para reconstruir el proyecto iOS:**
1. Elimina la carpeta `ios`:
   ```bash
   rm -rf ios
   ```

2. Regenera el directorio `ios`:
   ```bash
   flutter create .
   ```

3. Vuelve a agregar las configuraciones necesarias en el archivo `ios/Runner/Info.plist` (por ejemplo, permisos).

4. Instala las dependencias:
   ```bash
   cd ios
   pod install
   cd ..
   ```

---

### **3. Verifica el código restante**
Si desinstalaste una librería pero el código asociado sigue presente en tu proyecto, esto puede causar errores de memoria. Busca en tu código Dart cualquier referencia a las librerías desinstaladas.

#### **Cómo buscar referencias residuales:**
1. Usa un buscador de texto para encontrar referencias en tu proyecto:
   ```bash
   grep -r "nombre_de_libreria" .
   ```

2. Elimina cualquier código que use la librería desinstalada.

---

### **4. Revisa el stack trace**
Cuando aparece el error `EXC_BAD_ACCESS`, Xcode proporciona un stack trace que puede ayudarte a identificar dónde ocurre el problema.

#### **Pasos para revisar el stack trace:**
1. Abre el proyecto en Xcode (`ios/Runner.xcworkspace`).
2. Ejecuta la aplicación en un simulador o dispositivo.
3. Observa los logs en el panel de depuración.
4. Identifica el módulo o función que causa el error.

---

### **5. Habilita Address Sanitizer en Xcode**
Si el error persiste y no puedes identificar la causa, usa Address Sanitizer para detectar problemas de acceso a memoria:

1. Abre el proyecto en Xcode.
2. Ve a **Edit Scheme > Diagnostics**.
3. Activa **Address Sanitizer**.
4. Ejecuta la aplicación y observa los resultados.

---

### **6. Considera reinstalar las dependencias**
Si el proyecto sigue presentando problemas después de desinstalar librerías, considera reinstalarlas temporalmente para verificar si el problema es específico de las desinstalaciones.

---

### **Conclusión**
El error `EXC_BAD_ACCESS` suele ser causado por referencias residuales a librerías eliminadas o configuraciones incompletas en el proyecto nativo. Limpiar el proyecto, revisar los archivos nativos y reconstruir el proyecto desde cero son las soluciones más efectivas.

Si necesitas ayuda con un caso específico, comparte los logs de Xcode o el stack trace para identificar la causa exacta. 😊
