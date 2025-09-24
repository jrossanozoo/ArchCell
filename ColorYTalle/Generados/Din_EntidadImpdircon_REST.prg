
define class Din_EntidadImpdircon_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Impdircon"
	cClaseResponse = this.cNamespaceDTOs + ".ImpdirconResponse"
	cClaseModelo = "ImpdirconModelo"
	cEntidad = "Impdircon"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirconModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirconModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirconListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirconListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ImpdirconModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_concepto_desde", toEntidad, "F_concepto_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_concepto_hasta", toEntidad, "F_concepto_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_clasificacion_desde", toEntidad, "F_clasificacion_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_clasificacion_hasta", toEntidad, "F_clasificacion_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_desde", toEntidad, "F_sucursal_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_sucursal_hasta", toEntidad, "F_sucursal_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tiposucursal_desde", toEntidad, "F_tiposucursal_desde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "F_tiposucursal_hasta", toEntidad, "F_tiposucursal_hasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
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
			this.SetearAtributoString( toModeloResponse, "f_Concepto_Desde", toEntidad.f_Concepto_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Concepto_Hasta", toEntidad.f_Concepto_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Clasificacion_Desde", toEntidad.f_Clasificacion_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Clasificacion_Hasta", toEntidad.f_Clasificacion_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Desde", toEntidad.f_Sucursal_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_Sucursal_Hasta", toEntidad.f_Sucursal_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "f_TipoSucursal_Desde", toEntidad.f_TipoSucursal_Desde_PK)
			this.SetearAtributoString( toModeloResponse, "f_TipoSucursal_Hasta", toEntidad.f_TipoSucursal_Hasta_PK)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_concepto_desde", "CONDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_concepto_hasta", "CONHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_clasificacion_desde", "CLADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_clasificacion_hasta", "CLAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_desde", "SUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_sucursal_hasta", "SUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tiposucursal_desde", "TSUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "F_tiposucursal_hasta", "TSUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BASE")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Condesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Conhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cladesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clahasta LIKE '%" + lcExpresionBusqueda + "%'"
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