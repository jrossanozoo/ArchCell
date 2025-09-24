
define class Din_EntidadPrecargaetiart_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Precargaetiart"
	cClaseResponse = this.cNamespaceDTOs + ".PrecargaetiartResponse"
	cClaseModelo = "PrecargaetiartModelo"
	cEntidad = "Precargaetiart"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PrecargaetiartModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "PrecargaetiartModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "PrecargaetiartListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PrecargaetiartListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "PrecargaetiartModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modificaciondeprecios", toEntidad, "Modificaciondeprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Calculodeprecios", toEntidad, "Calculodeprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movimientodestock", toEntidad, "Movimientodestock_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sugerenciacantidades", toEntidad, "Sugerenciacantidades" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modocargaminimos", toEntidad, "Modocargaminimos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecios", toEntidad, "Listadeprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Solopreciosactualizados", toEntidad, "Solopreciosactualizados" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Incluircombinacionesconstock", toEntidad, "Incluircombinacionesconstock" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadporarticulo", toEntidad, "Cantidadporarticulo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Agrupamientodebases", toEntidad, "Agrupamientodebases" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulodecorte", toEntidad, "Articulodecorte_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impresionetiquetakitpack", toEntidad, "Impresionetiquetakitpack" )
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulo_comportamiento", toEntidad, "Articulo_comportamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidaddemedida_desde", toEntidad, "F_articulo_unidaddemedida_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidaddemedida_hasta", toEntidad, "F_articulo_unidaddemedida_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_desde", toEntidad, "F_articulo_nomenclador_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_hasta", toEntidad, "F_articulo_nomenclador_hasta_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechamodificacionfw_desde", toEntidad, "F_articulo_fechamodificacionfw_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechamodificacionfw_hasta", toEntidad, "F_articulo_fechamodificacionfw_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaaltafw_desde", toEntidad, "F_articulo_fechaaltafw_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaaltafw_hasta", toEntidad, "F_articulo_fechaaltafw_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_timestampalta_desde", toEntidad, "F_timestampalta_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_timestampalta_hasta", toEntidad, "F_timestampalta_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechatransferencia_desde", toEntidad, "F_articulo_fechatransferencia_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechatransferencia_hasta", toEntidad, "F_articulo_fechatransferencia_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaimpo_desde", toEntidad, "F_articulo_fechaimpo_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaimpo_hasta", toEntidad, "F_articulo_fechaimpo_hasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaexpo_desde", toEntidad, "F_articulo_fechaexpo_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaexpo_hasta", toEntidad, "F_articulo_fechaexpo_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_preciodirecto_desde", toEntidad, "F_preciodirecto_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_preciodirecto_hasta", toEntidad, "F_preciodirecto_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_marca_desde", toEntidad, "F_articulo_marca_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_marca_hasta", toEntidad, "F_articulo_marca_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_usuarioaltafw", toEntidad, "F_articulo_usuarioaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_usuariomodificacionfw", toEntidad, "F_articulo_usuariomodificacionfw" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "ModificacionDePrecios", toEntidad.ModificacionDePrecios_PK)
			this.SetearAtributoInteger( toModeloResponse, "CalculoDePrecios", toEntidad.CalculoDePrecios_PK)
			this.SetearAtributoString( toModeloResponse, "MovimientoDeStock", toEntidad.MovimientoDeStock_PK)
			this.SetearAtributoString( toModeloResponse, "SugerenciaCantidades", toEntidad.SugerenciaCantidades)
			this.SetearAtributoInteger( toModeloResponse, "ModoCargaMinimos", toEntidad.ModoCargaMinimos)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecios", toEntidad.ListaDePrecios_PK)
			this.SetearAtributo( toModeloResponse, "SoloPreciosActualizados", toEntidad.SoloPreciosActualizados)
			this.SetearAtributo( toModeloResponse, "IncluirCombinacionesConStock", toEntidad.IncluirCombinacionesConStock)
			this.SetearAtributoLong( toModeloResponse, "CantidadPorArticulo", toEntidad.CantidadPorArticulo)
			this.SetearAtributoString( toModeloResponse, "AgrupamientoDeBases", toEntidad.AgrupamientoDeBases)
			this.SetearAtributoString( toModeloResponse, "ArticuloDeCorte", toEntidad.ArticuloDeCorte_PK)
			this.SetearAtributoInteger( toModeloResponse, "ImpresionEtiquetaKitPack", toEntidad.ImpresionEtiquetaKitPack)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Desde", toEntidad.f_Articulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Hasta", toEntidad.f_Articulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Color_desde", toEntidad.f_Color_desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Color_hasta", toEntidad.f_Color_hasta_PK)
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
			this.SetearAtributoString( toModeloResponse, "f_Articulo_TipodeArticulo_Desde", toEntidad.f_Articulo_TipodeArticulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_TipodeArticulo_Hasta", toEntidad.f_Articulo_TipodeArticulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Articulo_Comportamiento", toEntidad.Articulo_Comportamiento)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UnidadDeMedida_Desde", toEntidad.f_Articulo_UnidadDeMedida_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UnidadDeMedida_Hasta", toEntidad.f_Articulo_UnidadDeMedida_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Desde", toEntidad.f_Articulo_Nomenclador_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Hasta", toEntidad.f_Articulo_Nomenclador_Hasta_PK)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaModificacionFw_Desde", toEntidad.f_Articulo_FechaModificacionFw_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaModificacionFw_Hasta", toEntidad.f_Articulo_FechaModificacionFw_Hasta)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaAltaFw_Desde", toEntidad.f_Articulo_FechaAltaFw_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaAltaFw_Hasta", toEntidad.f_Articulo_FechaAltaFw_Hasta)
			this.SetearAtributoLong( toModeloResponse, "f_Timestampalta_desde", toEntidad.f_Timestampalta_desde)
			this.SetearAtributoLong( toModeloResponse, "f_Timestampalta_hasta", toEntidad.f_Timestampalta_hasta)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaTransferencia_Desde", toEntidad.f_Articulo_FechaTransferencia_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaTransferencia_Hasta", toEntidad.f_Articulo_FechaTransferencia_Hasta)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaImpo_Desde", toEntidad.f_Articulo_FechaImpo_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaImpo_Hasta", toEntidad.f_Articulo_FechaImpo_Hasta)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaExpo_Desde", toEntidad.f_Articulo_FechaExpo_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaExpo_Hasta", toEntidad.f_Articulo_FechaExpo_Hasta)
			this.SetearAtributoDecimal( toModeloResponse, "f_Preciodirecto_Desde", toEntidad.f_Preciodirecto_Desde)
			this.SetearAtributoDecimal( toModeloResponse, "f_Preciodirecto_Hasta", toEntidad.f_Preciodirecto_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Marca_Desde", toEntidad.f_Articulo_Marca_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Marca_Hasta", toEntidad.f_Articulo_Marca_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UsuarioAltaFw", toEntidad.f_Articulo_UsuarioAltaFw)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UsuarioModificacionFw", toEntidad.f_Articulo_UsuarioModificacionFw)
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