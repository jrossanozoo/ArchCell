
define class Din_Mapeoentidadesdetalles as ZooSession of ZooSession.prg
	*--------------------------------------------------------------------------------------------------------
	function ObtenerColeccionParaCombo( tcEntidad as string ) as zoocoleccion OF zoocoleccion.prg
		local loRetorno as zoocoleccion OF zoocoleccion.prg, loItem as object
	
		loRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
			do case
				case alltrim( upper( tcEntidad ) ) == [BOLSASYCAJAS]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [CANCELACIONDECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [CLIENTE]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Clientes'
					loItem.cNombre = 'CLIENTE'
					loItem.cDominioVisual = 'CODIGO'
					loItem.Etiqueta = 'Código'
					loItem.AtributoMuestraRelacion = 'Nombre'
					loRetorno.Agregar( loItem , 'CLIENTE' )
				case alltrim( upper( tcEntidad ) ) == [DATOSFISCALES]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Esquema de datos fiscales'
					loItem.cNombre = 'DATOSFISCALES'
					loItem.cDominioVisual = 'CODIGO'
					loItem.Etiqueta = 'Código'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'DATOSFISCALES' )
				case alltrim( upper( tcEntidad ) ) == [ENTREGADEMERCADERIAS]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Entrega de mercaderías'
					loItem.cNombre = 'ENTREGADEMERCADERIAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'ENTREGADEMERCADERIAS' )
				case alltrim( upper( tcEntidad ) ) == [FACTURAELECTRONICADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FERIADO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Feriados'
					loItem.cNombre = 'FERIADO'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Año'
					loItem.AtributoMuestraRelacion = 'anio'
					loRetorno.Agregar( loItem , 'FERIADO' )
				case alltrim( upper( tcEntidad ) ) == [IMPRESIONDEETIQUETA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [MOVIMIENTODESTOCK]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADECREDITOELECTRONICADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADEDEBITOELECTRONICADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [PREPARACIONDEMERCADERIA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [REMITODECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelación de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresión de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparación de mercadería'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'Número'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'Número interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
			otherwise
				goServicios.Errores.LevantarExcepcion( 'No se puede obtener información para determinar los comprobantes en los que pueda basarse' )
			endcase
		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerColeccionDeAtributosControles() as zoocoleccion OF zoocoleccion.prg
		local loRetorno as zoocoleccion OF zoocoleccion.prg
	
		loRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loRetorno.add( 'BOLSASYCAJAS' )
		loRetorno.add( 'CANCELACIONDECOMPRA' )
		loRetorno.add( 'CLIENTE' )
		loRetorno.add( 'DATOSFISCALES' )
		loRetorno.add( 'ENTREGADEMERCADERIAS' )
		loRetorno.add( 'FACTURAELECTRONICADECREDITO' )
		loRetorno.add( 'FERIADO' )
		loRetorno.add( 'IMPRESIONDEETIQUETA' )
		loRetorno.add( 'MOVIMIENTODESTOCK' )
		loRetorno.add( 'NOTADECREDITOELECTRONICADECREDITO' )
		loRetorno.add( 'NOTADEDEBITOELECTRONICADECREDITO' )
		loRetorno.add( 'PREPARACIONDEMERCADERIA' )
		loRetorno.add( 'REMITODECOMPRA' )
		return loRetorno
	endfunc


enddefine