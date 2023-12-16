#renamer

$OutputEncoding = [System.Text.Encoding]::UTF8

#$rutaCarpeta = Read-Host "Ingresa la ruta de la carpeta que deseas analizar"
$rutaCarpeta = "C:\Users\mjoca\Downloads\jdownloader_descargas"

$contenidoCarpeta = Get-ChildItem -Path $rutaCarpeta
$contenidoCarpeta


$intentos = 0

function ValidarOpcion {
    param (
        [string]$opcion
    )
    if ($opcion -eq "s") {
        $extension = "*"
    }
    elseif ($opcion -eq "n") {
        Write-Host "`nSelecciona el tipo de archivo que deseas analizar:"
        Write-Host "A. Documento de texto (TXT)"
        Write-Host "B. Presentacion (PPTX)"
        Write-Host "C. Imagen (JPG o JPEG)"
        Write-Host "D. Audio (MP3)"
        Write-Host "E. Video (MP4)"
        Write-Host "F. Documento de Word (DOCX)"
        Write-Host "G. Documento de Excel (XLSX)"
        Write-Host "H. Otros archivos"
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

function CambiarNombreArchivos {
    param (
        [string]$ruta,
        [string]$extension,
        [string]$textoEliminar
    )
    $contadorArchivos = 0
    Write-Host ("`nArchivos renombrados:`n")
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

do {
    $intentos++
    if ($intentos -eq 3) {
        Write-Host "`nDemasiados intentos fallidos. Saliendo del programa."
        exit
    }
    $analizarTodos = Read-Host "`nDeseas analizar todos los archivos de la carpeta? (s/n)"
    $extension = ValidarOpcion $analizarTodos
} while ($extension -eq $null)

do {
    $textoEliminar = Read-Host "`nPor favor, ingresa el texto que deseas eliminar del nombre de los archivos"
    CambiarNombreArchivos -ruta $rutaCarpeta -extension $extension -textoEliminar $textoEliminar
    $repetir = Read-Host "`nDeseas realizar otra operacion? (s/n)"
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

Write-Host "`nFin del programa, gracias! :)"

Start-Sleep -Seconds 10
Clear-Host
