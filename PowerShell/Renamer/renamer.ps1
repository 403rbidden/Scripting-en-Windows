# REnamer
# 💣 Programa aún en fase de desarrollo, se recomienda mucha precaución.

# Establece la codificación de salida como UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Ruta de la carpeta de descargas en JDownloader
# $rutaCarpeta = "C:\Users\mjoca\Downloads\jdownloader_descargas"
$rutaCarpeta = Read-Host "Ingresa la ruta de la carpeta que deseas analizar"

# Obtiene el contenido de la carpeta
$contenidoCarpeta = Get-ChildItem -Path $rutaCarpeta
$contenidoCarpeta

# Inicializa el contador de intentos
$intentos = 0

# Función para validar la opción de análisis de archivos
function ValidarOpcion {
    param (
        [string]$opcion
    )

    # Diccionario para almacenar archivos por extensión
    $archivosPorExtension = @{}
    foreach ($archivo in $contenidoCarpeta) {
        $extension = $archivo.Extension
        if ($archivosPorExtension.ContainsKey($extension)) {
            $archivosPorExtension[$extension] += @($archivo.Name)
        } else {
            $archivosPorExtension[$extension] = @($archivo.Name)
        }
    }

    # Determina la extensión según la opción seleccionada
    if ($opcion -eq "s") {
        $extension = "*"
    } elseif ($opcion -eq "n") {
        # Solicita al usuario seleccionar el tipo de archivo
        Write-Host "`nSelecciona el tipo de archivo que deseas analizar:"
        # Opciones de archivo
        Write-Host "A. Documento de texto (TXT)"
        Write-Host "B. Presentación (PPTX)"
        Write-Host "C. Imagen (JPG o JPEG)"
        Write-Host "D. Audio (MP3)"
        Write-Host "E. Video (MP4)"
        Write-Host "F. Documento de Word (DOCX)"
        Write-Host "G. Documento de Excel (XLSX)"
        Write-Host "H. Otros archivos"
        
        # Asigna la extensión según la opción del usuario
        $extension = switch (Read-Host "`nIngresa la opcion correspondiente") {
            "a" { "txt" }
            "b" { "pptx" }
            "c" { "jpg" }
            "d" { "mp3" }
            "e" { "mp4" }
            "f" { "docx" }
            "g" { "xlsx" }
            "h" { Read-Host "`nIngresa la extensión del archivo (sin punto)" }
            default {
                Write-Host "`nOpción no válida. Por favor, inténtalo nuevamente."
                return $null
            }
        }

        # Muestra el listado de archivos con la extensión seleccionada
        $archivos = $archivosPorExtension[$extension]
        if ($archivos -ne $null -and $archivos.Count -gt 1) {
            Write-Host "`nListado de los archivos con la extensión especificada:"
            foreach ($archivo in $archivos) {
                Write-Host ("- " + (Get-Item (Join-Path -Path $rutaCarpeta -ChildPath $archivo)).Name)
            }
        }
    } else {
        Write-Host "`nOpción no válida. Por favor, inténtalo nuevamente."
        return $null
    }
    return $extension
}

# Función para cambiar el nombre de archivos
function CambiarNombreArchivos {
    param (
        [string]$ruta,
        [string]$extension,
        [string]$textoEliminar
    )

    # Contador de archivos renombrados
    $contadorArchivos = 0
    Write-Host ("`nArchivos renombrados:")

    # Obtiene y renombra archivos según el texto a eliminar
    Get-ChildItem -Path $ruta -Filter "*.$extension" | ForEach-Object {
        $nombreAntes = $_.BaseName
        if ($nombreAntes -match $textoEliminar) {
            $nuevoNombre = $_.BaseName -replace [regex]::Escape($textoEliminar), "" -replace ' ',''
            Write-Host ("- {0} -> {1}" -f $_.Name, ($nuevoNombre + $_.Extension))
            Rename-Item -Path $_.FullName -NewName ($nuevoNombre + $_.Extension)
            $contadorArchivos++
        }
    }
    Write-Host "`nProceso completado satisfactoriamente."
    Write-Host "Se han renombrado $contadorArchivos archivos en total."
}

# Bucle para analizar archivos y cambiar nombres
do {
    $intentos++
    if ($intentos -eq 3) {
        Write-Host "`nDemasiados intentos fallidos. Saliendo del programa."
        exit
    }

    # Pregunta al usuario si desea analizar todos los archivos
    $analizarTodos = Read-Host "`nDeseas analizar todos los archivos de la carpeta? (s/n)"
    $extension = ValidarOpcion $analizarTodos
} while ($extension -eq $null)

# Bucle para ingresar el texto a eliminar y repetir la operación
do {
    $textoEliminar = Read-Host "`nIngresa el texto que deseas eliminar del nombre de los archivos"
    CambiarNombreArchivos -ruta $rutaCarpeta -extension $extension -textoEliminar $textoEliminar

    # Pregunta al usuario si desea realizar otra operación
    $repetir = Read-Host "`nDeseas realizar otra operación? (s/n)"
    if ($repetir -eq "s") {
        $intentos = 0

        # Bucle para analizar archivos y cambiar nombres de nuevo
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

# Mensaje de finalización del programa
Write-Host "`nFin del programa, ¡gracias! :)"
Start-Sleep -Seconds 5
Clear-Host
