
define class Din_EntidadImpdirimp_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Impdirimp"
	cClaseResponse = this.cNamespaceDTOs + ".ImpdirimpResponse"
	cClaseModelo = "ImpdirimpModelo"
	cEntidad = "Impdirimp"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirimpModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirimpModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirimpListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirimpListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirimpModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_impuesto_desde", toEntidad, "F_impuesto_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_impuesto_hasta", toEntidad, "F_impuesto_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Aplicacion", toEntidad, "Aplicacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tipoimp_desde", toEntidad, "F_tipoimp_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tipoimp_hasta", toEntidad, "F_tipoimp_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_jurisdiccion_desde", toEntidad, "F_jurisdiccion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_jurisdiccion_hasta", toEntidad, "F_jurisdiccion_hasta_PK" )
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
			this.SetearAtributoString( toModeloResponse, "f_Impuesto_Desde", toEntidad.f_Impuesto_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Impuesto_Hasta", toEntidad.f_Impuesto_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "Aplicacion", toEntidad.Aplicacion)
			this.SetearAtributoString( toModeloResponse, "f_TipoImp_Desde", toEntidad.f_TipoImp_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_TipoImp_Hasta", toEntidad.f_TipoImp_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Jurisdiccion_Desde", toEntidad.f_Jurisdiccion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Jurisdiccion_Hasta", toEntidad.f_Jurisdiccion_Hasta_PK)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_impuesto_desde", "IMPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_impuesto_hasta", "IMPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Aplicacion", "APLICACION")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tipoimp_desde", "TIPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tipoimp_hasta", "TIPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_jurisdiccion_desde", "JURDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_jurisdiccion_hasta", "JURHASTA")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Impdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Imphasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aplicacion LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tiphasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Jurdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Jurhasta LIKE '%" + lcExpresionBusqueda + "%'"
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