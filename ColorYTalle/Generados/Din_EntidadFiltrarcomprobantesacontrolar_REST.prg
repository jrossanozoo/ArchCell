
define class Din_EntidadFiltrarcomprobantesacontrolar_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Filtrarcomprobantesacontrolar"
	cClaseResponse = this.cNamespaceDTOs + ".FiltrarcomprobantesacontrolarResponse"
	cClaseModelo = "FiltrarcomprobantesacontrolarModelo"
	cEntidad = "Filtrarcomprobantesacontrolar"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesacontrolarModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesacontrolarModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesacontrolarListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesacontrolarListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "FiltrarcomprobantesacontrolarModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedordesde", toEntidad, "Proveedordesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedorhasta", toEntidad, "Proveedorhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Origendestinodesde", toEntidad, "Origendestinodesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Origendestinohasta", toEntidad, "Origendestinohasta_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacomprobantedesde", toEntidad, "Fechacomprobantedesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacomprobantehasta", toEntidad, "Fechacomprobantehasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaentregadesde", toEntidad, "Fechaentregadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaentregahasta", toEntidad, "Fechaentregahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedordesde", toEntidad, "Vendedordesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedorhasta", toEntidad, "Vendedorhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Motivodesde", toEntidad, "Motivodesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Motivohasta", toEntidad, "Motivohasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Transportistadesde", toEntidad, "Transportistadesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Transportistahasta", toEntidad, "Transportistahasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entregaposterior", toEntidad, "Entregaposterior" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "ClienteDesde", toEntidad.ClienteDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteHasta", toEntidad.ClienteHasta_PK)
			this.SetearAtributoString( toModeloResponse, "ProveedorDesde", toEntidad.ProveedorDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ProveedorHasta", toEntidad.ProveedorHasta_PK)
			this.SetearAtributoString( toModeloResponse, "OrigenDestinoDesde", toEntidad.OrigenDestinoDesde_PK)
			this.SetearAtributoString( toModeloResponse, "OrigenDestinoHasta", toEntidad.OrigenDestinoHasta_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaComprobanteDesde", toEntidad.FechaComprobanteDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaComprobanteHasta", toEntidad.FechaComprobanteHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaEntregaDesde", toEntidad.FechaEntregaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaEntregaHasta", toEntidad.FechaEntregaHasta)
			this.SetearAtributoString( toModeloResponse, "VendedorDesde", toEntidad.VendedorDesde_PK)
			this.SetearAtributoString( toModeloResponse, "VendedorHasta", toEntidad.VendedorHasta_PK)
			this.SetearAtributoString( toModeloResponse, "MotivoDesde", toEntidad.MotivoDesde_PK)
			this.SetearAtributoString( toModeloResponse, "MotivoHasta", toEntidad.MotivoHasta_PK)
			this.SetearAtributoString( toModeloResponse, "TransportistaDesde", toEntidad.TransportistaDesde_PK)
			this.SetearAtributoString( toModeloResponse, "TransportistaHasta", toEntidad.TransportistaHasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "EntregaPosterior", toEntidad.EntregaPosterior)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedesde", "CLIEDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientehasta", "CLIEHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedordesde", "PROVDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedorhasta", "PROVHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Origendestinodesde", "ORIGDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Origendestinohasta", "ORIGHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacomprobantedesde", "FECOMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacomprobantehasta", "FECOMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaentregadesde", "FEENTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaentregahasta", "FEENTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedordesde", "VENDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedorhasta", "VENHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Motivodesde", "MOTIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Motivohasta", "MOTIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Transportistadesde", "TRANDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Transportistahasta", "TRANHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entregaposterior", "ENTREGAPOS")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Origdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Orighasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vendesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Venhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Motidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Motihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Trandesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tranhasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine