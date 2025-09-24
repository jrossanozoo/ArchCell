
define class Din_EntidadStockcombinacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Stockcombinacion"
	cClaseResponse = this.cNamespaceDTOs + ".StockcombinacionResponse"
	cClaseModelo = "StockcombinacionModelo"
	cEntidad = "Stockcombinacion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "StockcombinacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "StockcombinacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "StockcombinacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "StockcombinacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "StockcombinacionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulo", toEntidad, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Color", toEntidad, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Talle", toEntidad, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidad", toEntidad, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedcomp", toEntidad, "Pedcomp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedcomporiginal", toEntidad, "Pedcomporiginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedido", toEntidad, "Pedido" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidooriginal", toEntidad, "Pedidooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preparado", toEntidad, "Preparado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preparadooriginal", toEntidad, "Preparadooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Presupuestado", toEntidad, "Presupuestado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Presupuestadooriginal", toEntidad, "Presupuestadooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seniado", toEntidad, "Seniado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seniadooriginal", toEntidad, "Seniadooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Minreposicion", toEntidad, "Minreposicion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Maxreposicion", toEntidad, "Maxreposicion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entransito", toEntidad, "Entransito" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Articulo", toEntidad.Articulo_PK)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Color", toEntidad.Color_PK)
			this.SetearAtributoString( toModeloResponse, "Talle", toEntidad.Talle_PK)
			this.SetearAtributoDecimal( toModeloResponse, "Cantidad", toEntidad.Cantidad)
			this.SetearAtributoDecimal( toModeloResponse, "PEDCOMP", toEntidad.PEDCOMP)
			this.SetearAtributoDecimal( toModeloResponse, "PEDCOMPOriginal", toEntidad.PEDCOMPOriginal)
			this.SetearAtributoDecimal( toModeloResponse, "PEDIDO", toEntidad.PEDIDO)
			this.SetearAtributoDecimal( toModeloResponse, "PEDIDOOriginal", toEntidad.PEDIDOOriginal)
			this.SetearAtributoDecimal( toModeloResponse, "PREPARADO", toEntidad.PREPARADO)
			this.SetearAtributoDecimal( toModeloResponse, "PREPARADOOriginal", toEntidad.PREPARADOOriginal)
			this.SetearAtributoDecimal( toModeloResponse, "PRESUPUESTADO", toEntidad.PRESUPUESTADO)
			this.SetearAtributoDecimal( toModeloResponse, "PRESUPUESTADOOriginal", toEntidad.PRESUPUESTADOOriginal)
			this.SetearAtributoDecimal( toModeloResponse, "SENIADO", toEntidad.SENIADO)
			this.SetearAtributoDecimal( toModeloResponse, "SENIADOOriginal", toEntidad.SENIADOOriginal)
			this.SetearAtributoDecimal( toModeloResponse, "MinReposicion", toEntidad.MinReposicion)
			this.SetearAtributoDecimal( toModeloResponse, "MaxReposicion", toEntidad.MaxReposicion)
			this.SetearAtributoDecimal( toModeloResponse, "EnTransito", toEntidad.EnTransito)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulo", "COART")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Color", "COCOL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Talle", "TALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidad", "COCANT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedcomp", "PEDCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedcomporiginal", "CORIGPEDCO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedido", "PEDIDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidooriginal", "CORIGPEDID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Preparado", "PREPARADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Preparadooriginal", "CORIGPREPA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Presupuestado", "PRESUPUEST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Presupuestadooriginal", "CORIGPRESU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seniado", "SENIADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seniadooriginal", "CORIGSENIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Minreposicion", "MINREPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Maxreposicion", "MAXREPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entransito", "ENTRANSITO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Coart LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cocol LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Talle LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine