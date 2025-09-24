
define class Din_EntidadArqueodecaja_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Arqueodecaja"
	cClaseResponse = this.cNamespaceDTOs + ".ArqueodecajaResponse"
	cClaseModelo = "ArqueodecajaModelo"
	cEntidad = "Arqueodecaja"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ArqueodecajaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ArqueodecajaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ArqueodecajaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ArqueodecajaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ArqueodecajaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Caja", toEntidad, "Caja_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaaltafw", toEntidad, "Fechaaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horaaltafw", toEntidad, "Horaaltafw" )
			this.SetearDetalleDetalletotalporgrupo( toEntidad, toModeloEnRequest )
			this.SetearDetalleDetallerecuentoefectivo( toEntidad, toModeloEnRequest )
			this.SetearDetalleDetalleotros( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCompAfec( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CompAfec" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CompAfec[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CompAfec.LimpiarItem()
			else
				try
					toEntidad.CompAfec.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CompAfec.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocomprobante", toEntidad.CompAfec.oItem, "TipoComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocompcaracter", toEntidad.CompAfec.oItem, "TipoCompCaracter" )
			this.SetearAtributoModeloEnEntidad( loItem, "Letra", toEntidad.CompAfec.oItem, "Letra" )
			this.SetearAtributoModeloEnEntidad( loItem, "Puntodeventa", toEntidad.CompAfec.oItem, "PuntoDeVenta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.CompAfec.oItem, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.CompAfec.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.CompAfec.oItem, "Total" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.CompAfec.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Afecta", toEntidad.CompAfec.oItem, "Afecta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Interviniente", toEntidad.CompAfec.oItem, "Interviniente" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadcomprobante", toEntidad.CompAfec.oItem, "EntidadComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Origen", toEntidad.CompAfec.oItem, "Origen" )
			toEntidad.CompAfec.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleTotalPorGrupo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleTotalPorGrupo" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleTotalPorGrupo[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleTotalPorGrupo.LimpiarItem()
			else
				try
					toEntidad.DetalleTotalPorGrupo.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleTotalPorGrupo.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupadesc", toEntidad.DetalleTotalPorGrupo.oItem, "AgrupaDesc" )
			this.SetearAtributoModeloEnEntidad( loItem, "Totalgrupo", toEntidad.DetalleTotalPorGrupo.oItem, "TotalGrupo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Arqueado", toEntidad.DetalleTotalPorGrupo.oItem, "Arqueado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Difgrupo", toEntidad.DetalleTotalPorGrupo.oItem, "DifGrupo" )
			toEntidad.DetalleTotalPorGrupo.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleRecuentoEfectivo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleRecuentoEfectivo" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleRecuentoEfectivo[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleRecuentoEfectivo.LimpiarItem()
			else
				try
					toEntidad.DetalleRecuentoEfectivo.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleRecuentoEfectivo.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Monedadenom", toEntidad.DetalleRecuentoEfectivo.oItem, "MonedaDenom" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descri", toEntidad.DetalleRecuentoEfectivo.oItem, "Descri" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.DetalleRecuentoEfectivo.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordenom", toEntidad.DetalleRecuentoEfectivo.oItem, "ValorDenom" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.DetalleRecuentoEfectivo.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.DetalleRecuentoEfectivo.oItem, "Total" )
			toEntidad.DetalleRecuentoEfectivo.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleOtros( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleOtros" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleOtros[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleOtros.LimpiarItem()
			else
				try
					toEntidad.DetalleOtros.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleOtros.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.DetalleOtros.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.DetalleOtros.oItem, "ValorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Moneda", toEntidad.DetalleOtros.oItem, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Totalarqueo", toEntidad.DetalleOtros.oItem, "TotalArqueo" )
			toEntidad.DetalleOtros.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.CargarColeccionModeloCompAfec( toModeloResponse, toEntidad )
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoInteger( toModeloResponse, "Caja", toEntidad.Caja_PK)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaAltaFW", toEntidad.FechaAltaFW)
			this.SetearAtributoString( toModeloResponse, "HoraAltaFW", toEntidad.HoraAltaFW)
			this.CargarColeccionModeloDetalleTotalPorGrupo( toModeloResponse, toEntidad )
			this.CargarColeccionModeloDetalleRecuentoEfectivo( toModeloResponse, toEntidad )
			this.CargarColeccionModeloDetalleOtros( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCompAfec( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CompAfec" ) 
		with toEntidad
			for lnI = 1 to .CompAfec.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemComprobante" )
				this.SetearAtributoString( loItem, "Codigo", .CompAfec.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "TipoComprobante", .CompAfec.Item(lnI).TipoComprobante)
				this.SetearAtributoString( loItem, "TipoCompCaracter", .CompAfec.Item(lnI).TipoCompCaracter)
				this.SetearAtributoString( loItem, "Letra", .CompAfec.Item(lnI).Letra)
				this.SetearAtributoInteger( loItem, "PuntoDeVenta", .CompAfec.Item(lnI).PuntoDeVenta)
				this.SetearAtributoInteger( loItem, "Numero", .CompAfec.Item(lnI).Numero)
				this.SetearAtributoDatetime( loItem, "Fecha", .CompAfec.Item(lnI).Fecha)
				this.SetearAtributoDecimal( loItem, "Total", .CompAfec.Item(lnI).Total)
				this.SetearAtributoString( loItem, "Tipo", .CompAfec.Item(lnI).Tipo)
				this.SetearAtributoString( loItem, "Afecta", .CompAfec.Item(lnI).Afecta)
				this.SetearAtributoString( loItem, "Interviniente", .CompAfec.Item(lnI).Interviniente)
				this.SetearAtributoString( loItem, "EntidadComprobante", .CompAfec.Item(lnI).EntidadComprobante)
				this.SetearAtributoString( loItem, "Origen", .CompAfec.Item(lnI).Origen)
				this.SetearAtributoInteger( loItem, "NroItem", .CompAfec.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleTotalPorGrupo( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleTotalPorGrupo" ) 
		with toEntidad
			for lnI = 1 to .DetalleTotalPorGrupo.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemTotalporgrupo" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleTotalPorGrupo.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "AgrupaDesc", .DetalleTotalPorGrupo.Item(lnI).AgrupaDesc)
				this.SetearAtributoDecimal( loItem, "TotalGrupo", .DetalleTotalPorGrupo.Item(lnI).TotalGrupo)
				this.SetearAtributoDecimal( loItem, "Arqueado", .DetalleTotalPorGrupo.Item(lnI).Arqueado)
				this.SetearAtributoDecimal( loItem, "DifGrupo", .DetalleTotalPorGrupo.Item(lnI).DifGrupo)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleTotalPorGrupo.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleRecuentoEfectivo( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleRecuentoEfectivo" ) 
		with toEntidad
			for lnI = 1 to .DetalleRecuentoEfectivo.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRecefectivo" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleRecuentoEfectivo.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "MonedaDenom", .DetalleRecuentoEfectivo.Item(lnI).MonedaDenom)
				this.SetearAtributoString( loItem, "Descri", .DetalleRecuentoEfectivo.Item(lnI).Descri)
				this.SetearAtributoString( loItem, "Tipo", .DetalleRecuentoEfectivo.Item(lnI).Tipo)
				this.SetearAtributoDecimal( loItem, "ValorDenom", .DetalleRecuentoEfectivo.Item(lnI).ValorDenom)
				this.SetearAtributoLong( loItem, "Cantidad", .DetalleRecuentoEfectivo.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Total", .DetalleRecuentoEfectivo.Item(lnI).Total)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleRecuentoEfectivo.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleOtros( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleOtros" ) 
		with toEntidad
			for lnI = 1 to .DetalleOtros.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemArqueootros" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleOtros.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Valor", .DetalleOtros.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .DetalleOtros.Item(lnI).ValorDetalle)
				this.SetearAtributoString( loItem, "Moneda", .DetalleOtros.Item(lnI).Moneda_PK)
				this.SetearAtributoDecimal( loItem, "TotalArqueo", .DetalleOtros.Item(lnI).TotalArqueo)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleOtros.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Caja", "CAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "VENDEDOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaaltafw", "FALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horaaltafw", "HALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), AOBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vendedor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Haltafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine