
define class Din_EntidadReporteelectronico_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Reporteelectronico"
	cClaseResponse = this.cNamespaceDTOs + ".ReporteelectronicoResponse"
	cClaseModelo = "ReporteelectronicoModelo"
	cEntidad = "Reporteelectronico"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Codint" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Codint = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Codint = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "ReporteelectronicoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ReporteelectronicoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ReporteelectronicoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ReporteelectronicoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ReporteelectronicoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descargaafip", toEntidad, "Descargaafip" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesdeafip", toEntidad, "Fechadesdeafip" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahastaafip", toEntidad, "Fechahastaafip" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutaafip", toEntidad, "Rutaafip" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descargaauditoria", toEntidad, "Descargaauditoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodescargaauditoria", toEntidad, "Tipodescargaauditoria" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesdeauditoria", toEntidad, "Fechadesdeauditoria" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahastaauditoria", toEntidad, "Fechahastaauditoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerodesdeauditoria", toEntidad, "Numerodesdeauditoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerohastaauditoria", toEntidad, "Numerohastaauditoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutaauditoria", toEntidad, "Rutaauditoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Acciones", toEntidad, "Acciones" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "CodInt", toEntidad.CodInt)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributo( toModeloResponse, "DescargaAFIP", toEntidad.DescargaAFIP)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesdeAFIP", toEntidad.FechaDesdeAFIP)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHastaAFIP", toEntidad.FechaHastaAFIP)
			this.SetearAtributoString( toModeloResponse, "RutaAFIP", toEntidad.RutaAFIP)
			this.SetearAtributo( toModeloResponse, "DescargaAuditoria", toEntidad.DescargaAuditoria)
			this.SetearAtributoInteger( toModeloResponse, "TipoDescargaAuditoria", toEntidad.TipoDescargaAuditoria)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesdeAuditoria", toEntidad.FechaDesdeAuditoria)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHastaAuditoria", toEntidad.FechaHastaAuditoria)
			this.SetearAtributoInteger( toModeloResponse, "NumeroDesdeAuditoria", toEntidad.NumeroDesdeAuditoria)
			this.SetearAtributoInteger( toModeloResponse, "NumeroHastaAuditoria", toEntidad.NumeroHastaAuditoria)
			this.SetearAtributoString( toModeloResponse, "RutaAuditoria", toEntidad.RutaAuditoria)
			this.SetearAtributo( toModeloResponse, "Acciones", toEntidad.Acciones)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "PTOVENTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descargaafip", "DESAFIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesdeafip", "FECDDEAFIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahastaafip", "FECHTAAFIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutaafip", "RUTAAFIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descargaauditoria", "DESAUDI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodescargaauditoria", "TIPODES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesdeauditoria", "FECDDEAUDI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahastaauditoria", "FECHTAAUDI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerodesdeauditoria", "NRODDEAUDI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerohastaauditoria", "NROHTAAUD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutaauditoria", "RUTAAUDI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Acciones", "CONVERT( VARCHAR(MAX), ZADSFW)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rutaafip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rutaaudi LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Zadsfw LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine