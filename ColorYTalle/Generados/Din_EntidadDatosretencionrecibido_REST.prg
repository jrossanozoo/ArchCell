
define class Din_EntidadDatosretencionrecibido_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Datosretencionrecibido"
	cClaseResponse = this.cNamespaceDTOs + ".DatosretencionrecibidoResponse"
	cClaseModelo = "DatosretencionrecibidoModelo"
	cEntidad = "Datosretencionrecibido"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatosretencionrecibidoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatosretencionrecibidoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatosretencionrecibidoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatosretencionrecibidoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DatosretencionrecibidoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedetalle", toEntidad, "Clientedetalle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuit", toEntidad, "Cuit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recibo", toEntidad, "Recibo" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecharecibo", toEntidad, "Fecharecibo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impuesto", toEntidad, "Impuesto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoimpuesto", toEntidad, "Tipoimpuesto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Regimen", toEntidad, "Regimen_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Jurisdiccion", toEntidad, "Jurisdiccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Resolucion", toEntidad, "Resolucion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocertificado", toEntidad, "Numerocertificado" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacertificado", toEntidad, "Fechacertificado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observaciones", toEntidad, "Observaciones" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "codigo", toEntidad.codigo)
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteDetalle", toEntidad.ClienteDetalle)
			this.SetearAtributoString( toModeloResponse, "Cuit", toEntidad.Cuit)
			this.SetearAtributoString( toModeloResponse, "Recibo", toEntidad.Recibo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaRecibo", toEntidad.FechaRecibo)
			this.SetearAtributoString( toModeloResponse, "Impuesto", toEntidad.Impuesto_PK)
			this.SetearAtributoString( toModeloResponse, "TipoImpuesto", toEntidad.TipoImpuesto)
			this.SetearAtributoString( toModeloResponse, "Regimen", toEntidad.Regimen_PK)
			this.SetearAtributoString( toModeloResponse, "Jurisdiccion", toEntidad.Jurisdiccion_PK)
			this.SetearAtributoString( toModeloResponse, "Resolucion", toEntidad.Resolucion)
			this.SetearAtributoString( toModeloResponse, "NumeroCertificado", toEntidad.NumeroCertificado)
			this.SetearAtributoDateTime( toModeloResponse, "FechaCertificado", toEntidad.FechaCertificado)
			this.SetearAtributoDecimal( toModeloResponse, "Monto", toEntidad.Monto)
			this.SetearAtributo( toModeloResponse, "Observaciones", toEntidad.Observaciones)
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