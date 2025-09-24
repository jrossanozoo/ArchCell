
define class Din_EntidadComprobantederetencionrecibido_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Comprobantederetencionrecibido"
	cClaseResponse = this.cNamespaceDTOs + ".ComprobantederetencionrecibidoResponse"
	cClaseModelo = "ComprobantederetencionrecibidoModelo"
	cEntidad = "Comprobantederetencionrecibido"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantederetencionrecibidoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantederetencionrecibidoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantederetencionrecibidoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantederetencionrecibidoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantederetencionrecibidoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedetalle", toEntidad, "Clientedetalle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuit", toEntidad, "Cuit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoimpuesto", toEntidad, "Tipoimpuesto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Regimen", toEntidad, "Regimen_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Regimendetalle", toEntidad, "Regimendetalle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerointerno", toEntidad, "Numerointerno" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacertificado", toEntidad, "Fechacertificado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocertificado", toEntidad, "Numerocertificado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recibo", toEntidad, "Recibo" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecharecibo", toEntidad, "Fecharecibo" )
			this.SetearDetalleRetencionesdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observaciones", toEntidad, "Observaciones" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleRetencionesDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "RetencionesDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"RetencionesDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.RetencionesDetalle.LimpiarItem()
			else
				try
					toEntidad.RetencionesDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.RetencionesDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Impuesto", toEntidad.RetencionesDetalle.oItem, "Impuesto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Jurisdiccion", toEntidad.RetencionesDetalle.oItem, "Jurisdiccion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Resolucion", toEntidad.RetencionesDetalle.oItem, "Resolucion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.RetencionesDetalle.oItem, "Monto" )
			toEntidad.RetencionesDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteDetalle", toEntidad.ClienteDetalle)
			this.SetearAtributoString( toModeloResponse, "Cuit", toEntidad.Cuit)
			this.SetearAtributoString( toModeloResponse, "TipoImpuesto", toEntidad.TipoImpuesto)
			this.SetearAtributoString( toModeloResponse, "Regimen", toEntidad.Regimen_PK)
			this.SetearAtributoString( toModeloResponse, "RegimenDetalle", toEntidad.RegimenDetalle)
			this.SetearAtributoInteger( toModeloResponse, "NumeroInterno", toEntidad.NumeroInterno)
			this.SetearAtributoDateTime( toModeloResponse, "FechaCertificado", toEntidad.FechaCertificado)
			this.SetearAtributoString( toModeloResponse, "NumeroCertificado", toEntidad.NumeroCertificado)
			this.SetearAtributoString( toModeloResponse, "Recibo", toEntidad.Recibo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaRecibo", toEntidad.FechaRecibo)
			this.CargarColeccionModeloRetencionesDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
			this.SetearAtributo( toModeloResponse, "Observaciones", toEntidad.Observaciones)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloRetencionesDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "RetencionesDetalle" ) 
		with toEntidad
			for lnI = 1 to .RetencionesDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRetencionrecibida" )
				this.SetearAtributoString( loItem, "Codigo", .RetencionesDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Impuesto", .RetencionesDetalle.Item(lnI).Impuesto_PK)
				this.SetearAtributoString( loItem, "Jurisdiccion", .RetencionesDetalle.Item(lnI).Jurisdiccion)
				this.SetearAtributoString( loItem, "Resolucion", .RetencionesDetalle.Item(lnI).Resolucion)
				this.SetearAtributoDecimal( loItem, "Monto", .RetencionesDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .RetencionesDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "CLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedetalle", "CLIEDESC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuit", "CUIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoimpuesto", "TIPOIMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Regimen", "REGIMEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Regimendetalle", "REGIDESC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerointerno", "NUMINT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacertificado", "FECHCERT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocertificado", "NUMECERT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recibo", "RECIBO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecharecibo", "FECHRECI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Total", "RTOTAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observaciones", "CONVERT( VARCHAR(MAX), OBSE)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliedesc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cuit LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipoimp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Regimen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Regidesc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Numecert LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Recibo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obse LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine