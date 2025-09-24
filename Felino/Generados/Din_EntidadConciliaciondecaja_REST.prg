
define class Din_EntidadConciliaciondecaja_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Conciliaciondecaja"
	cClaseResponse = this.cNamespaceDTOs + ".ConciliaciondecajaResponse"
	cClaseModelo = "ConciliaciondecajaModelo"
	cEntidad = "Conciliaciondecaja"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ConciliaciondecajaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ConciliaciondecajaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ConciliaciondecajaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ConciliaciondecajaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ConciliaciondecajaModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Caja", toEntidad, "Caja_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Verificarhistoricos", toEntidad, "Verificarhistoricos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearDetalleConciliasaldo( toEntidad, toModeloEnRequest )
			this.SetearDetalleConciliamovimiento( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleConciliaSaldo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ConciliaSaldo" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ConciliaSaldo[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ConciliaSaldo.LimpiarItem()
			else
				try
					toEntidad.ConciliaSaldo.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ConciliaSaldo.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Desctipocomprobante", toEntidad.ConciliaSaldo.oItem, "DescTipoComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.ConciliaSaldo.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.ConciliaSaldo.oItem, "ValorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Saldoact", toEntidad.ConciliaSaldo.oItem, "SaldoAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Saldoproy", toEntidad.ConciliaSaldo.oItem, "SaldoProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Ajuste", toEntidad.ConciliaSaldo.oItem, "Ajuste" )
			toEntidad.ConciliaSaldo.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleConciliaMovimiento( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ConciliaMovimiento" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ConciliaMovimiento[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ConciliaMovimiento.LimpiarItem()
			else
				try
					toEntidad.ConciliaMovimiento.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ConciliaMovimiento.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Desctipocomprobante", toEntidad.ConciliaMovimiento.oItem, "DescTipoComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.ConciliaMovimiento.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.ConciliaMovimiento.oItem, "ValorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Saldoact", toEntidad.ConciliaMovimiento.oItem, "SaldoAct" )
			this.SetearAtributoModeloEnEntidad( loItem, "Saldoproy", toEntidad.ConciliaMovimiento.oItem, "SaldoProy" )
			this.SetearAtributoModeloEnEntidad( loItem, "Ajuste", toEntidad.ConciliaMovimiento.oItem, "Ajuste" )
			toEntidad.ConciliaMovimiento.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoInteger( toModeloResponse, "Caja", toEntidad.Caja_PK)
			this.SetearAtributo( toModeloResponse, "VerificarHistoricos", toEntidad.VerificarHistoricos)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.CargarColeccionModeloConciliaSaldo( toModeloResponse, toEntidad )
			this.CargarColeccionModeloConciliaMovimiento( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloConciliaSaldo( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ConciliaSaldo" ) 
		with toEntidad
			for lnI = 1 to .ConciliaSaldo.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemConciliasaldo" )
				this.SetearAtributoString( loItem, "codigo", .ConciliaSaldo.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "DescTipoComprobante", .ConciliaSaldo.Item(lnI).DescTipoComprobante)
				this.SetearAtributoString( loItem, "Valor", .ConciliaSaldo.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .ConciliaSaldo.Item(lnI).ValorDetalle)
				this.SetearAtributoDecimal( loItem, "SaldoAct", .ConciliaSaldo.Item(lnI).SaldoAct)
				this.SetearAtributoDecimal( loItem, "SaldoProy", .ConciliaSaldo.Item(lnI).SaldoProy)
				this.SetearAtributoDecimal( loItem, "Ajuste", .ConciliaSaldo.Item(lnI).Ajuste)
				this.SetearAtributoInteger( loItem, "NroItem", .ConciliaSaldo.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloConciliaMovimiento( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ConciliaMovimiento" ) 
		with toEntidad
			for lnI = 1 to .ConciliaMovimiento.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemConciliamovimiento" )
				this.SetearAtributoString( loItem, "codigo", .ConciliaMovimiento.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "DescTipoComprobante", .ConciliaMovimiento.Item(lnI).DescTipoComprobante)
				this.SetearAtributoString( loItem, "Valor", .ConciliaMovimiento.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .ConciliaMovimiento.Item(lnI).ValorDetalle)
				this.SetearAtributoDecimal( loItem, "SaldoAct", .ConciliaMovimiento.Item(lnI).SaldoAct)
				this.SetearAtributoDecimal( loItem, "SaldoProy", .ConciliaMovimiento.Item(lnI).SaldoProy)
				this.SetearAtributoDecimal( loItem, "Ajuste", .ConciliaMovimiento.Item(lnI).Ajuste)
				this.SetearAtributoInteger( loItem, "NroItem", .ConciliaMovimiento.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "CCNUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "CCFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Caja", "CCCAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Verificarhistoricos", "VERIFHIST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), CCOBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine