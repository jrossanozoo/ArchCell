
define class Din_EntidadFormatoexportacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Formatoexportacion"
	cClaseResponse = this.cNamespaceDTOs + ".FormatoexportacionResponse"
	cClaseModelo = "FormatoexportacionModelo"
	cEntidad = "Formatoexportacion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FormatoexportacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "FormatoexportacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "FormatoexportacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FormatoexportacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "FormatoexportacionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Completarizq", toEntidad, "Completarizq" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Completarder", toEntidad, "Completarder" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Alineacion", toEntidad, "Alineacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Capitalizacion", toEntidad, "Capitalizacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Lltrim", toEntidad, "Lltrim" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Lrtrim", toEntidad, "Lrtrim" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comienzacon", toEntidad, "Comienzacon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Truncardecimales", toEntidad, "Truncardecimales" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Decimales", toEntidad, "Decimales" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Separadordecimal", toEntidad, "Separadordecimal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Separadormiles", toEntidad, "Separadormiles" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Simboloinicial", toEntidad, "Simboloinicial" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Formatofecha", toEntidad, "Formatofecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Otroformato", toEntidad, "Otroformato" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "completarizq", toEntidad.completarizq)
			this.SetearAtributoString( toModeloResponse, "completarder", toEntidad.completarder)
			this.SetearAtributoString( toModeloResponse, "Alineacion", toEntidad.Alineacion)
			this.SetearAtributoString( toModeloResponse, "Capitalizacion", toEntidad.Capitalizacion)
			this.SetearAtributo( toModeloResponse, "lltrim", toEntidad.lltrim)
			this.SetearAtributo( toModeloResponse, "lrtrim", toEntidad.lrtrim)
			this.SetearAtributoString( toModeloResponse, "comienzacon", toEntidad.comienzacon)
			this.SetearAtributo( toModeloResponse, "TruncarDecimales", toEntidad.TruncarDecimales)
			this.SetearAtributoInteger( toModeloResponse, "Decimales", toEntidad.Decimales)
			this.SetearAtributoString( toModeloResponse, "separadordecimal", toEntidad.separadordecimal)
			this.SetearAtributoString( toModeloResponse, "separadormiles", toEntidad.separadormiles)
			this.SetearAtributoString( toModeloResponse, "simboloinicial", toEntidad.simboloinicial)
			this.SetearAtributoString( toModeloResponse, "formatofecha", toEntidad.formatofecha)
			this.SetearAtributoString( toModeloResponse, "otroformato", toEntidad.otroformato)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Completarizq", "COMPIZQ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Completarder", "COMPDER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Alineacion", "ALINEACION")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Capitalizacion", "CAPITALIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Lltrim", "LLTRIM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Lrtrim", "LRTRIM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comienzacon", "COMIENZA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Truncardecimales", "TRUNCAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Decimales", "CANTDECI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Separadordecimal", "SEPDEC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Separadormiles", "SECMILES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Simboloinicial", "INICIAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Formatofecha", "FORMFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Otroformato", "OTROFORM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), COBS)")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Compizq LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Compder LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Alineacion LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Capitaliz LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Comienza LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sepdec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Secmiles LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Inicial LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Formfecha LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Otroform LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine