
define class Din_EntidadAjustedeestados_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Ajustedeestados"
	cClaseResponse = this.cNamespaceDTOs + ".AjustedeestadosResponse"
	cClaseModelo = "AjustedeestadosModelo"
	cEntidad = "Ajustedeestados"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedeestadosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedeestadosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedeestadosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedeestadosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedeestadosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearDetalleStockafectado( toEntidad, toModeloEnRequest )
			this.SetearDetalleStockafectadoauditoriacomb( toEntidad, toModeloEnRequest )
			this.SetearDetalleComprobantesmodificados( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleStockAfectado( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "StockAfectado" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"StockAfectado[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.StockAfectado.LimpiarItem()
			else
				try
					toEntidad.StockAfectado.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.StockAfectado.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Situacion", toEntidad.StockAfectado.oItem, "Situacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.StockAfectado.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.StockAfectado.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.StockAfectado.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.StockAfectado.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.StockAfectado.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockact", toEntidad.StockAfectado.oItem, "StockAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockproy", toEntidad.StockAfectado.oItem, "StockProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.StockAfectado.oItem, "Cantidad" )
			toEntidad.StockAfectado.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleStockAfectadoAuditoriaComb( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "StockAfectadoAuditoriaComb" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"StockAfectadoAuditoriaComb[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.StockAfectadoAuditoriaComb.LimpiarItem()
			else
				try
					toEntidad.StockAfectadoAuditoriaComb.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.StockAfectadoAuditoriaComb.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Situacion", toEntidad.StockAfectadoAuditoriaComb.oItem, "Situacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.StockAfectadoAuditoriaComb.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.StockAfectadoAuditoriaComb.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.StockAfectadoAuditoriaComb.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.StockAfectadoAuditoriaComb.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.StockAfectadoAuditoriaComb.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockact", toEntidad.StockAfectadoAuditoriaComb.oItem, "StockAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockproy", toEntidad.StockAfectadoAuditoriaComb.oItem, "StockProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.StockAfectadoAuditoriaComb.oItem, "Cantidad" )
			toEntidad.StockAfectadoAuditoriaComb.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleComprobantesModificados( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ComprobantesModificados" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ComprobantesModificados[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ComprobantesModificados.LimpiarItem()
			else
				try
					toEntidad.ComprobantesModificados.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ComprobantesModificados.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Comprobante", toEntidad.ComprobantesModificados.oItem, "Comprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ComprobantesModificados.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.ComprobantesModificados.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ComprobantesModificados.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ComprobantesModificados.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ComprobantesModificados.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockact", toEntidad.ComprobantesModificados.oItem, "StockAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockproy", toEntidad.ComprobantesModificados.oItem, "StockProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ComprobantesModificados.oItem, "Cantidad" )
			toEntidad.ComprobantesModificados.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.CargarColeccionModeloStockAfectado( toModeloResponse, toEntidad )
			this.CargarColeccionModeloStockAfectadoAuditoriaComb( toModeloResponse, toEntidad )
			this.CargarColeccionModeloComprobantesModificados( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloStockAfectado( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "StockAfectado" ) 
		with toEntidad
			for lnI = 1 to .StockAfectado.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjustedeestados" )
				this.SetearAtributoString( loItem, "codigo", .StockAfectado.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Situacion", .StockAfectado.Item(lnI).Situacion)
				this.SetearAtributoString( loItem, "Articulo", .StockAfectado.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .StockAfectado.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .StockAfectado.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .StockAfectado.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .StockAfectado.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "StockAct", .StockAfectado.Item(lnI).StockAct)
				this.SetearAtributoDecimal( loItem, "StockProy", .StockAfectado.Item(lnI).StockProy)
				this.SetearAtributoDecimal( loItem, "Cantidad", .StockAfectado.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .StockAfectado.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloStockAfectadoAuditoriaComb( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "StockAfectadoAuditoriaComb" ) 
		with toEntidad
			for lnI = 1 to .StockAfectadoAuditoriaComb.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjestadosaudcomb" )
				this.SetearAtributoString( loItem, "codigo", .StockAfectadoAuditoriaComb.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Situacion", .StockAfectadoAuditoriaComb.Item(lnI).Situacion)
				this.SetearAtributoString( loItem, "Articulo", .StockAfectadoAuditoriaComb.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .StockAfectadoAuditoriaComb.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .StockAfectadoAuditoriaComb.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .StockAfectadoAuditoriaComb.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .StockAfectadoAuditoriaComb.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "StockAct", .StockAfectadoAuditoriaComb.Item(lnI).StockAct)
				this.SetearAtributoDecimal( loItem, "StockProy", .StockAfectadoAuditoriaComb.Item(lnI).StockProy)
				this.SetearAtributoDecimal( loItem, "Cantidad", .StockAfectadoAuditoriaComb.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .StockAfectadoAuditoriaComb.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloComprobantesModificados( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ComprobantesModificados" ) 
		with toEntidad
			for lnI = 1 to .ComprobantesModificados.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjustecomprobantes" )
				this.SetearAtributoString( loItem, "Codigo", .ComprobantesModificados.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Comprobante", .ComprobantesModificados.Item(lnI).Comprobante)
				this.SetearAtributoString( loItem, "Articulo", .ComprobantesModificados.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .ComprobantesModificados.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .ComprobantesModificados.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ComprobantesModificados.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ComprobantesModificados.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "StockAct", .ComprobantesModificados.Item(lnI).StockAct)
				this.SetearAtributoDecimal( loItem, "StockProy", .ComprobantesModificados.Item(lnI).StockProy)
				this.SetearAtributoDecimal( loItem, "Cantidad", .ComprobantesModificados.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .ComprobantesModificados.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), AJOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "AJNUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "AJFECHA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ajobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine