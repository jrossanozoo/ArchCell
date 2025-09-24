
define class Din_EntidadEnviodemensajeria_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Enviodemensajeria"
	cClaseResponse = this.cNamespaceDTOs + ".EnviodemensajeriaResponse"
	cClaseModelo = "EnviodemensajeriaModelo"
	cEntidad = "Enviodemensajeria"
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
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodemensajeriaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodemensajeriaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodemensajeriaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodemensajeriaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodemensajeriaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ecommerce", toEntidad, "Ecommerce_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidad", toEntidad, "Entidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diseno", toEntidad, "Diseno_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mlenviouno", toEntidad, "Mlenviouno" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mlenviodos", toEntidad, "Mlenviodos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mlacordar", toEntidad, "Mlacordar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Motivoparacomunicarse", toEntidad, "Motivoparacomunicarse" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Template", toEntidad, "Template" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mensaje", toEntidad, "Mensaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagen", toEntidad, "Imagen" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Ecommerce", toEntidad.Ecommerce_PK)
			this.SetearAtributoString( toModeloResponse, "Entidad", toEntidad.Entidad)
			this.SetearAtributoString( toModeloResponse, "Diseno", toEntidad.Diseno_PK)
			this.SetearAtributo( toModeloResponse, "MLEnvioUno", toEntidad.MLEnvioUno)
			this.SetearAtributo( toModeloResponse, "MLEnvioDos", toEntidad.MLEnvioDos)
			this.SetearAtributo( toModeloResponse, "MLAcordar", toEntidad.MLAcordar)
			this.SetearAtributoString( toModeloResponse, "MotivoParaComunicarse", toEntidad.MotivoParaComunicarse)
			this.SetearAtributoString( toModeloResponse, "Template", toEntidad.Template)
			this.SetearAtributo( toModeloResponse, "Mensaje", toEntidad.Mensaje)
			this.SetearAtributoString( toModeloResponse, "Imagen", toEntidad.Imagen)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ecommerce", "ECOMMERCE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entidad", "ENTIDAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diseno", "DIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mlenviouno", "MLENVUNO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mlenviodos", "MLENVDOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mlacordar", "MLACORDAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Motivoparacomunicarse", "MOTIVOMENS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Template", "TEMPLATE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mensaje", "CONVERT( VARCHAR(MAX), MENSAJE)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagen", "IMAGEN")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ecommerce LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entidad LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dis LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Motivomens LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Template LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mensaje LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Imagen LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine