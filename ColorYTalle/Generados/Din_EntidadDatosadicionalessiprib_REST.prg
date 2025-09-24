
define class Din_EntidadDatosadicionalessiprib_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Datosadicionalessiprib"
	cClaseResponse = this.cNamespaceDTOs + ".DatosadicionalessipribResponse"
	cClaseModelo = "DatosadicionalessipribModelo"
	cEntidad = "Datosadicionalessiprib"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatosadicionalessipribModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatosadicionalessipribModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatosadicionalessipribListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatosadicionalessipribListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DatosadicionalessipribModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condiibb", toEntidad, "Condiibb" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articuloinciso", toEntidad, "Articuloinciso_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoexencion", toEntidad, "Tipoexencion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ano", toEntidad, "Ano" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Certificado", toEntidad, "Certificado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Otrosgravamenes", toEntidad, "Otrosgravamenes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Registroeinspeccion", toEntidad, "Registroeinspeccion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoInteger( toModeloResponse, "CondIIBB", toEntidad.CondIIBB)
			this.SetearAtributoInteger( toModeloResponse, "ArticuloInciso", toEntidad.ArticuloInciso_PK)
			this.SetearAtributoInteger( toModeloResponse, "TipoExencion", toEntidad.TipoExencion)
			this.SetearAtributoInteger( toModeloResponse, "Ano", toEntidad.Ano)
			this.SetearAtributoInteger( toModeloResponse, "Certificado", toEntidad.Certificado)
			this.SetearAtributo( toModeloResponse, "OtrosGravamenes", toEntidad.OtrosGravamenes)
			this.SetearAtributo( toModeloResponse, "RegistroeInspeccion", toEntidad.RegistroeInspeccion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condiibb", "CONDIIBB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articuloinciso", "ARTICULOIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoexencion", "TIPOEXENC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ano", "ANIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Certificado", "CERTIFIC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Otrosgravamenes", "OTROSGRAV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Registroeinspeccion", "REGISTRO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine