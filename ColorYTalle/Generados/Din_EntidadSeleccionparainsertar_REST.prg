
define class Din_EntidadSeleccionparainsertar_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Seleccionparainsertar"
	cClaseResponse = this.cNamespaceDTOs + ".SeleccionparainsertarResponse"
	cClaseModelo = "SeleccionparainsertarModelo"
	cEntidad = "Seleccionparainsertar"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Codigo" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Codigo = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Codigo = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarListarRequest"
			case "Accion" $ tcOperacion
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			otherwise
				goServicios.Errores.LevantarExcepcionTexto( tcOperacion + " no implementada.")
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseResponse( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarModelo"
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerCursorIds( toEntidad as Object, tcFiltro as String, tcOrderBy as String, tnCantidad as Integer, tnPagina as Integer ) as String
		return toEntidad.oAd.ObtenerIdentificadoresPaginado( tcOrderBy, tcFiltro, tnCantidad, tnPagina )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearEntidadConDatosModelo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		with toEntidad
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Asiento", toEntidad, "Asiento_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bolsasycajas", toEntidad, "Bolsasycajas_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cancelaciondecompra", toEntidad, "Cancelaciondecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosfiscales", toEntidad, "Datosfiscales_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Devolucion", toEntidad, "Devolucion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidad", toEntidad, "Entidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Factura", toEntidad, "Factura_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturadecompra", toEntidad, "Facturadecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturadeexportacion", toEntidad, "Facturadeexportacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronica", toEntidad, "Facturaelectronica_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronicadecredito", toEntidad, "Facturaelectronicadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronicaexportacion", toEntidad, "Facturaelectronicaexportacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Feriado", toEntidad, "Feriado_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Finaldeproduccion", toEntidad, "Finaldeproduccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impresiondeetiqueta", toEntidad, "Impresiondeetiqueta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mercaderiaentransito", toEntidad, "Mercaderiaentransito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modificacionprecios", toEntidad, "Modificacionprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movimientodestock", toEntidad, "Movimientodestock_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movimientostockainvent", toEntidad, "Movimientostockainvent_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movimientostockaproducc", toEntidad, "Movimientostockaproducc_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movimientostockdesdeproducc", toEntidad, "Movimientostockdesdeproducc_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadecredito", toEntidad, "Notadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadecreditocompra", toEntidad, "Notadecreditocompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadecreditodeexportacion", toEntidad, "Notadecreditodeexportacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadecreditoelectronica", toEntidad, "Notadecreditoelectronica_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadecreditoelectronicadecredito", toEntidad, "Notadecreditoelectronicadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadecreditoelectronicaexportacion", toEntidad, "Notadecreditoelectronicaexportacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadedebito", toEntidad, "Notadedebito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadedebitocompra", toEntidad, "Notadedebitocompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadedebitodeexportacion", toEntidad, "Notadedebitodeexportacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadedebitoelectronica", toEntidad, "Notadedebitoelectronica_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadedebitoelectronicadecredito", toEntidad, "Notadedebitoelectronicadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadedebitoelectronicaexportacion", toEntidad, "Notadedebitoelectronicaexportacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedido", toEntidad, "Pedido_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidodecompra", toEntidad, "Pedidodecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preparaciondemercaderia", toEntidad, "Preparaciondemercaderia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Presupuesto", toEntidad, "Presupuesto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Presupuestodecompra", toEntidad, "Presupuestodecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Remito", toEntidad, "Remito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Remitodecompra", toEntidad, "Remitodecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Requerimientodecompra", toEntidad, "Requerimientodecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Solicituddecompra", toEntidad, "Solicituddecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ticketfactura", toEntidad, "Ticketfactura_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ticketnotadecredito", toEntidad, "Ticketnotadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ticketnotadedebito", toEntidad, "Ticketnotadedebito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordenar", toEntidad, "Ordenar" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "ASIENTO", toEntidad.ASIENTO_PK)
			this.SetearAtributoString( toModeloResponse, "BOLSASYCAJAS", toEntidad.BOLSASYCAJAS_PK)
			this.SetearAtributoString( toModeloResponse, "CANCELACIONDECOMPRA", toEntidad.CANCELACIONDECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "CLIENTE", toEntidad.CLIENTE_PK)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "DATOSFISCALES", toEntidad.DATOSFISCALES_PK)
			this.SetearAtributoString( toModeloResponse, "DEVOLUCION", toEntidad.DEVOLUCION_PK)
			this.SetearAtributoString( toModeloResponse, "Entidad", toEntidad.Entidad)
			this.SetearAtributoString( toModeloResponse, "FACTURA", toEntidad.FACTURA_PK)
			this.SetearAtributoString( toModeloResponse, "FACTURADECOMPRA", toEntidad.FACTURADECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "FACTURADEEXPORTACION", toEntidad.FACTURADEEXPORTACION_PK)
			this.SetearAtributoString( toModeloResponse, "FACTURAELECTRONICA", toEntidad.FACTURAELECTRONICA_PK)
			this.SetearAtributoString( toModeloResponse, "FACTURAELECTRONICADECREDITO", toEntidad.FACTURAELECTRONICADECREDITO_PK)
			this.SetearAtributoString( toModeloResponse, "FACTURAELECTRONICAEXPORTACION", toEntidad.FACTURAELECTRONICAEXPORTACION_PK)
			this.SetearAtributoInteger( toModeloResponse, "FERIADO", toEntidad.FERIADO_PK)
			this.SetearAtributoString( toModeloResponse, "FINALDEPRODUCCION", toEntidad.FINALDEPRODUCCION_PK)
			this.SetearAtributoLong( toModeloResponse, "IMPRESIONDEETIQUETA", toEntidad.IMPRESIONDEETIQUETA_PK)
			this.SetearAtributoString( toModeloResponse, "MERCADERIAENTRANSITO", toEntidad.MERCADERIAENTRANSITO_PK)
			this.SetearAtributoString( toModeloResponse, "MODIFICACIONPRECIOS", toEntidad.MODIFICACIONPRECIOS_PK)
			this.SetearAtributoString( toModeloResponse, "MOVIMIENTODESTOCK", toEntidad.MOVIMIENTODESTOCK_PK)
			this.SetearAtributoString( toModeloResponse, "MOVIMIENTOSTOCKAINVENT", toEntidad.MOVIMIENTOSTOCKAINVENT_PK)
			this.SetearAtributoString( toModeloResponse, "MOVIMIENTOSTOCKAPRODUCC", toEntidad.MOVIMIENTOSTOCKAPRODUCC_PK)
			this.SetearAtributoString( toModeloResponse, "MOVIMIENTOSTOCKDESDEPRODUCC", toEntidad.MOVIMIENTOSTOCKDESDEPRODUCC_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADECREDITO", toEntidad.NOTADECREDITO_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADECREDITOCOMPRA", toEntidad.NOTADECREDITOCOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADECREDITODEEXPORTACION", toEntidad.NOTADECREDITODEEXPORTACION_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADECREDITOELECTRONICA", toEntidad.NOTADECREDITOELECTRONICA_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADECREDITOELECTRONICADECREDITO", toEntidad.NOTADECREDITOELECTRONICADECREDITO_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADECREDITOELECTRONICAEXPORTACION", toEntidad.NOTADECREDITOELECTRONICAEXPORTACION_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADEDEBITO", toEntidad.NOTADEDEBITO_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADEDEBITOCOMPRA", toEntidad.NOTADEDEBITOCOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADEDEBITODEEXPORTACION", toEntidad.NOTADEDEBITODEEXPORTACION_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADEDEBITOELECTRONICA", toEntidad.NOTADEDEBITOELECTRONICA_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADEDEBITOELECTRONICADECREDITO", toEntidad.NOTADEDEBITOELECTRONICADECREDITO_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADEDEBITOELECTRONICAEXPORTACION", toEntidad.NOTADEDEBITOELECTRONICAEXPORTACION_PK)
			this.SetearAtributoString( toModeloResponse, "PEDIDO", toEntidad.PEDIDO_PK)
			this.SetearAtributoString( toModeloResponse, "PEDIDODECOMPRA", toEntidad.PEDIDODECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "PREPARACIONDEMERCADERIA", toEntidad.PREPARACIONDEMERCADERIA_PK)
			this.SetearAtributoString( toModeloResponse, "PRESUPUESTO", toEntidad.PRESUPUESTO_PK)
			this.SetearAtributoString( toModeloResponse, "PRESUPUESTODECOMPRA", toEntidad.PRESUPUESTODECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "REMITO", toEntidad.REMITO_PK)
			this.SetearAtributoString( toModeloResponse, "REMITODECOMPRA", toEntidad.REMITODECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "REQUERIMIENTODECOMPRA", toEntidad.REQUERIMIENTODECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "SOLICITUDDECOMPRA", toEntidad.SOLICITUDDECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "TICKETFACTURA", toEntidad.TICKETFACTURA_PK)
			this.SetearAtributoString( toModeloResponse, "TICKETNOTADECREDITO", toEntidad.TICKETNOTADECREDITO_PK)
			this.SetearAtributoString( toModeloResponse, "TICKETNOTADEDEBITO", toEntidad.TICKETNOTADEDEBITO_PK)
			this.SetearAtributo( toModeloResponse, "Ordenar", toEntidad.Ordenar)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
		endif
	
		return lcRetorno 
	endfunc
	

enddefine