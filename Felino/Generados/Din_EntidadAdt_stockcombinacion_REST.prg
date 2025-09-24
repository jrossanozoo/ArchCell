
define class Din_EntidadAdt_stockcombinacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Adt_stockcombinacion"
	cClaseResponse = this.cNamespaceDTOs + ".Adt_stockcombinacionResponse"
	cClaseModelo = "Adt_stockcombinacionModelo"
	cEntidad = "Adt_stockcombinacion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_stockcombinacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_stockcombinacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_stockcombinacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_stockcombinacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "Adt_stockcombinacionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidad", toEntidad, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadoriginal", toEntidad, "Cantidadoriginal" )
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
			this.SetearAtributoInteger( toModeloResponse, "Cantidad", toEntidad.Cantidad)
			this.SetearAtributoInteger( toModeloResponse, "CantidadOriginal", toEntidad.CantidadOriginal)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidad", "COCANT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadoriginal", "CORIG")
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
		endif
	
		return lcRetorno 
	endfunc
	

enddefine