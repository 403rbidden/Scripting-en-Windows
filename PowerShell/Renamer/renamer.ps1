# Renamer

# ⚠️
# El programa está aún en fase de desarrollo, se recomienda mucha precaución.
# ¡Realizar las pruebas únicamente en un entorno controlado!

# Establece la codificación de salida como UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Define la ruta de la carpeta a analizar
#$rutaCarpeta = "C:\Users\mjoca\Downloads\jdownloader_descargas"
$rutaCarpeta = Read-Host "Ingresa la ruta de la carpeta que deseas analizar"

# Obtiene el contenido de la carpeta
$contenidoCarpeta = Get-ChildItem -Path $rutaCarpeta
$contenidoCarpeta

# Inicializa el contador de intentos
$intentos = 0

# Función para validar la opción de analizar todos los archivos o seleccionar un tipo específico
function ValidarOpcion {
    param (
        [string]$opcion
    )
    if ($opcion -eq "s") {
        $extension = "*"
    }
    elseif ($opcion -eq "n") {
        # Solicita al usuario seleccionar el tipo de archivo
        Write-Host "`nSelecciona el tipo de archivo que deseas analizar:"
        Write-Host "A. Documento de texto (TXT)"
        Write-Host "B. Presentacion (PPTX)"
        Write-Host "C. Imagen (JPG o JPEG)"
        Write-Host "D. Audio (MP3)"
        Write-Host "E. Video (MP4)"
        Write-Host "F. Documento de Word (DOCX)"
        Write-Host "G. Documento de Excel (XLSX)"
        Write-Host "H. Otros archivos"
        
        # Utiliza un switch para asignar la extensión según la opción seleccionada
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
    }
    else {
        Write-Host "`nOpcion no valida. Por favor, intentalo nuevamente."
        return $null
    }
    return $extension
}

# Función para listar los archivos con una extensión específica
function ListarArchivos {
    param (
        [string]$ruta,
        [string]$extension
    )
    Write-Host "`nListado de los archivos con la extension '.$extension' especificada:"
    # Obtiene y muestra los archivos con la extensión especificada
    Get-ChildItem -Path $ruta -Filter "*.$extension" | ForEach-Object {
        Write-Host ("- {0}" -f $_.Name)
    }
}

# Función para cambiar el nombre de archivos eliminando un texto específico
function CambiarNombreArchivos {
    param (
        [string]$ruta,
        [string]$extension,
        [string]$textoEliminar
    )
    $contadorArchivos = 0
    Write-Host ("`nArchivos renombrados:`n")
    # Obtiene y muestra los archivos con la extensión especificada, cambiando el nombre si contiene el texto a eliminar
    Get-ChildItem -Path $ruta -Filter "*.$extension" | ForEach-Object {
        $nombreAntes = $_.BaseName
        if ($nombreAntes -match $textoEliminar) {
            $nuevoNombre = $_.BaseName -replace [regex]::Escape($textoEliminar), ""
            Write-Host ("- {0} -> {1}" -f $_.Name, ($nuevoNombre + $_.Extension))
            Rename-Item -Path $_.FullName -NewName ($nuevoNombre + $_.Extension)
            $contadorArchivos++
        }
    }
    Write-Host "`nProceso completado satisfactoriamente."
    Write-Host "Se han renombrado $contadorArchivos archivos en total."
}

# Bucle principal para analizar y renombrar archivos
do {
    $intentos++
    if ($intentos -eq 3) {
        Write-Host "`nDemasiados intentos fallidos. Saliendo del programa."
        exit
    }
    # Solicita al usuario si desea analizar todos los archivos
    $analizarTodos = Read-Host "`nDeseas analizar todos los archivos de la carpeta? (s/n)"
    $extension = ValidarOpcion $analizarTodos
    ListarArchivos -ruta $rutaCarpeta -extension $extension
} while ($extension -eq $null)

# Bucle secundario para cambiar nombres y repetir la operación si se desea
do {
    $textoEliminar = Read-Host "`nPor favor, ingresa el texto que deseas eliminar del nombre de los archivos"
    CambiarNombreArchivos -ruta $rutaCarpeta -extension $extension -textoEliminar $textoEliminar
    $repetir = Read-Host "`nDeseas realizar otra operacion? (s/n)"
    if ($repetir -eq "s") {
        # Reinicia el contador de intentos y repite el proceso
        $intentos = 0
        do {
            $intentos++
            if ($intentos -eq 3) {
                Write-Host "`nDemasiados intentos fallidos. Saliendo del programa."
                exit
            }
            $analizarTodos = Read-Host "`nDeseas analizar todos los archivos de la carpeta? (s/n)"
            $extension = ValidarOpcion $analizarTodos
            ListarArchivos -ruta $rutaCarpeta -extension $extension
        } while ($extension -eq $null)
    }
} while ($repetir -eq "s")

Write-Host "`nFin del programa, gracias! :)"

# Espera 10 segundos antes de limpiar la consola
Start-Sleep -Seconds 10
Clear-Host
