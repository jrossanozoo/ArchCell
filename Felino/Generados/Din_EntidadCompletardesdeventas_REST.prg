
define class Din_EntidadCompletardesdeventas_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Completardesdeventas"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidad_desde", toEntidad, "F_articulo_unidad_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidad_hasta", toEntidad, "F_articulo_unidad_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_desde", toEntidad, "F_articulo_nomenclador_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_hasta", toEntidad, "F_articulo_nomenclador_hasta" )
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
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Desde", toEntidad.f_Articulo_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Hasta", toEntidad.f_Articulo_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Color_Desde", toEntidad.f_Color_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Color_Hasta", toEntidad.f_Color_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Desde", toEntidad.f_Talle_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Hasta", toEntidad.f_Talle_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Desde", toEntidad.f_Articulo_Proveedor_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Hasta", toEntidad.f_Articulo_Proveedor_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Anio_Desde", toEntidad.f_Articulo_Anio_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Anio_Hasta", toEntidad.f_Articulo_Anio_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Desde", toEntidad.f_Articulo_Material_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Hasta", toEntidad.f_Articulo_Material_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Desde", toEntidad.f_Articulo_Clasificacion_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Hasta", toEntidad.f_Articulo_Clasificacion_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Unidad_Desde", toEntidad.f_Articulo_Unidad_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Unidad_Hasta", toEntidad.f_Articulo_Unidad_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Desde", toEntidad.f_Articulo_Nomenclador_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Hasta", toEntidad.f_Articulo_Nomenclador_Hasta)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_desde", "CLIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_hasta", "CLIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_desde", "ARTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_hasta", "ARTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_desde", "COLDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_hasta", "COLHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_desde", "TALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_hasta", "TALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_desde", "PRODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_hasta", "PROHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_anio_desde", "ANIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_anio_hasta", "ANIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_desde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_hasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_desde", "CLASIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_hasta", "CLASIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidad_desde", "UNIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidad_hasta", "UNIHASTA")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arthasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Coldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Colhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Talhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Anidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Anihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Matdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbahasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine