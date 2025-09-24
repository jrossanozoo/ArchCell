
define class Din_EntidadTipodecomprobantedecompra_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Tipodecomprobantedecompra"
	cClaseResponse = this.cNamespaceDTOs + ".TipodecomprobantedecompraResponse"
	cClaseModelo = "TipodecomprobantedecompraModelo"
	cEntidad = "Tipodecomprobantedecompra"
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
				lcRetorno = this.cNamespaceDTOs + "." + "TipodecomprobantedecompraModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "TipodecomprobantedecompraModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "TipodecomprobantedecompraListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "TipodecomprobantedecompraListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "TipodecomprobantedecompraModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letracomporigen", toEntidad, "Letracomporigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ptovtaextcomporigen", toEntidad, "Ptovtaextcomporigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrocomporigen", toEntidad, "Nrocomporigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocomporigen", toEntidad, "Tipocomporigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ptovtacomporigen", toEntidad, "Ptovtacomporigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigooperacion", toEntidad, "Codigooperacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Despacho", toEntidad, "Despacho_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Anodespacho", toEntidad, "Anodespacho" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigodeaduana", toEntidad, "Codigodeaduana" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodedestino", toEntidad, "Tipodedestino" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrodespacho", toEntidad, "Nrodespacho" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Digitoverificador", toEntidad, "Digitoverificador" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedeivaliqa", toEntidad, "Porcentajedeivaliqa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodeivaliqa", toEntidad, "Montodeivaliqa" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "LetraCompOrigen", toEntidad.LetraCompOrigen)
			this.SetearAtributoInteger( toModeloResponse, "PtoVtaExtCompOrigen", toEntidad.PtoVtaExtCompOrigen)
			this.SetearAtributoInteger( toModeloResponse, "NroCompOrigen", toEntidad.NroCompOrigen)
			this.SetearAtributoInteger( toModeloResponse, "TipoCompOrigen", toEntidad.TipoCompOrigen)
			this.SetearAtributoInteger( toModeloResponse, "PtoVtaCompOrigen", toEntidad.PtoVtaCompOrigen)
			this.SetearAtributoString( toModeloResponse, "CodigoOperacion", toEntidad.CodigoOperacion)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Despacho", toEntidad.Despacho_PK)
			this.SetearAtributoString( toModeloResponse, "AnoDespacho", toEntidad.AnoDespacho)
			this.SetearAtributoString( toModeloResponse, "CodigoDeAduana", toEntidad.CodigoDeAduana)
			this.SetearAtributoString( toModeloResponse, "TipoDeDestino", toEntidad.TipoDeDestino)
			this.SetearAtributoString( toModeloResponse, "NroDespacho", toEntidad.NroDespacho)
			this.SetearAtributoString( toModeloResponse, "DigitoVerificador", toEntidad.DigitoVerificador)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDeIVALiqA", toEntidad.PorcentajeDeIVALiqA)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDeIvaLiqA", toEntidad.MontoDeIvaLiqA)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipocomporigen", "TIPOCOMPOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigooperacion", "CODOPE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Despacho", "DESPACHO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Anodespacho", "ANODESPA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigodeaduana", "CODADUANA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodedestino", "TIPODESTIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nrodespacho", "NRODESPA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Digitoverificador", "DIGVERIF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajedeivaliqa", "PORLIQUIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodeivaliqa", "IVALIQUIA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codope LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Despacho LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Anodespa LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codaduana LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipodestin LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nrodespa LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Digverif LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine