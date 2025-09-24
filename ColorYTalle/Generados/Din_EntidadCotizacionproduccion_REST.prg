
define class Din_EntidadCotizacionproduccion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Cotizacionproduccion"
	cClaseResponse = this.cNamespaceDTOs + ".CotizacionproduccionResponse"
	cClaseModelo = "CotizacionproduccionModelo"
	cEntidad = "Cotizacionproduccion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CotizacionproduccionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CotizacionproduccionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CotizacionproduccionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CotizacionproduccionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CotizacionproduccionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Gestiondeproduccion", toEntidad, "Gestiondeproduccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendeproduccion", toEntidad, "Ordendeproduccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proceso", toEntidad, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Taller", toEntidad, "Taller_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadecosto", toEntidad, "Listadecosto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Generar", toEntidad, "Generar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letracomprobante", toEntidad, "Letracomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventacomprobante", toEntidad, "Puntodeventacomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocomprobante", toEntidad, "Numerocomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Insumos", toEntidad, "Insumos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descartes", toEntidad, "Descartes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observ", toEntidad, "Observ" )
			this.SetearDetalleCotizacionordenproduccion( toEntidad, toModeloEnRequest )
			this.SetearDetalleCotizacionordendescarte( toEntidad, toModeloEnRequest )
			this.SetearDetalleCotizacionordeninsumos( toEntidad, toModeloEnRequest )
			this.SetearDetalleCotizacionordenadicionales( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCotizacionOrdenProduccion( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CotizacionOrdenProduccion" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CotizacionOrdenProduccion[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CotizacionOrdenProduccion.LimpiarItem()
			else
				try
					toEntidad.CotizacionOrdenProduccion.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CotizacionOrdenProduccion.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaborado", toEntidad.CotizacionOrdenProduccion.oItem, "Semielaborado_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaboradodetalle", toEntidad.CotizacionOrdenProduccion.oItem, "SemielaboradoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.CotizacionOrdenProduccion.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.CotizacionOrdenProduccion.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.CotizacionOrdenProduccion.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.CotizacionOrdenProduccion.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.CotizacionOrdenProduccion.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.CotizacionOrdenProduccion.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.CotizacionOrdenProduccion.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.CotizacionOrdenProduccion.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.CotizacionOrdenProduccion.oItem, "Monto" )
			toEntidad.CotizacionOrdenProduccion.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCotizacionOrdenDescarte( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CotizacionOrdenDescarte" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CotizacionOrdenDescarte[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CotizacionOrdenDescarte.LimpiarItem()
			else
				try
					toEntidad.CotizacionOrdenDescarte.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CotizacionOrdenDescarte.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaborado", toEntidad.CotizacionOrdenDescarte.oItem, "Semielaborado_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaboradodetalle", toEntidad.CotizacionOrdenDescarte.oItem, "SemielaboradoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.CotizacionOrdenDescarte.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.CotizacionOrdenDescarte.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.CotizacionOrdenDescarte.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.CotizacionOrdenDescarte.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.CotizacionOrdenDescarte.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.CotizacionOrdenDescarte.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.CotizacionOrdenDescarte.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.CotizacionOrdenDescarte.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.CotizacionOrdenDescarte.oItem, "Monto" )
			toEntidad.CotizacionOrdenDescarte.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCotizacionOrdenInsumos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CotizacionOrdenInsumos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CotizacionOrdenInsumos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CotizacionOrdenInsumos.LimpiarItem()
			else
				try
					toEntidad.CotizacionOrdenInsumos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CotizacionOrdenInsumos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.CotizacionOrdenInsumos.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.CotizacionOrdenInsumos.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.CotizacionOrdenInsumos.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.CotizacionOrdenInsumos.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.CotizacionOrdenInsumos.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.CotizacionOrdenInsumos.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.CotizacionOrdenInsumos.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.CotizacionOrdenInsumos.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.CotizacionOrdenInsumos.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.CotizacionOrdenInsumos.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.CotizacionOrdenInsumos.oItem, "Monto" )
			toEntidad.CotizacionOrdenInsumos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCotizacionOrdenAdicionales( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CotizacionOrdenAdicionales" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CotizacionOrdenAdicionales[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CotizacionOrdenAdicionales.LimpiarItem()
			else
				try
					toEntidad.CotizacionOrdenAdicionales.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CotizacionOrdenAdicionales.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.CotizacionOrdenAdicionales.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.CotizacionOrdenAdicionales.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.CotizacionOrdenAdicionales.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.CotizacionOrdenAdicionales.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.CotizacionOrdenAdicionales.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.CotizacionOrdenAdicionales.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.CotizacionOrdenAdicionales.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.CotizacionOrdenAdicionales.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.CotizacionOrdenAdicionales.oItem, "Monto" )
			toEntidad.CotizacionOrdenAdicionales.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "GestionDeProduccion", toEntidad.GestionDeProduccion_PK)
			this.SetearAtributoString( toModeloResponse, "OrdenDeProduccion", toEntidad.OrdenDeProduccion_PK)
			this.SetearAtributoString( toModeloResponse, "Proceso", toEntidad.Proceso_PK)
			this.SetearAtributoString( toModeloResponse, "Taller", toEntidad.Taller_PK)
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDeCosto", toEntidad.ListaDeCosto_PK)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoInteger( toModeloResponse, "Generar", toEntidad.Generar)
			this.SetearAtributoString( toModeloResponse, "LetraComprobante", toEntidad.LetraComprobante)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaComprobante", toEntidad.PuntoDeVentaComprobante)
			this.SetearAtributoInteger( toModeloResponse, "NumeroComprobante", toEntidad.NumeroComprobante)
			this.SetearAtributoInteger( toModeloResponse, "Insumos", toEntidad.Insumos)
			this.SetearAtributoInteger( toModeloResponse, "Descartes", toEntidad.Descartes)
			this.SetearAtributo( toModeloResponse, "Observ", toEntidad.Observ)
			this.CargarColeccionModeloCotizacionOrdenProduccion( toModeloResponse, toEntidad )
			this.CargarColeccionModeloCotizacionOrdenDescarte( toModeloResponse, toEntidad )
			this.CargarColeccionModeloCotizacionOrdenInsumos( toModeloResponse, toEntidad )
			this.CargarColeccionModeloCotizacionOrdenAdicionales( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCotizacionOrdenProduccion( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CotizacionOrdenProduccion" ) 
		with toEntidad
			for lnI = 1 to .CotizacionOrdenProduccion.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCotizaordenproducc" )
				this.SetearAtributoString( loItem, "Codigo", .CotizacionOrdenProduccion.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Semielaborado", .CotizacionOrdenProduccion.Item(lnI).Semielaborado_PK)
				this.SetearAtributoString( loItem, "SemielaboradoDetalle", .CotizacionOrdenProduccion.Item(lnI).SemielaboradoDetalle)
				this.SetearAtributoString( loItem, "Color", .CotizacionOrdenProduccion.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .CotizacionOrdenProduccion.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .CotizacionOrdenProduccion.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .CotizacionOrdenProduccion.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .CotizacionOrdenProduccion.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Articulo", .CotizacionOrdenProduccion.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .CotizacionOrdenProduccion.Item(lnI).ArticuloDetalle)
				this.SetearAtributoDecimal( loItem, "Costo", .CotizacionOrdenProduccion.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .CotizacionOrdenProduccion.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .CotizacionOrdenProduccion.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCotizacionOrdenDescarte( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CotizacionOrdenDescarte" ) 
		with toEntidad
			for lnI = 1 to .CotizacionOrdenDescarte.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCotizaordendescarte" )
				this.SetearAtributoString( loItem, "Codigo", .CotizacionOrdenDescarte.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Semielaborado", .CotizacionOrdenDescarte.Item(lnI).Semielaborado_PK)
				this.SetearAtributoString( loItem, "SemielaboradoDetalle", .CotizacionOrdenDescarte.Item(lnI).SemielaboradoDetalle)
				this.SetearAtributoString( loItem, "Color", .CotizacionOrdenDescarte.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .CotizacionOrdenDescarte.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .CotizacionOrdenDescarte.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .CotizacionOrdenDescarte.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .CotizacionOrdenDescarte.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Articulo", .CotizacionOrdenDescarte.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .CotizacionOrdenDescarte.Item(lnI).ArticuloDetalle)
				this.SetearAtributoDecimal( loItem, "Costo", .CotizacionOrdenDescarte.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .CotizacionOrdenDescarte.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .CotizacionOrdenDescarte.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCotizacionOrdenInsumos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CotizacionOrdenInsumos" ) 
		with toEntidad
			for lnI = 1 to .CotizacionOrdenInsumos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCotizaordeninsumos" )
				this.SetearAtributoString( loItem, "Codigo", .CotizacionOrdenInsumos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Insumo", .CotizacionOrdenInsumos.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .CotizacionOrdenInsumos.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .CotizacionOrdenInsumos.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .CotizacionOrdenInsumos.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .CotizacionOrdenInsumos.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .CotizacionOrdenInsumos.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .CotizacionOrdenInsumos.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Articulo", .CotizacionOrdenInsumos.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .CotizacionOrdenInsumos.Item(lnI).ArticuloDetalle)
				this.SetearAtributoDecimal( loItem, "Costo", .CotizacionOrdenInsumos.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .CotizacionOrdenInsumos.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .CotizacionOrdenInsumos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCotizacionOrdenAdicionales( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CotizacionOrdenAdicionales" ) 
		with toEntidad
			for lnI = 1 to .CotizacionOrdenAdicionales.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCotizaordenadicion" )
				this.SetearAtributoString( loItem, "Codigo", .CotizacionOrdenAdicionales.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .CotizacionOrdenAdicionales.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .CotizacionOrdenAdicionales.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .CotizacionOrdenAdicionales.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .CotizacionOrdenAdicionales.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .CotizacionOrdenAdicionales.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .CotizacionOrdenAdicionales.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .CotizacionOrdenAdicionales.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Costo", .CotizacionOrdenAdicionales.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .CotizacionOrdenAdicionales.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .CotizacionOrdenAdicionales.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Gestiondeproduccion", "GESTIONPRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendeproduccion", "ORDENDEPRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proceso", "PROCESO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Taller", "TALLER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "PROVEEDOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadecosto", "LISTAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Moneda", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Generar", "GENERA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letracomprobante", "LETRACOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventacomprobante", "PUNTOCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocomprobante", "NUMEROCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Insumos", "INSUMOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descartes", "DESCARTES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observ", "CONVERT( VARCHAR(MAX), COBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Gestionpro LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ordendepro LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Proceso LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taller LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Proveedor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Listac LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Letracomp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine