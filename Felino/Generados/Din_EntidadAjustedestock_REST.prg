
define class Din_EntidadAjustedestock_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Ajustedestock"
	cClaseResponse = this.cNamespaceDTOs + ".AjustedestockResponse"
	cClaseModelo = "AjustedestockModelo"
	cEntidad = "Ajustedestock"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedestockModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedestockModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedestockListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedestockListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "AjustedestockModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Hora", toEntidad, "Hora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serie", toEntidad, "Serie" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuario", toEntidad, "Usuario" )
			this.SetearDetalleStockafectado( toEntidad, toModeloEnRequest )
			this.SetearDetalleStockafectadoauditoriacomb( toEntidad, toModeloEnRequest )
			this.SetearDetalleStockafectadoentransito( toEntidad, toModeloEnRequest )
			this.SetearDetalleStockafectadoauditoriaentransito( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallestockafectado( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "stockafectado" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"stockafectado[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.stockafectado.LimpiarItem()
			else
				try
					toEntidad.stockafectado.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.stockafectado.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.stockafectado.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.stockafectado.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.stockafectado.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.stockafectado.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.stockafectado.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockact", toEntidad.stockafectado.oItem, "StockAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockproy", toEntidad.stockafectado.oItem, "StockProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.stockafectado.oItem, "Cantidad" )
			toEntidad.stockafectado.Actualizar()
			
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
	protected function SetearDetallestockafectadoEnTransito( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "stockafectadoEnTransito" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"stockafectadoEnTransito[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.stockafectadoEnTransito.LimpiarItem()
			else
				try
					toEntidad.stockafectadoEnTransito.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.stockafectadoEnTransito.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.stockafectadoEnTransito.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.stockafectadoEnTransito.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.stockafectadoEnTransito.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.stockafectadoEnTransito.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.stockafectadoEnTransito.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockact", toEntidad.stockafectadoEnTransito.oItem, "StockAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockproy", toEntidad.stockafectadoEnTransito.oItem, "StockProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.stockafectadoEnTransito.oItem, "Cantidad" )
			toEntidad.stockafectadoEnTransito.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleStockAfectadoAuditoriaEnTransito( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "StockAfectadoAuditoriaEnTransito" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"StockAfectadoAuditoriaEnTransito[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.StockAfectadoAuditoriaEnTransito.LimpiarItem()
			else
				try
					toEntidad.StockAfectadoAuditoriaEnTransito.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.StockAfectadoAuditoriaEnTransito.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockact", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "StockAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Stockproy", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "StockProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.StockAfectadoAuditoriaEnTransito.oItem, "Cantidad" )
			toEntidad.StockAfectadoAuditoriaEnTransito.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Hora", toEntidad.Hora)
			this.SetearAtributoString( toModeloResponse, "Serie", toEntidad.Serie)
			this.SetearAtributoString( toModeloResponse, "Usuario", toEntidad.Usuario)
			this.CargarColeccionModelostockafectado( toModeloResponse, toEntidad )
			this.CargarColeccionModeloStockAfectadoAuditoriaComb( toModeloResponse, toEntidad )
			this.CargarColeccionModelostockafectadoEnTransito( toModeloResponse, toEntidad )
			this.CargarColeccionModeloStockAfectadoAuditoriaEnTransito( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModelostockafectado( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "stockafectado" ) 
		with toEntidad
			for lnI = 1 to .stockafectado.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjustedestock" )
				this.SetearAtributoString( loItem, "codigo", .stockafectado.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Articulo", .stockafectado.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .stockafectado.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .stockafectado.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .stockafectado.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .stockafectado.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "StockAct", .stockafectado.Item(lnI).StockAct)
				this.SetearAtributoDecimal( loItem, "StockProy", .stockafectado.Item(lnI).StockProy)
				this.SetearAtributoDecimal( loItem, "Cantidad", .stockafectado.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .stockafectado.Item(lnI).NroItem )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjaudicombinacion" )
				this.SetearAtributoString( loItem, "codigo", .StockAfectadoAuditoriaComb.Item(lnI).codigo)
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
	protected function CargarColeccionModelostockafectadoEnTransito( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "stockafectadoEnTransito" ) 
		with toEntidad
			for lnI = 1 to .stockafectadoEnTransito.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjustockentransito" )
				this.SetearAtributoString( loItem, "codigo", .stockafectadoEnTransito.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Articulo", .stockafectadoEnTransito.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .stockafectadoEnTransito.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .stockafectadoEnTransito.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .stockafectadoEnTransito.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .stockafectadoEnTransito.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "StockAct", .stockafectadoEnTransito.Item(lnI).StockAct)
				this.SetearAtributoDecimal( loItem, "StockProy", .stockafectadoEnTransito.Item(lnI).StockProy)
				this.SetearAtributoDecimal( loItem, "Cantidad", .stockafectadoEnTransito.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .stockafectadoEnTransito.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloStockAfectadoAuditoriaEnTransito( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "StockAfectadoAuditoriaEnTransito" ) 
		with toEntidad
			for lnI = 1 to .StockAfectadoAuditoriaEnTransito.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAjaudientransito" )
				this.SetearAtributoString( loItem, "codigo", .StockAfectadoAuditoriaEnTransito.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Articulo", .StockAfectadoAuditoriaEnTransito.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .StockAfectadoAuditoriaEnTransito.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .StockAfectadoAuditoriaEnTransito.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .StockAfectadoAuditoriaEnTransito.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .StockAfectadoAuditoriaEnTransito.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "StockAct", .StockAfectadoAuditoriaEnTransito.Item(lnI).StockAct)
				this.SetearAtributoDecimal( loItem, "StockProy", .StockAfectadoAuditoriaEnTransito.Item(lnI).StockProy)
				this.SetearAtributoDecimal( loItem, "Cantidad", .StockAfectadoAuditoriaEnTransito.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .StockAfectadoAuditoriaEnTransito.Item(lnI).NroItem )
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "AJFEDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "AJFEHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "AJFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Hora", "AJDHORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serie", "AJSERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuario", "AJDUSUARIO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ajobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ajdhora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ajserie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ajdusuario LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine