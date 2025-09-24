
define class Din_EntidadAjusteccproveedor_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Ajusteccproveedor"
	cClaseResponse = this.cNamespaceDTOs + ".AjusteccproveedorResponse"
	cClaseModelo = "AjusteccproveedorModelo"
	cEntidad = "Ajusteccproveedor"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AjusteccproveedorModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "AjusteccproveedorModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "AjusteccproveedorListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AjusteccproveedorListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "AjusteccproveedorModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valor", toEntidad, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante", toEntidad, "Monedacomprobante_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Motivo", toEntidad, "Motivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cotizacion", toEntidad, "Cotizacion" )
			this.SetearDetalleAjustedetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAjusteDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "AjusteDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"AjusteDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.AjusteDetalle.LimpiarItem()
			else
				try
					toEntidad.AjusteDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.AjusteDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proveedor", toEntidad.AjusteDetalle.oItem, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Proveedordetalle", toEntidad.AjusteDetalle.oItem, "ProveedorDetalle" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechavencimiento", toEntidad.AjusteDetalle.oItem, "FechaVencimiento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.AjusteDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.AjusteDetalle.oItem, "Monto" )
			toEntidad.AjusteDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "Valor", toEntidad.Valor_PK)
			this.SetearAtributoString( toModeloResponse, "MonedaComprobante", toEntidad.MonedaComprobante_PK)
			this.SetearAtributoString( toModeloResponse, "Motivo", toEntidad.Motivo_PK)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDecimal( toModeloResponse, "Cotizacion", toEntidad.Cotizacion)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloAjusteDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAjusteDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "AjusteDetalle" ) 
		with toEntidad
			for lnI = 1 to .AjusteDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjusteccproveedor" )
				this.SetearAtributoString( loItem, "Proveedor", .AjusteDetalle.Item(lnI).Proveedor_PK)
				this.SetearAtributoString( loItem, "ProveedorDetalle", .AjusteDetalle.Item(lnI).ProveedorDetalle)
				this.SetearAtributoDatetime( loItem, "FechaVencimiento", .AjusteDetalle.Item(lnI).FechaVencimiento)
				this.SetearAtributoString( loItem, "Descripcion", .AjusteDetalle.Item(lnI).Descripcion)
				this.SetearAtributoDecimal( loItem, "Monto", .AjusteDetalle.Item(lnI).Monto)
				this.SetearAtributoString( loItem, "Codigo", .AjusteDetalle.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "NroItem", .AjusteDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "FVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valor", "VALOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monedacomprobante", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Motivo", "MOTIVO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "FPTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cotizacion", "COTIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "FOBS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fven LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Valor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Motivo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine