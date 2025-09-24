
define class Din_EntidadAdt_consumocliente_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Adt_consumocliente"
	cClaseResponse = this.cNamespaceDTOs + ".Adt_consumoclienteResponse"
	cClaseModelo = "Adt_consumoclienteModelo"
	cEntidad = "Adt_consumocliente"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Adt_cod" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Adt_cod = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Adt_cod = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_consumoclienteModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_consumoclienteModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_consumoclienteListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_consumoclienteListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_consumoclienteModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_adn", toEntidad, "Adt_adn" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_cod", toEntidad, "Adt_cod" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_comp", toEntidad, "Adt_comp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_ent", toEntidad, "Adt_ent" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_ext", toEntidad, "Adt_ext" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Adt_fecha", toEntidad, "Adt_fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_hora", toEntidad, "Adt_hora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_serie", toEntidad, "Adt_serie" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_usr", toEntidad, "Adt_usr" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Adt_vers", toEntidad, "Adt_vers" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacomp", toEntidad, "Fechacomp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocomprobante", toEntidad, "Tipocomprobante" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "ADT_ADN", toEntidad.ADT_ADN)
			this.SetearAtributoString( toModeloResponse, "ADT_Cod", toEntidad.ADT_Cod)
			this.SetearAtributoString( toModeloResponse, "ADT_Comp", toEntidad.ADT_Comp)
			this.SetearAtributoString( toModeloResponse, "ADT_Ent", toEntidad.ADT_Ent)
			this.SetearAtributo( toModeloResponse, "ADT_Ext", toEntidad.ADT_Ext)
			this.SetearAtributoDateTime( toModeloResponse, "ADT_Fecha", toEntidad.ADT_Fecha)
			this.SetearAtributoString( toModeloResponse, "ADT_Hora", toEntidad.ADT_Hora)
			this.SetearAtributoString( toModeloResponse, "ADT_Serie", toEntidad.ADT_Serie)
			this.SetearAtributoString( toModeloResponse, "ADT_Usr", toEntidad.ADT_Usr)
			this.SetearAtributoString( toModeloResponse, "ADT_Vers", toEntidad.ADT_Vers)
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaComp", toEntidad.FechaComp)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoDecimal( toModeloResponse, "monto", toEntidad.monto)
			this.SetearAtributoInteger( toModeloResponse, "tipoComprobante", toEntidad.tipoComprobante)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_adn", "ADT_ADN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_comp", "ADT_COMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_ent", "ADT_ENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_ext", "ADT_EXT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_fecha", "ADT_FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_hora", "ADT_HORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_serie", "ADT_SERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_usr", "ADT_USR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Adt_vers", "ADT_VERS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "CLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigo", "CODIGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacomp", "FECCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "LETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "PTOVTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monto", "MONTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipocomprobante", "TIPCOMP")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_adn LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_cod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_comp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_ent LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_hora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_serie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_usr LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Adt_vers LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Letra LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine