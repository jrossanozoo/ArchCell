
define class Din_EntidadComision_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Comision"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechamodificacionfw", toEntidad, "Fechamodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horamodificacionfw", toEntidad, "Horamodificacionfw" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciadesde", toEntidad, "Fechavigenciadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciahasta", toEntidad, "Fechavigenciahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentaje", toEntidad, "Porcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montofijo", toEntidad, "Montofijo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_desde", toEntidad, "F_articulo_material_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_hasta", toEntidad, "F_articulo_material_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_grupo_desde", toEntidad, "F_articulo_grupo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_grupo_hasta", toEntidad, "F_articulo_grupo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_listadeprecio_codigo_desde", toEntidad, "F_listadeprecio_codigo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_listadeprecio_codigo_hasta", toEntidad, "F_listadeprecio_codigo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidaddemedida_desde", toEntidad, "F_articulo_unidaddemedida_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidaddemedida_hasta", toEntidad, "F_articulo_unidaddemedida_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_familia_desde", toEntidad, "F_articulo_familia_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_familia_hasta", toEntidad, "F_articulo_familia_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_linea_desde", toEntidad, "F_articulo_linea_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_linea_hasta", toEntidad, "F_articulo_linea_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_categoriadearticulo_desde", toEntidad, "F_articulo_categoriadearticulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_categoriadearticulo_hasta", toEntidad, "F_articulo_categoriadearticulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_desde", toEntidad, "F_articulo_clasificacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_hasta", toEntidad, "F_articulo_clasificacion_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_tipodearticulo_desde", toEntidad, "F_articulo_tipodearticulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_tipodearticulo_hasta", toEntidad, "F_articulo_tipodearticulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_codigo_desde", toEntidad, "F_sucursal_codigo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_codigo_hasta", toEntidad, "F_sucursal_codigo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_tipo_desde", toEntidad, "F_sucursal_tipo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_tipo_hasta", toEntidad, "F_sucursal_tipo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_linea_desde", toEntidad, "F_sucursal_linea_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_linea_hasta", toEntidad, "F_sucursal_linea_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_segmentacion_desde", toEntidad, "F_sucursal_segmentacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_segmentacion_hasta", toEntidad, "F_sucursal_segmentacion_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_desde", toEntidad, "F_cliente_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_hasta", toEntidad, "F_cliente_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_clasificacion_desde", toEntidad, "F_cliente_clasificacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_clasificacion_hasta", toEntidad, "F_cliente_clasificacion_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_nfantasia_desde", toEntidad, "F_cliente_nfantasia_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_nfantasia_hasta", toEntidad, "F_cliente_nfantasia_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_tipo_desde", toEntidad, "F_cliente_tipo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_tipo_hasta", toEntidad, "F_cliente_tipo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_categoria_desde", toEntidad, "F_cliente_categoria_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_categoria_hasta", toEntidad, "F_cliente_categoria_hasta_PK" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAgrupublidetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Agrupublidetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Agrupublidetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Agrupublidetalle.LimpiarItem()
			else
				try
					toEntidad.Agrupublidetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Agrupublidetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.Agrupublidetalle.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoDateTime( toModeloResponse, "FechaModificacionFW", toEntidad.FechaModificacionFW)
			this.SetearAtributoString( toModeloResponse, "HoraModificacionFW", toEntidad.HoraModificacionFW)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaDesde", toEntidad.FechaVigenciaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaHasta", toEntidad.FechaVigenciaHasta)
			this.SetearAtributoDecimal( toModeloResponse, "Porcentaje", toEntidad.Porcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "MontoFijo", toEntidad.MontoFijo)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
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
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Desde", toEntidad.f_Articulo_Material_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Hasta", toEntidad.f_Articulo_Material_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Grupo_Desde", toEntidad.f_Articulo_Grupo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Grupo_Hasta", toEntidad.f_Articulo_Grupo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_ListaDePrecio_Codigo_Desde", toEntidad.f_ListaDePrecio_Codigo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_ListaDePrecio_Codigo_Hasta", toEntidad.f_ListaDePrecio_Codigo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UnidadDeMedida_Desde", toEntidad.f_Articulo_UnidadDeMedida_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UnidadDeMedida_Hasta", toEntidad.f_Articulo_UnidadDeMedida_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Familia_Desde", toEntidad.f_Articulo_Familia_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Familia_Hasta", toEntidad.f_Articulo_Familia_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Linea_Desde", toEntidad.f_Articulo_Linea_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Linea_Hasta", toEntidad.f_Articulo_Linea_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_CategoriaDeArticulo_Desde", toEntidad.f_Articulo_CategoriaDeArticulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_CategoriaDeArticulo_Hasta", toEntidad.f_Articulo_CategoriaDeArticulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Desde", toEntidad.f_Articulo_Clasificacion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Clasificacion_Hasta", toEntidad.f_Articulo_Clasificacion_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_TipodeArticulo_Desde", toEntidad.f_Articulo_TipodeArticulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_TipodeArticulo_Hasta", toEntidad.f_Articulo_TipodeArticulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Codigo_desde", toEntidad.f_Sucursal_Codigo_desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Codigo_hasta", toEntidad.f_Sucursal_Codigo_hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Tipo_Desde", toEntidad.f_Sucursal_Tipo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Tipo_Hasta", toEntidad.f_Sucursal_Tipo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Linea_Desde", toEntidad.f_Sucursal_Linea_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Linea_Hasta", toEntidad.f_Sucursal_Linea_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Segmentacion_Desde", toEntidad.f_Sucursal_Segmentacion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Segmentacion_Hasta", toEntidad.f_Sucursal_Segmentacion_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Desde", toEntidad.f_Cliente_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Hasta", toEntidad.f_Cliente_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Clasificacion_Desde", toEntidad.f_Cliente_Clasificacion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Clasificacion_Hasta", toEntidad.f_Cliente_Clasificacion_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_NFantasia_Desde", toEntidad.f_Cliente_NFantasia_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_NFantasia_Hasta", toEntidad.f_Cliente_NFantasia_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Tipo_Desde", toEntidad.f_Cliente_Tipo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Tipo_Hasta", toEntidad.f_Cliente_Tipo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Categoria_Desde", toEntidad.f_Cliente_Categoria_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Categoria_Hasta", toEntidad.f_Cliente_Categoria_Hasta_PK)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAgrupublidetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Agrupublidetalle" ) 
		with toEntidad
			for lnI = 1 to .Agrupublidetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAgrupapublic" )
				this.SetearAtributoString( loItem, "Codigo", .Agrupublidetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Agrupamiento", .Agrupublidetalle.Item(lnI).Agrupamiento_PK)
				this.SetearAtributoString( loItem, "AgrupamientoDetalle", .Agrupublidetalle.Item(lnI).AgrupamientoDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .Agrupublidetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoagrupamientopublicaciones", "TIPAGRUPUB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechamodificacionfw", "FMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horamodificacionfw", "HMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciadesde", "FECHAFD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciahasta", "FECHAH")
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_temporada_desde", "TEMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_temporada_hasta", "TEMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_ano_desde", "ANODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_ano_hasta", "ANOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_desde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_hasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_grupo_desde", "GRUDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_grupo_hasta", "GRUHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_listadeprecio_codigo_desde", "LISDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_listadeprecio_codigo_hasta", "LISHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidaddemedida_desde", "UNIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidaddemedida_hasta", "UNIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_familia_desde", "FAMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_familia_hasta", "FAMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_linea_desde", "LINDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_linea_hasta", "LINHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_categoriadearticulo_desde", "CATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_categoriadearticulo_hasta", "CATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_desde", "CLADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_hasta", "CLAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_tipodearticulo_desde", "TIPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_tipodearticulo_hasta", "TIPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_codigo_desde", "SUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_codigo_hasta", "SUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_tipo_desde", "TIPSDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_tipo_hasta", "TIPSHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_linea_desde", "LINSDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_linea_hasta", "LINSHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_segmentacion_desde", "SEGSDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_segmentacion_hasta", "SEGSHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_desde", "FPERSOND")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_hasta", "FPERSONH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_clasificacion_desde", "CLCLASD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_clasificacion_hasta", "CLCLASH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_nfantasia_desde", "CLCODFANTD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_nfantasia_hasta", "CLCODFANTH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_tipo_desde", "CLTIPOCLID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_tipo_hasta", "CLTIPOCLIH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_categoria_desde", "CLCATECLID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_categoria_hasta", "CLCATECLIH")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Temdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Temhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Matdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Grudesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Gruhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lisdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lishasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lindesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Linhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Catdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cladesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tiphasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Suchasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipsdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipshasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Linsdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Linshasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Segsdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Segshasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fpersond LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fpersonh LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clclasd LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clclash LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcodfantd LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcodfanth LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltipoclid LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltipoclih LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcateclid LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcateclih LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine