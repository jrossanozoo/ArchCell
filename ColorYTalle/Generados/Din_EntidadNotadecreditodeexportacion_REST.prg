
define class Din_EntidadNotadecreditodeexportacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Notadecreditodeexportacion"
	cClaseResponse = this.cNamespaceDTOs + ".NotadecreditodeexportacionResponse"
	cClaseModelo = "NotadecreditodeexportacionModelo"
	cEntidad = "Notadecreditodeexportacion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditodeexportacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditodeexportacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditodeexportacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditodeexportacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditodeexportacionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearDetalleImpuestoscomprobante( toEntidad, toModeloEnRequest )
			this.SetearDetalleImpuestosdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedescripcion", toEntidad, "Clientedescripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante", toEntidad, "Monedacomprobante_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Email", toEntidad, "Email" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecios", toEntidad, "Listadeprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cotizaciondespacho", toEntidad, "Cotizaciondespacho" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearDetalleFacturadetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleArticulosseniadosdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavtosenia", toEntidad, "Fechavtosenia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ajustesporredondeos", toEntidad, "Ajustesporredondeos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedescuento", toEntidad, "Porcentajedescuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuento", toEntidad, "Descuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodescuento3", toEntidad, "Montodescuento3" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargoporcentaje", toEntidad, "Recargoporcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto", toEntidad, "Recargomonto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto2", toEntidad, "Recargomonto2" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodescuento2visual", toEntidad, "Montodescuento2visual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto1visual", toEntidad, "Recargomonto1visual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impuestos", toEntidad, "Impuestos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totalimpuestos", toEntidad, "Totalimpuestos" )
			this.SetearDetalleValoresdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vueltovirtual", toEntidad, "Vueltovirtual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
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
	protected function SetearDetalleImpuestosComprobante( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ImpuestosComprobante" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ImpuestosComprobante[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ImpuestosComprobante.LimpiarItem()
			else
				try
					toEntidad.ImpuestosComprobante.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ImpuestosComprobante.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Basedecalculo", toEntidad.ImpuestosComprobante.oItem, "BaseDeCalculo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.ImpuestosComprobante.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoimpuesto", toEntidad.ImpuestosComprobante.oItem, "CodigoImpuesto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codigointerno", toEntidad.ImpuestosComprobante.oItem, "CodigoInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.ImpuestosComprobante.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Jurisdiccion", toEntidad.ImpuestosComprobante.oItem, "Jurisdiccion_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Minimo", toEntidad.ImpuestosComprobante.oItem, "Minimo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Minimonoimponible", toEntidad.ImpuestosComprobante.oItem, "MinimoNoImponible" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ImpuestosComprobante.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montobase", toEntidad.ImpuestosComprobante.oItem, "MontoBase" )
			this.SetearAtributoModeloEnEntidad( loItem, "Nroitem", toEntidad.ImpuestosComprobante.oItem, "NroItem" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentaje", toEntidad.ImpuestosComprobante.oItem, "Porcentaje" )
			this.SetearAtributoModeloEnEntidad( loItem, "Regimenimpositivo", toEntidad.ImpuestosComprobante.oItem, "RegimenImpositivo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipoimpuesto", toEntidad.ImpuestosComprobante.oItem, "TipoImpuesto" )
			toEntidad.ImpuestosComprobante.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleImpuestosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ImpuestosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ImpuestosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ImpuestosDetalle.LimpiarItem()
			else
				try
					toEntidad.ImpuestosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ImpuestosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.ImpuestosDetalle.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodeimpuestointerno", toEntidad.ImpuestosDetalle.oItem, "MontoDeImpuestoInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodeimpuestointernosindescuento", toEntidad.ImpuestosDetalle.oItem, "MontoDeImpuestoInternoSinDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodeiva", toEntidad.ImpuestosDetalle.oItem, "MontoDeIva" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodeivasindescuento", toEntidad.ImpuestosDetalle.oItem, "MontoDeIvaSinDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montonogravado", toEntidad.ImpuestosDetalle.oItem, "MontoNoGravado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montonogravadosindescuento", toEntidad.ImpuestosDetalle.oItem, "MontoNoGravadoSinDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentajedeiva", toEntidad.ImpuestosDetalle.oItem, "PorcentajeDeIva" )
			toEntidad.ImpuestosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleFacturaDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "FacturaDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"FacturaDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.FacturaDetalle.LimpiarItem()
			else
				try
					toEntidad.FacturaDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.FacturaDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Afe_saldo", toEntidad.FacturaDetalle.oItem, "Afe_Saldo" )
			if goParametros.Felino.CodigosDeBarras.HabilitarLectura
				if toEntidad.FacturaDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras != goParametros.Felino.CodigosDeBarras.HabilitarLectura
					toEntidad.FacturaDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras = goParametros.Felino.CodigosDeBarras.HabilitarLectura
				endif
				try
					this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.FacturaDetalle.oItem, "CodigoDeBarras" )
				catch to loError
					try
						this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.FacturaDetalle.oItem, "Articulo_PK" )
					catch
						goServicios.Errores.LevantarExcepcion( loError )
					endtry
				endtry
			else
				this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.FacturaDetalle.oItem, "Articulo_PK" )
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuentoconimpuestos", toEntidad.FacturaDetalle.oItem, "MontoDescuentoConImpuestos" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuentosinimpuestos", toEntidad.FacturaDetalle.oItem, "MontoDescuentoSinImpuestos" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montoiva", toEntidad.FacturaDetalle.oItem, "MontoIVA" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentajeiva", toEntidad.FacturaDetalle.oItem, "PorcentajeIVA" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precioconimpuestos", toEntidad.FacturaDetalle.oItem, "PrecioConImpuestos" )
			this.SetearAtributoModeloEnEntidad( loItem, "Preciosinimpuestos", toEntidad.FacturaDetalle.oItem, "PrecioSinImpuestos" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.FacturaDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.FacturaDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.FacturaDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.FacturaDetalle.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.FacturaDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.FacturaDetalle.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.FacturaDetalle.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuento", toEntidad.FacturaDetalle.oItem, "MontoDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.FacturaDetalle.oItem, "Monto" )
			toEntidad.FacturaDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleArticulosSeniadosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ArticulosSeniadosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ArticulosSeniadosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ArticulosSeniadosDetalle.LimpiarItem()
			else
				try
					toEntidad.ArticulosSeniadosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ArticulosSeniadosDetalle.LimpiarItem()
				endtry 
			endif
			if goParametros.Felino.CodigosDeBarras.HabilitarLectura
				if toEntidad.ArticulosSeniadosDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras != goParametros.Felino.CodigosDeBarras.HabilitarLectura
					toEntidad.ArticulosSeniadosDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras = goParametros.Felino.CodigosDeBarras.HabilitarLectura
				endif
				try
					this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ArticulosSeniadosDetalle.oItem, "CodigoDeBarras" )
				catch to loError
					try
						this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ArticulosSeniadosDetalle.oItem, "Articulo_PK" )
					catch
						goServicios.Errores.LevantarExcepcion( loError )
					endtry
				endtry
			else
				this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ArticulosSeniadosDetalle.oItem, "Articulo_PK" )
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.ArticulosSeniadosDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ArticulosSeniadosDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ArticulosSeniadosDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ArticulosSeniadosDetalle.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ArticulosSeniadosDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.ArticulosSeniadosDetalle.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.ArticulosSeniadosDetalle.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuento", toEntidad.ArticulosSeniadosDetalle.oItem, "MontoDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ArticulosSeniadosDetalle.oItem, "Monto" )
			toEntidad.ArticulosSeniadosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleValoresDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		local lcValor as String, llEsTarjeta as Boolean, llEsChequeDeTercero as Boolean, llEsChequePropio as Boolean 
		local llDebePedirDatosCheque as Boolean, llDebeSetearNumeroInternoCheque as Boolean 
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ValoresDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ValoresDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ValoresDetalle.LimpiarItem()
			else
				try
					toEntidad.ValoresDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ValoresDetalle.LimpiarItem()
				endtry 
			endif
			lcValor = _screen.dotnetbridge.ObtenerValorpropiedad( loItem, "Valor" )
			llEsTarjeta = this.VerificarSiValorEsTipoTarjeta( lcValor )
			if !llEsTarjeta
				llDebePedirDatosCheque = this.DebePedirDatosCheque( lcValor )
				if !llDebePedirDatosCheque
					llDebeSetearNumeroInternoCheque = this.DebeSetearNumeroInternoCheque( lcValor )
				endif
			endif
			if llEsTarjeta
				this.SetearAtributoModeloEnEntidad( loItem, "Recibido", this, "nMontoParaCupon" )
				this.SetearAtributoModeloEnEntidad( loItem, "DatosTarjeta", this, "oDatosTarjetaRequest" )
				this.BindearEvento( toEntidad, "EventoObtenerDatosDelCupon", this, "ManejarCupon" )
			else
				if llDebePedirDatosCheque
					this.BindearEvento( toEntidad.ValoresDetalle.oItem.oCompCajero.oCompChequesPropios, "EventoPedirCheque", this, "ManejarCheque" )
					this.SetearAtributoModeloEnEntidad( loItem, "DatosCheque", this, "oDatosChequeRequest" )
				endif
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.ValoresDetalle.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.ValoresDetalle.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.ValoresDetalle.oItem, "ValorDetalle" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.ValoresDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerointerno", toEntidad.ValoresDetalle.oItem, "NumeroInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ValoresDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentajedesrec", toEntidad.ValoresDetalle.oItem, "PorcentajeDesRec" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodesrec", toEntidad.ValoresDetalle.oItem, "MontoDesRec" )
			if !llEsTarjeta and !llDebePedirDatosCheque
				if toEntidad.ValoresDetalle.oItem.Valor.Tipo == 8 or llDebeSetearNumeroInternoCheque
					this.ManejarDatosExtraValor( toEntidad, loItem )
				else
					this.SetearAtributoModeloEnEntidad( loItem, "Recibido", toEntidad.ValoresDetalle.oItem, "Recibido" )
				endif
			endif
			this.DesBindearEvento( toEntidad, "EventoObtenerDatosDelCupon", this, "ManejarCupon" )
			if llDebePedirDatosCheque
				this.DesBindearEvento( toEntidad.ValoresDetalle.oItem.oCompCajero.oCompChequesPropios, "EventoPedirCheque", this, "ManejarCheque" )
			endif
			toEntidad.ValoresDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.CargarColeccionModeloCompAfec( toModeloResponse, toEntidad )
			this.CargarColeccionModeloImpuestosComprobante( toModeloResponse, toEntidad )
			this.CargarColeccionModeloImpuestosDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "ClienteDescripcion", toEntidad.ClienteDescripcion)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "MonedaComprobante", toEntidad.MonedaComprobante_PK)
			this.SetearAtributoString( toModeloResponse, "Email", toEntidad.Email)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecios", toEntidad.ListaDePrecios_PK)
			this.SetearAtributoDecimal( toModeloResponse, "COTIZACIONDESPACHO", toEntidad.COTIZACIONDESPACHO)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.CargarColeccionModeloFacturaDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloArticulosSeniadosDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDateTime( toModeloResponse, "FechaVtoSenia", toEntidad.FechaVtoSenia)
			this.SetearAtributoDecimal( toModeloResponse, "AjustesPorRedondeos", toEntidad.AjustesPorRedondeos)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDescuento", toEntidad.PorcentajeDescuento)
			this.SetearAtributoDecimal( toModeloResponse, "Descuento", toEntidad.Descuento)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDescuento3", toEntidad.MontoDescuento3)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoPorcentaje", toEntidad.RecargoPorcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto", toEntidad.RecargoMonto)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto2", toEntidad.RecargoMonto2)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDescuento2Visual", toEntidad.MontoDescuento2Visual)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto1Visual", toEntidad.RecargoMonto1Visual)
			this.SetearAtributoDecimal( toModeloResponse, "Impuestos", toEntidad.Impuestos)
			this.SetearAtributoDecimal( toModeloResponse, "TotalImpuestos", toEntidad.TotalImpuestos)
			this.CargarColeccionModeloValoresDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "VueltoVirtual", toEntidad.VueltoVirtual)
			this.SetearAtributoString( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
			this.CargarColeccionModeloNoPermiteModificacion( toModeloResponse, toEntidad )
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
	protected function CargarColeccionModeloImpuestosComprobante( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ImpuestosComprobante" ) 
		with toEntidad
			for lnI = 1 to .ImpuestosComprobante.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemImpuestoventas" )
				this.SetearAtributoString( loItem, "BaseDeCalculo", .ImpuestosComprobante.Item(lnI).BaseDeCalculo)
				this.SetearAtributoString( loItem, "Codigo", .ImpuestosComprobante.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoImpuesto", .ImpuestosComprobante.Item(lnI).CodigoImpuesto)
				this.SetearAtributoString( loItem, "CodigoInterno", .ImpuestosComprobante.Item(lnI).CodigoInterno)
				this.SetearAtributoString( loItem, "Descripcion", .ImpuestosComprobante.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Jurisdiccion", .ImpuestosComprobante.Item(lnI).Jurisdiccion_PK)
				this.SetearAtributoDecimal( loItem, "Minimo", .ImpuestosComprobante.Item(lnI).Minimo)
				this.SetearAtributoDecimal( loItem, "MinimoNoImponible", .ImpuestosComprobante.Item(lnI).MinimoNoImponible)
				this.SetearAtributoDecimal( loItem, "Monto", .ImpuestosComprobante.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "MontoBase", .ImpuestosComprobante.Item(lnI).MontoBase)
				this.SetearAtributoDecimal( loItem, "Porcentaje", .ImpuestosComprobante.Item(lnI).Porcentaje)
				this.SetearAtributoString( loItem, "RegimenImpositivo", .ImpuestosComprobante.Item(lnI).RegimenImpositivo)
				this.SetearAtributoString( loItem, "TipoImpuesto", .ImpuestosComprobante.Item(lnI).TipoImpuesto)
				this.SetearAtributoInteger( loItem, "NroItem", .ImpuestosComprobante.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloImpuestosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ImpuestosDetalle" ) 
		with toEntidad
			for lnI = 1 to .ImpuestosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemImpuestos" )
				this.SetearAtributoString( loItem, "Codigo", .ImpuestosDetalle.Item(lnI).Codigo)
				this.SetearAtributoDecimal( loItem, "MontoDeImpuestoInterno", .ImpuestosDetalle.Item(lnI).MontoDeImpuestoInterno)
				this.SetearAtributoDecimal( loItem, "MontoDeImpuestoInternoSinDescuento", .ImpuestosDetalle.Item(lnI).MontoDeImpuestoInternoSinDescuento)
				this.SetearAtributoDecimal( loItem, "MontoDeIva", .ImpuestosDetalle.Item(lnI).MontoDeIva)
				this.SetearAtributoDecimal( loItem, "MontoDeIvaSinDescuento", .ImpuestosDetalle.Item(lnI).MontoDeIvaSinDescuento)
				this.SetearAtributoDecimal( loItem, "MontoNoGravado", .ImpuestosDetalle.Item(lnI).MontoNoGravado)
				this.SetearAtributoDecimal( loItem, "MontoNoGravadoSinDescuento", .ImpuestosDetalle.Item(lnI).MontoNoGravadoSinDescuento)
				this.SetearAtributoDecimal( loItem, "PorcentajeDeIva", .ImpuestosDetalle.Item(lnI).PorcentajeDeIva)
				this.SetearAtributoInteger( loItem, "NroItem", .ImpuestosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloFacturaDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "FacturaDetalle" ) 
		with toEntidad
			for lnI = 1 to .FacturaDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemArticulosventas" )
				this.SetearAtributoDecimal( loItem, "Afe_Saldo", .FacturaDetalle.Item(lnI).Afe_Saldo)
				this.SetearAtributoString( loItem, "Articulo", .FacturaDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "Codigo", .FacturaDetalle.Item(lnI).Codigo)
				this.SetearAtributoDecimal( loItem, "MontoDescuentoConImpuestos", .FacturaDetalle.Item(lnI).MontoDescuentoConImpuestos)
				this.SetearAtributoDecimal( loItem, "MontoDescuentoSinImpuestos", .FacturaDetalle.Item(lnI).MontoDescuentoSinImpuestos)
				this.SetearAtributoDecimal( loItem, "MontoIVA", .FacturaDetalle.Item(lnI).MontoIVA)
				this.SetearAtributoDecimal( loItem, "PorcentajeIVA", .FacturaDetalle.Item(lnI).PorcentajeIVA)
				this.SetearAtributoDecimal( loItem, "PrecioConImpuestos", .FacturaDetalle.Item(lnI).PrecioConImpuestos)
				this.SetearAtributoDecimal( loItem, "PrecioSinImpuestos", .FacturaDetalle.Item(lnI).PrecioSinImpuestos)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .FacturaDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .FacturaDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .FacturaDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .FacturaDetalle.Item(lnI).Talle_PK)
				this.SetearAtributoDecimal( loItem, "Cantidad", .FacturaDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Precio", .FacturaDetalle.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Descuento", .FacturaDetalle.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "MontoDescuento", .FacturaDetalle.Item(lnI).MontoDescuento)
				this.SetearAtributoDecimal( loItem, "Monto", .FacturaDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .FacturaDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloArticulosSeniadosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ArticulosSeniadosDetalle" ) 
		with toEntidad
			for lnI = 1 to .ArticulosSeniadosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemArticulosseniados" )
				this.SetearAtributoString( loItem, "Articulo", .ArticulosSeniadosDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "Codigo", .ArticulosSeniadosDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .ArticulosSeniadosDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .ArticulosSeniadosDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ArticulosSeniadosDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ArticulosSeniadosDetalle.Item(lnI).Talle_PK)
				this.SetearAtributoDecimal( loItem, "Cantidad", .ArticulosSeniadosDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Precio", .ArticulosSeniadosDetalle.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Descuento", .ArticulosSeniadosDetalle.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "MontoDescuento", .ArticulosSeniadosDetalle.Item(lnI).MontoDescuento)
				this.SetearAtributoDecimal( loItem, "Monto", .ArticulosSeniadosDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .ArticulosSeniadosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloValoresDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ValoresDetalle" ) 
		with toEntidad
			for lnI = 1 to .ValoresDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemValores" )
				this.SetearAtributoString( loItem, "Codigo", .ValoresDetalle.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "Tipo", .ValoresDetalle.Item(lnI).Tipo)
				this.SetearAtributoString( loItem, "Valor", .ValoresDetalle.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .ValoresDetalle.Item(lnI).ValorDetalle)
				this.SetearAtributoDatetime( loItem, "Fecha", .ValoresDetalle.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "NumeroInterno", .ValoresDetalle.Item(lnI).NumeroInterno)
				this.SetearAtributoDecimal( loItem, "Monto", .ValoresDetalle.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "PorcentajeDesRec", .ValoresDetalle.Item(lnI).PorcentajeDesRec)
				this.SetearAtributoDecimal( loItem, "MontoDesRec", .ValoresDetalle.Item(lnI).MontoDesRec)
				this.SetearAtributoDecimal( loItem, "Recibido", .ValoresDetalle.Item(lnI).Recibido)
				this.SetearDatosExtraDelItem( loItem, toEntidad, lnI )
				this.SetearAtributoInteger( loItem, "NroItem", .ValoresDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "FPERSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedescripcion", "FCLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "FVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monedacomprobante", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Email", "EMAIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecios", "CODLISTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cotizaciondespacho", "COTIZDESP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "FPTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavtosenia", "VTOSENIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ajustesporredondeos", "FAJXRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajedescuento", "FPODES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuento", "FDESCU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodescuento3", "MD3")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargoporcentaje", "RECPOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto", "MR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto2", "MR2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Impuestos", "FIMPUESTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Totalimpuestos", "TOTIMPUE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "FOBS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Total", "FTOTAL")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fperson LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fcliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fven LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Email LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codlista LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloNoPermiteModificacion( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		if this.lPermiteModificacion
			loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "NoPermiteModificacion" )
			loColeccionObservaciones = toEntidad.ObtenerResultadoDeVotacion()
			for lnI = 1 to loColeccionObservaciones.Count
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loColeccionObservaciones.Item[lnI] )
			endfor
		endif
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerXmlDatosEntidad( toEntidad as Object, toRequest as Object ) as String
		loRequestDesempaquetada = this.DesempaquetarRequest( toRequest )
		this.lPermiteModificacion = _screen.DotNetBridge.ObtenerValorPropiedad( loRequestDesempaquetada , "AgregarModificacion" )
		return dodefault( toEntidad, toRequest )
	endfunc

enddefine