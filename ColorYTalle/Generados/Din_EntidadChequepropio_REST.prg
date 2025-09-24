
define class Din_EntidadChequepropio_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Chequepropio"
	cClaseResponse = this.cNamespaceDTOs + ".ChequepropioResponse"
	cClaseModelo = "ChequepropioModelo"
	cEntidad = "Chequepropio"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ChequepropioModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ChequepropioModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ChequepropioListarRequest"
			case tcOperacion == "Anular"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ChequepropioListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ChequepropioModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeroc", toEntidad, "Numeroc" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estado", toEntidad, "Estado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipo", toEntidad, "Tipo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Chequera", toEntidad, "Chequera_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidadfinanciera", toEntidad, "Entidadfinanciera_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Chequeelectronico", toEntidad, "Chequeelectronico" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaemision", toEntidad, "Fechaemision" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearDetalleHistorialdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleHistorialDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "HistorialDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"HistorialDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.HistorialDetalle.LimpiarItem()
			else
				try
					toEntidad.HistorialDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.HistorialDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.HistorialDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hora", toEntidad.HistorialDetalle.oItem, "Hora" )
			this.SetearAtributoModeloEnEntidad( loItem, "Comprobante", toEntidad.HistorialDetalle.oItem, "Comprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Concepto", toEntidad.HistorialDetalle.oItem, "Concepto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Conceptodetalle", toEntidad.HistorialDetalle.oItem, "ConceptoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.HistorialDetalle.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cajaestado", toEntidad.HistorialDetalle.oItem, "CajaEstado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cajaestadodetalle", toEntidad.HistorialDetalle.oItem, "CajaEstadoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Basedeorigen", toEntidad.HistorialDetalle.oItem, "BaseDeOrigen" )
			this.SetearAtributoModeloEnEntidad( loItem, "Estado", toEntidad.HistorialDetalle.oItem, "Estado" )
			toEntidad.HistorialDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "NumeroC", toEntidad.NumeroC)
			this.SetearAtributoString( toModeloResponse, "Estado", toEntidad.Estado)
			this.SetearAtributoInteger( toModeloResponse, "Tipo", toEntidad.Tipo)
			this.SetearAtributoString( toModeloResponse, "Chequera", toEntidad.Chequera_PK)
			this.SetearAtributoString( toModeloResponse, "EntidadFinanciera", toEntidad.EntidadFinanciera_PK)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributo( toModeloResponse, "ChequeElectronico", toEntidad.ChequeElectronico)
			this.SetearAtributoDecimal( toModeloResponse, "Monto", toEntidad.Monto)
			this.SetearAtributoDateTime( toModeloResponse, "FechaEmision", toEntidad.FechaEmision)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.CargarColeccionModeloHistorialDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloHistorialDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "HistorialDetalle" ) 
		with toEntidad
			for lnI = 1 to .HistorialDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemChequepropiohist" )
				this.SetearAtributoString( loItem, "Codigo", .HistorialDetalle.Item(lnI).Codigo)
				this.SetearAtributoDatetime( loItem, "Fecha", .HistorialDetalle.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Hora", .HistorialDetalle.Item(lnI).Hora)
				this.SetearAtributoString( loItem, "Comprobante", .HistorialDetalle.Item(lnI).Comprobante)
				this.SetearAtributoString( loItem, "Concepto", .HistorialDetalle.Item(lnI).Concepto_PK)
				this.SetearAtributoString( loItem, "ConceptoDetalle", .HistorialDetalle.Item(lnI).ConceptoDetalle)
				this.SetearAtributoInteger( loItem, "Tipo", .HistorialDetalle.Item(lnI).Tipo)
				this.SetearAtributoInteger( loItem, "CajaEstado", .HistorialDetalle.Item(lnI).CajaEstado)
				this.SetearAtributoString( loItem, "CajaEstadoDetalle", .HistorialDetalle.Item(lnI).CajaEstadoDetalle)
				this.SetearAtributoString( loItem, "BaseDeOrigen", .HistorialDetalle.Item(lnI).BaseDeOrigen)
				this.SetearAtributoString( loItem, "Estado", .HistorialDetalle.Item(lnI).Estado)
				this.SetearAtributoInteger( loItem, "NroItem", .HistorialDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "PTOVENTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeroc", "NUMEROC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estado", "ESTADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipo", "TIPOCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Chequera", "CHEQUERA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entidadfinanciera", "CENTFIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "CNUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Chequeelectronico", "CELECTRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monto", "CMONTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaemision", "CFECHAEMI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "CFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Moneda", "CMONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "PRVORIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), COBSS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Estado LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Chequera LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Centfin LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cmoneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prvorig LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobss LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine