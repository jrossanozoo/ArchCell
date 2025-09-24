
define class Din_EntidadImpdirart_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Impdirart"
	cClaseResponse = this.cNamespaceDTOs + ".ImpdirartResponse"
	cClaseModelo = "ImpdirartModelo"
	cEntidad = "Impdirart"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Numero" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Numero = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Numero = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirartModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirartModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirartListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirartListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirartModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Plandecuentas", toEntidad, "Plandecuentas_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Importancia", toEntidad, "Importancia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_desde", toEntidad, "F_articulo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_articulo_hasta", toEntidad, "F_articulo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comportamiento", toEntidad, "Comportamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_proveedor_desde", toEntidad, "F_proveedor_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_proveedor_hasta", toEntidad, "F_proveedor_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_temporada_desde", toEntidad, "F_temporada_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_temporada_hasta", toEntidad, "F_temporada_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_anio_desde", toEntidad, "F_anio_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_anio_hasta", toEntidad, "F_anio_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_familia_desde", toEntidad, "F_familia_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_familia_hasta", toEntidad, "F_familia_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_material_desde", toEntidad, "F_material_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_material_hasta", toEntidad, "F_material_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_linea_desde", toEntidad, "F_linea_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_linea_hasta", toEntidad, "F_linea_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_grupo_desde", toEntidad, "F_grupo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_grupo_hasta", toEntidad, "F_grupo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_categoria_desde", toEntidad, "F_categoria_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_categoria_hasta", toEntidad, "F_categoria_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_clasificacion_desde", toEntidad, "F_clasificacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_clasificacion_hasta", toEntidad, "F_clasificacion_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tipo_desde", toEntidad, "F_tipo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tipo_hasta", toEntidad, "F_tipo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionivaventas", toEntidad, "Condicionivaventas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_ivav_desde", toEntidad, "F_ivav_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_ivav_hasta", toEntidad, "F_ivav_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionivacompras", toEntidad, "Condicionivacompras" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_ivac_desde", toEntidad, "F_ivac_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_ivac_hasta", toEntidad, "F_ivac_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_impi_desde", toEntidad, "F_impi_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_impi_hasta", toEntidad, "F_impi_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_desde", toEntidad, "F_sucursal_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_hasta", toEntidad, "F_sucursal_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tiposucursal_desde", toEntidad, "F_tiposucursal_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tiposucursal_hasta", toEntidad, "F_tiposucursal_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodeasiento", toEntidad, "Tipodeasiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "PlanDeCuentas", toEntidad.PlanDeCuentas_PK)
			this.SetearAtributoInteger( toModeloResponse, "Importancia", toEntidad.Importancia)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Desde", toEntidad.f_Articulo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Articulo_Hasta", toEntidad.f_Articulo_Hasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "Comportamiento", toEntidad.Comportamiento)
			this.SetearAtributoString( toModeloResponse, "f_Proveedor_Desde", toEntidad.f_Proveedor_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Proveedor_Hasta", toEntidad.f_Proveedor_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Temporada_Desde", toEntidad.f_Temporada_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Temporada_Hasta", toEntidad.f_Temporada_Hasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "f_Anio_Desde", toEntidad.f_Anio_Desde)
			this.SetearAtributoInteger( toModeloResponse, "f_Anio_Hasta", toEntidad.f_Anio_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Familia_Desde", toEntidad.f_Familia_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Familia_Hasta", toEntidad.f_Familia_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Material_Desde", toEntidad.f_Material_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Material_Hasta", toEntidad.f_Material_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Linea_Desde", toEntidad.f_Linea_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Linea_Hasta", toEntidad.f_Linea_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Grupo_Desde", toEntidad.f_Grupo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Grupo_Hasta", toEntidad.f_Grupo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Categoria_Desde", toEntidad.f_Categoria_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Categoria_Hasta", toEntidad.f_Categoria_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Clasificacion_Desde", toEntidad.f_Clasificacion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Clasificacion_Hasta", toEntidad.f_Clasificacion_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Tipo_Desde", toEntidad.f_Tipo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Tipo_Hasta", toEntidad.f_Tipo_Hasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "CondicionIvaVentas", toEntidad.CondicionIvaVentas)
			this.SetearAtributoDecimal( toModeloResponse, "f_Ivav_Desde", toEntidad.f_Ivav_Desde)
			this.SetearAtributoDecimal( toModeloResponse, "f_Ivav_Hasta", toEntidad.f_Ivav_Hasta)
			this.SetearAtributoInteger( toModeloResponse, "CondicionIvaCompras", toEntidad.CondicionIvaCompras)
			this.SetearAtributoDecimal( toModeloResponse, "f_Ivac_Desde", toEntidad.f_Ivac_Desde)
			this.SetearAtributoDecimal( toModeloResponse, "f_Ivac_Hasta", toEntidad.f_Ivac_Hasta)
			this.SetearAtributoDecimal( toModeloResponse, "f_Impi_Desde", toEntidad.f_Impi_Desde)
			this.SetearAtributoDecimal( toModeloResponse, "f_Impi_Hasta", toEntidad.f_Impi_Hasta)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Desde", toEntidad.f_Sucursal_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Hasta", toEntidad.f_Sucursal_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_TipoSucursal_Desde", toEntidad.f_TipoSucursal_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_TipoSucursal_Hasta", toEntidad.f_TipoSucursal_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributoInteger( toModeloResponse, "TipoDeAsiento", toEntidad.TipoDeAsiento)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIPCIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Plandecuentas", "PCUENTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Importancia", "IMPORTANCI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_desde", "ARTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_articulo_hasta", "ARTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comportamiento", "COMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_proveedor_desde", "PRODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_proveedor_hasta", "PROHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_temporada_desde", "TEMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_temporada_hasta", "TEMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_anio_desde", "ANIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_anio_hasta", "ANIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_familia_desde", "FAMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_familia_hasta", "FAMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_material_desde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_material_hasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_linea_desde", "LINDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_linea_hasta", "LINHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_grupo_desde", "GRUDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_grupo_hasta", "GRUHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_categoria_desde", "CATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_categoria_hasta", "CATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_clasificacion_desde", "CLADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_clasificacion_hasta", "CLAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tipo_desde", "TIPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tipo_hasta", "TIPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionivaventas", "ARTCONIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_ivav_desde", "IVVDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_ivav_hasta", "IVVHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionivacompras", "ARTIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_ivac_desde", "IVCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_ivac_hasta", "IVCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_impi_desde", "IMPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_impi_hasta", "IMPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_desde", "SUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_hasta", "SUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tiposucursal_desde", "TSUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tiposucursal_hasta", "TSUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodeasiento", "TIPOASI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descripcio LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Pcuenta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arthasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prohasta LIKE '%" + lcExpresionBusqueda + "%'"
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Suchasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tsucdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tsuchasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Base LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine