
define class Din_EntidadPedido_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Pedido"
	cClaseResponse = this.cNamespaceDTOs + ".PedidoResponse"
	cClaseModelo = "PedidoModelo"
	cEntidad = "Pedido"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PedidoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "PedidoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "PedidoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PedidoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "PedidoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedescripcion", toEntidad, "Clientedescripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mercaderiaconsignacion", toEntidad, "Mercaderiaconsignacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante", toEntidad, "Monedacomprobante_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecios", toEntidad, "Listadeprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Forpago", toEntidad, "Forpago_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Motivo", toEntidad, "Motivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Transportista", toEntidad, "Transportista_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Direccionentrega", toEntidad, "Direccionentrega" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cotizacion", toEntidad, "Cotizacion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadeentrega", toEntidad, "Fechadeentrega" )
			this.SetearDetalleFacturadetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleKitsdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ajustesporredondeos", toEntidad, "Ajustesporredondeos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedescuento", toEntidad, "Porcentajedescuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuento", toEntidad, "Descuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impuestos", toEntidad, "Impuestos" )
			this.SetearDetallePromocionesdetalle( toEntidad, toModeloEnRequest )
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
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocompcaracter", toEntidad.CompAfec.oItem, "TipoCompCaracter" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.CompAfec.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.CompAfec.oItem, "Total" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.CompAfec.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Interviniente", toEntidad.CompAfec.oItem, "Interviniente" )
			this.SetearAtributoModeloEnEntidad( loItem, "Origen", toEntidad.CompAfec.oItem, "Origen" )
			toEntidad.CompAfec.Actualizar()
			
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
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.FacturaDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.FacturaDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.FacturaDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.FacturaDetalle.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.FacturaDetalle.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.FacturaDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuento", toEntidad.FacturaDetalle.oItem, "MontoDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.FacturaDetalle.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.FacturaDetalle.oItem, "Monto" )
			toEntidad.FacturaDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleKitsDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "KitsDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"KitsDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.KitsDetalle.LimpiarItem()
			else
				try
					toEntidad.KitsDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.KitsDetalle.LimpiarItem()
				endtry 
			endif
			if goParametros.Felino.CodigosDeBarras.HabilitarLectura
				if toEntidad.KitsDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras != goParametros.Felino.CodigosDeBarras.HabilitarLectura
					toEntidad.KitsDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras = goParametros.Felino.CodigosDeBarras.HabilitarLectura
				endif
				try
					this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.KitsDetalle.oItem, "CodigoDeBarras" )
				catch to loError
					try
						this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.KitsDetalle.oItem, "Articulo_PK" )
					catch
						goServicios.Errores.LevantarExcepcion( loError )
					endtry
				endtry
			else
				this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.KitsDetalle.oItem, "Articulo_PK" )
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.KitsDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.KitsDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.KitsDetalle.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.KitsDetalle.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.KitsDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuento", toEntidad.KitsDetalle.oItem, "MontoDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.KitsDetalle.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.KitsDetalle.oItem, "Monto" )
			toEntidad.KitsDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallePromocionesDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "PromocionesDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"PromocionesDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.PromocionesDetalle.LimpiarItem()
			else
				try
					toEntidad.PromocionesDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.PromocionesDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Promocion", toEntidad.PromocionesDetalle.oItem, "Promocion_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Promociondetalle", toEntidad.PromocionesDetalle.oItem, "PromocionDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.PromocionesDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Beneficio", toEntidad.PromocionesDetalle.oItem, "Beneficio" )
			toEntidad.PromocionesDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.CargarColeccionModeloCompAfec( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "ClienteDescripcion", toEntidad.ClienteDescripcion)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributo( toModeloResponse, "MercaderiaConsignacion", toEntidad.MercaderiaConsignacion)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "MonedaComprobante", toEntidad.MonedaComprobante_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecios", toEntidad.ListaDePrecios_PK)
			this.SetearAtributoString( toModeloResponse, "ForPago", toEntidad.ForPago_PK)
			this.SetearAtributoString( toModeloResponse, "Motivo", toEntidad.Motivo_PK)
			this.SetearAtributoString( toModeloResponse, "Transportista", toEntidad.Transportista_PK)
			this.SetearAtributoString( toModeloResponse, "DireccionEntrega", toEntidad.DireccionEntrega)
			this.SetearAtributoDecimal( toModeloResponse, "Cotizacion", toEntidad.Cotizacion)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDeEntrega", toEntidad.FechaDeEntrega)
			this.CargarColeccionModeloFacturaDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloKitsDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "AjustesPorRedondeos", toEntidad.AjustesPorRedondeos)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDescuento", toEntidad.PorcentajeDescuento)
			this.SetearAtributoDecimal( toModeloResponse, "Descuento", toEntidad.Descuento)
			this.SetearAtributoDecimal( toModeloResponse, "Impuestos", toEntidad.Impuestos)
			this.CargarColeccionModeloPromocionesDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
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
				this.SetearAtributoString( loItem, "TipoCompCaracter", .CompAfec.Item(lnI).TipoCompCaracter)
				this.SetearAtributoDatetime( loItem, "Fecha", .CompAfec.Item(lnI).Fecha)
				this.SetearAtributoDecimal( loItem, "Total", .CompAfec.Item(lnI).Total)
				this.SetearAtributoString( loItem, "Tipo", .CompAfec.Item(lnI).Tipo)
				this.SetearAtributoString( loItem, "Interviniente", .CompAfec.Item(lnI).Interviniente)
				this.SetearAtributoString( loItem, "Origen", .CompAfec.Item(lnI).Origen)
				this.SetearAtributoInteger( loItem, "NroItem", .CompAfec.Item(lnI).NroItem )
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
				this.SetearAtributoString( loItem, "Articulo", .FacturaDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "Codigo", .FacturaDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .FacturaDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .FacturaDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .FacturaDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .FacturaDetalle.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "Descuento", .FacturaDetalle.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "Cantidad", .FacturaDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "MontoDescuento", .FacturaDetalle.Item(lnI).MontoDescuento)
				this.SetearAtributoDecimal( loItem, "Precio", .FacturaDetalle.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Monto", .FacturaDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .FacturaDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloKitsDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "KitsDetalle" ) 
		with toEntidad
			for lnI = 1 to .KitsDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemKits" )
				this.SetearAtributoString( loItem, "Articulo", .KitsDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "Codigo", .KitsDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .KitsDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "ColorDetalle", .KitsDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .KitsDetalle.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "Descuento", .KitsDetalle.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "Cantidad", .KitsDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "MontoDescuento", .KitsDetalle.Item(lnI).MontoDescuento)
				this.SetearAtributoDecimal( loItem, "Precio", .KitsDetalle.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Monto", .KitsDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .KitsDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloPromocionesDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "PromocionesDetalle" ) 
		with toEntidad
			for lnI = 1 to .PromocionesDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPromociones" )
				this.SetearAtributoString( loItem, "Codigo", .PromocionesDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Promocion", .PromocionesDetalle.Item(lnI).Promocion_PK)
				this.SetearAtributoString( loItem, "PromocionDetalle", .PromocionesDetalle.Item(lnI).PromocionDetalle)
				this.SetearAtributoInteger( loItem, "Cantidad", .PromocionesDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Beneficio", .PromocionesDetalle.Item(lnI).Beneficio)
				this.SetearAtributoInteger( loItem, "NroItem", .PromocionesDetalle.Item(lnI).NroItem )
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "FPTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mercaderiaconsignacion", "MERCONSIGN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "FVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monedacomprobante", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecios", "CODLISTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Forpago", "FPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Motivo", "MOTIVO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Transportista", "FTRANSP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Direccionentrega", "DIRENTR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cotizacion", "COTIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadeentrega", "FFCHENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ajustesporredondeos", "FAJXRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajedescuento", "FPODES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuento", "FDESCU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Impuestos", "FIMPUESTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), FOBS)")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fven LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codlista LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fpago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Motivo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ftransp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Direntr LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine