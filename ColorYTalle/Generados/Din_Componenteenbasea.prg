
define class Din_COMPONENTEENBASEA as Componente of Componente.prg
	nSigno = 0

	*-----------------------------------------------------------------------------------------
	function ObtenerColeccionParaCombo( tcComprobante as string ) as zoocoleccion OF zoocoleccion.prg
		local loRetorno as zoocoleccion OF zoocoleccion.prg, loItem as object
		
		loRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		
		do case
			case alltrim( upper( tcComprobante ) ) == 'FACTURA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito manual de venta'
				loItem.cNombre = 'Notadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito fiscal de venta'
				loItem.cNombre = 'Ticketnotadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica de venta'
				loItem.cNombre = 'Notadecreditoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadecreditoelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito manual de venta'
				loItem.cNombre = 'Notadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito fiscal de venta'
				loItem.cNombre = 'Ticketnotadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica de venta'
				loItem.cNombre = 'Notadecreditoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadecreditoelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura manual de venta'
				loItem.cNombre = 'Factura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura fiscal de venta'
				loItem.cNombre = 'Ticketfactura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Cancelación de venta'
				loItem.cNombre = 'Devolucion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica de venta'
				loItem.cNombre = 'Facturaelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Facturaelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito manual de venta'
				loItem.cNombre = 'Notadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito fiscal de venta'
				loItem.cNombre = 'Ticketnotadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica de venta'
				loItem.cNombre = 'Notadedebitoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadedebitoelectronicadecredito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura manual de venta'
				loItem.cNombre = 'Factura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura fiscal de venta'
				loItem.cNombre = 'Ticketfactura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Cancelación de venta'
				loItem.cNombre = 'Devolucion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica de venta'
				loItem.cNombre = 'Facturaelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Facturaelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito manual de venta'
				loItem.cNombre = 'Notadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito fiscal de venta'
				loItem.cNombre = 'Ticketnotadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica de venta'
				loItem.cNombre = 'Notadedebitoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadedebitoelectronicadecredito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADEDEBITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'FACTURADECOMPRA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de compra'
				loItem.cNombre = 'Remitodecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de compra'
				loItem.cNombre = 'Pedidodecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de compra'
				loItem.cNombre = 'Presupuestodecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOCOMPRA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de compra'
				loItem.cNombre = 'Facturadecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Cancelación de compra'
				loItem.cNombre = 'Cancelaciondecompra'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'REMITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura manual de venta'
				loItem.cNombre = 'Factura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura fiscal de venta'
				loItem.cNombre = 'Ticketfactura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica de venta'
				loItem.cNombre = 'Facturaelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Facturaelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'PEDIDO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito manual de venta'
				loItem.cNombre = 'Notadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito fiscal de venta'
				loItem.cNombre = 'Ticketnotadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica de venta'
				loItem.cNombre = 'Notadecreditoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadecreditoelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Cancelación de venta'
				loItem.cNombre = 'Devolucion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica de venta'
				loItem.cNombre = 'Facturaelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura manual de venta'
				loItem.cNombre = 'Factura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura fiscal de venta'
				loItem.cNombre = 'Ticketfactura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Facturaelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito manual de venta'
				loItem.cNombre = 'Notadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito fiscal de venta'
				loItem.cNombre = 'Ticketnotadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica de venta'
				loItem.cNombre = 'Notadedebitoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadedebitoelectronicadecredito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'PRESUPUESTODECOMPRA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Solicitud de compra'
				loItem.cNombre = 'Solicituddecompra'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica exportación de venta'
				loItem.cNombre = 'Notadecreditoelectronicaexportacion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICAEXPORTACION'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica exportación de venta'
				loItem.cNombre = 'Facturaelectronicaexportacion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica exportación de venta'
				loItem.cNombre = 'Notadedebitoelectronicaexportacion'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICAEXPORTACION'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'PEDIDODECOMPRA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de compra'
				loItem.cNombre = 'Presupuestodecompra'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'SOLICITUDDECOMPRA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Requerimiento de compra'
				loItem.cNombre = 'Requerimientodecompra'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'REMITODECOMPRA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de compra'
				loItem.cNombre = 'Pedidodecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Solicitud de compra'
				loItem.cNombre = 'Solicituddecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de compra'
				loItem.cNombre = 'Presupuestodecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de compra'
				loItem.cNombre = 'Pedidodecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de compra'
				loItem.cNombre = 'Remitodecompra'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Requerimiento de compra'
				loItem.cNombre = 'Requerimientodecompra'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito manual de venta'
				loItem.cNombre = 'Notadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito fiscal de venta'
				loItem.cNombre = 'Ticketnotadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica de venta'
				loItem.cNombre = 'Notadecreditoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito de exportación de venta'
				loItem.cNombre = 'Notadecreditodeexportacion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadecreditoelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura manual de venta'
				loItem.cNombre = 'Factura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura fiscal de venta'
				loItem.cNombre = 'Ticketfactura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Cancelación de venta'
				loItem.cNombre = 'Devolucion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica de venta'
				loItem.cNombre = 'Facturaelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de exportación de venta'
				loItem.cNombre = 'Facturadeexportacion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Facturaelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito de exportación de venta'
				loItem.cNombre = 'Notadedebitodeexportacion'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITODEEXPORTACION'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito manual de venta'
				loItem.cNombre = 'Notadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito fiscal de venta'
				loItem.cNombre = 'Ticketnotadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica de venta'
				loItem.cNombre = 'Notadecreditoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadecreditoelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura manual de venta'
				loItem.cNombre = 'Factura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura fiscal de venta'
				loItem.cNombre = 'Ticketfactura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Cancelación de venta'
				loItem.cNombre = 'Devolucion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica de venta'
				loItem.cNombre = 'Facturaelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Facturaelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito manual de venta'
				loItem.cNombre = 'Notadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito fiscal de venta'
				loItem.cNombre = 'Ticketnotadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica de venta'
				loItem.cNombre = 'Notadedebitoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadedebitoelectronicadecredito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOAGRUPADA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito manual de venta'
				loItem.cNombre = 'Notadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito fiscal de venta'
				loItem.cNombre = 'Ticketnotadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica de venta'
				loItem.cNombre = 'Notadecreditoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadecreditoelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Preparación de mercadería'
				loItem.cNombre = 'Preparaciondemercaderia'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Cancelación de venta'
				loItem.cNombre = 'Devolucion'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura electrónica de venta'
				loItem.cNombre = 'Facturaelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura manual de venta'
				loItem.cNombre = 'Factura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura fiscal de venta'
				loItem.cNombre = 'Ticketfactura'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Factura de crédito electrónica MiPyME de venta'
				loItem.cNombre = 'Facturaelectronicadecredito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito manual de venta'
				loItem.cNombre = 'Notadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito fiscal de venta'
				loItem.cNombre = 'Ticketnotadedebito'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica de venta'
				loItem.cNombre = 'Notadedebitoelectronica'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Nota de débito electrónica MiPyME de venta'
				loItem.cNombre = 'Notadedebitoelectronicadecredito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Remito de venta'
				loItem.cNombre = 'Remito'
				loRetorno.Agregar( loItem )
			case alltrim( upper( tcComprobante ) ) == 'PREPARACIONDEMERCADERIA'
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Pedido de venta'
				loItem.cNombre = 'Pedido'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Presupuesto de venta'
				loItem.cNombre = 'Presupuesto'
				loRetorno.Agregar( loItem )
				loItem = newobject( 'ItemCombo' )
				loItem.cDescripcion = 'Picking'
				loItem.cNombre = 'Picking'
				loRetorno.Agregar( loItem )
			otherwise
				local loex as exception
				
				loex = newobject(  "zooexception", "zooexception.prg" )
				with loex
					.message = "No se puede obtener información para determinar los comprobantes en los que pueda basarse " + tcComprobante + "."
					.details = .message
					.grabar()
					.throw()
				endwith
		endcase
		
		return loRetorno
	endfunc


	*-----------------------------------------------------------------------------------------
	function ModificaStock( tcComprobante as string ) as Boolean
		Local llRetorno as Boolean
		
		do case
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADEDEBITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOCOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURADECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOCOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'CANCELACIONDECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'PEDIDO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'PRESUPUESTODECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'SOLICITUDDECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICAEXPORTACION'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICAEXPORTACION'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICAEXPORTACION'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'PEDIDODECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'SOLICITUDDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REQUERIMIENTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'REMITODECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'SOLICITUDDECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REQUERIMIENTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITODEEXPORTACION'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURADEEXPORTACION'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITODEEXPORTACION'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'PREPARACIONDEMERCADERIA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'PREPARACIONDEMERCADERIA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			otherwise
				local loex as exception
				
				loex = newobject(  "zooexception", "zooexception.prg" )
				with loex
					if empty( this.cNombreEntidadAfectada )
						.message = "No se seteo correctamente la entidad Afectada"
					else
						.message = "No se puede obtener información para determinar si el comprobante " + tcComprobante + " en base a " + this.cNombreEntidadAfectada + " modifica stock."
					endif
					.details = .message
					.grabar()
					.throw()
				endwith
		endcase
		return llRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ModificaAfeStock( tcComprobante as string ) as Boolean
		Local llRetorno as Boolean
		
		do case
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETFACTURA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'TICKETNOTADEDEBITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOCOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURADECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOCOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'CANCELACIONDECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'REMITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'DEVOLUCION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'PEDIDO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'PRESUPUESTODECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'SOLICITUDDECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICAEXPORTACION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICAEXPORTACION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICAEXPORTACION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICAEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'PEDIDODECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'SOLICITUDDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REQUERIMIENTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'REMITODECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'SOLICITUDDECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDODECOMPRA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'CANCELACIONDECOMPRA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REQUERIMIENTODECOMPRA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITODEEXPORTACION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURADEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURADEEXPORTACION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITODEEXPORTACION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITODEEXPORTACION' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOAGRUPADA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'FACTURAELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'DEVOLUCION'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETFACTURA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'FACTURAELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'TICKETNOTADEDEBITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICA'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADECREDITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'NOTADEDEBITOELECTRONICADECREDITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'NOTADEDEBITOELECTRONICADECREDITO' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'REMITO'
				llRetorno = .F.
			case alltrim( upper( tcComprobante ) ) == 'PREPARACIONDEMERCADERIA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PEDIDO'
				llRetorno = .T.
			case alltrim( upper( tcComprobante ) ) == 'PREPARACIONDEMERCADERIA' and alltrim( upper( this.cNombreEntidadAfectada ) ) == 'PRESUPUESTO'
				llRetorno = .T.
			otherwise
				local loex as exception
				
				loex = newobject(  "zooexception", "zooexception.prg" )
				with loex
					if empty( this.cNombreEntidadAfectada )
						.message = "No se seteo correctamente la entidad Afectada"
					else
						.message = "No se puede obtener información para determinar si el comprobante " + tcComprobante + " en base a " + this.cNombreEntidadAfectada + " modifica stock."
					endif
					.details = .message
					.grabar()
					.throw()
				endwith
		endcase
		return llRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function SoportaBasadoEn( tcComprobante as string ) as Boolean
		Local llRetorno as Boolean
		
		llretorno = .f.
						llRetorno = inlist( upper( alltrim( tcComprobante ) ), 'FACTURA', 'TICKETFACTURA', 'NOTADECREDITO', 'NOTADEDEBITO', 'TICKETNOTADECREDITO', 'TICKETNOTADEDEBITO', 'FACTURADECOMPRA', 'NOTADECREDITOCOMPRA', 'REMITO', 'DEVOLUCION', 'PEDIDO', 'FACTURAELECTRONICA', 'NOTADECREDITOELECTRONICA', 'NOTADEDEBITOELECTRONICA', 'PRESUPUESTODECOMPRA', 'FACTURAELECTRONICAEXPORTACION', 'NOTADECREDITOELECTRONICAEXPORTACION', 'NOTADEDEBITOELECTRONICAEXPORTACION', 'PEDIDODECOMPRA', 'SOLICITUDDECOMPRA', 'REMITODECOMPRA', 'CANCELACIONDECOMPRA', 'FACTURADEEXPORTACION', 'NOTADECREDITODEEXPORTACION' ) ;
							or inlist( upper( alltrim( tcComprobante ) ), 'NOTADEDEBITODEEXPORTACION', 'FACTURAAGRUPADA', 'NOTADECREDITOAGRUPADA', 'NOTADEDEBITOAGRUPADA', 'FACTURAELECTRONICADECREDITO', 'NOTADECREDITOELECTRONICADECREDITO', 'NOTADEDEBITOELECTRONICADECREDITO', 'PREPARACIONDEMERCADERIA' )
		return llRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	protected function ObtenerNombreDeComprobante( tnTipoComprobante as integer ) as String
		Local lcRetorno as String
		
		lcretorno = ''
		do case
			case tnTipoComprobante = 1
				lcRetorno = 'Factura Manual De Venta'
			case tnTipoComprobante = 2
				lcRetorno = 'Factura Fiscal De Venta'
			case tnTipoComprobante = 3
				lcRetorno = 'Nota De Crédito Manual De Venta'
			case tnTipoComprobante = 4
				lcRetorno = 'Nota De Débito Manual De Venta'
			case tnTipoComprobante = 5
				lcRetorno = 'Nota De Crédito Fiscal De Venta'
			case tnTipoComprobante = 6
				lcRetorno = 'Nota De Débito Fiscal De Venta'
			case tnTipoComprobante = 8
				lcRetorno = 'Factura De Compra'
			case tnTipoComprobante = 10
				lcRetorno = 'Nota De Crédito De Compra'
			case tnTipoComprobante = 11
				lcRetorno = 'Remito De Venta'
			case tnTipoComprobante = 12
				lcRetorno = 'Cancelación De Venta'
			case tnTipoComprobante = 23
				lcRetorno = 'Pedido De Venta'
			case tnTipoComprobante = 25
				lcRetorno = 'Presupuesto De Venta'
			case tnTipoComprobante = 27
				lcRetorno = 'Factura Electrónica De Venta'
			case tnTipoComprobante = 28
				lcRetorno = 'Nota De Crédito Electrónica De Venta'
			case tnTipoComprobante = 29
				lcRetorno = 'Nota De Débito Electrónica De Venta'
			case tnTipoComprobante = 30
				lcRetorno = 'Presupuesto De Compra'
			case tnTipoComprobante = 33
				lcRetorno = 'Factura Electrónica Exportación De Venta'
			case tnTipoComprobante = 35
				lcRetorno = 'Nota De Crédito Electrónica Exportación De Venta'
			case tnTipoComprobante = 36
				lcRetorno = 'Nota De Débito Electrónica Exportación De Venta'
			case tnTipoComprobante = 38
				lcRetorno = 'Pedido De Compra'
			case tnTipoComprobante = 39
				lcRetorno = 'Solicitud De Compra'
			case tnTipoComprobante = 40
				lcRetorno = 'Remito De Compra'
			case tnTipoComprobante = 41
				lcRetorno = 'Cancelación De Compra'
			case tnTipoComprobante = 42
				lcRetorno = 'Requerimiento De Compra'
			case tnTipoComprobante = 47
				lcRetorno = 'Factura De Exportación De Venta'
			case tnTipoComprobante = 48
				lcRetorno = 'Nota De Crédito De Exportación De Venta'
			case tnTipoComprobante = 49
				lcRetorno = 'Nota De Débito De Exportación De Venta'
			case tnTipoComprobante = 51
				lcRetorno = 'Factura'
			case tnTipoComprobante = 52
				lcRetorno = 'Nota De Crédito'
			case tnTipoComprobante = 53
				lcRetorno = 'Nota De Débito'
			case tnTipoComprobante = 54
				lcRetorno = 'Factura De Crédito Electrónica Mipyme De Venta'
			case tnTipoComprobante = 55
				lcRetorno = 'Nota De Crédito Electrónica Mipyme De Venta'
			case tnTipoComprobante = 56
				lcRetorno = 'Nota De Débito Electrónica Mipyme De Venta'
			case tnTipoComprobante = 57
				lcRetorno = 'Preparación De Mercadería'
			otherwise
				lcRetorno = '[' + transform( tnTipoComprobante ) + '] Comprobante Desconocido'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function EsComprobanteAfectado( tcComprobante as string ) as Boolean
		Local llRetorno as Boolean
		
		llretorno = .f.
						llRetorno = inlist( upper( alltrim( tcComprobante ) ), 'FACTURA', 'TICKETFACTURA', 'NOTADECREDITO', 'NOTADEDEBITO', 'TICKETNOTADECREDITO', 'TICKETNOTADEDEBITO', 'FACTURADECOMPRA', 'REMITO', 'DEVOLUCION', 'PEDIDO', 'PRESUPUESTO', 'FACTURAELECTRONICA', 'NOTADECREDITOELECTRONICA', 'NOTADEDEBITOELECTRONICA', 'PRESUPUESTODECOMPRA', 'FACTURAELECTRONICAEXPORTACION', 'NOTADECREDITOELECTRONICAEXPORTACION', 'NOTADEDEBITOELECTRONICAEXPORTACION', 'PEDIDODECOMPRA', 'SOLICITUDDECOMPRA', 'REMITODECOMPRA', 'CANCELACIONDECOMPRA', 'REQUERIMIENTODECOMPRA', 'FACTURADEEXPORTACION' ) ;
							or inlist( upper( alltrim( tcComprobante ) ), 'NOTADECREDITODEEXPORTACION', 'NOTADEDEBITODEEXPORTACION', 'FACTURAELECTRONICADECREDITO', 'NOTADECREDITOELECTRONICADECREDITO', 'NOTADEDEBITOELECTRONICADECREDITO', 'PREPARACIONDEMERCADERIA' )
		return llRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	protected function ObtenerNombreDeEntidad( tnTipoComprobante as integer ) as String
		Local lcRetorno as String
		
		lcretorno = ''
		do case
			case tnTipoComprobante = 1
				lcRetorno = 'Factura'
			case tnTipoComprobante = 2
				lcRetorno = 'Ticketfactura'
			case tnTipoComprobante = 3
				lcRetorno = 'Notadecredito'
			case tnTipoComprobante = 4
				lcRetorno = 'Notadedebito'
			case tnTipoComprobante = 5
				lcRetorno = 'Ticketnotadecredito'
			case tnTipoComprobante = 6
				lcRetorno = 'Ticketnotadedebito'
			case tnTipoComprobante = 8
				lcRetorno = 'Facturadecompra'
			case tnTipoComprobante = 10
				lcRetorno = 'Notadecreditocompra'
			case tnTipoComprobante = 11
				lcRetorno = 'Remito'
			case tnTipoComprobante = 12
				lcRetorno = 'Devolucion'
			case tnTipoComprobante = 23
				lcRetorno = 'Pedido'
			case tnTipoComprobante = 25
				lcRetorno = 'Presupuesto'
			case tnTipoComprobante = 27
				lcRetorno = 'Facturaelectronica'
			case tnTipoComprobante = 28
				lcRetorno = 'Notadecreditoelectronica'
			case tnTipoComprobante = 29
				lcRetorno = 'Notadedebitoelectronica'
			case tnTipoComprobante = 30
				lcRetorno = 'Presupuestodecompra'
			case tnTipoComprobante = 33
				lcRetorno = 'Facturaelectronicaexportacion'
			case tnTipoComprobante = 35
				lcRetorno = 'Notadecreditoelectronicaexportacion'
			case tnTipoComprobante = 36
				lcRetorno = 'Notadedebitoelectronicaexportacion'
			case tnTipoComprobante = 38
				lcRetorno = 'Pedidodecompra'
			case tnTipoComprobante = 39
				lcRetorno = 'Solicituddecompra'
			case tnTipoComprobante = 40
				lcRetorno = 'Remitodecompra'
			case tnTipoComprobante = 41
				lcRetorno = 'Cancelaciondecompra'
			case tnTipoComprobante = 42
				lcRetorno = 'Requerimientodecompra'
			case tnTipoComprobante = 47
				lcRetorno = 'Facturadeexportacion'
			case tnTipoComprobante = 48
				lcRetorno = 'Notadecreditodeexportacion'
			case tnTipoComprobante = 49
				lcRetorno = 'Notadedebitodeexportacion'
			case tnTipoComprobante = 51
				lcRetorno = 'Facturaagrupada'
			case tnTipoComprobante = 52
				lcRetorno = 'Notadecreditoagrupada'
			case tnTipoComprobante = 53
				lcRetorno = 'Notadedebitoagrupada'
			case tnTipoComprobante = 54
				lcRetorno = 'Facturaelectronicadecredito'
			case tnTipoComprobante = 55
				lcRetorno = 'Notadecreditoelectronicadecredito'
			case tnTipoComprobante = 56
				lcRetorno = 'Notadedebitoelectronicadecredito'
			case tnTipoComprobante = 57
				lcRetorno = 'Preparaciondemercaderia'
			otherwise
				lcRetorno = '[' + transform( tnTipoComprobante ) + '] Comprobante Desconocido'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerColeccionEntidadSegunDescripcion( ) as zoocoleccion OF zoocoleccion.prg
		local loRetorno as zoocoleccion OF zoocoleccion.prg
		
		loRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loRetorno.Agregar( 'CANCELACIONDECOMPRA','CANCELACIÓN DE COMPRA')
		loRetorno.Agregar( 'DEVOLUCION','CANCELACIÓN DE VENTA')
		loRetorno.Agregar( 'FACTURAAGRUPADA','FACTURA')
		loRetorno.Agregar( 'FACTURAELECTRONICA','FACTURA ELECTRÓNICA DE VENTA')
		loRetorno.Agregar( 'FACTURAELECTRONICADECREDITO','FACTURA DE CRÉDITO ELECTRÓNICA MIPYME DE VENTA')
		loRetorno.Agregar( 'FACTURAELECTRONICAEXPORTACION','FACTURA ELECTRÓNICA EXPORTACIÓN DE VENTA')
		loRetorno.Agregar( 'FACTURA','FACTURA MANUAL DE VENTA')
		loRetorno.Agregar( 'FACTURADECOMPRA','FACTURA DE COMPRA')
		loRetorno.Agregar( 'FACTURADEEXPORTACION','FACTURA DE EXPORTACIÓN DE VENTA')
		loRetorno.Agregar( 'NOTADECREDITOAGRUPADA','NOTA DE CRÉDITO')
		loRetorno.Agregar( 'NOTADECREDITOELECTRONICA','NOTA DE CRÉDITO ELECTRÓNICA DE VENTA')
		loRetorno.Agregar( 'NOTADECREDITOELECTRONICADECREDITO','NOTA DE CRÉDITO ELECTRÓNICA MIPYME DE VENTA')
		loRetorno.Agregar( 'NOTADECREDITOELECTRONICAEXPORTACION','NOTA DE CRÉDITO ELECTRÓNICA EXPORTACIÓN DE VENTA')
		loRetorno.Agregar( 'NOTADEDEBITOAGRUPADA','NOTA DE DÉBITO')
		loRetorno.Agregar( 'NOTADEDEBITOELECTRONICA','NOTA DE DÉBITO ELECTRÓNICA DE VENTA')
		loRetorno.Agregar( 'NOTADEDEBITOELECTRONICADECREDITO','NOTA DE DÉBITO ELECTRÓNICA MIPYME DE VENTA')
		loRetorno.Agregar( 'NOTADEDEBITOELECTRONICAEXPORTACION','NOTA DE DÉBITO ELECTRÓNICA EXPORTACIÓN DE VENTA')
		loRetorno.Agregar( 'NOTADECREDITO','NOTA DE CRÉDITO MANUAL DE VENTA')
		loRetorno.Agregar( 'NOTADECREDITOCOMPRA','NOTA DE CRÉDITO DE COMPRA')
		loRetorno.Agregar( 'NOTADECREDITODEEXPORTACION','NOTA DE CRÉDITO DE EXPORTACIÓN DE VENTA')
		loRetorno.Agregar( 'NOTADEDEBITO','NOTA DE DÉBITO MANUAL DE VENTA')
		loRetorno.Agregar( 'NOTADEDEBITODEEXPORTACION','NOTA DE DÉBITO DE EXPORTACIÓN DE VENTA')
		loRetorno.Agregar( 'PEDIDO','PEDIDO DE VENTA')
		loRetorno.Agregar( 'PICKING','PICKING')
		loRetorno.Agregar( 'PRESUPUESTODECOMPRA','PRESUPUESTO DE COMPRA')
		loRetorno.Agregar( 'PEDIDODECOMPRA','PEDIDO DE COMPRA')
		loRetorno.Agregar( 'PREPARACIONDEMERCADERIA','PREPARACIÓN DE MERCADERÍA')
		loRetorno.Agregar( 'REMITO','REMITO DE VENTA')
		loRetorno.Agregar( 'REMITODECOMPRA','REMITO DE COMPRA')
		loRetorno.Agregar( 'SOLICITUDDECOMPRA','SOLICITUD DE COMPRA')
		loRetorno.Agregar( 'TICKETFACTURA','FACTURA FISCAL DE VENTA')
		loRetorno.Agregar( 'TICKETNOTADECREDITO','NOTA DE CRÉDITO FISCAL DE VENTA')
		loRetorno.Agregar( 'TICKETNOTADEDEBITO','NOTA DE DÉBITO FISCAL DE VENTA')
		
		return loRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerFiltroPorTipoComprobanteBuscador( toBusqueda as Object, tcTipoComprobante as String ) as string 
		*** Este método se subclasea ***
		return ''
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerJoinParaFiltroDeBuscadorEspecifico( toBusqueda as Object, tcTipoComprobante as String ) as string 
		*** Este método se subclasea ***
		return ''
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerWhereParaFiltroDeBuscadorEspecifico( toBusqueda as Object, tcTipoComprobante as String ) as string 
		*** Este método se subclasea ***
		return ''
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerTablasConcatenadasParaFiltroDeBuscadorEspecifico( toBusqueda as Object, tcTipoComprobante as String ) as String 
		*** Este método se subclasea ***
		return ''
	endfunc

enddefine

******************************************************************************************
Define class ItemCombo as custom
	cDescripcion = ''
	cNombre = ''
EndDefine