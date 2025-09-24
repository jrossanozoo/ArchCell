
define class Din_EntidadCierredelote_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Cierredelote"
	cClaseResponse = this.cNamespaceDTOs + ".CierredeloteResponse"
	cClaseModelo = "CierredeloteModelo"
	cEntidad = "Cierredelote"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CierredeloteModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CierredeloteModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CierredeloteListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CierredeloteListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CierredeloteModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeroc", toEntidad, "Numeroc" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaalta", toEntidad, "Fechaalta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horaalta", toEntidad, "Horaalta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serieorigen", toEntidad, "Serieorigen" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacierredelote", toEntidad, "Fechacierredelote" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horacierredelote", toEntidad, "Horacierredelote" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Equipopos", toEntidad, "Equipopos_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ticketicard", toEntidad, "Ticketicard" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearDetalleDetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Detalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Detalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Detalle.LimpiarItem()
			else
				try
					toEntidad.Detalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Detalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Nrolote", toEntidad.Detalle.oItem, "NroLote" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tarjeta", toEntidad.Detalle.oItem, "Tarjeta_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tarjetadetalle", toEntidad.Detalle.oItem, "TarjetaDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montototalcompras", toEntidad.Detalle.oItem, "MontoTotalCompras" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montototalanulacioncompras", toEntidad.Detalle.oItem, "MontoTotalAnulacionCompras" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montototaldevoluciones", toEntidad.Detalle.oItem, "MontoTotalDevoluciones" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montototalanulaciondevoluciones", toEntidad.Detalle.oItem, "MontoTotalAnulacionDevoluciones" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montototal", toEntidad.Detalle.oItem, "MontoTotal" )
			toEntidad.Detalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "NumeroC", toEntidad.NumeroC)
			this.SetearAtributoDateTime( toModeloResponse, "FECHAALTA", toEntidad.FECHAALTA)
			this.SetearAtributoString( toModeloResponse, "HORAALTA", toEntidad.HORAALTA)
			this.SetearAtributoString( toModeloResponse, "SerieOrigen", toEntidad.SerieOrigen)
			this.SetearAtributoDateTime( toModeloResponse, "FechaCierreDeLote", toEntidad.FechaCierreDeLote)
			this.SetearAtributoString( toModeloResponse, "HoraCierreDeLote", toEntidad.HoraCierreDeLote)
			this.SetearAtributoString( toModeloResponse, "EquipoPOS", toEntidad.EquipoPOS_PK)
			this.SetearAtributo( toModeloResponse, "TicketICard", toEntidad.TicketICard)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.CargarColeccionModeloDetalle( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Detalle" ) 
		with toEntidad
			for lnI = 1 to .Detalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemLote" )
				this.SetearAtributoString( loItem, "Codigo", .Detalle.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "NroLote", .Detalle.Item(lnI).NroLote)
				this.SetearAtributoString( loItem, "Tarjeta", .Detalle.Item(lnI).Tarjeta_PK)
				this.SetearAtributoString( loItem, "TarjetaDetalle", .Detalle.Item(lnI).TarjetaDetalle)
				this.SetearAtributoDecimal( loItem, "MontoTotalCompras", .Detalle.Item(lnI).MontoTotalCompras)
				this.SetearAtributoDecimal( loItem, "MontoTotalAnulacionCompras", .Detalle.Item(lnI).MontoTotalAnulacionCompras)
				this.SetearAtributoDecimal( loItem, "MontoTotalDevoluciones", .Detalle.Item(lnI).MontoTotalDevoluciones)
				this.SetearAtributoDecimal( loItem, "MontoTotalAnulacionDevoluciones", .Detalle.Item(lnI).MontoTotalAnulacionDevoluciones)
				this.SetearAtributoDecimal( loItem, "MontoTotal", .Detalle.Item(lnI).MontoTotal)
				this.SetearAtributoInteger( loItem, "NroItem", .Detalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeroc", "NUMEROC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaalta", "FALTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horaalta", "HORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serieorigen", "SERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacierredelote", "FCIELOTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horacierredelote", "HCIELOTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Equipopos", "EQUIPOPOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ticketicard", "CONVERT( VARCHAR(MAX), TXTICARD)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hcielote LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Equipopos LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Txticard LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine