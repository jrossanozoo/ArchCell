
define class Din_EntidadDescargadecheques_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Descargadecheques"
	cClaseResponse = this.cNamespaceDTOs + ".DescargadechequesResponse"
	cClaseModelo = "DescargadechequesModelo"
	cEntidad = "Descargadecheques"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DescargadechequesModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DescargadechequesModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DescargadechequesListarRequest"
			case tcOperacion == "Anular"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DescargadechequesListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DescargadechequesModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Destinodescarga", toEntidad, "Destinodescarga_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Concepto", toEntidad, "Concepto_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearDetalleChequesdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observ", toEntidad, "Observ" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleChequesDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ChequesDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ChequesDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ChequesDetalle.LimpiarItem()
			else
				try
					toEntidad.ChequesDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ChequesDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Numerointerno", toEntidad.ChequesDetalle.oItem, "NumeroInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinanciera", toEntidad.ChequesDetalle.oItem, "EntidadFinanciera_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinancieradetalle", toEntidad.ChequesDetalle.oItem, "EntidadFinancieraDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.ChequesDetalle.oItem, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechaemision", toEntidad.ChequesDetalle.oItem, "FechaEmision" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechapago", toEntidad.ChequesDetalle.oItem, "FechaPago" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codigotributariolibrador", toEntidad.ChequesDetalle.oItem, "CodigoTributarioLibrador" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cliente", toEntidad.ChequesDetalle.oItem, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedetalle", toEntidad.ChequesDetalle.oItem, "ClienteDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ChequesDetalle.oItem, "Monto" )
			toEntidad.ChequesDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "DestinoDescarga", toEntidad.DestinoDescarga_PK)
			this.SetearAtributoString( toModeloResponse, "Concepto", toEntidad.Concepto_PK)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.CargarColeccionModeloChequesDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Observ", toEntidad.Observ)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloChequesDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ChequesDetalle" ) 
		with toEntidad
			for lnI = 1 to .ChequesDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDescargacheque" )
				this.SetearAtributoString( loItem, "Codigo", .ChequesDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "NumeroInterno", .ChequesDetalle.Item(lnI).NumeroInterno)
				this.SetearAtributoString( loItem, "EntidadFinanciera", .ChequesDetalle.Item(lnI).EntidadFinanciera_PK)
				this.SetearAtributoString( loItem, "EntidadFinancieraDetalle", .ChequesDetalle.Item(lnI).EntidadFinancieraDetalle)
				this.SetearAtributoInteger( loItem, "Numero", .ChequesDetalle.Item(lnI).Numero)
				this.SetearAtributoDatetime( loItem, "FechaEmision", .ChequesDetalle.Item(lnI).FechaEmision)
				this.SetearAtributoDatetime( loItem, "FechaPago", .ChequesDetalle.Item(lnI).FechaPago)
				this.SetearAtributoString( loItem, "CodigoTributarioLibrador", .ChequesDetalle.Item(lnI).CodigoTributarioLibrador)
				this.SetearAtributoString( loItem, "Cliente", .ChequesDetalle.Item(lnI).Cliente_PK)
				this.SetearAtributoString( loItem, "ClienteDetalle", .ChequesDetalle.Item(lnI).ClienteDetalle)
				this.SetearAtributoDecimal( loItem, "Monto", .ChequesDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .ChequesDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Destinodescarga", "DESTINO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Concepto", "CONCEPTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "LETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "PTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observ", "COBS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Destino LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Concepto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Letra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine