
define class Din_EntidadCalculodeprecios_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Calculodeprecios"
	cClaseResponse = this.cNamespaceDTOs + ".CalculodepreciosResponse"
	cClaseModelo = "CalculodepreciosModelo"
	cEntidad = "Calculodeprecios"
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
		toEntidad.Codigo = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "CalculodepreciosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CalculodepreciosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CalculodepreciosListarRequest"
			case tcOperacion == "Anular"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CalculodepreciosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CalculodepreciosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Importarsintransaccion", toEntidad, "Importarsintransaccion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usacombinacion", toEntidad, "Usacombinacion" )
			this.SetearDetalleModprecios( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechabase", toEntidad, "Fechabase" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigencia", toEntidad, "Fechavigencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulo_comportamiento", toEntidad, "Articulo_comportamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preciokitpackxparticipante", toEntidad, "Preciokitpackxparticipante" )
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
	protected function SetearDetalleModPrecios( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ModPrecios" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ModPrecios[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ModPrecios.LimpiarItem()
			else
				try
					toEntidad.ModPrecios.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ModPrecios.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Lprecio", toEntidad.ModPrecios.oItem, "LPrecio_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Lpreciodetalle", toEntidad.ModPrecios.oItem, "LPrecioDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Accion", toEntidad.ModPrecios.oItem, "Accion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Lprecioa", toEntidad.ModPrecios.oItem, "LPrecioA_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.ModPrecios.oItem, "Valor" )
			this.SetearAtributoModeloEnEntidad( loItem, "Formula", toEntidad.ModPrecios.oItem, "Formula_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Redondeo", toEntidad.ModPrecios.oItem, "Redondeo_PK" )
			toEntidad.ModPrecios.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "ImportarSinTransaccion", toEntidad.ImportarSinTransaccion)
			this.SetearAtributo( toModeloResponse, "UsaCombinacion", toEntidad.UsaCombinacion)
			this.CargarColeccionModeloModPrecios( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaBase", toEntidad.FechaBase)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigencia", toEntidad.FechaVigencia)
			this.SetearAtributoString( toModeloResponse, "Articulo_Comportamiento", toEntidad.Articulo_Comportamiento)
			this.SetearAtributo( toModeloResponse, "PrecioKitPackxParticipante", toEntidad.PrecioKitPackxParticipante)
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
	protected function CargarColeccionModeloModPrecios( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ModPrecios" ) 
		with toEntidad
			for lnI = 1 to .ModPrecios.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCalculodeprecios" )
				this.SetearAtributoInteger( loItem, "Codigo", .ModPrecios.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "LPrecio", .ModPrecios.Item(lnI).LPrecio_PK)
				this.SetearAtributoString( loItem, "LPrecioDetalle", .ModPrecios.Item(lnI).LPrecioDetalle)
				this.SetearAtributoString( loItem, "Accion", .ModPrecios.Item(lnI).Accion)
				this.SetearAtributoString( loItem, "LPrecioA", .ModPrecios.Item(lnI).LPrecioA_PK)
				this.SetearAtributoDecimal( loItem, "Valor", .ModPrecios.Item(lnI).Valor)
				this.SetearAtributoString( loItem, "Formula", .ModPrecios.Item(lnI).Formula_PK)
				this.SetearAtributoString( loItem, "Redondeo", .ModPrecios.Item(lnI).Redondeo_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .ModPrecios.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Importarsintransaccion", "SINTRANSAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usacombinacion", "USACOMB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), MOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechabase", "FECHABASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigencia", "FECHAVIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulo_comportamiento", "COMPORTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Preciokitpackxparticipante", "KPXPARTIC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_desde", "ARTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_hasta", "ARTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_desde", "COLDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_hasta", "COLHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_desde", "TALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_hasta", "TALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_desde", "PROVDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_hasta", "PROVHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_temporada_desde", "TEMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_temporada_hasta", "TEMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_ano_desde", "ANODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_ano_hasta", "ANOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_familia_desde", "FAMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_familia_hasta", "FAMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_desde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_hasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_linea_desde", "LINDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_linea_hasta", "LINHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_grupo_desde", "GRUDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_grupo_hasta", "GRUHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_categoriadearticulo_desde", "CATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_categoriadearticulo_hasta", "CATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_desde", "CLADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_hasta", "CLAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_tipodearticulo_desde", "TIPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_tipodearticulo_hasta", "TIPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidaddemedida_desde", "UNIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidaddemedida_hasta", "UNIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_nomenclador_desde", "NARBADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_nomenclador_hasta", "NARBAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechamodificacionfw_desde", "MODDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechamodificacionfw_hasta", "MODHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaaltafw_desde", "ALTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaaltafw_hasta", "ALTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_timestampalta_desde", "FTSADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_timestampalta_hasta", "FTSAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechatransferencia_desde", "TRADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechatransferencia_hasta", "TRAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaimpo_desde", "IMPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaimpo_hasta", "IMPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaexpo_desde", "EXPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaexpo_hasta", "EXPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_preciodirecto_desde", "PRECDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_preciodirecto_hasta", "PRECHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_marca_desde", "MARCADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_marca_hasta", "MARCAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_usuarioaltafw", "UALTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_usuariomodificacionfw", "UMOD")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Comporta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arthasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Coldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Colhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Talhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Temdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Temhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Matdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lindesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Linhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Grudesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Gruhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Catdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cladesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tiphasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marcadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marcahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ualta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Umod LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine