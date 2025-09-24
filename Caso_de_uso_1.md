# Caso de Uso 1: Validaci�n de Tope de Cuenta Corriente en Facturaci�n

## Descripci�n del Requerimiento

Agregar una validaci�n al proceso de grabaci�n de facturas para que no permita grabar una factura si tiene un c�digo de cliente y este no tiene definido un tope de cuenta corriente.

## An�lisis T�cnico

### Investigaci�n Inicial

1. **Archivo Principal**: `/home/jrossano/repo/Legacy/Felino/Ventas/ent_Factura.prg`
   - Clase: `Ent_Factura` que hereda de `Din_EntidadFactura`
   - M�todo existente: `AntesDeGrabar()` que ya conten�a validaciones previas

2. **Estructura de Validaci�n Existente**:
   - Ya exist�a una validaci�n `ValidarLetraSegunSituacionFiscal()` 
   - Patr�n establecido para agregar nuevas validaciones en `AntesDeGrabar()`

3. **Entidad Cliente**:
   - Archivo: `/home/jrossano/repo/Legacy/Felino/Generados/Din_EntidadCliente.prg`
   - Propiedad relevante: `Credito = 0` (tope de cuenta corriente)
   - Propiedad de identificaci�n: `Codigo = []`

4. **Sistema de Control de L�mite de Cr�dito**:
   - Encontrada referencia en `ent_ComprobanteDeVentas.prg`
   - Propiedad: `nTopeDelCliente = 0`
   - Funci�n: `ObtenerTopeDelCliente()` (implementaci�n vac�a, se bindea desde kontroler)

## Implementaci�n

### Cambios Realizados

#### 1. Modificaci�n del M�todo `AntesDeGrabar()`

**Ubicaci�n**: `/home/jrossano/repo/Legacy/Felino/Ventas/ent_Factura.prg` - L�neas 23-32

**Cambio**:
```prg
Function AntesDeGrabar() As Boolean
    local llRetorno as Boolean
    llRetorno = dodefault()
    if llRetorno
        llRetorno = this.ValidarLetraSegunSituacionFiscal()
    endif
    if llRetorno
        llRetorno = this.ValidarTopeDeCredito()  // NUEVO
    endif
    return llRetorno
endfunc
```

#### 2. Nueva Funci�n de Validaci�n

**Ubicaci�n**: `/home/jrossano/repo/Legacy/Felino/Ventas/ent_Factura.prg` - L�neas 55-67

**Implementaci�n**:
```prg
protected function ValidarTopeDeCredito() as Boolean
    local llRetorno as Boolean
    llRetorno = .T.
    
    if vartype( this.Cliente ) = "O" and !isnull( this.Cliente ) and !empty( this.Cliente.Codigo )
        if this.Cliente.Credito <= 0
            llRetorno = .F.
            goMensajes.Advertir( "El cliente " + alltrim( this.Cliente.Codigo ) + " no tiene definido un tope de cuenta corriente." )
        endif
    endif
    
    return llRetorno
endfunc
```

## L�gica de Validaci�n

### Condiciones Verificadas

1. **Existencia del Cliente**: 
   - `vartype( this.Cliente ) = "O"` - Verifica que Cliente sea un objeto
   - `!isnull( this.Cliente )` - Verifica que no sea nulo

2. **Cliente con C�digo**: 
   - `!empty( this.Cliente.Codigo )` - Solo valida si el cliente tiene c�digo definido

3. **Tope de Cuenta Corriente**: 
   - `this.Cliente.Credito <= 0` - Verifica que el tope sea mayor a cero

### Comportamiento

- **Si no hay cliente**: La validaci�n pasa (no aplica)
- **Si hay cliente sin c�digo**: La validaci�n pasa (no aplica)
- **Si hay cliente con c�digo pero sin tope**: La validaci�n falla, impide el grabado
- **Si hay cliente con c�digo y con tope > 0**: La validaci�n pasa

## Integraci�n con el Sistema

### Patr�n de Dise�o Utilizado

- **Template Method**: Uso del m�todo `AntesDeGrabar()` que es llamado autom�ticamente antes del grabado
- **Chain of Responsibility**: Las validaciones se ejecutan en secuencia, si una falla, se detiene el proceso
- **Factory Pattern**: Uso de `goMensajes.Advertir()` para mostrar mensajes al usuario

### Compatibilidad

- **Herencia**: La funci�n respeta la herencia existente llamando a `dodefault()`
- **Patr�n Existente**: Sigue el mismo patr�n que `ValidarLetraSegunSituacionFiscal()`
- **Mensajer�a**: Utiliza el sistema de mensajes global existente (`goMensajes`)

## Pruebas Sugeridas

### Casos de Prueba

1. **Factura sin cliente**: Deber�a grabar normalmente
2. **Factura con cliente sin c�digo**: Deber�a grabar normalmente  
3. **Factura con cliente con c�digo pero Credito = 0**: No deber�a grabar, mostrar mensaje
4. **Factura con cliente con c�digo pero Credito < 0**: No deber�a grabar, mostrar mensaje
5. **Factura con cliente con c�digo y Credito > 0**: Deber�a grabar normalmente

### Mensaje de Error

```
"El cliente [CODIGO_CLIENTE] no tiene definido un tope de cuenta corriente."
```

## Consideraciones T�cnicas

### Ventajas de la Implementaci�n

- **M�nimo Impacto**: Solo afecta el archivo de factura espec�fico
- **Reutilizable**: El patr�n puede aplicarse a otros comprobantes
- **Mantenible**: Funci�n separada y bien documentada
- **Consistente**: Sigue las convenciones del c�digo existente

### Posibles Extensiones Futuras

- Aplicar la misma validaci�n a otros tipos de comprobantes
- Parametrizar el comportamiento (advertir vs. bloquear)
- Agregar validaciones adicionales relacionadas con cuenta corriente
- Integrar con el sistema de l�mites de cr�dito existente

## Archivos Modificados

- `/home/jrossano/repo/Legacy/Felino/Ventas/ent_Factura.prg`

## Archivos Analizados (Sin Modificar)

- `/home/jrossano/repo/Legacy/Felino/Generados/Din_EntidadCliente.prg`
- `/home/jrossano/repo/Legacy/Felino/Ventas/ent_ComprobanteDeVentas.prg`
- Varios archivos generados relacionados con clientes y cr�ditos
