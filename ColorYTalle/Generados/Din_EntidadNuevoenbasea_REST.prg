
define class Din_EntidadNuevoenbasea_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Nuevoenbasea"
	cClaseResponse = this.cNamespaceDTOs + ".NuevoenbaseaResponse"
	cClaseModelo = "NuevoenbaseaModelo"
	cEntidad = "Nuevoenbasea"
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
				lcRetorno = this.cNamespaceDTOs + "." + "NuevoenbaseaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "NuevoenbaseaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "NuevoenbaseaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "NuevoenbaseaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "NuevoenbaseaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidad", toEntidad, "Entidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Operatoria", toEntidad, "Operatoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Filtro", toEntidad, "Filtro" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mercaderiaconsignacion", toEntidad, "Mercaderiaconsignacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clienteconsignacion", toEntidad, "Clienteconsignacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bdconsignacion", toEntidad, "Bdconsignacion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_consignacion_desde", toEntidad, "Fecha_consignacion_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_consignacion_hasta", toEntidad, "Fecha_consignacion_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferencia", toEntidad, "Diferencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bolsasycajas", toEntidad, "Bolsasycajas_PK" )
			this.SetearDetalleDetallecomprobantes( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_desde", toEntidad, "Cliente_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_hasta", toEntidad, "Cliente_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero_desde", toEntidad, "Numero_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero_hasta", toEntidad, "Numero_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_desde", toEntidad, "Fecha_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_hasta", toEntidad, "Fecha_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechafactura_desde", toEntidad, "Fechafactura_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechafactura_hasta", toEntidad, "Fechafactura_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor_desde", toEntidad, "Proveedor_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor_hasta", toEntidad, "Proveedor_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor_desde", toEntidad, "Vendedor_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor_hasta", toEntidad, "Vendedor_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante_desde", toEntidad, "Monedacomprobante_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante_hasta", toEntidad, "Monedacomprobante_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_desde", toEntidad, "F_articulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_hasta", toEntidad, "F_articulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_desde", toEntidad, "F_color_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_hasta", toEntidad, "F_color_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_desde", toEntidad, "F_talle_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_hasta", toEntidad, "F_talle_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_desde", toEntidad, "F_articulo_proveedor_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_hasta", toEntidad, "F_articulo_proveedor_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_temporada_desde", toEntidad, "F_articulo_temporada_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_temporada_hasta", toEntidad, "F_articulo_temporada_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_ano_desde", toEntidad, "F_articulo_ano_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_ano_hasta", toEntidad, "F_articulo_ano_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_familia_desde", toEntidad, "F_articulo_familia_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_familia_hasta", toEntidad, "F_articulo_familia_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_desde", toEntidad, "F_articulo_material_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_hasta", toEntidad, "F_articulo_material_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_linea_desde", toEntidad, "F_articulo_linea_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_linea_hasta", toEntidad, "F_articulo_linea_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_grupo_desde", toEntidad, "F_articulo_grupo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_grupo_hasta", toEntidad, "F_articulo_grupo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_categoriadearticulo_desde", toEntidad, "F_articulo_categoriadearticulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_categoriadearticulo_hasta", toEntidad, "F_articulo_categoriadearticulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_desde", toEntidad, "F_articulo_clasificacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_hasta", toEntidad, "F_articulo_clasificacion_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_tipodearticulo_desde", toEntidad, "F_articulo_tipodearticulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_tipodearticulo_hasta", toEntidad, "F_articulo_tipodearticulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_paletadecolores_desde", toEntidad, "F_articulo_paletadecolores_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_paletadecolores_hasta", toEntidad, "F_articulo_paletadecolores_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_curvadetalles_desde", toEntidad, "F_articulo_curvadetalles_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_curvadetalles_hasta", toEntidad, "F_articulo_curvadetalles_hasta_PK" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleComprobantes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleComprobantes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleComprobantes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleComprobantes.LimpiarItem()
			else
				try
					toEntidad.DetalleComprobantes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleComprobantes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.DetalleComprobantes.oItem, "Numero" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.DetalleComprobantes.oItem, "Descripcion" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.DetalleComprobantes.oItem, "Fecha" )
			toEntidad.DetalleComprobantes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Entidad", toEntidad.Entidad)
			this.SetearAtributoInteger( toModeloResponse, "Operatoria", toEntidad.Operatoria)
			this.SetearAtributoString( toModeloResponse, "Filtro", toEntidad.Filtro)
			this.SetearAtributo( toModeloResponse, "MercaderiaConsignacion", toEntidad.MercaderiaConsignacion)
			this.SetearAtributoString( toModeloResponse, "ClienteConsignacion", toEntidad.ClienteConsignacion_PK)
			this.SetearAtributoString( toModeloResponse, "BDConsignacion", toEntidad.BDConsignacion)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_Consignacion_Desde", toEntidad.fecha_Consignacion_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_Consignacion_Hasta", toEntidad.fecha_Consignacion_Hasta)
			this.SetearAtributoString( toModeloResponse, "Diferencia", toEntidad.Diferencia)
			this.SetearAtributoString( toModeloResponse, "BolsasyCajas", toEntidad.BolsasyCajas_PK)
			this.CargarColeccionModeloDetalleComprobantes( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "cliente_Desde", toEntidad.cliente_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "cliente_Hasta", toEntidad.cliente_Hasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "numero_desde", toEntidad.numero_desde)
			this.SetearAtributoInteger( toModeloResponse, "numero_Hasta", toEntidad.numero_Hasta)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_Desde", toEntidad.fecha_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_hasta", toEntidad.fecha_hasta)
			this.SetearAtributoDateTime( toModeloResponse, "fechafactura_Desde", toEntidad.fechafactura_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "fechafactura_Hasta", toEntidad.fechafactura_Hasta)
			this.SetearAtributoString( toModeloResponse, "proveedor_Desde", toEntidad.proveedor_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "proveedor_Hasta", toEntidad.proveedor_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "vendedor_desde", toEntidad.vendedor_desde_PK)
			this.SetearAtributoString( toModeloResponse, "vendedor_hasta", toEntidad.vendedor_hasta_PK)
			this.SetearAtributoString( toModeloResponse, "monedaComprobante_desde", toEntidad.monedaComprobante_desde_PK)
			this.SetearAtributoString( toModeloResponse, "monedaComprobante_hasta", toEntidad.monedaComprobante_hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Desde", toEntidad.f_Articulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Hasta", toEntidad.f_Articulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Color_Desde", toEntidad.f_Color_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Color_Hasta", toEntidad.f_Color_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Desde", toEntidad.f_Talle_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Hasta", toEntidad.f_Talle_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Desde", toEntidad.f_Articulo_Proveedor_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Hasta", toEntidad.f_Articulo_Proveedor_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Temporada_Desde", toEntidad.f_Articulo_Temporada_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Temporada_Hasta", toEntidad.f_Articulo_Temporada_Hasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "f_Articulo_Ano_Desde", toEntidad.f_Articulo_Ano_Desde)
			this.SetearAtributoInteger( toModeloResponse, "f_Articulo_Ano_Hasta", toEntidad.f_Articulo_Ano_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Familia_Desde", toEntidad.f_Articulo_Familia_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Familia_Hasta", toEntidad.f_Articulo_Familia_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Desde", toEntidad.f_Articulo_Material_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Hasta", toEntidad.f_Articulo_Material_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Linea_Desde", toEntidad.f_Articulo_Linea_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Linea_Hasta", toEntidad.f_Articulo_Linea_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Grupo_Desde", toEntidad.f_Articulo_Grupo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Grupo_Hasta", toEntidad.f_Articulo_Grupo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_CategoriaDeArticulo_Desde", toEntidad.f_Articulo_CategoriaDeArticulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_CategoriaDeArticulo_Hasta", toEntidad.f_Articulo_CategoriaDeArticulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Desde", toEntidad.f_Articulo_Clasificacion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Hasta", toEntidad.f_Articulo_Clasificacion_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_TipoDeArticulo_Desde", toEntidad.f_Articulo_TipoDeArticulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_TipoDeArticulo_Hasta", toEntidad.f_Articulo_TipoDeArticulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_PaletaDeColores_Desde", toEntidad.f_Articulo_PaletaDeColores_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_PaletaDeColores_Hasta", toEntidad.f_Articulo_PaletaDeColores_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_CurvaDeTalles_Desde", toEntidad.f_Articulo_CurvaDeTalles_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_CurvaDeTalles_Hasta", toEntidad.f_Articulo_CurvaDeTalles_Hasta_PK)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleComprobantes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleComprobantes" ) 
		with toEntidad
			for lnI = 1 to .DetalleComprobantes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemComprobantesenbasea" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleComprobantes.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Numero", .DetalleComprobantes.Item(lnI).Numero)
				this.SetearAtributoString( loItem, "Descripcion", .DetalleComprobantes.Item(lnI).Descripcion)
				this.SetearAtributoDatetime( loItem, "Fecha", .DetalleComprobantes.Item(lnI).Fecha)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleComprobantes.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diferencia", "DIFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bolsasycajas", "BOLYCAJ")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dife LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Bolycaj LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine