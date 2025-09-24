# Migraci�n de ManejoArchivos a .NET Core

## Resumen de Cambios

Este documento detalla la modernizaci�n de la clase `ManejoArchivos` original hacia `ManejoArchivosCore`, reemplazando el uso de `Scripting.FileSystemObject` (COM) por las clases nativas de .NET Core para operaciones con archivos y carpetas.

## Equivalencias .NET Core vs Scripting.FileSystemObject

### Principales Clases .NET Core Utilizadas

| Funcionalidad | Scripting.FileSystemObject | .NET Core Equivalente |
|---------------|----------------------------|------------------------|
| Verificar existencia de archivo | `FileExists()` | `System.IO.File.Exists()` |
| Verificar existencia de carpeta | `FolderExists()` | `System.IO.Directory.Exists()` |
| Crear carpeta | `CreateFolder()` | `System.IO.Directory.CreateDirectory()` |
| Eliminar archivo | `DeleteFile()` | `System.IO.File.Delete()` |
| Eliminar carpeta | Custom recursion | `System.IO.Directory.Delete(path, recursive)` |
| Copiar archivo | `CopyFile()` | `System.IO.File.Copy()` |
| Mover archivo | `MoveFile()` | `System.IO.File.Move()` |
| Leer archivo | `OpenTextFile().ReadAll()` | `System.IO.File.ReadAllText()` |
| Escribir archivo | `OpenTextFile().Write()` | `System.IO.File.WriteAllText()` |
| Obtener archivos | Custom enumeration | `System.IO.Directory.GetFiles()` |
| Manipular rutas | String manipulation | `System.IO.Path.*` methods |

### Ventajas de .NET Core sobre FileSystemObject

1. **Multiplataforma**: Funciona en Windows, Linux, macOS
2. **Mejor rendimiento**: M�todos nativos sin overhead de COM
3. **Seguridad mejorada**: Mejor manejo de excepciones y validaci�n
4. **Soporte de encoding**: UTF-8, ASCII, Unicode nativo
5. **API moderna**: M�todos s�ncronos y as�ncronos disponibles
6. **Mejor manejo de rutas**: `Path.Combine()` es multiplataforma
7. **Sin dependencias COM**: No requiere registro de componentes

## Nuevos M�todos Implementados

### M�todos de Verificaci�n
```foxpro
* Reemplaza: Directory() y File()
this.ExisteArchivo(tcRuta)      // System.IO.File.Exists()
this.ExisteDirectorio(tcRuta)   // System.IO.Directory.Exists()
```

### M�todos de Manipulaci�n de Archivos
```foxpro
* Mejorados con mejor manejo de errores y encoding
this.LeerArchivo(tcRuta, tcEncoding)           // System.IO.File.ReadAllText()
this.EscribirArchivo(tcRuta, tcContenido, tcEncoding)  // System.IO.File.WriteAllText()
this.CopiarArchivo(tcOrigen, tcDestino, tlSobreEscribir)  // System.IO.File.Copy()
this.MoverArchivo(tcOrigen, tcDestino, tlSobreEscribir)   // System.IO.File.Move()
this.BorrarArchivo(tcArchivo)                  // System.IO.File.Delete()
```

### M�todos de Manipulaci�n de Carpetas
```foxpro
* Simplificados y m�s robustos
this.CrearCarpeta(tcCarpeta)     // System.IO.Directory.CreateDirectory()
this.BorrarCarpeta(tcCarpeta)    // System.IO.Directory.Delete(path, true)
```

### M�todos de Manipulaci�n de Rutas (Multiplataforma)
```foxpro
* Nuevos m�todos multiplataforma
this.CombinarRutas(tcRuta1, tcRuta2, tcRuta3, tcRuta4)  // System.IO.Path.Combine()
this.ObtenerDirectorioPadre(tcRuta)        // System.IO.Path.GetDirectoryName()
this.ObtenerNombreArchivo(tcRuta, tlSinExt) // System.IO.Path.GetFileName()
this.ObtenerExtension(tcRuta)              // System.IO.Path.GetExtension()
```

### M�todos de Informaci�n de Archivos
```foxpro
* Informaci�n detallada con System.IO.FileInfo
this.ObtenerInformacionArchivo(tcRuta)
* Retorna objeto con:
* - Existe, Nombre, Extension, DirectorioPadre
* - Tama�o, FechaCreacion, FechaModificacion, FechaAcceso
* - SoloLectura
```

### M�todos de Enumeraci�n Mejorados
```foxpro
* Con soporte para patrones y recursividad
this.ObtenerArchivosEnDirectorio(tcDir, tcPatron, tlRecursivo)
this.ObtenerDirectoriosEnDirectorio(tcDir, tcPatron, tlRecursivo)
```

### M�todos para Archivos Binarios
```foxpro
* Nuevos m�todos para datos binarios
this.LeerArchivoBinario(tcRuta)              // System.IO.File.ReadAllBytes()
this.EscribirArchivoBinario(tcRuta, tcDatos) // System.IO.File.WriteAllBytes()
```

### M�todos de Archivos Temporales
```foxpro
* Rutas temporales del sistema
this.ObtenerRutaTemporal()     // System.IO.Path.GetTempPath()
this.ObtenerArchivoTemporal()  // System.IO.Path.GetTempFileName()
```

## Mejoras de Arquitectura

### 1. Manejo de Errores Unificado
- Todas las operaciones tienen manejo de excepciones
- Sistema de logging centralizado con fallback
- Mensajes de error descriptivos con detalles t�cnicos

### 2. Soporte de Encoding
- UTF-8 por defecto (est�ndar moderno)
- Soporte para ASCII y Unicode
- Especificaci�n expl�cita de encoding en lectura/escritura

### 3. Operaciones At�micas
- Mejor manejo de operaciones de movimiento con sobreescritura
- Validaciones previas para evitar estados inconsistentes

### 4. Compatibilidad Hacia Atr�s
- M�todos wrapper para mantener compatibilidad con c�digo existente
- Mismo comportamiento en m�todos de di�logo (GetFile, GetPict, GetDir)

## M�todos Eliminados/Reemplazados

### Eliminados (Obsoletos en .NET Core)
- `SetearAtributos()`: Reemplazado por `SetearAtributosSoloLectura()`
- `GetAttribFile()`: Los atributos se manejan con `FileInfo.IsReadOnly`
- `SetAttribFile()`: Simplificado a solo lectura (m�s com�n)
- `WinSetFileTime()`: Reemplazado por propiedades de `FileInfo`
- M�todos de Win32 API: Reemplazados por APIs nativas .NET

### Simplificados
- Eliminaci�n de recursividad manual (Directory.Delete la maneja)
- Eliminaci�n de manejo manual de atributos de archivos
- Eliminaci�n de APIs Win32 para fechas y atributos

## Uso de la Nueva Clase

### Migraci�n B�sica
```foxpro
* Antes (ManejoArchivos original)
loManejo = NEWOBJECT("ManejoArchivos", "ManejoArchivos.prg")
loManejo.CrearCarpeta("C:\MiCarpeta")
lcContenido = loManejo.LeerArchivo("C:\archivo.txt")

* Despu�s (ManejoArchivosCore)
loManejo = NEWOBJECT("ManejoArchivosCore", "ManejoArchivosCore.prg")
loManejo.CrearCarpeta("C:\MiCarpeta")
lcContenido = loManejo.LeerArchivo("C:\archivo.txt", "UTF8")
```

### Nuevas Capacidades
```foxpro
* Rutas multiplataforma
lcRuta = loManejo.CombinarRutas("C:\Base", "SubCarpeta", "archivo.txt")

* Informaci�n detallada
loInfo = loManejo.ObtenerInformacionArchivo("C:\archivo.txt")
? loInfo.Tama�o, loInfo.FechaModificacion

* B�squeda con patrones
loArchivos = loManejo.ObtenerArchivosEnDirectorio("C:\", "*.txt", .T.)
```

## Consideraciones de Rendimiento

1. **Mejor rendimiento**: APIs nativas vs COM
2. **Menor uso de memoria**: Sin overhead de componentes COM
3. **Operaciones at�micas**: Menor riesgo de corrupci�n de datos
4. **Caching autom�tico**: .NET Core optimiza operaciones de I/O

## Requisitos

- Framework .NET Core 3.1 o superior
- Zoo framework con soporte para creaci�n de objetos .NET
- Sistema operativo: Windows, Linux, o macOS

## Migraci�n Recomendada

1. **Fase 1**: Implementar `ManejoArchivosCore` en paralelo
2. **Fase 2**: Migrar m�dulos no cr�ticos para pruebas
3. **Fase 3**: Migraci�n gradual de m�dulos cr�ticos
4. **Fase 4**: Deprecar `ManejoArchivos` original

La nueva implementaci�n mantiene compatibilidad funcional mientras ofrece mejor rendimiento, seguridad y capacidades multiplataforma.
