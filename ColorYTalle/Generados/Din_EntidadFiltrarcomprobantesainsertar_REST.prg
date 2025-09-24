
define class Din_EntidadFiltrarcomprobantesainsertar_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Filtrarcomprobantesainsertar"
	cClaseResponse = this.cNamespaceDTOs + ".FiltrarcomprobantesainsertarResponse"
	cClaseModelo = "FiltrarcomprobantesainsertarModelo"
	cEntidad = "Filtrarcomprobantesainsertar"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesainsertarModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesainsertarModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesainsertarListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesainsertarListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesainsertarModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedesde", toEntidad, "Clientedesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientehasta", toEntidad, "Clientehasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocomprobantedesde", toEntidad, "Numerocomprobantedesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocomprobantehasta", toEntidad, "Numerocomprobantehasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacomprobantedesde", toEntidad, "Fechacomprobantedesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacomprobantehasta", toEntidad, "Fechacomprobantehasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedordesde", toEntidad, "Vendedordesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedorhasta", toEntidad, "Vendedorhasta_PK" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "ClienteDesde", toEntidad.ClienteDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteHasta", toEntidad.ClienteHasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "NumeroComprobanteDesde", toEntidad.NumeroComprobanteDesde)
			this.SetearAtributoInteger( toModeloResponse, "NumeroComprobanteHasta", toEntidad.NumeroComprobanteHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaComprobanteDesde", toEntidad.FechaComprobanteDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaComprobanteHasta", toEntidad.FechaComprobanteHasta)
			this.SetearAtributoString( toModeloResponse, "VendedorDesde", toEntidad.VendedorDesde_PK)
			this.SetearAtributoString( toModeloResponse, "VendedorHasta", toEntidad.VendedorHasta_PK)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedesde", "CLIEDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientehasta", "CLIEHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocomprobantedesde", "NUMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocomprobantehasta", "NUMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacomprobantedesde", "FECOMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacomprobantehasta", "FECOMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedordesde", "VENDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedorhasta", "VENHASTA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliedesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliehasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vendesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Venhasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine