
define class Din_EntidadSelechequeainsertar_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Selechequeainsertar"
	cClaseResponse = this.cNamespaceDTOs + ".SelechequeainsertarResponse"
	cClaseModelo = "SelechequeainsertarModelo"
	cEntidad = "Selechequeainsertar"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SelechequeainsertarModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SelechequeainsertarModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SelechequeainsertarListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SelechequeainsertarListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SelechequeainsertarModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Saldopendiente", toEntidad, "Saldopendiente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Criteriodeseleccion", toEntidad, "Criteriodeseleccion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordenamiento", toEntidad, "Ordenamiento" )
			this.SetearDetalleDetallechequesainsertar( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferencia", toEntidad, "Diferencia" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleChequesAInsertar( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleChequesAInsertar" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleChequesAInsertar[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleChequesAInsertar.LimpiarItem()
			else
				try
					toEntidad.DetalleChequesAInsertar.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleChequesAInsertar.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigovalor", toEntidad.DetalleChequesAInsertar.oItem, "CodigoValor" )
			this.SetearAtributoModeloEnEntidad( loItem, "Moneda", toEntidad.DetalleChequesAInsertar.oItem, "Moneda" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cliente", toEntidad.DetalleChequesAInsertar.oItem, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedetalle", toEntidad.DetalleChequesAInsertar.oItem, "ClienteDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.DetalleChequesAInsertar.oItem, "Numero" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinanciera", toEntidad.DetalleChequesAInsertar.oItem, "EntidadFinanciera_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinancieradetalle", toEntidad.DetalleChequesAInsertar.oItem, "EntidadFinancieraDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numeroint", toEntidad.DetalleChequesAInsertar.oItem, "NumeroInt" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codigotributariolibrador", toEntidad.DetalleChequesAInsertar.oItem, "CodigoTributarioLibrador" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechadepago", toEntidad.DetalleChequesAInsertar.oItem, "FechaDePago" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechaemision", toEntidad.DetalleChequesAInsertar.oItem, "FechaEmision" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.DetalleChequesAInsertar.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Seleccionado", toEntidad.DetalleChequesAInsertar.oItem, "Seleccionado" )
			toEntidad.DetalleChequesAInsertar.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "SaldoPendiente", toEntidad.SaldoPendiente)
			this.SetearAtributoInteger( toModeloResponse, "CriterioDeSeleccion", toEntidad.CriterioDeSeleccion)
			this.SetearAtributoInteger( toModeloResponse, "Ordenamiento", toEntidad.Ordenamiento)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloDetalleChequesAInsertar( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "Diferencia", toEntidad.Diferencia)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleChequesAInsertar( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleChequesAInsertar" ) 
		with toEntidad
			for lnI = 1 to .DetalleChequesAInsertar.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemSelechequeainsertar" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleChequesAInsertar.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoValor", .DetalleChequesAInsertar.Item(lnI).CodigoValor)
				this.SetearAtributoString( loItem, "Moneda", .DetalleChequesAInsertar.Item(lnI).Moneda)
				this.SetearAtributoString( loItem, "Cliente", .DetalleChequesAInsertar.Item(lnI).Cliente_PK)
				this.SetearAtributoString( loItem, "ClienteDetalle", .DetalleChequesAInsertar.Item(lnI).ClienteDetalle)
				this.SetearAtributoInteger( loItem, "Numero", .DetalleChequesAInsertar.Item(lnI).Numero)
				this.SetearAtributoString( loItem, "EntidadFinanciera", .DetalleChequesAInsertar.Item(lnI).EntidadFinanciera_PK)
				this.SetearAtributoString( loItem, "EntidadFinancieraDetalle", .DetalleChequesAInsertar.Item(lnI).EntidadFinancieraDetalle)
				this.SetearAtributoInteger( loItem, "NumeroInt", .DetalleChequesAInsertar.Item(lnI).NumeroInt)
				this.SetearAtributoString( loItem, "CodigoTributarioLibrador", .DetalleChequesAInsertar.Item(lnI).CodigoTributarioLibrador)
				this.SetearAtributoDatetime( loItem, "FechaDePago", .DetalleChequesAInsertar.Item(lnI).FechaDePago)
				this.SetearAtributoDatetime( loItem, "FechaEmision", .DetalleChequesAInsertar.Item(lnI).FechaEmision)
				this.SetearAtributoDecimal( loItem, "Monto", .DetalleChequesAInsertar.Item(lnI).Monto)
				this.SetearAtributo( loItem, "Seleccionado", .DetalleChequesAInsertar.Item(lnI).Seleccionado)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleChequesAInsertar.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
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