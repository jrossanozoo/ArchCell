
define class Din_EntidadRemitoelectronico_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Remitoelectronico"
	cClaseResponse = this.cNamespaceDTOs + ".RemitoelectronicoResponse"
	cClaseModelo = "RemitoelectronicoModelo"
	cEntidad = "Remitoelectronico"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Numero" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Numero = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Numero = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "RemitoelectronicoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "RemitoelectronicoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "RemitoelectronicoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "RemitoelectronicoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "RemitoelectronicoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entregaenorigen", toEntidad, "Entregaenorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sucursal", toEntidad, "Sucursal_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechasalida", toEntidad, "Fechasalida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Hora", toEntidad, "Hora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Transportista", toEntidad, "Transportista_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dominiovehiculo", toEntidad, "Dominiovehiculo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dominioacoplado", toEntidad, "Dominioacoplado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bultos", toEntidad, "Bultos" )
			this.SetearDetalleDetallederemitos( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleDeRemitos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleDeRemitos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleDeRemitos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleDeRemitos.LimpiarItem()
			else
				try
					toEntidad.DetalleDeRemitos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleDeRemitos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Remito", toEntidad.DetalleDeRemitos.oItem, "Remito" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cliente", toEntidad.DetalleDeRemitos.oItem, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedetalle", toEntidad.DetalleDeRemitos.oItem, "ClienteDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Direccion", toEntidad.DetalleDeRemitos.oItem, "Direccion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.DetalleDeRemitos.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Noterminadodevuelto", toEntidad.DetalleDeRemitos.oItem, "NoTerminadoDevuelto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Importetotal", toEntidad.DetalleDeRemitos.oItem, "ImporteTotal" )
			this.SetearAtributoModeloEnEntidad( loItem, "Procesado", toEntidad.DetalleDeRemitos.oItem, "Procesado" )
			toEntidad.DetalleDeRemitos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributo( toModeloResponse, "EntregaEnOrigen", toEntidad.EntregaEnOrigen)
			this.SetearAtributoString( toModeloResponse, "Sucursal", toEntidad.Sucursal_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaSalida", toEntidad.FechaSalida)
			this.SetearAtributoString( toModeloResponse, "Hora", toEntidad.Hora)
			this.SetearAtributoString( toModeloResponse, "Transportista", toEntidad.Transportista_PK)
			this.SetearAtributoString( toModeloResponse, "DominioVehiculo", toEntidad.DominioVehiculo)
			this.SetearAtributoString( toModeloResponse, "DominioAcoplado", toEntidad.DominioAcoplado)
			this.SetearAtributoLong( toModeloResponse, "Bultos", toEntidad.Bultos)
			this.CargarColeccionModeloDetalleDeRemitos( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleDeRemitos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleDeRemitos" ) 
		with toEntidad
			for lnI = 1 to .DetalleDeRemitos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRemitoelec" )
				this.SetearAtributoInteger( loItem, "Codigo", .DetalleDeRemitos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Remito", .DetalleDeRemitos.Item(lnI).Remito)
				this.SetearAtributoString( loItem, "Cliente", .DetalleDeRemitos.Item(lnI).Cliente_PK)
				this.SetearAtributoString( loItem, "ClienteDetalle", .DetalleDeRemitos.Item(lnI).ClienteDetalle)
				this.SetearAtributoString( loItem, "Direccion", .DetalleDeRemitos.Item(lnI).Direccion)
				this.SetearAtributoDecimal( loItem, "Cantidad", .DetalleDeRemitos.Item(lnI).Cantidad)
				this.SetearAtributo( loItem, "NoTerminadoDevuelto", .DetalleDeRemitos.Item(lnI).NoTerminadoDevuelto)
				this.SetearAtributoDecimal( loItem, "ImporteTotal", .DetalleDeRemitos.Item(lnI).ImporteTotal)
				this.SetearAtributoString( loItem, "Procesado", .DetalleDeRemitos.Item(lnI).Procesado)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleDeRemitos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entregaenorigen", "ENTREGA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sucursal", "SUCURSAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechasalida", "FECSAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Hora", "HORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Transportista", "TRANSPORTI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Dominiovehiculo", "DOMVEH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Dominioacoplado", "DOMACOP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bultos", "BULTOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucursal LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Transporti LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Domveh LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Domacop LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine