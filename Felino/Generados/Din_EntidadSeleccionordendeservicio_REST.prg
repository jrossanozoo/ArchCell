
define class Din_EntidadSeleccionordendeservicio_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Seleccionordendeservicio"
	cClaseResponse = this.cNamespaceDTOs + ".SeleccionordendeservicioResponse"
	cClaseModelo = "SeleccionordendeservicioModelo"
	cEntidad = "Seleccionordendeservicio"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionordendeservicioModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionordendeservicioModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionordendeservicioListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionordendeservicioListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionordendeservicioModelo"
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
			this.SetearDetalleDetalleordenes( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleOrdenes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleOrdenes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleOrdenes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleOrdenes.LimpiarItem()
			else
				try
					toEntidad.DetalleOrdenes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleOrdenes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Orden", toEntidad.DetalleOrdenes.oItem, "Orden_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipodeorden", toEntidad.DetalleOrdenes.oItem, "TipoDeOrden_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.DetalleOrdenes.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cliente", toEntidad.DetalleOrdenes.oItem, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Basededatos", toEntidad.DetalleOrdenes.oItem, "BaseDeDatos" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.DetalleOrdenes.oItem, "Fecha" )
			toEntidad.DetalleOrdenes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloDetalleOrdenes( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleOrdenes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleOrdenes" ) 
		with toEntidad
			for lnI = 1 to .DetalleOrdenes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOrdendeservicio" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleOrdenes.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Orden", .DetalleOrdenes.Item(lnI).Orden_PK)
				this.SetearAtributoString( loItem, "TipoDeOrden", .DetalleOrdenes.Item(lnI).TipoDeOrden_PK)
				this.SetearAtributoString( loItem, "Articulo", .DetalleOrdenes.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "Cliente", .DetalleOrdenes.Item(lnI).Cliente_PK)
				this.SetearAtributoString( loItem, "BaseDeDatos", .DetalleOrdenes.Item(lnI).BaseDeDatos)
				this.SetearAtributoDatetime( loItem, "Fecha", .DetalleOrdenes.Item(lnI).Fecha)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleOrdenes.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
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