
define class Din_EntidadRegistrodeactividad_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Registrodeactividad"
	cClaseResponse = this.cNamespaceDTOs + ".RegistrodeactividadResponse"
	cClaseModelo = "RegistrodeactividadModelo"
	cEntidad = "Registrodeactividad"
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
				lcRetorno = this.cNamespaceDTOs + "." + "RegistrodeactividadModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "RegistrodeactividadModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "RegistrodeactividadListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "RegistrodeactividadListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "RegistrodeactividadModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Actividad", toEntidad, "Actividad" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechainicio", toEntidad, "Fechainicio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horainicio", toEntidad, "Horainicio" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechafin", toEntidad, "Fechafin" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horafin", toEntidad, "Horafin" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiemponetosininteracciondelusuario", toEntidad, "Tiemponetosininteracciondelusuario" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Invocador", toEntidad, "Invocador" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Actividad", toEntidad.Actividad)
			this.SetearAtributoDateTime( toModeloResponse, "FechaInicio", toEntidad.FechaInicio)
			this.SetearAtributoString( toModeloResponse, "HoraInicio", toEntidad.HoraInicio)
			this.SetearAtributoDateTime( toModeloResponse, "FechaFin", toEntidad.FechaFin)
			this.SetearAtributoString( toModeloResponse, "HoraFin", toEntidad.HoraFin)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributoDecimal( toModeloResponse, "TiempoNetoSinInteracciondelUsuario", toEntidad.TiempoNetoSinInteracciondelUsuario)
			this.SetearAtributoString( toModeloResponse, "Invocador", toEntidad.Invocador)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Actividad", "CACTIVIDAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechainicio", "CFECHAINI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horainicio", "CHORAINI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechafin", "CFECHAFIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horafin", "CHORAFIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BDALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiemponetosininteracciondelusuario", "NNETO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Invocador", "INVOCADOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cactividad LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Choraini LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Chorafin LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Bdaltafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Invocador LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine