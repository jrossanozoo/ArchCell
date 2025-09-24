
define class Din_EntidadAdt_cliente_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Adt_cliente"
	cClaseResponse = this.cNamespaceDTOs + ".Adt_clienteResponse"
	cClaseModelo = "Adt_clienteModelo"
	cEntidad = "Adt_cliente"
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
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_clienteModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_clienteModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_clienteListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_clienteListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_clienteModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuit", toEntidad, "Cuit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacion", toEntidad, "Clasificacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecio", toEntidad, "Listadeprecio_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nroiibb", toEntidad, "Nroiibb" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rut", toEntidad, "Rut" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Situacionfiscal", toEntidad, "Situacionfiscal_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoconvenio", toEntidad, "Tipoconvenio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Topectacte", toEntidad, "Topectacte" )
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
			this.SetearAtributoString( toModeloResponse, "CUIT", toEntidad.CUIT)
			this.SetearAtributoString( toModeloResponse, "Clasificacion", toEntidad.Clasificacion_PK)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecio", toEntidad.ListaDePrecio_PK)
			this.SetearAtributoLong( toModeloResponse, "NroIIBB", toEntidad.NroIIBB)
			this.SetearAtributoString( toModeloResponse, "RUT", toEntidad.RUT)
			this.SetearAtributoInteger( toModeloResponse, "SituacionFiscal", toEntidad.SituacionFiscal_PK)
			this.SetearAtributoInteger( toModeloResponse, "TipoConvenio", toEntidad.TipoConvenio)
			this.SetearAtributoDecimal( toModeloResponse, "TopeCtaCte", toEntidad.TopeCtaCte)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuit", "CLCUIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacion", "CLCLAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigo", "CLCOD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecio", "CLLISPREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nroiibb", "CLNROIIBB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rut", "RUT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Situacionfiscal", "CLIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoconvenio", "CLTIPCONV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Topectacte", "CLTOPECCTE")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcuit LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clclas LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cllisprec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rut LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine