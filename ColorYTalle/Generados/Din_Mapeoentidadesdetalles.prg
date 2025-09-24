
define class Din_Mapeoentidadesdetalles as ZooSession of ZooSession.prg
	*--------------------------------------------------------------------------------------------------------
	function ObtenerColeccionParaCombo( tcEntidad as string ) as zoocoleccion OF zoocoleccion.prg
		local loRetorno as zoocoleccion OF zoocoleccion.prg, loItem as object
	
		loRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
			do case
				case alltrim( upper( tcEntidad ) ) == [ASIENTO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Asientos'
					loItem.cNombre = 'ASIENTO'
					loItem.cDominioVisual = 'CODIGO'
					loItem.Etiqueta = 'Identificador'
					loItem.AtributoMuestraRelacion = 'Numero'
					loRetorno.Agregar( loItem , 'ASIENTO' )
				case alltrim( upper( tcEntidad ) ) == [BOLSASYCAJAS]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [CANCELACIONDECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [CLIENTE]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Clientes'
					loItem.cNombre = 'CLIENTE'
					loItem.cDominioVisual = 'CODIGO'
					loItem.Etiqueta = 'C�digo'
					loItem.AtributoMuestraRelacion = 'Nombre'
					loRetorno.Agregar( loItem , 'CLIENTE' )
				case alltrim( upper( tcEntidad ) ) == [DATOSFISCALES]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Esquema de datos fiscales'
					loItem.cNombre = 'DATOSFISCALES'
					loItem.cDominioVisual = 'CODIGO'
					loItem.Etiqueta = 'C�digo'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'DATOSFISCALES' )
				case alltrim( upper( tcEntidad ) ) == [DEVOLUCION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FACTURADECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FACTURADEEXPORTACION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FACTURAELECTRONICADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FACTURAELECTRONICAEXPORTACION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FACTURAELECTRONICA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FACTURA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [FERIADO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Feriados'
					loItem.cNombre = 'FERIADO'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'A�o'
					loItem.AtributoMuestraRelacion = 'anio'
					loRetorno.Agregar( loItem , 'FERIADO' )
				case alltrim( upper( tcEntidad ) ) == [FINALDEPRODUCCION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Finalizaci�n de producci�n'
					loItem.cNombre = 'FINALDEPRODUCCION'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'FINALDEPRODUCCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos desde producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKDESDEPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKDESDEPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos entre inventarios'
					loItem.cNombre = 'MOVIMIENTOSTOCKAINVENT'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAINVENT' )
				case alltrim( upper( tcEntidad ) ) == [IMPRESIONDEETIQUETA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [MERCADERIAENTRANSITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [MODIFICACIONPRECIOS]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [MOVIMIENTODESTOCK]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [MOVIMIENTOSTOCKAINVENT]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Finalizaci�n de producci�n'
					loItem.cNombre = 'FINALDEPRODUCCION'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'FINALDEPRODUCCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos desde producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKDESDEPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKDESDEPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos entre inventarios'
					loItem.cNombre = 'MOVIMIENTOSTOCKAINVENT'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAINVENT' )
				case alltrim( upper( tcEntidad ) ) == [MOVIMIENTOSTOCKAPRODUCC]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [MOVIMIENTOSTOCKDESDEPRODUCC]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Finalizaci�n de producci�n'
					loItem.cNombre = 'FINALDEPRODUCCION'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'FINALDEPRODUCCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos desde producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKDESDEPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKDESDEPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos entre inventarios'
					loItem.cNombre = 'MOVIMIENTOSTOCKAINVENT'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAINVENT' )
				case alltrim( upper( tcEntidad ) ) == [NOTADECREDITOCOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADECREDITODEEXPORTACION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADECREDITOELECTRONICADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADECREDITOELECTRONICAEXPORTACION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADECREDITOELECTRONICA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADEDEBITOCOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADEDEBITODEEXPORTACION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADEDEBITOELECTRONICADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADEDEBITOELECTRONICAEXPORTACION]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADEDEBITOELECTRONICA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [NOTADEDEBITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [PEDIDODECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [PEDIDO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [PREPARACIONDEMERCADERIA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [PRESUPUESTODECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [PRESUPUESTO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [REMITODECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [REMITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [REQUERIMIENTODECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [SOLICITUDDECOMPRA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [TICKETFACTURA]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [TICKETNOTADECREDITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
				case alltrim( upper( tcEntidad ) ) == [TICKETNOTADEDEBITO]
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Bolsas y cajas'
					loItem.cNombre = 'BOLSASYCAJAS'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'BOLSASYCAJAS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de compra'
					loItem.cNombre = 'CANCELACIONDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'CANCELACIONDECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Cancelaci�n de venta'
					loItem.cNombre = 'DEVOLUCION'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'DEVOLUCION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de compra'
					loItem.cNombre = 'FACTURADECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'FACTURAELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura de exportaci�n de venta'
					loItem.cNombre = 'FACTURADEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURADEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica de venta'
					loItem.cNombre = 'FACTURAELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura electr�nica exportaci�n de venta'
					loItem.cNombre = 'FACTURAELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURAELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura fiscal de venta'
					loItem.cNombre = 'TICKETFACTURA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETFACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Factura manual de venta'
					loItem.cNombre = 'FACTURA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'FACTURA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Impresi�n de etiquetas'
					loItem.cNombre = 'IMPRESIONDEETIQUETA'
					loItem.cDominioVisual = 'CODIGONUMERICO'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Descripcion'
					loRetorno.Agregar( loItem , 'IMPRESIONDEETIQUETA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Mercader�a en tr�nsito'
					loItem.cNombre = 'MERCADERIAENTRANSITO'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MERCADERIAENTRANSITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Modificaci�n de precios'
					loItem.cNombre = 'MODIFICACIONPRECIOS'
					loItem.cDominioVisual = 'CLAVEDEBUSQUEDA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MODIFICACIONPRECIOS' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de insumos a producci�n'
					loItem.cNombre = 'MOVIMIENTOSTOCKAPRODUCC'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTOSTOCKAPRODUCC' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Movimiento de stock'
					loItem.cNombre = 'MOVIMIENTODESTOCK'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Fecha'
					loRetorno.Agregar( loItem , 'MOVIMIENTODESTOCK' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de compra'
					loItem.cNombre = 'NOTADECREDITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota cr�dito'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito de exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADECREDITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTESINLETRA'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de cr�dito manual de venta'
					loItem.cNombre = 'NOTADECREDITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de compra'
					loItem.cNombre = 'NOTADEDEBITOCOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno nota d�bito.'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOCOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito de exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITODEEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITODEEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica MiPyME de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICADECREDITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICADECREDITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICA'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito electr�nica exportaci�n de venta'
					loItem.cNombre = 'NOTADEDEBITOELECTRONICAEXPORTACION'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITOELECTRONICAEXPORTACION' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito fiscal de venta'
					loItem.cNombre = 'TICKETNOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'TICKETNOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Nota de d�bito manual de venta'
					loItem.cNombre = 'NOTADEDEBITO'
					loItem.cDominioVisual = 'NUMEROPTOVTAEDITABLE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'NOTADEDEBITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de compra'
					loItem.cNombre = 'PEDIDODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Pedido de venta'
					loItem.cNombre = 'PEDIDO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PEDIDO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Preparaci�n de mercader�a'
					loItem.cNombre = 'PREPARACIONDEMERCADERIA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PREPARACIONDEMERCADERIA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de compra'
					loItem.cNombre = 'PRESUPUESTODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Presupuesto de venta'
					loItem.cNombre = 'PRESUPUESTO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'PRESUPUESTO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de compra'
					loItem.cNombre = 'REMITODECOMPRA'
					loItem.cDominioVisual = 'CLAVECANDIDATA'
					loItem.Etiqueta = 'N�mero interno'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Remito de venta'
					loItem.cNombre = 'REMITO'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REMITO' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Requerimiento de compra'
					loItem.cNombre = 'REQUERIMIENTODECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'REQUERIMIENTODECOMPRA' )
					loItem = _screen.zoo.CrearObjeto( 'ItemCombo' )
					loItem.cDescripcion = 'Solicitud de compra'
					loItem.cNombre = 'SOLICITUDDECOMPRA'
					loItem.cDominioVisual = 'NUMEROCOMPROBANTE'
					loItem.Etiqueta = 'N�mero'
					loItem.AtributoMuestraRelacion = 'Obs'
					loRetorno.Agregar( loItem , 'SOLICITUDDECOMPRA' )
			otherwise
				goServicios.Errores.LevantarExcepcion( 'No se puede obtener informaci�n para determinar los comprobantes en los que pueda basarse' )
			endcase
		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerColeccionDeAtributosControles() as zoocoleccion OF zoocoleccion.prg
		local loRetorno as zoocoleccion OF zoocoleccion.prg
	
		loRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loRetorno.add( 'ASIENTO' )
		loRetorno.add( 'BOLSASYCAJAS' )
		loRetorno.add( 'CANCELACIONDECOMPRA' )
		loRetorno.add( 'CLIENTE' )
		loRetorno.add( 'DATOSFISCALES' )
		loRetorno.add( 'DEVOLUCION' )
		loRetorno.add( 'FACTURADECOMPRA' )
		loRetorno.add( 'FACTURADEEXPORTACION' )
		loRetorno.add( 'FACTURAELECTRONICADECREDITO' )
		loRetorno.add( 'FACTURAELECTRONICAEXPORTACION' )
		loRetorno.add( 'FACTURAELECTRONICA' )
		loRetorno.add( 'FACTURA' )
		loRetorno.add( 'FERIADO' )
		loRetorno.add( 'FINALDEPRODUCCION' )
		loRetorno.add( 'IMPRESIONDEETIQUETA' )
		loRetorno.add( 'MERCADERIAENTRANSITO' )
		loRetorno.add( 'MODIFICACIONPRECIOS' )
		loRetorno.add( 'MOVIMIENTODESTOCK' )
		loRetorno.add( 'MOVIMIENTOSTOCKAINVENT' )
		loRetorno.add( 'MOVIMIENTOSTOCKAPRODUCC' )
		loRetorno.add( 'MOVIMIENTOSTOCKDESDEPRODUCC' )
		loRetorno.add( 'NOTADECREDITOCOMPRA' )
		loRetorno.add( 'NOTADECREDITODEEXPORTACION' )
		loRetorno.add( 'NOTADECREDITOELECTRONICADECREDITO' )
		loRetorno.add( 'NOTADECREDITOELECTRONICAEXPORTACION' )
		loRetorno.add( 'NOTADECREDITOELECTRONICA' )
		loRetorno.add( 'NOTADECREDITO' )
		loRetorno.add( 'NOTADEDEBITOCOMPRA' )
		loRetorno.add( 'NOTADEDEBITODEEXPORTACION' )
		loRetorno.add( 'NOTADEDEBITOELECTRONICADECREDITO' )
		loRetorno.add( 'NOTADEDEBITOELECTRONICAEXPORTACION' )
		loRetorno.add( 'NOTADEDEBITOELECTRONICA' )
		loRetorno.add( 'NOTADEDEBITO' )
		loRetorno.add( 'PEDIDODECOMPRA' )
		loRetorno.add( 'PEDIDO' )
		loRetorno.add( 'PREPARACIONDEMERCADERIA' )
		loRetorno.add( 'PRESUPUESTODECOMPRA' )
		loRetorno.add( 'PRESUPUESTO' )
		loRetorno.add( 'REMITODECOMPRA' )
		loRetorno.add( 'REMITO' )
		loRetorno.add( 'REQUERIMIENTODECOMPRA' )
		loRetorno.add( 'SOLICITUDDECOMPRA' )
		loRetorno.add( 'TICKETFACTURA' )
		loRetorno.add( 'TICKETNOTADECREDITO' )
		loRetorno.add( 'TICKETNOTADEDEBITO' )
		return loRetorno
	endfunc


enddefine