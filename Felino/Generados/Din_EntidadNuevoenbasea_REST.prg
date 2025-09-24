
define class Din_EntidadNuevoenbasea_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Nuevoenbasea"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferencia", toEntidad, "Diferencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mercaderiaconsignacion", toEntidad, "Mercaderiaconsignacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clienteconsignacion", toEntidad, "Clienteconsignacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bdconsignacion", toEntidad, "Bdconsignacion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_consignacion_desde", toEntidad, "Fecha_consignacion_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_consignacion_hasta", toEntidad, "Fecha_consignacion_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bolsasycajas", toEntidad, "Bolsasycajas_PK" )
			this.SetearDetalleDetallecomprobantes( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_desde", toEntidad, "Cliente_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_hasta", toEntidad, "Cliente_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero_desde", toEntidad, "Numero_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero_hasta", toEntidad, "Numero_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_desde", toEntidad, "Fecha_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha_hasta", toEntidad, "Fecha_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechafactura_desde", toEntidad, "Fechafactura_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechafactura_hasta", toEntidad, "Fechafactura_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor_desde", toEntidad, "Proveedor_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor_hasta", toEntidad, "Proveedor_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor_desde", toEntidad, "Vendedor_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor_hasta", toEntidad, "Vendedor_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante_desde", toEntidad, "Monedacomprobante_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante_hasta", toEntidad, "Monedacomprobante_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_desde", toEntidad, "F_articulo_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_hasta", toEntidad, "F_articulo_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_desde", toEntidad, "F_color_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_hasta", toEntidad, "F_color_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_desde", toEntidad, "F_talle_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_hasta", toEntidad, "F_talle_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_desde", toEntidad, "F_articulo_proveedor_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_hasta", toEntidad, "F_articulo_proveedor_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_anio_desde", toEntidad, "F_articulo_anio_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_anio_hasta", toEntidad, "F_articulo_anio_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_desde", toEntidad, "F_articulo_material_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_hasta", toEntidad, "F_articulo_material_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_desde", toEntidad, "F_articulo_clasificacion_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_hasta", toEntidad, "F_articulo_clasificacion_hasta" )
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
			this.SetearAtributoString( toModeloResponse, "Diferencia", toEntidad.Diferencia)
			this.SetearAtributo( toModeloResponse, "MercaderiaConsignacion", toEntidad.MercaderiaConsignacion)
			this.SetearAtributoString( toModeloResponse, "ClienteConsignacion", toEntidad.ClienteConsignacion_PK)
			this.SetearAtributoString( toModeloResponse, "BDConsignacion", toEntidad.BDConsignacion)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_Consignacion_Desde", toEntidad.fecha_Consignacion_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_Consignacion_Hasta", toEntidad.fecha_Consignacion_Hasta)
			this.SetearAtributoString( toModeloResponse, "BolsasyCajas", toEntidad.BolsasyCajas_PK)
			this.CargarColeccionModeloDetalleComprobantes( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "cliente_Desde", toEntidad.cliente_Desde)
			this.SetearAtributoString( toModeloResponse, "cliente_Hasta", toEntidad.cliente_Hasta)
			this.SetearAtributoInteger( toModeloResponse, "numero_desde", toEntidad.numero_desde)
			this.SetearAtributoInteger( toModeloResponse, "numero_Hasta", toEntidad.numero_Hasta)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_Desde", toEntidad.fecha_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "fecha_hasta", toEntidad.fecha_hasta)
			this.SetearAtributoDateTime( toModeloResponse, "fechafactura_Desde", toEntidad.fechafactura_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "fechafactura_Hasta", toEntidad.fechafactura_Hasta)
			this.SetearAtributoString( toModeloResponse, "proveedor_Desde", toEntidad.proveedor_Desde)
			this.SetearAtributoString( toModeloResponse, "proveedor_Hasta", toEntidad.proveedor_Hasta)
			this.SetearAtributoString( toModeloResponse, "vendedor_desde", toEntidad.vendedor_desde)
			this.SetearAtributoString( toModeloResponse, "vendedor_hasta", toEntidad.vendedor_hasta)
			this.SetearAtributoString( toModeloResponse, "monedaComprobante_desde", toEntidad.monedaComprobante_desde_PK)
			this.SetearAtributoString( toModeloResponse, "monedaComprobante_hasta", toEntidad.monedaComprobante_hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Desde", toEntidad.f_Articulo_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Hasta", toEntidad.f_Articulo_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Color_Desde", toEntidad.f_Color_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Color_Hasta", toEntidad.f_Color_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Desde", toEntidad.f_Talle_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Hasta", toEntidad.f_Talle_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Desde", toEntidad.f_Articulo_Proveedor_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Hasta", toEntidad.f_Articulo_Proveedor_Hasta)
			this.SetearAtributoInteger( toModeloResponse, "f_Articulo_Anio_Desde", toEntidad.f_Articulo_Anio_Desde)
			this.SetearAtributoInteger( toModeloResponse, "f_Articulo_Anio_Hasta", toEntidad.f_Articulo_Anio_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Desde", toEntidad.f_Articulo_Material_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Hasta", toEntidad.f_Articulo_Material_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Desde", toEntidad.f_Articulo_Clasificacion_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Hasta", toEntidad.f_Articulo_Clasificacion_Hasta)
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