
define class Din_EntidadOrdendeproduccion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Ordendeproduccion"
	cClaseResponse = this.cNamespaceDTOs + ".OrdendeproduccionResponse"
	cClaseModelo = "OrdendeproduccionModelo"
	cEntidad = "Ordendeproduccion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeproduccionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeproduccionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeproduccionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeproduccionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeproduccionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modelo", toEntidad, "Modelo_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Curvadeproduccion", toEntidad, "Curvadeproduccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidad", toEntidad, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Productofinal", toEntidad, "Productofinal_PK" )
			this.SetearDetalleOrdenprocesos( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearDetalleOrdencurva( toEntidad, toModeloEnRequest )
			this.SetearDetalleOrdeninsumos( toEntidad, toModeloEnRequest )
			this.SetearDetalleOrdensalidas( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenProcesos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenProcesos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenProcesos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenProcesos.LimpiarItem()
			else
				try
					toEntidad.OrdenProcesos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenProcesos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.OrdenProcesos.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Procesodetalle", toEntidad.OrdenProcesos.oItem, "ProcesoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Orden", toEntidad.OrdenProcesos.oItem, "Orden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Taller", toEntidad.OrdenProcesos.oItem, "Taller_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Inventarioentrada", toEntidad.OrdenProcesos.oItem, "InventarioEntrada_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Inventariosalida", toEntidad.OrdenProcesos.oItem, "InventarioSalida_PK" )
			toEntidad.OrdenProcesos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenCurva( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenCurva" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenCurva[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenCurva.LimpiarItem()
			else
				try
					toEntidad.OrdenCurva.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenCurva.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Producto", toEntidad.OrdenCurva.oItem, "Producto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Productodetalle", toEntidad.OrdenCurva.oItem, "ProductoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.OrdenCurva.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.OrdenCurva.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.OrdenCurva.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.OrdenCurva.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.OrdenCurva.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.OrdenCurva.oItem, "Total" )
			toEntidad.OrdenCurva.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenInsumos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenInsumos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenInsumos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenInsumos.LimpiarItem()
			else
				try
					toEntidad.OrdenInsumos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenInsumos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.OrdenInsumos.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.OrdenInsumos.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.OrdenInsumos.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.OrdenInsumos.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallemdetalle", toEntidad.OrdenInsumos.oItem, "TalleMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.OrdenInsumos.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.OrdenInsumos.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.OrdenInsumos.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colororddet", toEntidad.OrdenInsumos.oItem, "ColorOrdDet" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.OrdenInsumos.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.OrdenInsumos.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidaddemedida", toEntidad.OrdenInsumos.oItem, "UnidadDeMedida_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.OrdenInsumos.oItem, "Cantidad" )
			toEntidad.OrdenInsumos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenSalidas( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenSalidas" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenSalidas[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenSalidas.LimpiarItem()
			else
				try
					toEntidad.OrdenSalidas.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenSalidas.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.OrdenSalidas.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.OrdenSalidas.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.OrdenSalidas.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.OrdenSalidas.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallemdetalle", toEntidad.OrdenSalidas.oItem, "TalleMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaborado", toEntidad.OrdenSalidas.oItem, "Semielaborado_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaboradodetalle", toEntidad.OrdenSalidas.oItem, "SemielaboradoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.OrdenSalidas.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.OrdenSalidas.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.OrdenSalidas.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.OrdenSalidas.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.OrdenSalidas.oItem, "Cantidad" )
			toEntidad.OrdenSalidas.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "Modelo", toEntidad.Modelo_PK)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "CurvaDeProduccion", toEntidad.CurvaDeProduccion_PK)
			this.SetearAtributoInteger( toModeloResponse, "Cantidad", toEntidad.Cantidad)
			this.SetearAtributoString( toModeloResponse, "ProductoFinal", toEntidad.ProductoFinal_PK)
			this.CargarColeccionModeloOrdenProcesos( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.CargarColeccionModeloOrdenCurva( toModeloResponse, toEntidad )
			this.CargarColeccionModeloOrdenInsumos( toModeloResponse, toEntidad )
			this.CargarColeccionModeloOrdenSalidas( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenProcesos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenProcesos" ) 
		with toEntidad
			for lnI = 1 to .OrdenProcesos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOrdenproceso" )
				this.SetearAtributoString( loItem, "CodigoOrden", .OrdenProcesos.Item(lnI).CodigoOrden)
				this.SetearAtributoString( loItem, "Proceso", .OrdenProcesos.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ProcesoDetalle", .OrdenProcesos.Item(lnI).ProcesoDetalle)
				this.SetearAtributoInteger( loItem, "Orden", .OrdenProcesos.Item(lnI).Orden)
				this.SetearAtributoString( loItem, "Taller", .OrdenProcesos.Item(lnI).Taller_PK)
				this.SetearAtributoString( loItem, "InventarioEntrada", .OrdenProcesos.Item(lnI).InventarioEntrada_PK)
				this.SetearAtributoString( loItem, "InventarioSalida", .OrdenProcesos.Item(lnI).InventarioSalida_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenProcesos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenCurva( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenCurva" ) 
		with toEntidad
			for lnI = 1 to .OrdenCurva.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOrdencurva" )
				this.SetearAtributoString( loItem, "CodigoOrden", .OrdenCurva.Item(lnI).CodigoOrden)
				this.SetearAtributoString( loItem, "Producto", .OrdenCurva.Item(lnI).Producto_PK)
				this.SetearAtributoString( loItem, "ProductoDetalle", .OrdenCurva.Item(lnI).ProductoDetalle)
				this.SetearAtributoString( loItem, "Color", .OrdenCurva.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .OrdenCurva.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .OrdenCurva.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .OrdenCurva.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .OrdenCurva.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Total", .OrdenCurva.Item(lnI).Total)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenCurva.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenInsumos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenInsumos" ) 
		with toEntidad
			for lnI = 1 to .OrdenInsumos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOrdeninsumo" )
				this.SetearAtributoString( loItem, "CodigoOrden", .OrdenInsumos.Item(lnI).CodigoOrden)
				this.SetearAtributoString( loItem, "Proceso", .OrdenInsumos.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ColorM", .OrdenInsumos.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .OrdenInsumos.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .OrdenInsumos.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "TalleMDetalle", .OrdenInsumos.Item(lnI).TalleMDetalle)
				this.SetearAtributoString( loItem, "Insumo", .OrdenInsumos.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .OrdenInsumos.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .OrdenInsumos.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorOrdDet", .OrdenInsumos.Item(lnI).ColorOrdDet)
				this.SetearAtributoString( loItem, "Talle", .OrdenInsumos.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .OrdenInsumos.Item(lnI).TalleDetalle)
				this.SetearAtributoString( loItem, "UnidadDeMedida", .OrdenInsumos.Item(lnI).UnidadDeMedida_PK)
				this.SetearAtributoDecimal( loItem, "Cantidad", .OrdenInsumos.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenInsumos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenSalidas( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenSalidas" ) 
		with toEntidad
			for lnI = 1 to .OrdenSalidas.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOrdensalida" )
				this.SetearAtributoString( loItem, "CodigoOrden", .OrdenSalidas.Item(lnI).CodigoOrden)
				this.SetearAtributoString( loItem, "Proceso", .OrdenSalidas.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ColorM", .OrdenSalidas.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .OrdenSalidas.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .OrdenSalidas.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "TalleMDetalle", .OrdenSalidas.Item(lnI).TalleMDetalle)
				this.SetearAtributoString( loItem, "Semielaborado", .OrdenSalidas.Item(lnI).Semielaborado_PK)
				this.SetearAtributoString( loItem, "SemielaboradoDetalle", .OrdenSalidas.Item(lnI).SemielaboradoDetalle)
				this.SetearAtributoString( loItem, "Color", .OrdenSalidas.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .OrdenSalidas.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .OrdenSalidas.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .OrdenSalidas.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .OrdenSalidas.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenSalidas.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Modelo", "MODELO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Curvadeproduccion", "CURVAPROD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidad", "NCANTIDAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Productofinal", "PRODUCTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Modelo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Curvaprod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Producto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine