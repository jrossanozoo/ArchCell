
define class Din_EntidadSeleccionparainsertar_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Seleccionparainsertar"
	cClaseResponse = this.cNamespaceDTOs + ".SeleccionparainsertarResponse"
	cClaseModelo = "SeleccionparainsertarModelo"
	cEntidad = "Seleccionparainsertar"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SeleccionparainsertarModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bolsasycajas", toEntidad, "Bolsasycajas_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cancelaciondecompra", toEntidad, "Cancelaciondecompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosfiscales", toEntidad, "Datosfiscales_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entregademercaderias", toEntidad, "Entregademercaderias_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidad", toEntidad, "Entidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronicadecredito", toEntidad, "Facturaelectronicadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Feriado", toEntidad, "Feriado_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impresiondeetiqueta", toEntidad, "Impresiondeetiqueta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movimientodestock", toEntidad, "Movimientodestock_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadecreditoelectronicadecredito", toEntidad, "Notadecreditoelectronicadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Notadedebitoelectronicadecredito", toEntidad, "Notadedebitoelectronicadecredito_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordenar", toEntidad, "Ordenar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preparaciondemercaderia", toEntidad, "Preparaciondemercaderia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Remitodecompra", toEntidad, "Remitodecompra_PK" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "BOLSASYCAJAS", toEntidad.BOLSASYCAJAS_PK)
			this.SetearAtributoString( toModeloResponse, "CANCELACIONDECOMPRA", toEntidad.CANCELACIONDECOMPRA_PK)
			this.SetearAtributoString( toModeloResponse, "CLIENTE", toEntidad.CLIENTE_PK)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "DATOSFISCALES", toEntidad.DATOSFISCALES_PK)
			this.SetearAtributoString( toModeloResponse, "ENTREGADEMERCADERIAS", toEntidad.ENTREGADEMERCADERIAS_PK)
			this.SetearAtributoString( toModeloResponse, "Entidad", toEntidad.Entidad)
			this.SetearAtributoString( toModeloResponse, "FACTURAELECTRONICADECREDITO", toEntidad.FACTURAELECTRONICADECREDITO_PK)
			this.SetearAtributoInteger( toModeloResponse, "FERIADO", toEntidad.FERIADO_PK)
			this.SetearAtributoLong( toModeloResponse, "IMPRESIONDEETIQUETA", toEntidad.IMPRESIONDEETIQUETA_PK)
			this.SetearAtributoString( toModeloResponse, "MOVIMIENTODESTOCK", toEntidad.MOVIMIENTODESTOCK_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADECREDITOELECTRONICADECREDITO", toEntidad.NOTADECREDITOELECTRONICADECREDITO_PK)
			this.SetearAtributoString( toModeloResponse, "NOTADEDEBITOELECTRONICADECREDITO", toEntidad.NOTADEDEBITOELECTRONICADECREDITO_PK)
			this.SetearAtributo( toModeloResponse, "Ordenar", toEntidad.Ordenar)
			this.SetearAtributoString( toModeloResponse, "PREPARACIONDEMERCADERIA", toEntidad.PREPARACIONDEMERCADERIA_PK)
			this.SetearAtributoString( toModeloResponse, "REMITODECOMPRA", toEntidad.REMITODECOMPRA_PK)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
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