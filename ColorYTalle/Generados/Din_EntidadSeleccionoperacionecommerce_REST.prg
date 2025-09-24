
define class Din_EntidadSeleccionoperacionecommerce_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Seleccionoperacionecommerce"
	cClaseResponse = this.cNamespaceDTOs + ".SeleccionoperacionecommerceResponse"
	cClaseModelo = "SeleccionoperacionecommerceModelo"
	cEntidad = "Seleccionoperacionecommerce"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionoperacionecommerceModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionoperacionecommerceModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionoperacionecommerceListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionoperacionecommerceListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionoperacionecommerceModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Plataforma", toEntidad, "Plataforma_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodeenvio", toEntidad, "Tipodeenvio" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Cab_fecha_desde", toEntidad, "Cab_fecha_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Cab_fecha_hasta", toEntidad, "Cab_fecha_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_hora_desde", toEntidad, "Cab_hora_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_hora_hasta", toEntidad, "Cab_hora_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_numero_desde", toEntidad, "Cab_numero_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_numero_hasta", toEntidad, "Cab_numero_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_packid_desde", toEntidad, "Cab_packid_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_packid_hasta", toEntidad, "Cab_packid_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_clienteecom_desde", toEntidad, "Cab_clienteecom_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_clienteecom_hasta", toEntidad, "Cab_clienteecom_hasta_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Item_fechacancelacion_desde", toEntidad, "Item_fechacancelacion_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Item_fechacancelacion_hasta", toEntidad, "Item_fechacancelacion_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_pagado", toEntidad, "Cab_pagado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_datosenvio", toEntidad, "Cab_datosenvio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_datospago", toEntidad, "Cab_datospago" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cab_obs", toEntidad, "Cab_obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_storeorderid_desde", toEntidad, "Item_storeorderid_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_storeorderid_hasta", toEntidad, "Item_storeorderid_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_idpublicacion_desde", toEntidad, "Item_idpublicacion_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_idpublicacion_hasta", toEntidad, "Item_idpublicacion_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_descripcion", toEntidad, "Item_descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_desde", toEntidad, "Item_articulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_hasta", toEntidad, "Item_articulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_color_desde", toEntidad, "Item_color_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_color_hasta", toEntidad, "Item_color_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_talle_desde", toEntidad, "Item_talle_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_talle_hasta", toEntidad, "Item_talle_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_proveedor_desde", toEntidad, "Item_articulo_proveedor_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_proveedor_hasta", toEntidad, "Item_articulo_proveedor_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_temporada_desde", toEntidad, "Item_articulo_temporada_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_temporada_hasta", toEntidad, "Item_articulo_temporada_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_ano_desde", toEntidad, "Item_articulo_ano_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_ano_hasta", toEntidad, "Item_articulo_ano_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_familia_desde", toEntidad, "Item_articulo_familia_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_familia_hasta", toEntidad, "Item_articulo_familia_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_material_desde", toEntidad, "Item_articulo_material_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_material_hasta", toEntidad, "Item_articulo_material_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_linea_desde", toEntidad, "Item_articulo_linea_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_linea_hasta", toEntidad, "Item_articulo_linea_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_grupo_desde", toEntidad, "Item_articulo_grupo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Item_articulo_grupo_hasta", toEntidad, "Item_articulo_grupo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Accion", toEntidad, "Accion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Buzon", toEntidad, "Buzon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Utilizastockotrabase", toEntidad, "Utilizastockotrabase" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bdorigenstock", toEntidad, "Bdorigenstock" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Accionfullenv", toEntidad, "Accionfullenv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Buzonfullenv", toEntidad, "Buzonfullenv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatosfullenv", toEntidad, "Basededatosfullenv" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Plataforma", toEntidad.Plataforma_PK)
			this.SetearAtributoString( toModeloResponse, "TipoDeEnvio", toEntidad.TipoDeEnvio)
			this.SetearAtributoDateTime( toModeloResponse, "Cab_fecha_Desde", toEntidad.Cab_fecha_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "Cab_fecha_Hasta", toEntidad.Cab_fecha_Hasta)
			this.SetearAtributoString( toModeloResponse, "Cab_Hora_Desde", toEntidad.Cab_Hora_Desde)
			this.SetearAtributoString( toModeloResponse, "Cab_Hora_Hasta", toEntidad.Cab_Hora_Hasta)
			this.SetearAtributoString( toModeloResponse, "Cab_Numero_Desde", toEntidad.Cab_Numero_Desde)
			this.SetearAtributoString( toModeloResponse, "Cab_Numero_Hasta", toEntidad.Cab_Numero_Hasta)
			this.SetearAtributoString( toModeloResponse, "Cab_PackId_Desde", toEntidad.Cab_PackId_Desde)
			this.SetearAtributoString( toModeloResponse, "Cab_PackId_Hasta", toEntidad.Cab_PackId_Hasta)
			this.SetearAtributoString( toModeloResponse, "Cab_ClienteEcom_Desde", toEntidad.Cab_ClienteEcom_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Cab_ClienteEcom_Hasta", toEntidad.Cab_ClienteEcom_Hasta_PK)
			this.SetearAtributoDateTime( toModeloResponse, "Item_FechaCancelacion_Desde", toEntidad.Item_FechaCancelacion_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "Item_FechaCancelacion_Hasta", toEntidad.Item_FechaCancelacion_Hasta)
			this.SetearAtributoString( toModeloResponse, "Cab_Pagado", toEntidad.Cab_Pagado)
			this.SetearAtributoString( toModeloResponse, "Cab_DatosEnvio", toEntidad.Cab_DatosEnvio)
			this.SetearAtributoString( toModeloResponse, "Cab_DatosPago", toEntidad.Cab_DatosPago)
			this.SetearAtributoString( toModeloResponse, "Cab_Obs", toEntidad.Cab_Obs)
			this.SetearAtributoString( toModeloResponse, "Item_StoreOrderId_Desde", toEntidad.Item_StoreOrderId_Desde)
			this.SetearAtributoString( toModeloResponse, "Item_StoreOrderId_Hasta", toEntidad.Item_StoreOrderId_Hasta)
			this.SetearAtributoString( toModeloResponse, "Item_IDPublicacion_Desde", toEntidad.Item_IDPublicacion_Desde)
			this.SetearAtributoString( toModeloResponse, "Item_IDPublicacion_Hasta", toEntidad.Item_IDPublicacion_Hasta)
			this.SetearAtributoString( toModeloResponse, "Item_Descripcion", toEntidad.Item_Descripcion)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Desde", toEntidad.Item_Articulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Hasta", toEntidad.Item_Articulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Color_Desde", toEntidad.Item_Color_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Color_Hasta", toEntidad.Item_Color_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Talle_Desde", toEntidad.Item_Talle_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Talle_Hasta", toEntidad.Item_Talle_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Proveedor_Desde", toEntidad.Item_Articulo_Proveedor_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Proveedor_Hasta", toEntidad.Item_Articulo_Proveedor_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Temporada_Desde", toEntidad.Item_Articulo_Temporada_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Temporada_Hasta", toEntidad.Item_Articulo_Temporada_Hasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "Item_Articulo_Ano_Desde", toEntidad.Item_Articulo_Ano_Desde)
			this.SetearAtributoInteger( toModeloResponse, "Item_Articulo_Ano_Hasta", toEntidad.Item_Articulo_Ano_Hasta)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Familia_Desde", toEntidad.Item_Articulo_Familia_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Familia_Hasta", toEntidad.Item_Articulo_Familia_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Material_Desde", toEntidad.Item_Articulo_Material_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Material_Hasta", toEntidad.Item_Articulo_Material_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Linea_Desde", toEntidad.Item_Articulo_Linea_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Linea_Hasta", toEntidad.Item_Articulo_Linea_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Grupo_Desde", toEntidad.Item_Articulo_Grupo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "Item_Articulo_Grupo_Hasta", toEntidad.Item_Articulo_Grupo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Accion", toEntidad.Accion)
			this.SetearAtributoString( toModeloResponse, "Buzon", toEntidad.Buzon)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributo( toModeloResponse, "UtilizaStockOtraBase", toEntidad.UtilizaStockOtraBase)
			this.SetearAtributoString( toModeloResponse, "BDOrigenStock", toEntidad.BDOrigenStock)
			this.SetearAtributoString( toModeloResponse, "AccionFullEnv", toEntidad.AccionFullEnv)
			this.SetearAtributoString( toModeloResponse, "BuzonFullEnv", toEntidad.BuzonFullEnv)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatosFullEnv", toEntidad.BaseDeDatosFullEnv)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cab_datosenvio", "ENVIO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Envio LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine