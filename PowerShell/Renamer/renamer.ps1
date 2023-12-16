# [SIN TERMINAR] Renamer 💣

# Establecer la codificación a UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Ruta de la carpeta que se va a analizar
#$rutaCarpeta = Read-Host "Ingresa la ruta de la carpeta que deseas analizar"
$rutaCarpeta = "C:\Users\mjoca\Downloads\jdownloader_descargas"

# Obtener la lista de elementos (archivos y carpetas) en la carpeta
$contenidoCarpeta = Get-ChildItem -Path $rutaCarpeta
$contenidoCarpeta

# Inicializar el contador de intentos
$intentos = 0

# Función para validar la opción de análisis de archivos
function ValidarOpcion {
    param (
        [string]$opcion
    )

    # Opción para analizar todos los archivos
    if ($opcion -eq "s") {
        $extension = "*"  # Analizar todos los archivos
    }
    # Opción para analizar archivos específicos
    elseif ($opcion -eq "n") {
        # Solicitar al usuario que seleccione el tipo de archivo a analizar
        Write-Host "`nSelecciona el tipo de archivo que deseas analizar:"
        # Lista de opciones disponibles
        Write-Host "A. Documento de texto (TXT)"
        Write-Host "B. Presentacion (PPTX)"
        Write-Host "C. Imagen (JPG o JPEG)"
        Write-Host "D. Audio (MP3)"
        Write-Host "E. Video (MP4)"
        Write-Host "F. Documento de Word (DOCX)"
        Write-Host "G. Documento de Excel (XLSX)"
        Write-Host "H. Otros archivos"
		
		# Obtener la extensión basada en la opción del usuario
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

		# Crear un diccionario para almacenar archivos por extensión
		$archivosPorExtension = @{}

		# Recorrer la lista de archivos y agrupar por extensión
		foreach ($archivo in $contenidoCarpeta) {
			$extension = $archivo.Extension
			if ($archivosPorExtension.ContainsKey($extension)) {
				$archivosPorExtension[$extension] += @($archivo.Name)
			} else {
				$archivosPorExtension[$extension] = @($archivo.Name)
			}
		}

		# Mostrar archivos con la misma extensión por pantalla
		$archivos = $archivosPorExtension[$extension]
		if ($archivos -ne $null -and $archivos.Count -gt 1) {
			Write-Host "`nListado de los archivos con la extension especificada:"
			foreach ($archivo in $archivos) {
				Write-Host ("- " + (Get-Item (Join-Path -Path $rutaCarpeta -ChildPath $archivo)).Name)
			}
		}
	
    }
	# Manejar opción no válida
	else {
		Write-Host "`nOpcion no valida. Por favor, intentalo nuevamente."
		return $null
	}

	return $extension
}

# Función para cambiar el nombre de archivos en una carpeta
function CambiarNombreArchivos {
    param (
        [string]$ruta,
        [string]$extension,
        [string]$textoEliminar
    )
    
    # Inicializar el contador de archivos renombrados
    $contadorArchivos = 0 
    
    Write-Host ("`nArchivos renombrados:`n")

    # Obtener archivos que coincidan con la extensión
    Get-ChildItem -Path $ruta -Filter "*.$extension" | ForEach-Object {
        $nombreAntes = $_.Name
        $nuevoNombre = $_.Name -replace $textoEliminar -replace ' ',''
        Write-Host ("- {0} -> {1}" -f $nombreAntes, $nuevoNombre)
        Rename-Item -Path $_.FullName -NewName $nuevoNombre
        $contadorArchivos++  # Incrementar el contador por cada archivo renombrado
    }

    Write-Host "`nProceso completado satisfactoriamente."
    Write-Host "Se han renombrado $contadorArchivos archivos en total."
}

# Bucle para obtener la extensión correcta para el análisis
do {
    $intentos++
    if ($intentos -eq 3) {
        Write-Host "`nDemasiados intentos fallidos. Saliendo del programa."
        exit
    }

    $analizarTodos = Read-Host "`nDeseas analizar todos los archivos de la carpeta? (s/n)"

    $extension = ValidarOpcion $analizarTodos

} while ($extension -eq $null)

# Bucle principal para realizar operaciones hasta que el usuario decida salir
do {
    # Solicitar al usuario el texto que desea eliminar del nombre de los archivos
    $textoEliminar = Read-Host "`nPor favor, ingresa el texto que deseas eliminar del nombre de los archivos"

    # Llamar a la función para cambiar el nombre de los archivos
    CambiarNombreArchivos -ruta $rutaCarpeta -extension $extension -textoEliminar $textoEliminar

    # Preguntar al usuario si desea realizar otra operación
    $repetir = Read-Host "`nDeseas realizar otra operacion? (s/n)"
    if ($repetir -eq "s") {
        $intentos = 0
        # Bucle para obtener la extensión correcta para el análisis
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
