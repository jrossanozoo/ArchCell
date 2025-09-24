
define class Din_EntidadImpdircli_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Impdircli"
	cClaseResponse = this.cNamespaceDTOs + ".ImpdircliResponse"
	cClaseModelo = "ImpdircliModelo"
	cEntidad = "Impdircli"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdircliModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdircliModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdircliListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdircliListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdircliModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_desde", toEntidad, "F_cliente_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_cliente_hasta", toEntidad, "F_cliente_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_idglobal_desde", toEntidad, "F_idglobal_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_idglobal_hasta", toEntidad, "F_idglobal_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Situacionfiscal", toEntidad, "Situacionfiscal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_vendedor_desde", toEntidad, "F_vendedor_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_vendedor_hasta", toEntidad, "F_vendedor_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_lista_desde", toEntidad, "F_lista_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_lista_hasta", toEntidad, "F_lista_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_clasificacion_desde", toEntidad, "F_clasificacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_clasificacion_hasta", toEntidad, "F_clasificacion_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tipo_desde", toEntidad, "F_tipo_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tipo_hasta", toEntidad, "F_tipo_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_categoria_desde", toEntidad, "F_categoria_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_categoria_hasta", toEntidad, "F_categoria_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_provincia_desde", toEntidad, "F_provincia_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_provincia_hasta", toEntidad, "F_provincia_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_pais_desde", toEntidad, "F_pais_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_pais_hasta", toEntidad, "F_pais_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_desde", toEntidad, "F_sucursal_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_hasta", toEntidad, "F_sucursal_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tiposucursal_desde", toEntidad, "F_tiposucursal_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tiposucursal_hasta", toEntidad, "F_tiposucursal_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imputacion", toEntidad, "Imputacion_PK" )
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
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Desde", toEntidad.f_Cliente_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Cliente_Hasta", toEntidad.f_Cliente_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_idglobal_Desde", toEntidad.f_idglobal_Desde)
			this.SetearAtributoString( toModeloResponse, "f_idglobal_Hasta", toEntidad.f_idglobal_Hasta)
			this.SetearAtributoInteger( toModeloResponse, "SituacionFiscal", toEntidad.SituacionFiscal)
			this.SetearAtributoString( toModeloResponse, "f_Vendedor_Desde", toEntidad.f_Vendedor_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Vendedor_Hasta", toEntidad.f_Vendedor_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Lista_Desde", toEntidad.f_Lista_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Lista_Hasta", toEntidad.f_Lista_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Clasificacion_Desde", toEntidad.f_Clasificacion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Clasificacion_Hasta", toEntidad.f_Clasificacion_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Tipo_Desde", toEntidad.f_Tipo_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Tipo_Hasta", toEntidad.f_Tipo_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Categoria_Desde", toEntidad.f_Categoria_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Categoria_Hasta", toEntidad.f_Categoria_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Provincia_Desde", toEntidad.f_Provincia_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Provincia_Hasta", toEntidad.f_Provincia_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Pais_Desde", toEntidad.f_Pais_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Pais_Hasta", toEntidad.f_Pais_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Desde", toEntidad.f_Sucursal_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Hasta", toEntidad.f_Sucursal_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_TipoSucursal_Desde", toEntidad.f_TipoSucursal_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_TipoSucursal_Hasta", toEntidad.f_TipoSucursal_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributoInteger( toModeloResponse, "Imputacion", toEntidad.Imputacion_PK)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_desde", "CLIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_cliente_hasta", "CLIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_idglobal_desde", "GLODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_idglobal_hasta", "GLOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Situacionfiscal", "SITFIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_vendedor_desde", "VENDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_vendedor_hasta", "VENHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_lista_desde", "LISDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_lista_hasta", "LISHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_clasificacion_desde", "CLADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_clasificacion_hasta", "CLAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tipo_desde", "TIPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tipo_hasta", "TIPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_categoria_desde", "CATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_categoria_hasta", "CATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_provincia_desde", "PRODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_provincia_hasta", "PROHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_pais_desde", "PAIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_pais_hasta", "PAIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_desde", "SUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_hasta", "SUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tiposucursal_desde", "TSUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tiposucursal_hasta", "TSUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imputacion", "IMPVAL")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Glodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Glohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vendesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Venhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lisdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lishasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cladesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tiphasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Catdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Paidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Paihasta LIKE '%" + lcExpresionBusqueda + "%'"
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