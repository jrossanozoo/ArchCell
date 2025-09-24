
define class Din_EntidadCaea_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Caea"
	cClaseResponse = this.cNamespaceDTOs + ".CaeaResponse"
	cClaseModelo = "CaeaModelo"
	cEntidad = "Caea"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Numerointerno" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Numerointerno = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Numerointerno = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "CaeaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CaeaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CaeaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CaeaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CaeaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerointerno", toEntidad, "Numerointerno" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ptoventa", toEntidad, "Ptoventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Periodocaea", toEntidad, "Periodocaea" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Quincena", toEntidad, "Quincena" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocaea", toEntidad, "Numerocaea" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciadesde", toEntidad, "Fechavigenciadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciahasta", toEntidad, "Fechavigenciahasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechatope", toEntidad, "Fechatope" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadeproceso", toEntidad, "Fechadeproceso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comentariosafip", toEntidad, "Comentariosafip" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoLong( toModeloResponse, "NumeroInterno", toEntidad.NumeroInterno)
			this.SetearAtributoInteger( toModeloResponse, "PtoVenta", toEntidad.PtoVenta)
			this.SetearAtributoString( toModeloResponse, "PeriodoCAEA", toEntidad.PeriodoCAEA)
			this.SetearAtributoInteger( toModeloResponse, "Quincena", toEntidad.Quincena)
			this.SetearAtributoString( toModeloResponse, "NumeroCAEA", toEntidad.NumeroCAEA)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaDesde", toEntidad.FechaVigenciaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaHasta", toEntidad.FechaVigenciaHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaTope", toEntidad.FechaTope)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDeProceso", toEntidad.FechaDeProceso)
			this.SetearAtributo( toModeloResponse, "ComentariosAFIP", toEntidad.ComentariosAFIP)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ptoventa", "PTOVTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Periodocaea", "PERIODO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Quincena", "QUINCENA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocaea", "NCAEA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciadesde", "VIGENCIAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciahasta", "VIGENCIAH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechatope", "FECHATOPE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadeproceso", "FECHAPROC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comentariosafip", "CONVERT( VARCHAR(MAX), OBSAFIP)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Periodo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ncaea LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obsafip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine