![Stitch moon face](https://github.com/403rbidden/Scripting-en-Windows/blob/main/PowerShell/Renamer/stitch_moon_face.png)

# reNAMER

## Introducción
Este script de PowerShell, llamado **Renamer**, está diseñado para simplificar el proceso de cambio de nombre de archivos dentro de una carpeta especificada. 
Proporciona a los usuarios la capacidad de personalizar nombres de archivos de manera eficiente, eliminando caracteres o símbolos no deseados.

<span style="color:blue">¡Por favor, revisa este archivo README detenidamente antes de ejecutar el script!</span>

## ⚙️ Instrucciones de Uso

### Requisitos Previos
- Este script está destinado a ser utilizado en sistemas basados en Windows con PowerShell.
- Asegúrate de tener los permisos necesarios para ejecutar el script.

### Ejecución
<span style="color:yellow">¡El programa está sin terminar!</span>
1. Abre una ventana de PowerShell.
2. Navega al directorio que contiene el script usando el comando `cd`.
3. Ejecuta el script ingresando el siguiente comando:

    ```powershell
    .\Renamer.ps1
    ```
5. Sigue las indicaciones para personalizar las operaciones de cambio de nombre.

### Entrada del Usuario
- El script te solicitará elegir entre analizar todos los archivos o tipos de archivo específicos.
- Para tipos de archivo específicos, se te pedirá que elijas el tipo de archivo a analizar.

### Advertencia
- **Permisos:** Es posible que el script requiera permisos apropiados, especialmente al cambiar nombres de archivos.

### Manejo de Errores
- Si se producen errores durante la ejecución, el script mostrará mensajes de error para guiarte en el proceso de resolución.

### Información Adicional
- El script proporciona una experiencia interactiva, permitiendo a los usuarios ingresar preferencias para el cambio de nombre de archivos.
- Mensajes con colores mejoran la legibilidad para una experiencia amigable.

## Flujo del Programa

1. **Opciones de Análisis de Archivos:**
   - Elige analizar todos los archivos en la carpeta especificada o tipos de archivo específicos.
   - Para tipos de archivo específicos, selecciona el tipo de archivo a analizar.

2. **Eliminación de Texto:**
   - Ingresa el texto que deseas eliminar de los nombres de archivo.

3. **Proceso de Cambio de Nombre de Archivos:**
   - El script mostrará los archivos antes y después del cambio de nombre, incluyendo el texto eliminado.
   - Los archivos se renombrarán según las preferencias especificadas.

4. **Repetir Operación:**
   - Opcionalmente, elige realizar otra operación de cambio de nombre de archivos.
   - El script te guiará a través de operaciones subsiguientes.

5. **Finalización del Programa:**
   - Recibe un mensaje de despedida cuando eliges salir del programa.

## Autor
Este script ha sido creado por María Jesús Ocaña Rodríguez, AKA. 403rbidden.

### Personalización y Atribución
- Siéntete libre de personalizar y utilizar este script según tus necesidades.
- Si encuentras problemas o tienes sugerencias de mejora, no dudes en ponerte en contacto.

## 🕊 Descargo de Responsabilidad
- Este script realiza cambios directos en los nombres de archivos dentro de la carpeta especificada.
  Asegúrate de tener copias de seguridad actualizadas de tus datos antes de ejecutar el script para evitar la pérdida accidental de información.
- No se asume ninguna responsabilidad por la pérdida de datos, daños o cualquier otro problema que pueda surgir como resultado directo o indirecto del uso de este script.
  Es responsabilidad del usuario comprender completamente las acciones que realiza el script antes de ejecutarlo.
- Se recomienda encarecidamente revisar el código fuente del script para garantizar la transparencia y comprender las operaciones que realizará en tus archivos antes de ejecutarlo.
- Ten en cuenta que este script puede modificar directamente los nombres de archivos en el sistema de archivos. Utilízalo bajo tu propio riesgo y verifica que los cambios realizados sean los esperados.
- Siempre ejecuta scripts descargados de fuentes externas en un entorno de prueba antes de aplicarlos a datos sensibles.
