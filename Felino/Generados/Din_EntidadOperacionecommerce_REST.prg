
define class Din_EntidadOperacionecommerce_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Operacionecommerce"
	cClaseResponse = this.cNamespaceDTOs + ".OperacionecommerceResponse"
	cClaseModelo = "OperacionecommerceModelo"
	cEntidad = "Operacionecommerce"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OperacionecommerceModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "OperacionecommerceModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "OperacionecommerceListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OperacionecommerceListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "OperacionecommerceModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ecommerce", toEntidad, "Ecommerce_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clienteecom", toEntidad, "Clienteecom_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedragon", toEntidad, "Clientedragon_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosenvio", toEntidad, "Datosenvio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefonoenvio", toEntidad, "Telefonoenvio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datospago", toEntidad, "Datospago" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pagado", toEntidad, "Pagado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Hora", toEntidad, "Hora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mlfullenvios", toEntidad, "Mlfullenvios" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Packid", toEntidad, "Packid" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadepago", toEntidad, "Fechadepago" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Linkoperacionecommerce", toEntidad, "Linkoperacionecommerce" )
			this.SetearDetallePublicaciondetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuentoporcentaje", toEntidad, "Descuentoporcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuentomonto", toEntidad, "Descuentomonto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuentomonto2", toEntidad, "Descuentomonto2" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargoporcentaje", toEntidad, "Recargoporcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto", toEntidad, "Recargomonto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto2", toEntidad, "Recargomonto2" )
			this.SetearDetalleValoresdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Zadsfw", toEntidad, "Zadsfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
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
	protected function SetearDetallePublicacionDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "PublicacionDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"PublicacionDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.PublicacionDetalle.LimpiarItem()
			else
				try
					toEntidad.PublicacionDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.PublicacionDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Idpublicacion", toEntidad.PublicacionDetalle.oItem, "IDPublicacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.PublicacionDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.PublicacionDetalle.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.PublicacionDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.PublicacionDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.PublicacionDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.PublicacionDetalle.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.PublicacionDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.PublicacionDetalle.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.PublicacionDetalle.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.PublicacionDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuento", toEntidad.PublicacionDetalle.oItem, "MontoDescuento" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechacancelacion", toEntidad.PublicacionDetalle.oItem, "FechaCancelacion" )
			toEntidad.PublicacionDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleValoresDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
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
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.ValoresDetalle.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.ValoresDetalle.oItem, "ValorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recibido", toEntidad.ValoresDetalle.oItem, "Recibido" )
			toEntidad.ValoresDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.CargarColeccionModeloCompAfec( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Ecommerce", toEntidad.Ecommerce_PK)
			this.SetearAtributoString( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "ClienteEcom", toEntidad.ClienteEcom_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteDragon", toEntidad.ClienteDragon_PK)
			this.SetearAtributoString( toModeloResponse, "DatosEnvio", toEntidad.DatosEnvio)
			this.SetearAtributoString( toModeloResponse, "TelefonoEnvio", toEntidad.TelefonoEnvio)
			this.SetearAtributoString( toModeloResponse, "DatosPago", toEntidad.DatosPago)
			this.SetearAtributo( toModeloResponse, "Pagado", toEntidad.Pagado)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Hora", toEntidad.Hora)
			this.SetearAtributo( toModeloResponse, "MLFullEnvios", toEntidad.MLFullEnvios)
			this.SetearAtributoString( toModeloResponse, "PackId", toEntidad.PackId)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDePago", toEntidad.FechaDePago)
			this.SetearAtributoString( toModeloResponse, "LinkOperacionEcommerce", toEntidad.LinkOperacionEcommerce)
			this.CargarColeccionModeloPublicacionDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "DescuentoPorcentaje", toEntidad.DescuentoPorcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "DescuentoMonto", toEntidad.DescuentoMonto)
			this.SetearAtributoDecimal( toModeloResponse, "DescuentoMonto2", toEntidad.DescuentoMonto2)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoPorcentaje", toEntidad.RecargoPorcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto", toEntidad.RecargoMonto)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto2", toEntidad.RecargoMonto2)
			this.CargarColeccionModeloValoresDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
			this.SetearAtributo( toModeloResponse, "ZADSFW", toEntidad.ZADSFW)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
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
	protected function CargarColeccionModeloPublicacionDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "PublicacionDetalle" ) 
		with toEntidad
			for lnI = 1 to .PublicacionDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPublicacionecom" )
				this.SetearAtributoString( loItem, "Codigo", .PublicacionDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "IDPublicacion", .PublicacionDetalle.Item(lnI).IDPublicacion)
				this.SetearAtributoString( loItem, "Descripcion", .PublicacionDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Articulo", .PublicacionDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .PublicacionDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .PublicacionDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .PublicacionDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .PublicacionDetalle.Item(lnI).Talle)
				this.SetearAtributoLong( loItem, "Cantidad", .PublicacionDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Precio", .PublicacionDetalle.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Descuento", .PublicacionDetalle.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "Monto", .PublicacionDetalle.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "MontoDescuento", .PublicacionDetalle.Item(lnI).MontoDescuento)
				this.SetearAtributoDatetime( loItem, "FechaCancelacion", .PublicacionDetalle.Item(lnI).FechaCancelacion)
				this.SetearAtributoInteger( loItem, "NroItem", .PublicacionDetalle.Item(lnI).NroItem )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemValoropeecom" )
				this.SetearAtributoString( loItem, "Codigo", .ValoresDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Valor", .ValoresDetalle.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .ValoresDetalle.Item(lnI).ValorDetalle)
				this.SetearAtributoDecimal( loItem, "Recibido", .ValoresDetalle.Item(lnI).Recibido)
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
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ecommerce", "ECOMMERCE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clienteecom", "CLIECOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedragon", "CLIEDRAGON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datosenvio", "ENVIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefonoenvio", "TELENVIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datospago", "PAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pagado", "PAGADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Hora", "HORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mlfullenvios", "MLFULLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Packid", "PACKID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadepago", "FPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Linkoperacionecommerce", "URLECOMM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuentoporcentaje", "PODESC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuentomonto", "MONDESC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuentomonto2", "MONDES2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargoporcentaje", "PORREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto", "MONREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto2", "MONREC2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Total", "OPTOTAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Zadsfw", "CONVERT( VARCHAR(MAX), ZADSFW)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ecommerce LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Numero LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliecom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliedragon LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Envio LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Telenvio LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Pago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Packid LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Urlecomm LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Zadsfw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine