# [SIN TERMINAR] REnamer 💣

# Establecer la codificación a UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Ruta de la carpeta que se va a analizar
#$rutaCarpeta = "C:\Users\mjoca\Downloads\jdownloader_descargas"
$rutaCarpeta = Read-Host "Ingresa la ruta completa del directorio que deseas analizar"

# Obtención del contenido de la carpeta
$contenidoCarpeta = Get-ChildItem -Path $rutaCarpeta
$contenidoCarpeta

# Contador de intentos
$intentos = 0

# Función para validar la opción seleccionada por el usuario
function ValidarOpcion {
    param (
        [string]$opcion
    )

    # Inicialización de un diccionario para agrupar archivos por extensión
    $archivosPorExtension = @{}

    # Recorre cada archivo en la carpeta
    foreach ($archivo in $contenidoCarpeta) {
        $extension = $archivo.Extension

        # Agrupa los archivos por su extensión
        if ($archivosPorExtension.ContainsKey($extension)) {
            $archivosPorExtension[$extension] += @($archivo.Name)
        } else {
            $archivosPorExtension[$extension] = @($archivo.Name)
        }
    }

    # Determina la extensión según la opción seleccionada por el usuario
    if ($opcion -eq "s") {
        $extension = "*"
    }
    elseif ($opcion -eq "n") {

        # Presenta un menú de opciones al usuario
        Write-Host "`nSelecciona el tipo de archivo que deseas analizar:"
        Write-Host "A. Documento de texto (TXT)"
        Write-Host "B. Presentacion (PPTX)"
        Write-Host "C. Imagen (JPG o JPEG)"
        Write-Host "D. Audio (MP3)"
        Write-Host "E. Video (MP4)"
        Write-Host "F. Documento de Word (DOCX)"
        Write-Host "G. Documento de Excel (XLSX)"
        Write-Host "H. Otros archivos"

        # Recopila la opción del usuario
        $extension = switch (Read-Host "`nIngresa la opcion correspondiente") {
            "a" { "txt" }
            "b" { "pptx" }
            "c" { "jpg" }
            "d" { "mp3" }
            "e" { "mp4" }
            "f" { "docx" }
            "g" { "xlsx" }
            "h" { Read-Host "`nIngresa la extension del archivo (sin punto)" }
            default {
                Write-Host "`nOpcion no valida. Por favor, intentalo nuevamente."
                return $null
            }
        }

        # Muestra la lista de archivos si hay más de uno con la extensión especificada
        $archivos = $archivosPorExtension[$extension]
        if ($archivos -ne $null -and $archivos.Count -gt 1) {
            Write-Host "`nListado de los archivos con la extension especificada:"
            foreach ($archivo in $archivos) {
                Write-Host ("- " + (Get-Item (Join-Path -Path $rutaCarpeta -ChildPath $archivo)).Name)
            }
        }
    }
    else {
        Write-Host "`nOpcion no valida. Por favor, intentalo nuevamente."
        return $null
    }

    # Retorna la extensión seleccionada
    return $extension
}

# Función para cambiar el nombre de archivos que contienen un texto específico
function CambiarNombreArchivos {
    param (
        [string]$ruta,
        [string]$extension,
        [string]$textoEliminar
    )

    # Inicializa el contador de archivos modificados
    $contadorArchivos = 0

    # Muestra archivos renombrados
    Write-Host ("`nArchivos renombrados:`n")

    # Recorre archivos con la extensión deseada
    Get-ChildItem -Path $ruta -Filter "*.$extension" | ForEach-Object {
        $nombreAntes = $_.BaseName

        # Comprueba si el texto a eliminar está presente en el nombre
        if ($nombreAntes -match $textoEliminar) {
            # Realiza el cambio de nombre
            $nuevoNombre = $_.BaseName -replace [regex]::Escape($textoEliminar), ""
            Write-Host ("- {0} -> {1}" -f $_.Name, ($nuevoNombre + $_.Extension))
            Rename-Item -Path $_.FullName -NewName ($nuevoNombre + $_.Extension)
            $contadorArchivos++
        }
    }

    # Muestra mensaje de finalización
    Write-Host "`nProceso completado satisfactoriamente."
    Write-Host "Se han renombrado $contadorArchivos archivos en total."
}

# Bucle para seleccionar la opción de analizar todos o archivos específicos
do {
    $intentos++
    if ($intentos -eq 3) {
        Write-Host "`nDemasiados intentos fallidos. Saliendo del programa."
        exit
    }
    $analizarTodos = Read-Host "`nDeseas analizar todos los archivos de la carpeta? (s/n)"
    $extension = ValidarOpcion $analizarTodos
} while ($extension -eq $null)

# Bucle principal para realizar operaciones adicionales
do {
    # Solicita el texto a eliminar del nombre de los archivos
    $textoEliminar = Read-Host "`nPor favor, ingresa el texto que deseas eliminar del nombre de los archivos"

    # Llama a la función para cambiar el nombre de archivos
    CambiarNombreArchivos -ruta $rutaCarpeta -extension $extension -textoEliminar $textoEliminar

    # Pregunta al usuario si desea realizar otra operación
    $repetir = Read-Host "`nDeseas realizar otra operacion? (s/n)"

    # Si el usuario elige repetir, reinicia el proceso de selección de archivos
    if ($repetir -eq "s") {
        $intentos = 0
        do {
            $intentos++
            if ($intentos -eq 3) {
                Write-Host "`nDemasiados intentos fallidos. Saliendo del programa."
                exit
            }
            $analizarTodos = Read-Host "`nDeseas analizar todos los archivos de la carpeta? (s/n)"
            $extension = ValidarOpcion $analizarTodos
        } while ($extension -eq $null)
    }
} while ($repetir -eq "s")

# Mensaje de despedida
Write-Host "`nFin del programa, gracias! :)"

# Esperar 10 segundos antes de limpiar la pantalla
Start-Sleep -Seconds 10
Clear-Host
