
define class Din_EntidadCondiciondepago_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Condiciondepago"
	cClaseResponse = this.cNamespaceDTOs + ".CondiciondepagoResponse"
	cClaseModelo = "CondiciondepagoModelo"
	cEntidad = "Condiciondepago"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CondiciondepagoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CondiciondepagoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CondiciondepagoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CondiciondepagoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CondiciondepagoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodepagos", toEntidad, "Tipodepagos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fechadevencimiento", toEntidad, "Fechadevencimiento" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Frecuencia", toEntidad, "Frecuencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidaddepagos", toEntidad, "Cantidaddepagos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuentacorriente", toEntidad, "Cuentacorriente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Anticipo", toEntidad, "Anticipo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigovaloranticipo", toEntidad, "Codigovaloranticipo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuento", toEntidad, "Descuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargo", toEntidad, "Recargo" )
			this.SetearDetallePagospersonalizados( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAgrupublidetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Agrupublidetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Agrupublidetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Agrupublidetalle.LimpiarItem()
			else
				try
					toEntidad.Agrupublidetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Agrupublidetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.Agrupublidetalle.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallePagosPersonalizados( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "PagosPersonalizados" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"PagosPersonalizados[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.PagosPersonalizados.LimpiarItem()
			else
				try
					toEntidad.PagosPersonalizados.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.PagosPersonalizados.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.PagosPersonalizados.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.PagosPersonalizados.oItem, "ValorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipovalordescripcion", toEntidad.PagosPersonalizados.oItem, "TipoValorDescripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.PagosPersonalizados.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargo", toEntidad.PagosPersonalizados.oItem, "Recargo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Diasapartirdefechacomprobante", toEntidad.PagosPersonalizados.oItem, "DiasAPartirDeFechaComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentajedelcomprobante", toEntidad.PagosPersonalizados.oItem, "PorcentajeDelComprobante" )
			toEntidad.PagosPersonalizados.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoInteger( toModeloResponse, "TipoDePagos", toEntidad.TipoDePagos)
			this.SetearAtributoInteger( toModeloResponse, "FechaDeVencimiento", toEntidad.FechaDeVencimiento)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributo( toModeloResponse, "Frecuencia", toEntidad.Frecuencia)
			this.SetearAtributoInteger( toModeloResponse, "CantidadDePagos", toEntidad.CantidadDePagos)
			this.SetearAtributoString( toModeloResponse, "CuentaCorriente", toEntidad.CuentaCorriente_PK)
			this.SetearAtributoDecimal( toModeloResponse, "Anticipo", toEntidad.Anticipo)
			this.SetearAtributoString( toModeloResponse, "CodigoValorAnticipo", toEntidad.CodigoValorAnticipo_PK)
			this.SetearAtributoDecimal( toModeloResponse, "Descuento", toEntidad.Descuento)
			this.SetearAtributoDecimal( toModeloResponse, "Recargo", toEntidad.Recargo)
			this.CargarColeccionModeloPagosPersonalizados( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAgrupublidetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Agrupublidetalle" ) 
		with toEntidad
			for lnI = 1 to .Agrupublidetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAgrupapublic" )
				this.SetearAtributoString( loItem, "Codigo", .Agrupublidetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Agrupamiento", .Agrupublidetalle.Item(lnI).Agrupamiento_PK)
				this.SetearAtributoString( loItem, "AgrupamientoDetalle", .Agrupublidetalle.Item(lnI).AgrupamientoDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .Agrupublidetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloPagosPersonalizados( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "PagosPersonalizados" ) 
		with toEntidad
			for lnI = 1 to .PagosPersonalizados.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPagospersonalizados" )
				this.SetearAtributoString( loItem, "Codigo", .PagosPersonalizados.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Valor", .PagosPersonalizados.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .PagosPersonalizados.Item(lnI).ValorDetalle)
				this.SetearAtributoString( loItem, "TipoValorDescripcion", .PagosPersonalizados.Item(lnI).TipoValorDescripcion)
				this.SetearAtributoDecimal( loItem, "Descuento", .PagosPersonalizados.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "Recargo", .PagosPersonalizados.Item(lnI).Recargo)
				this.SetearAtributoInteger( loItem, "DiasAPartirDeFechaComprobante", .PagosPersonalizados.Item(lnI).DiasAPartirDeFechaComprobante)
				this.SetearAtributoDecimal( loItem, "PorcentajeDelComprobante", .PagosPersonalizados.Item(lnI).PorcentajeDelComprobante)
				this.SetearAtributoInteger( loItem, "NroItem", .PagosPersonalizados.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoagrupamientopublicaciones", "TIPAGRUPUB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "CLNOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodepagos", "TIPOPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadevencimiento", "FECHAVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Frecuencia", "CONVERT( VARCHAR(MAX), FRECUENCIA)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidaddepagos", "CANTPAGOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuentacorriente", "CTACTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Anticipo", "ANTICIPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigovaloranticipo", "CVALANT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuento", "DESCUENTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargo", "RECARGO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Frecuencia LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctacte LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cvalant LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine