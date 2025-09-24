
define class Din_EntidadComportamientocodigosugeridoentidad_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Comportamientocodigosugeridoentidad"
	cClaseResponse = this.cNamespaceDTOs + ".ComportamientocodigosugeridoentidadResponse"
	cClaseModelo = "ComportamientocodigosugeridoentidadModelo"
	cEntidad = "Comportamientocodigosugeridoentidad"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Entidad" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Entidad = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Entidad = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "ComportamientocodigosugeridoentidadModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComportamientocodigosugeridoentidadModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComportamientocodigosugeridoentidadListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComportamientocodigosugeridoentidadListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ComportamientocodigosugeridoentidadModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidad", toEntidad, "Entidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Anchodisponible", toEntidad, "Anchodisponible" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sugerir", toEntidad, "Sugerir" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idglobal", toEntidad, "Idglobal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Anchoasugerir", toEntidad, "Anchoasugerir" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usarprefijobasededatos", toEntidad, "Usarprefijobasededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Prefijoentidad", toEntidad, "Prefijoentidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Busquedaextendida", toEntidad, "Busquedaextendida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vistaprevia", toEntidad, "Vistaprevia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Salta", toEntidad, "Salta" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Entidad", toEntidad.Entidad)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoInteger( toModeloResponse, "AnchoDisponible", toEntidad.AnchoDisponible)
			this.SetearAtributo( toModeloResponse, "Sugerir", toEntidad.Sugerir)
			this.SetearAtributo( toModeloResponse, "IdGlobal", toEntidad.IdGlobal)
			this.SetearAtributoInteger( toModeloResponse, "AnchoASugerir", toEntidad.AnchoASugerir)
			this.SetearAtributo( toModeloResponse, "UsarPrefijoBaseDeDatos", toEntidad.UsarPrefijoBaseDeDatos)
			this.SetearAtributoString( toModeloResponse, "PrefijoEntidad", toEntidad.PrefijoEntidad)
			this.SetearAtributo( toModeloResponse, "BusquedaExtendida", toEntidad.BusquedaExtendida)
			this.SetearAtributoString( toModeloResponse, "VistaPrevia", toEntidad.VistaPrevia)
			this.SetearAtributo( toModeloResponse, "Salta", toEntidad.Salta)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Anchodisponible", "ANCHODISPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sugerir", "SUGERIR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idglobal", "IDGLOBAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Anchoasugerir", "ANCHOSUGER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usarprefijobasededatos", "PREFIJOBD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Prefijoentidad", "PREFIJO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Busquedaextendida", "BUSQEXTEND")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vistaprevia", "VISTAPREV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Salta", "SALTA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entidad LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prefijo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vistaprev LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine