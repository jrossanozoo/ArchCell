
define class Din_EntidadMovimientostockaproducc_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Movimientostockaproducc"
	cClaseResponse = this.cNamespaceDTOs + ".MovimientostockaproduccResponse"
	cClaseModelo = "MovimientostockaproduccModelo"
	cEntidad = "Movimientostockaproducc"
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
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockaproduccModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockaproduccModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockaproduccListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockaproduccListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockaproduccModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Inventariodestino", toEntidad, "Inventariodestino_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearDetalleMovimientodetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleMovimientoDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "MovimientoDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"MovimientoDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.MovimientoDetalle.LimpiarItem()
			else
				try
					toEntidad.MovimientoDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.MovimientoDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.MovimientoDetalle.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.MovimientoDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.MovimientoDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.MovimientoDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.MovimientoDetalle.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidad", toEntidad.MovimientoDetalle.oItem, "Unidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.MovimientoDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.MovimientoDetalle.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.MovimientoDetalle.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Partida", toEntidad.MovimientoDetalle.oItem, "Partida" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidadinsumo", toEntidad.MovimientoDetalle.oItem, "UnidadInsumo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Rinde", toEntidad.MovimientoDetalle.oItem, "Rinde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidadinsumo", toEntidad.MovimientoDetalle.oItem, "CantidadInsumo" )
			toEntidad.MovimientoDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "InventarioDestino", toEntidad.InventarioDestino_PK)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.CargarColeccionModeloMovimientoDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloMovimientoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "MovimientoDetalle" ) 
		with toEntidad
			for lnI = 1 to .MovimientoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemMstockaprod" )
				this.SetearAtributoString( loItem, "Codigo", .MovimientoDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .MovimientoDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .MovimientoDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .MovimientoDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .MovimientoDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .MovimientoDetalle.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "Unidad", .MovimientoDetalle.Item(lnI).Unidad)
				this.SetearAtributoDecimal( loItem, "Cantidad", .MovimientoDetalle.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Insumo", .MovimientoDetalle.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .MovimientoDetalle.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Partida", .MovimientoDetalle.Item(lnI).Partida)
				this.SetearAtributoString( loItem, "UnidadInsumo", .MovimientoDetalle.Item(lnI).UnidadInsumo)
				this.SetearAtributoDecimal( loItem, "Rinde", .MovimientoDetalle.Item(lnI).Rinde)
				this.SetearAtributoDecimal( loItem, "CantidadInsumo", .MovimientoDetalle.Item(lnI).CantidadInsumo)
				this.SetearAtributoInteger( loItem, "NroItem", .MovimientoDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Inventariodestino", "INVENTDEST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), MOBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Inventdest LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine