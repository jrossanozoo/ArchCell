
define class Din_EntidadCajaauditoria_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Cajaauditoria"
	cClaseResponse = this.cNamespaceDTOs + ".CajaauditoriaResponse"
	cClaseModelo = "CajaauditoriaModelo"
	cEntidad = "Cajaauditoria"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Id" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Id = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Id = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "CajaauditoriaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CajaauditoriaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CajaauditoriaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CajaauditoriaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CajaauditoriaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cajaestado", toEntidad, "Cajaestado_PK" )
			this.SetearDetalleDetallevaloresauditoria( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Hora", toEntidad, "Hora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Id", toEntidad, "Id" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montototal", toEntidad, "Montototal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tarea", toEntidad, "Tarea" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleValoresAuditoria( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleValoresAuditoria" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleValoresAuditoria[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleValoresAuditoria.LimpiarItem()
			else
				try
					toEntidad.DetalleValoresAuditoria.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleValoresAuditoria.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Idcajaauditoria", toEntidad.DetalleValoresAuditoria.oItem, "IdCajaAuditoria" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.DetalleValoresAuditoria.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.DetalleValoresAuditoria.oItem, "Valor_PK" )
			toEntidad.DetalleValoresAuditoria.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "CajaEstado", toEntidad.CajaEstado_PK)
			this.CargarColeccionModeloDetalleValoresAuditoria( toModeloResponse, toEntidad )
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Hora", toEntidad.Hora)
			this.SetearAtributoLong( toModeloResponse, "Id", toEntidad.Id)
			this.SetearAtributoDecimal( toModeloResponse, "MontoTotal", toEntidad.MontoTotal)
			this.SetearAtributoString( toModeloResponse, "Tarea", toEntidad.Tarea)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleValoresAuditoria( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleValoresAuditoria" ) 
		with toEntidad
			for lnI = 1 to .DetalleValoresAuditoria.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCajaauditoria" )
				this.SetearAtributoLong( loItem, "IdCajaAuditoria", .DetalleValoresAuditoria.Item(lnI).IdCajaAuditoria)
				this.SetearAtributoDecimal( loItem, "Monto", .DetalleValoresAuditoria.Item(lnI).Monto)
				this.SetearAtributoString( loItem, "Valor", .DetalleValoresAuditoria.Item(lnI).Valor_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleValoresAuditoria.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cajaestado", "NUMCAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Hora", "HORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montototal", "MONTOTOT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tarea", "TAREA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tarea LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine