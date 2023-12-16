![Stitch moon face](https://github.com/403rbidden/Scripting-en-Windows/blob/main/PowerShell/Renamer/stitch_moon_face.png)

# REnamer

## Introducción

Este programa ha sido creado con el objetivo principal de simplificar el proceso de cambio de nombre de archivos y carpetas dentro de un directorio específico. 
Su propósito es proporcionar a los usuarios la capacidad de personalizar nombres de manera eficiente, eliminando caracteres o símbolos no deseados.

Diseñado, en primer lugar, para ser amigable y beneficioso, especialmente para usuarios no avanzados, pone la accesibilidad en el centro de su enfoque. 
Facilita la gestión y personalización de nombres de archivos y carpetas de manera intuitiva, ofreciendo una herramienta que simplifica las tareas digitales.

Con un fuerte compromiso de hacer que la tecnología sea más accesible para todos, busca dar un paso significativo hacia ese objetivo. 
Permite que incluso aquellos colectivos vulnerables o en riesgo de exclusión digital, como las personas mayores, disfruten de una experiencia informática más cómoda, agradable y eficiente.

Antes de ejecutar esta aplicación, es crucial revisar detenidamente las secciones de "Advertencia" y "Descargo de responsabilidad" para garantizar una experiencia segura.

## ⚙️ Instrucciones de Uso

### Requisitos Previos
- Diseñado para sistemas basados en Windows con PowerShell.
- Asegúrate de tener los permisos de ejecución necesarios.

### Ejecución
<span style="color:yellow">¡El programa está sin terminar!</span>
1. Abre PowerShell.
2. Navega al directorio del script con `cd`.
3. Ejecuta con:

    ```powershell
    .\renamer.ps1
    ```
5. Sigue las indicaciones suministradas por la aplicación.

### Entrada del Usuario
- Seleccionar la ruta.
- Selecciona analizar todos los archivos o tipos específicos.
Se puede filtrar por extensión del archivo.

### Advertencia
- **Estado del Programa:**
  - **Renamer** está en desarrollo, se recomienda mucha precaución.
  - Realizar las pruebas en un entorno controlado.

- **Permisos:**
  - Puede necesitar privilegios de administrador para ciertos cambios.
  - Ejecútalo con permisos elevados, especialmente con archivos críticos del sistema.
  - Asegúrate de tener permisos adecuados para evitar problemas o pérdida de datos.

### Manejo de Errores
- Errores mostrarán mensajes para guiar en la resolución.

### Información Adicional
- Experiencia interactiva, permite ingresar preferencias.
- Mensajes con colores que mejoran la legibilidad.

## Flujo del Programa

1. **Opciones de Análisis de Archivos:**
   - Elige analizar todos los archivos o tipos específicos.
   - Para tipos específicos, selecciona el tipo de archivo.

2. **Eliminación de Texto:**
   - Ingresa la cadena de texto o símbolos a eliminar de los archivos.

3. **Proceso de Cambio de Nombre:**
   - Muestra archivos antes y después, incluyendo el texto eliminado.
   - Renombra según preferencias.

4. **Repetir Operación:**
   - Opcional, realiza otra operación.
   - El script guiará al asuario través de las diferentes operaciones adicionales.

5. **Finalización del Programa:**
   - Recibe mensaje de despedida al salir.

## Autor
Creado por María Jesús Ocaña Rodríguez, AKA. 403rbidden.

### Personalización y Atribución
- Personaliza según tus necesidades.
- Problemas o sugerencias, contacta.

## 🕊 Descargo de Responsabilidad
- Cambios directos en nombres de archivos. Haz copias de seguridad antes de ejecutar para evitar pérdida de información.
- No se asume responsabilidad por pérdida de datos u otros problemas del uso de este script.
  Comprende completamente las acciones antes de ejecutarlo.
- Revisa el código fuente para transparencia y comprende las operaciones antes de ejecutar.
- Puede modificar nombres directamente en el sistema. Úsalo bajo tu riesgo y verifica cambios.
- Ejecuta scripts descargados en prueba antes de aplicar a datos sensibles.
