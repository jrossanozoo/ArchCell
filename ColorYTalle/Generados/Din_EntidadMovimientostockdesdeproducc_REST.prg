
define class Din_EntidadMovimientostockdesdeproducc_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Movimientostockdesdeproducc"
	cClaseResponse = this.cNamespaceDTOs + ".MovimientostockdesdeproduccResponse"
	cClaseModelo = "MovimientostockdesdeproduccModelo"
	cEntidad = "Movimientostockdesdeproducc"
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
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockdesdeproduccModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockdesdeproduccModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockdesdeproduccListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockdesdeproduccListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientostockdesdeproduccModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Inventarioorigen", toEntidad, "Inventarioorigen_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearDetalleMovimientodetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCompAfec( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CompAfec" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CompAfec[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CompAfec.LimpiarItem()
			else
				try
					toEntidad.CompAfec.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CompAfec.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocomprobante", toEntidad.CompAfec.oItem, "TipoComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocompcaracter", toEntidad.CompAfec.oItem, "TipoCompCaracter" )
			this.SetearAtributoModeloEnEntidad( loItem, "Letra", toEntidad.CompAfec.oItem, "Letra" )
			this.SetearAtributoModeloEnEntidad( loItem, "Puntodeventa", toEntidad.CompAfec.oItem, "PuntoDeVenta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.CompAfec.oItem, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.CompAfec.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.CompAfec.oItem, "Total" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.CompAfec.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Afecta", toEntidad.CompAfec.oItem, "Afecta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Interviniente", toEntidad.CompAfec.oItem, "Interviniente" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadcomprobante", toEntidad.CompAfec.oItem, "EntidadComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Origen", toEntidad.CompAfec.oItem, "Origen" )
			toEntidad.CompAfec.Actualizar()
			
		endfor
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
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.MovimientoDetalle.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.MovimientoDetalle.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.MovimientoDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.MovimientoDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.MovimientoDetalle.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Partida", toEntidad.MovimientoDetalle.oItem, "Partida" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidad", toEntidad.MovimientoDetalle.oItem, "Unidad_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.MovimientoDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.MovimientoDetalle.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.MovimientoDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorart", toEntidad.MovimientoDetalle.oItem, "ColorArt_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorartdetalle", toEntidad.MovimientoDetalle.oItem, "ColorArtDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talleart", toEntidad.MovimientoDetalle.oItem, "TalleArt_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidadstockdf", toEntidad.MovimientoDetalle.oItem, "UnidadStockDF_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Rinde", toEntidad.MovimientoDetalle.oItem, "Rinde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidadstockdf", toEntidad.MovimientoDetalle.oItem, "CantidadStockDF" )
			toEntidad.MovimientoDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloCompAfec( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "InventarioOrigen", toEntidad.InventarioOrigen_PK)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.CargarColeccionModeloMovimientoDetalle( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCompAfec( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CompAfec" ) 
		with toEntidad
			for lnI = 1 to .CompAfec.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemComprobante" )
				this.SetearAtributoString( loItem, "Codigo", .CompAfec.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "TipoComprobante", .CompAfec.Item(lnI).TipoComprobante)
				this.SetearAtributoString( loItem, "TipoCompCaracter", .CompAfec.Item(lnI).TipoCompCaracter)
				this.SetearAtributoString( loItem, "Letra", .CompAfec.Item(lnI).Letra)
				this.SetearAtributoInteger( loItem, "PuntoDeVenta", .CompAfec.Item(lnI).PuntoDeVenta)
				this.SetearAtributoInteger( loItem, "Numero", .CompAfec.Item(lnI).Numero)
				this.SetearAtributoDatetime( loItem, "Fecha", .CompAfec.Item(lnI).Fecha)
				this.SetearAtributoDecimal( loItem, "Total", .CompAfec.Item(lnI).Total)
				this.SetearAtributoString( loItem, "Tipo", .CompAfec.Item(lnI).Tipo)
				this.SetearAtributoString( loItem, "Afecta", .CompAfec.Item(lnI).Afecta)
				this.SetearAtributoString( loItem, "Interviniente", .CompAfec.Item(lnI).Interviniente)
				this.SetearAtributoString( loItem, "EntidadComprobante", .CompAfec.Item(lnI).EntidadComprobante)
				this.SetearAtributoString( loItem, "Origen", .CompAfec.Item(lnI).Origen)
				this.SetearAtributoInteger( loItem, "NroItem", .CompAfec.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloMovimientoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "MovimientoDetalle" ) 
		with toEntidad
			for lnI = 1 to .MovimientoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemMstockdesdeprod" )
				this.SetearAtributoString( loItem, "Codigo", .MovimientoDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Insumo", .MovimientoDetalle.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .MovimientoDetalle.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .MovimientoDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .MovimientoDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .MovimientoDetalle.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "Partida", .MovimientoDetalle.Item(lnI).Partida)
				this.SetearAtributoString( loItem, "Unidad", .MovimientoDetalle.Item(lnI).Unidad_PK)
				this.SetearAtributoDecimal( loItem, "Cantidad", .MovimientoDetalle.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Articulo", .MovimientoDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .MovimientoDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "ColorArt", .MovimientoDetalle.Item(lnI).ColorArt_PK)
				this.SetearAtributoString( loItem, "ColorArtDetalle", .MovimientoDetalle.Item(lnI).ColorArtDetalle)
				this.SetearAtributoString( loItem, "TalleArt", .MovimientoDetalle.Item(lnI).TalleArt_PK)
				this.SetearAtributoString( loItem, "UnidadStockDF", .MovimientoDetalle.Item(lnI).UnidadStockDF_PK)
				this.SetearAtributoDecimal( loItem, "Rinde", .MovimientoDetalle.Item(lnI).Rinde)
				this.SetearAtributoDecimal( loItem, "CantidadStockDF", .MovimientoDetalle.Item(lnI).CantidadStockDF)
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
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Inventarioorigen", "INVENTORIG")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Inventorig LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine