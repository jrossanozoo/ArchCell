
define class Din_EntidadStockcombinacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Stockcombinacion"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidad", toEntidad, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedcompra", toEntidad, "Pedcompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedcompraoriginal", toEntidad, "Pedcompraoriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedido", toEntidad, "Pedido" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidooriginal", toEntidad, "Pedidooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Precompra", toEntidad, "Precompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Precompraoriginal", toEntidad, "Precompraoriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preparado", toEntidad, "Preparado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preparadooriginal", toEntidad, "Preparadooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Presupuestado", toEntidad, "Presupuestado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Presupuestadooriginal", toEntidad, "Presupuestadooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Reqcompra", toEntidad, "Reqcompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Reqcompraoriginal", toEntidad, "Reqcompraoriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seniado", toEntidad, "Seniado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seniadooriginal", toEntidad, "Seniadooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Solcompra", toEntidad, "Solcompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Solcompraoriginal", toEntidad, "Solcompraoriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferenciaentrestockyreposicion", toEntidad, "Diferenciaentrestockyreposicion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferenciaentrestockycantidadcomb", toEntidad, "Diferenciaentrestockycantidadcomb" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadoriginal", toEntidad, "Cantidadoriginal" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "Cantidad", toEntidad.Cantidad)
			this.SetearAtributoInteger( toModeloResponse, "PEDCOMPRA", toEntidad.PEDCOMPRA)
			this.SetearAtributoInteger( toModeloResponse, "PEDCOMPRAOriginal", toEntidad.PEDCOMPRAOriginal)
			this.SetearAtributoInteger( toModeloResponse, "PEDIDO", toEntidad.PEDIDO)
			this.SetearAtributoInteger( toModeloResponse, "PEDIDOOriginal", toEntidad.PEDIDOOriginal)
			this.SetearAtributoInteger( toModeloResponse, "PRECOMPRA", toEntidad.PRECOMPRA)
			this.SetearAtributoInteger( toModeloResponse, "PRECOMPRAOriginal", toEntidad.PRECOMPRAOriginal)
			this.SetearAtributoInteger( toModeloResponse, "PREPARADO", toEntidad.PREPARADO)
			this.SetearAtributoInteger( toModeloResponse, "PREPARADOOriginal", toEntidad.PREPARADOOriginal)
			this.SetearAtributoInteger( toModeloResponse, "PRESUPUESTADO", toEntidad.PRESUPUESTADO)
			this.SetearAtributoInteger( toModeloResponse, "PRESUPUESTADOOriginal", toEntidad.PRESUPUESTADOOriginal)
			this.SetearAtributoInteger( toModeloResponse, "REQCOMPRA", toEntidad.REQCOMPRA)
			this.SetearAtributoInteger( toModeloResponse, "REQCOMPRAOriginal", toEntidad.REQCOMPRAOriginal)
			this.SetearAtributoInteger( toModeloResponse, "SENIADO", toEntidad.SENIADO)
			this.SetearAtributoInteger( toModeloResponse, "SENIADOOriginal", toEntidad.SENIADOOriginal)
			this.SetearAtributoInteger( toModeloResponse, "SOLCOMPRA", toEntidad.SOLCOMPRA)
			this.SetearAtributoInteger( toModeloResponse, "SOLCOMPRAOriginal", toEntidad.SOLCOMPRAOriginal)
			this.SetearAtributoInteger( toModeloResponse, "DiferenciaEntreStockYReposicion", toEntidad.DiferenciaEntreStockYReposicion)
			this.SetearAtributoInteger( toModeloResponse, "DiferenciaEntreStockYCantidadComb", toEntidad.DiferenciaEntreStockYCantidadComb)
			this.SetearAtributoInteger( toModeloResponse, "CantidadOriginal", toEntidad.CantidadOriginal)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidad", "COCANT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedcompra", "PEDCOMPRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedcompraoriginal", "CORIGPEDCO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedido", "PEDIDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidooriginal", "CORIGPEDID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Precompra", "PRECOMPRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Precompraoriginal", "CORIGPRECO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Preparado", "PREPARADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Preparadooriginal", "CORIGPREPA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Presupuestado", "PRESUPUEST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Presupuestadooriginal", "CORIGPRESU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Reqcompra", "REQCOMPRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Reqcompraoriginal", "CORIGREQCO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seniado", "SENIADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seniadooriginal", "CORIGSENIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Solcompra", "SOLCOMPRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Solcompraoriginal", "CORIGSOLCO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadoriginal", "CORIG")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
		endif
	
		return lcRetorno 
	endfunc
	

enddefine