
define class Din_EntidadCalculodeprecios_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Calculodeprecios"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechabase", toEntidad, "Fechabase" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigencia", toEntidad, "Fechavigencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Importarsintransaccion", toEntidad, "Importarsintransaccion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usacombinacion", toEntidad, "Usacombinacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearDetalleModprecios( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulo_comportamiento", toEntidad, "Articulo_comportamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preciokitpackxparticipante", toEntidad, "Preciokitpackxparticipante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_desde", toEntidad, "F_articulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_hasta", toEntidad, "F_articulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_desde", toEntidad, "F_color_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_color_hasta", toEntidad, "F_color_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_desde", toEntidad, "F_talle_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_talle_hasta", toEntidad, "F_talle_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_desde", toEntidad, "F_articulo_proveedor_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_proveedor_hasta", toEntidad, "F_articulo_proveedor_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidad_desde", toEntidad, "F_articulo_unidad_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_unidad_hasta", toEntidad, "F_articulo_unidad_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_desde", toEntidad, "F_articulo_material_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_material_hasta", toEntidad, "F_articulo_material_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_estacion_desde", toEntidad, "F_articulo_estacion_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_estacion_hasta", toEntidad, "F_articulo_estacion_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_anio_desde", toEntidad, "F_articulo_anio_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_anio_hasta", toEntidad, "F_articulo_anio_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_desde", toEntidad, "F_articulo_nomenclador_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_nomenclador_hasta", toEntidad, "F_articulo_nomenclador_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_desde", toEntidad, "F_articulo_clasificacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_clasificacion_hasta", toEntidad, "F_articulo_clasificacion_hasta_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaaltafw_desde", toEntidad, "F_articulo_fechaaltafw_desde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "F_articulo_fechaaltafw_hasta", toEntidad, "F_articulo_fechaaltafw_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_preciodirecto_desde", toEntidad, "F_preciodirecto_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_preciodirecto_hasta", toEntidad, "F_preciodirecto_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_usuarioaltafw", toEntidad, "F_articulo_usuarioaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_usuariomodificacionfw", toEntidad, "F_articulo_usuariomodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_timestampalta_desde", toEntidad, "F_timestampalta_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_timestampalta_hasta", toEntidad, "F_timestampalta_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_marca_desde", toEntidad, "F_articulo_marca_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_marca_hasta", toEntidad, "F_articulo_marca_hasta_PK" )
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
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaBase", toEntidad.FechaBase)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigencia", toEntidad.FechaVigencia)
			this.SetearAtributo( toModeloResponse, "ImportarSinTransaccion", toEntidad.ImportarSinTransaccion)
			this.SetearAtributo( toModeloResponse, "UsaCombinacion", toEntidad.UsaCombinacion)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.CargarColeccionModeloModPrecios( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Articulo_Comportamiento", toEntidad.Articulo_Comportamiento)
			this.SetearAtributo( toModeloResponse, "PrecioKitPackxParticipante", toEntidad.PrecioKitPackxParticipante)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Desde", toEntidad.f_Articulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Hasta", toEntidad.f_Articulo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Color_Desde", toEntidad.f_Color_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Color_Hasta", toEntidad.f_Color_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Desde", toEntidad.f_Talle_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Talle_Hasta", toEntidad.f_Talle_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Desde", toEntidad.f_Articulo_Proveedor_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Proveedor_Hasta", toEntidad.f_Articulo_Proveedor_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Unidad_Desde", toEntidad.f_Articulo_Unidad_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Unidad_Hasta", toEntidad.f_Articulo_Unidad_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Desde", toEntidad.f_Articulo_Material_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Material_Hasta", toEntidad.f_Articulo_Material_Hasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "f_Articulo_Estacion_Desde", toEntidad.f_Articulo_Estacion_Desde)
			this.SetearAtributoInteger( toModeloResponse, "f_Articulo_Estacion_Hasta", toEntidad.f_Articulo_Estacion_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Anio_Desde", toEntidad.f_Articulo_Anio_Desde)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Anio_Hasta", toEntidad.f_Articulo_Anio_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Desde", toEntidad.f_Articulo_Nomenclador_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Nomenclador_Hasta", toEntidad.f_Articulo_Nomenclador_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_clasificacion_desde", toEntidad.f_Articulo_clasificacion_desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_clasificacion_hasta", toEntidad.f_Articulo_clasificacion_hasta_PK)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaAltaFW_Desde", toEntidad.f_Articulo_FechaAltaFW_Desde)
			this.SetearAtributoDateTime( toModeloResponse, "f_Articulo_FechaAltaFW_Hasta", toEntidad.f_Articulo_FechaAltaFW_Hasta)
			this.SetearAtributoDecimal( toModeloResponse, "f_Preciodirecto_Desde", toEntidad.f_Preciodirecto_Desde)
			this.SetearAtributoDecimal( toModeloResponse, "f_Preciodirecto_Hasta", toEntidad.f_Preciodirecto_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UsuarioAltaFw", toEntidad.f_Articulo_UsuarioAltaFw)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_UsuarioModificacionFw", toEntidad.f_Articulo_UsuarioModificacionFw)
			this.SetearAtributoLong( toModeloResponse, "f_TimestampAlta_desde", toEntidad.f_TimestampAlta_desde)
			this.SetearAtributoLong( toModeloResponse, "f_TimestampAlta_hasta", toEntidad.f_TimestampAlta_hasta)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Marca_Desde", toEntidad.f_Articulo_Marca_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Marca_Hasta", toEntidad.f_Articulo_Marca_Hasta_PK)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechabase", "FECHABASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigencia", "FECHAVIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Importarsintransaccion", "SINTRANSAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usacombinacion", "USACOMB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), MOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulo_comportamiento", "COMPORTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Preciokitpackxparticipante", "KPXPARTIC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_desde", "ARTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_hasta", "ARTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_desde", "COLDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_color_hasta", "COLHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_desde", "TALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_talle_hasta", "TALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_desde", "PRODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_proveedor_hasta", "PROHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidad_desde", "UNIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_unidad_hasta", "UNIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_desde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_material_hasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_estacion_desde", "ESTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_estacion_hasta", "ESTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_anio_desde", "ANIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_anio_hasta", "ANIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_nomenclador_desde", "NARBADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_nomenclador_hasta", "NARBAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_desde", "CLASIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_clasificacion_hasta", "CLASIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaaltafw_desde", "FECDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_fechaaltafw_hasta", "FECHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_preciodirecto_desde", "PRECDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_preciodirecto_hasta", "PRECHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_usuarioaltafw", "UALTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_usuariomodificacionfw", "UMOD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_timestampalta_desde", "FTSADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_timestampalta_hasta", "FTSAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_marca_desde", "MARCADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_marca_hasta", "MARCAHASTA")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Matdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Anidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Anihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Narbahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ualta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Umod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marcadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marcahasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine