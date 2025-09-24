
define class Din_EntidadComision_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Comision"
	cClaseResponse = this.cNamespaceDTOs + ".ComisionResponse"
	cClaseModelo = "ComisionModelo"
	cEntidad = "Comision"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComisionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComisionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComisionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComisionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ComisionModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciadesde", toEntidad, "Fechavigenciadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciahasta", toEntidad, "Fechavigenciahasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechamodificacionfw", toEntidad, "Fechamodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horamodificacionfw", toEntidad, "Horamodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentaje", toEntidad, "Porcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montofijo", toEntidad, "Montofijo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_desde", toEntidad, "F_articulo_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_hasta", toEntidad, "F_articulo_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_desde", toEntidad, "F_color_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_hasta", toEntidad, "F_color_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_desde", toEntidad, "F_talle_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_hasta", toEntidad, "F_talle_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_desde", toEntidad, "F_articulo_proveedor_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_hasta", toEntidad, "F_articulo_proveedor_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidad_desde", toEntidad, "F_articulo_unidad_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidad_hasta", toEntidad, "F_articulo_unidad_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_desde", toEntidad, "F_articulo_material_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_hasta", toEntidad, "F_articulo_material_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_codigo_desde", toEntidad, "F_sucursal_codigo_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_codigo_hasta", toEntidad, "F_sucursal_codigo_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_tipo_desde", toEntidad, "F_sucursal_tipo_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_tipo_hasta", toEntidad, "F_sucursal_tipo_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_linea_desde", toEntidad, "F_sucursal_linea_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_linea_hasta", toEntidad, "F_sucursal_linea_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_segmentacion_desde", toEntidad, "F_sucursal_segmentacion_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_segmentacion_hasta", toEntidad, "F_sucursal_segmentacion_hasta" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaDesde", toEntidad.FechaVigenciaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaHasta", toEntidad.FechaVigenciaHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaModificacionFW", toEntidad.FechaModificacionFW)
			this.SetearAtributoString( toModeloResponse, "HoraModificacionFW", toEntidad.HoraModificacionFW)
			this.SetearAtributoDecimal( toModeloResponse, "Porcentaje", toEntidad.Porcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "MontoFijo", toEntidad.MontoFijo)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Desde", toEntidad.f_Articulo_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Hasta", toEntidad.f_Articulo_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Color_desde", toEntidad.f_Color_desde)
			this.SetearAtributoString( toModeloResponse, "f_Color_hasta", toEntidad.f_Color_hasta)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Desde", toEntidad.f_Talle_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Hasta", toEntidad.f_Talle_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Desde", toEntidad.f_Articulo_Proveedor_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Hasta", toEntidad.f_Articulo_Proveedor_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Unidad_Desde", toEntidad.f_Articulo_Unidad_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Unidad_Hasta", toEntidad.f_Articulo_Unidad_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Desde", toEntidad.f_Articulo_Material_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Hasta", toEntidad.f_Articulo_Material_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Codigo_desde", toEntidad.f_Sucursal_Codigo_desde)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Codigo_hasta", toEntidad.f_Sucursal_Codigo_hasta)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Tipo_Desde", toEntidad.f_Sucursal_Tipo_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Tipo_Hasta", toEntidad.f_Sucursal_Tipo_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Linea_Desde", toEntidad.f_Sucursal_Linea_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Linea_Hasta", toEntidad.f_Sucursal_Linea_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Segmentacion_Desde", toEntidad.f_Sucursal_Segmentacion_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Segmentacion_Hasta", toEntidad.f_Sucursal_Segmentacion_Hasta)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciadesde", "FECHAFD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciahasta", "FECHAH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechamodificacionfw", "FMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horamodificacionfw", "HMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentaje", "PORCENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montofijo", "MONTOF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), MOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_desde", "ARTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_hasta", "ARTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_desde", "COLDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_hasta", "COLHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_desde", "TALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_hasta", "TALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_desde", "PROVDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_hasta", "PROVHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidad_desde", "UNIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidad_hasta", "UNIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_desde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_hasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_codigo_desde", "SUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_codigo_hasta", "SUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_tipo_desde", "TIPSDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_tipo_hasta", "TIPSHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_linea_desde", "LINSDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_linea_hasta", "LINSHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_segmentacion_desde", "SEGSDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_segmentacion_hasta", "SEGSHASTA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hmodifw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arthasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Coldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Colhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Talhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Matdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Suchasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipsdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipshasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Linsdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Linshasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Segsdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Segshasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine