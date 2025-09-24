
define class Din_EntidadPreparaciondemercaderia_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Preparaciondemercaderia"
	cClaseResponse = this.cNamespaceDTOs + ".PreparaciondemercaderiaResponse"
	cClaseModelo = "PreparaciondemercaderiaModelo"
	cEntidad = "Preparaciondemercaderia"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PreparaciondemercaderiaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "PreparaciondemercaderiaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "PreparaciondemercaderiaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PreparaciondemercaderiaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "PreparaciondemercaderiaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecios", toEntidad, "Listadeprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Forpago", toEntidad, "Forpago_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Motivo", toEntidad, "Motivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Transportista", toEntidad, "Transportista_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadeentrega", toEntidad, "Fechadeentrega" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mercaderiaconsignacion", toEntidad, "Mercaderiaconsignacion" )
			this.SetearDetalleFacturadetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ajustesporredondeos", toEntidad, "Ajustesporredondeos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedescuento", toEntidad, "Porcentajedescuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuento", toEntidad, "Descuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodescuento3", toEntidad, "Montodescuento3" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargoporcentaje", toEntidad, "Recargoporcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto", toEntidad, "Recargomonto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto2", toEntidad, "Recargomonto2" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impuestos", toEntidad, "Impuestos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totalimpuestos", toEntidad, "Totalimpuestos" )
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
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.CargarColeccionModeloCompAfec( toModeloResponse, toEntidad )
			this.CargarColeccionModeloImpuestosComprobante( toModeloResponse, toEntidad )
			this.CargarColeccionModeloImpuestosDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "ClienteDescripcion", toEntidad.ClienteDescripcion)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecios", toEntidad.ListaDePrecios_PK)
			this.SetearAtributoString( toModeloResponse, "ForPago", toEntidad.ForPago_PK)
			this.SetearAtributoString( toModeloResponse, "Motivo", toEntidad.Motivo_PK)
			this.SetearAtributoString( toModeloResponse, "Transportista", toEntidad.Transportista_PK)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDeEntrega", toEntidad.FechaDeEntrega)
			this.SetearAtributo( toModeloResponse, "MercaderiaConsignacion", toEntidad.MercaderiaConsignacion)
			this.CargarColeccionModeloFacturaDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "AjustesPorRedondeos", toEntidad.AjustesPorRedondeos)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDescuento", toEntidad.PorcentajeDescuento)
			this.SetearAtributoDecimal( toModeloResponse, "Descuento", toEntidad.Descuento)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDescuento3", toEntidad.MontoDescuento3)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoPorcentaje", toEntidad.RecargoPorcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto", toEntidad.RecargoMonto)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto2", toEntidad.RecargoMonto2)
			this.SetearAtributoDecimal( toModeloResponse, "Impuestos", toEntidad.Impuestos)
			this.SetearAtributoDecimal( toModeloResponse, "TotalImpuestos", toEntidad.TotalImpuestos)
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
	protected function CargarColeccionModeloImpuestosComprobante( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ImpuestosComprobante" ) 
		with toEntidad
			for lnI = 1 to .ImpuestosComprobante.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemImpuestoventas" )
				this.SetearAtributoString( loItem, "Codigo", .ImpuestosComprobante.Item(lnI).Codigo)
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
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "FPERSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedescripcion", "FCLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "FVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecios", "CODLISTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Forpago", "FPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Motivo", "MOTIVO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Transportista", "FTRANSP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "FPTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadeentrega", "FFCHENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mercaderiaconsignacion", "MERCONSIGN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ajustesporredondeos", "FAJXRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajedescuento", "FPODES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuento", "FDESCU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodescuento3", "MD3")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), FOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargoporcentaje", "RECPOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto", "MR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto2", "MR2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Impuestos", "FIMPUESTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Totalimpuestos", "TOTIMPUE")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codlista LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fpago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Motivo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ftransp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine