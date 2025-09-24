
define class Din_EntidadCompletardesdeventas_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Completardesdeventas"
	cClaseResponse = this.cNamespaceDTOs + ".CompletardesdeventasResponse"
	cClaseModelo = "CompletardesdeventasModelo"
	cEntidad = "Completardesdeventas"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardesdeventasModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardesdeventasModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardesdeventasListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardesdeventasListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardesdeventasModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Baseorigen", toEntidad, "Baseorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basestock", toEntidad, "Basestock" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nocomercializable", toEntidad, "Nocomercializable" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_desde", toEntidad, "F_cliente_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_hasta", toEntidad, "F_cliente_hasta_PK" )
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidaddemedida_desde", toEntidad, "F_articulo_unidaddemedida_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidaddemedida_hasta", toEntidad, "F_articulo_unidaddemedida_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_desde", toEntidad, "F_articulo_nomenclador_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_hasta", toEntidad, "F_articulo_nomenclador_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_precioconimpuestos_desde", toEntidad, "F_precioconimpuestos_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_precioconimpuestos_hasta", toEntidad, "F_precioconimpuestos_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechamodificacionfw_desde", toEntidad, "F_articulo_fechamodificacionfw_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechamodificacionfw_hasta", toEntidad, "F_articulo_fechamodificacionfw_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaaltafw_desde", toEntidad, "F_articulo_fechaaltafw_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaaltafw_hasta", toEntidad, "F_articulo_fechaaltafw_hasta" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoString( toModeloResponse, "BaseOrigen", toEntidad.BaseOrigen)
			this.SetearAtributoString( toModeloResponse, "BaseStock", toEntidad.BaseStock)
			this.SetearAtributoString( toModeloResponse, "NoComercializable", toEntidad.NoComercializable)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Desde", toEntidad.f_Cliente_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Hasta", toEntidad.f_Cliente_Hasta_PK)
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
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UnidadDeMedida_Desde", toEntidad.f_Articulo_UnidadDeMedida_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UnidadDeMedida_Hasta", toEntidad.f_Articulo_UnidadDeMedida_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Desde", toEntidad.f_Articulo_Nomenclador_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Hasta", toEntidad.f_Articulo_Nomenclador_Hasta_PK)
			this.SetearAtributoDecimal( toModeloResponse, "f_PrecioConImpuestos_Desde", toEntidad.f_PrecioConImpuestos_Desde)
			this.SetearAtributoDecimal( toModeloResponse, "f_PrecioConImpuestos_Hasta", toEntidad.f_PrecioConImpuestos_Hasta)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaModificacionFW_Desde", toEntidad.f_Articulo_FechaModificacionFW_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaModificacionFW_Hasta", toEntidad.f_Articulo_FechaModificacionFW_Hasta)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaAltaFW_Desde", toEntidad.f_Articulo_FechaAltaFW_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaAltaFW_Hasta", toEntidad.f_Articulo_FechaAltaFW_Hasta)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FECHADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FECHAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Baseorigen", "BASEORIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basestock", "BASESTOCK")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nocomercializable", "NOCOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_desde", "CLIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_hasta", "CLIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_desde", "ARTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_hasta", "ARTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_desde", "COLDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_hasta", "COLHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_desde", "TALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_hasta", "TALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_desde", "PRODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_hasta", "PROHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_temporada_desde", "TEMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_temporada_hasta", "TEMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_ano_desde", "ANIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_ano_hasta", "ANIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_familia_desde", "FAMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_familia_hasta", "FAMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_desde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_hasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_linea_desde", "LINEADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_linea_hasta", "LINEAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_grupo_desde", "GRUPODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_grupo_hasta", "GRUPOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_categoriadearticulo_desde", "CATEGDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_categoriadearticulo_hasta", "CATEGHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_desde", "CLASIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_hasta", "CLASIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_tipodearticulo_desde", "TIPODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_tipodearticulo_hasta", "TIPOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_paletadecolores_desde", "PALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_paletadecolores_hasta", "PALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_curvadetalles_desde", "CURDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_curvadetalles_hasta", "CURHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidaddemedida_desde", "UNIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidaddemedida_hasta", "UNIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_nomenclador_desde", "NARBADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_nomenclador_hasta", "NARBAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_precioconimpuestos_desde", "PRECIVADES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_precioconimpuestos_hasta", "PRECIVAHAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechamodificacionfw_desde", "FECMODDESD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechamodificacionfw_hasta", "FECMODHAST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaaltafw_desde", "FECALTADES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaaltafw_hasta", "FECALTAHAS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Baseorig LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Basestock LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nocom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arthasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Coldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Colhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Talhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Temdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Temhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Matdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lineadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lineahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Grupodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Grupohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Categdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Categhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Paldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Palhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Curdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Curhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbahasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine