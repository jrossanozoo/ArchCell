
define class Din_EntidadLiquidaciondetaller_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Liquidaciondetaller"
	cClaseResponse = this.cNamespaceDTOs + ".LiquidaciondetallerResponse"
	cClaseModelo = "LiquidaciondetallerModelo"
	cEntidad = "Liquidaciondetaller"
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
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidaciondetallerModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidaciondetallerModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidaciondetallerListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidaciondetallerListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidaciondetallerModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Taller", toEntidad, "Taller_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadecosto", toEntidad, "Listadecosto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comprobante", toEntidad, "Comprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letracomprobante", toEntidad, "Letracomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventacomprobante", toEntidad, "Puntodeventacomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocomprobante", toEntidad, "Numerocomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendesde", toEntidad, "Ordendesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordenhasta", toEntidad, "Ordenhasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Procesodesde", toEntidad, "Procesodesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Procesohasta", toEntidad, "Procesohasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Gestiondesde", toEntidad, "Gestiondesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Gestionhasta", toEntidad, "Gestionhasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descartes", toEntidad, "Descartes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Insumos", toEntidad, "Insumos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observ", toEntidad, "Observ" )
			this.SetearDetalleLiquidaciontallerproduccion( toEntidad, toModeloEnRequest )
			this.SetearDetalleLiquidaciontallerdescarte( toEntidad, toModeloEnRequest )
			this.SetearDetalleLiquidaciontallerinsumos( toEntidad, toModeloEnRequest )
			this.SetearDetalleLiquidaciontalleradicionales( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleLiquidacionTallerProduccion( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "LiquidacionTallerProduccion" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"LiquidacionTallerProduccion[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.LiquidacionTallerProduccion.LimpiarItem()
			else
				try
					toEntidad.LiquidacionTallerProduccion.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.LiquidacionTallerProduccion.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.LiquidacionTallerProduccion.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Procesodetalle", toEntidad.LiquidacionTallerProduccion.oItem, "ProcesoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaborado", toEntidad.LiquidacionTallerProduccion.oItem, "Semielaborado_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaboradodetalle", toEntidad.LiquidacionTallerProduccion.oItem, "SemielaboradoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.LiquidacionTallerProduccion.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.LiquidacionTallerProduccion.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.LiquidacionTallerProduccion.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.LiquidacionTallerProduccion.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.LiquidacionTallerProduccion.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.LiquidacionTallerProduccion.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.LiquidacionTallerProduccion.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.LiquidacionTallerProduccion.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.LiquidacionTallerProduccion.oItem, "Monto" )
			toEntidad.LiquidacionTallerProduccion.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleLiquidacionTallerDescarte( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "LiquidacionTallerDescarte" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"LiquidacionTallerDescarte[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.LiquidacionTallerDescarte.LimpiarItem()
			else
				try
					toEntidad.LiquidacionTallerDescarte.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.LiquidacionTallerDescarte.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.LiquidacionTallerDescarte.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Procesodetalle", toEntidad.LiquidacionTallerDescarte.oItem, "ProcesoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaborado", toEntidad.LiquidacionTallerDescarte.oItem, "Semielaborado_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaboradodetalle", toEntidad.LiquidacionTallerDescarte.oItem, "SemielaboradoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.LiquidacionTallerDescarte.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.LiquidacionTallerDescarte.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.LiquidacionTallerDescarte.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.LiquidacionTallerDescarte.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.LiquidacionTallerDescarte.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.LiquidacionTallerDescarte.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.LiquidacionTallerDescarte.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.LiquidacionTallerDescarte.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.LiquidacionTallerDescarte.oItem, "Monto" )
			toEntidad.LiquidacionTallerDescarte.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleLiquidacionTallerInsumos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "LiquidacionTallerInsumos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"LiquidacionTallerInsumos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.LiquidacionTallerInsumos.LimpiarItem()
			else
				try
					toEntidad.LiquidacionTallerInsumos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.LiquidacionTallerInsumos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.LiquidacionTallerInsumos.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Procesodetalle", toEntidad.LiquidacionTallerInsumos.oItem, "ProcesoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.LiquidacionTallerInsumos.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.LiquidacionTallerInsumos.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.LiquidacionTallerInsumos.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.LiquidacionTallerInsumos.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.LiquidacionTallerInsumos.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.LiquidacionTallerInsumos.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.LiquidacionTallerInsumos.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.LiquidacionTallerInsumos.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.LiquidacionTallerInsumos.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.LiquidacionTallerInsumos.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.LiquidacionTallerInsumos.oItem, "Monto" )
			toEntidad.LiquidacionTallerInsumos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleLiquidacionTallerAdicionales( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "LiquidacionTallerAdicionales" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"LiquidacionTallerAdicionales[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.LiquidacionTallerAdicionales.LimpiarItem()
			else
				try
					toEntidad.LiquidacionTallerAdicionales.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.LiquidacionTallerAdicionales.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.LiquidacionTallerAdicionales.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.LiquidacionTallerAdicionales.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.LiquidacionTallerAdicionales.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costo", toEntidad.LiquidacionTallerAdicionales.oItem, "Costo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.LiquidacionTallerAdicionales.oItem, "Monto" )
			toEntidad.LiquidacionTallerAdicionales.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Taller", toEntidad.Taller_PK)
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDeCosto", toEntidad.ListaDeCosto_PK)
			this.SetearAtributoString( toModeloResponse, "Comprobante", toEntidad.Comprobante)
			this.SetearAtributoString( toModeloResponse, "LetraComprobante", toEntidad.LetraComprobante)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaComprobante", toEntidad.PuntoDeVentaComprobante)
			this.SetearAtributoInteger( toModeloResponse, "NumeroComprobante", toEntidad.NumeroComprobante)
			this.SetearAtributoString( toModeloResponse, "OrdenDesde", toEntidad.OrdenDesde)
			this.SetearAtributoString( toModeloResponse, "OrdenHasta", toEntidad.OrdenHasta)
			this.SetearAtributoString( toModeloResponse, "ProcesoDesde", toEntidad.ProcesoDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ProcesoHasta", toEntidad.ProcesoHasta_PK)
			this.SetearAtributoString( toModeloResponse, "GestionDesde", toEntidad.GestionDesde)
			this.SetearAtributoString( toModeloResponse, "GestionHasta", toEntidad.GestionHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoInteger( toModeloResponse, "Descartes", toEntidad.Descartes)
			this.SetearAtributoInteger( toModeloResponse, "Insumos", toEntidad.Insumos)
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
			this.SetearAtributo( toModeloResponse, "Observ", toEntidad.Observ)
			this.CargarColeccionModeloLiquidacionTallerProduccion( toModeloResponse, toEntidad )
			this.CargarColeccionModeloLiquidacionTallerDescarte( toModeloResponse, toEntidad )
			this.CargarColeccionModeloLiquidacionTallerInsumos( toModeloResponse, toEntidad )
			this.CargarColeccionModeloLiquidacionTallerAdicionales( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloLiquidacionTallerProduccion( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "LiquidacionTallerProduccion" ) 
		with toEntidad
			for lnI = 1 to .LiquidacionTallerProduccion.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemLiqtallerproduccion" )
				this.SetearAtributoString( loItem, "Codigo", .LiquidacionTallerProduccion.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Proceso", .LiquidacionTallerProduccion.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ProcesoDetalle", .LiquidacionTallerProduccion.Item(lnI).ProcesoDetalle)
				this.SetearAtributoString( loItem, "Semielaborado", .LiquidacionTallerProduccion.Item(lnI).Semielaborado_PK)
				this.SetearAtributoString( loItem, "SemielaboradoDetalle", .LiquidacionTallerProduccion.Item(lnI).SemielaboradoDetalle)
				this.SetearAtributoString( loItem, "Color", .LiquidacionTallerProduccion.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .LiquidacionTallerProduccion.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .LiquidacionTallerProduccion.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .LiquidacionTallerProduccion.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .LiquidacionTallerProduccion.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Articulo", .LiquidacionTallerProduccion.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .LiquidacionTallerProduccion.Item(lnI).ArticuloDetalle)
				this.SetearAtributoDecimal( loItem, "Costo", .LiquidacionTallerProduccion.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .LiquidacionTallerProduccion.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .LiquidacionTallerProduccion.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloLiquidacionTallerDescarte( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "LiquidacionTallerDescarte" ) 
		with toEntidad
			for lnI = 1 to .LiquidacionTallerDescarte.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemLiqtallerdescarte" )
				this.SetearAtributoString( loItem, "Codigo", .LiquidacionTallerDescarte.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Proceso", .LiquidacionTallerDescarte.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ProcesoDetalle", .LiquidacionTallerDescarte.Item(lnI).ProcesoDetalle)
				this.SetearAtributoString( loItem, "Semielaborado", .LiquidacionTallerDescarte.Item(lnI).Semielaborado_PK)
				this.SetearAtributoString( loItem, "SemielaboradoDetalle", .LiquidacionTallerDescarte.Item(lnI).SemielaboradoDetalle)
				this.SetearAtributoString( loItem, "Color", .LiquidacionTallerDescarte.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .LiquidacionTallerDescarte.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .LiquidacionTallerDescarte.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .LiquidacionTallerDescarte.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .LiquidacionTallerDescarte.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Articulo", .LiquidacionTallerDescarte.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .LiquidacionTallerDescarte.Item(lnI).ArticuloDetalle)
				this.SetearAtributoDecimal( loItem, "Costo", .LiquidacionTallerDescarte.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .LiquidacionTallerDescarte.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .LiquidacionTallerDescarte.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloLiquidacionTallerInsumos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "LiquidacionTallerInsumos" ) 
		with toEntidad
			for lnI = 1 to .LiquidacionTallerInsumos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemLiqtallerinsumos" )
				this.SetearAtributoString( loItem, "Codigo", .LiquidacionTallerInsumos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Proceso", .LiquidacionTallerInsumos.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ProcesoDetalle", .LiquidacionTallerInsumos.Item(lnI).ProcesoDetalle)
				this.SetearAtributoString( loItem, "Insumo", .LiquidacionTallerInsumos.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .LiquidacionTallerInsumos.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .LiquidacionTallerInsumos.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .LiquidacionTallerInsumos.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .LiquidacionTallerInsumos.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .LiquidacionTallerInsumos.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .LiquidacionTallerInsumos.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Articulo", .LiquidacionTallerInsumos.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .LiquidacionTallerInsumos.Item(lnI).ArticuloDetalle)
				this.SetearAtributoDecimal( loItem, "Costo", .LiquidacionTallerInsumos.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .LiquidacionTallerInsumos.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .LiquidacionTallerInsumos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloLiquidacionTallerAdicionales( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "LiquidacionTallerAdicionales" ) 
		with toEntidad
			for lnI = 1 to .LiquidacionTallerAdicionales.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemLiqtalleradicional" )
				this.SetearAtributoString( loItem, "Codigo", .LiquidacionTallerAdicionales.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .LiquidacionTallerAdicionales.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .LiquidacionTallerAdicionales.Item(lnI).ArticuloDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .LiquidacionTallerAdicionales.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Costo", .LiquidacionTallerAdicionales.Item(lnI).Costo)
				this.SetearAtributoDecimal( loItem, "Monto", .LiquidacionTallerAdicionales.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .LiquidacionTallerAdicionales.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Taller", "TALLER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "PROVEEDOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Moneda", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadecosto", "LISTACOSTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comprobante", "COMPROB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letracomprobante", "LETRACOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventacomprobante", "PUNTOCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocomprobante", "NUMEROCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendesde", "ORDENDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordenhasta", "ORDENHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Procesodesde", "PROCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Procesohasta", "PROCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Gestiondesde", "GESTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Gestionhasta", "GESTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FECDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FECHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descartes", "DESCARTES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Insumos", "INSUMOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Total", "FTOTAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observ", "CONVERT( VARCHAR(MAX), COBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taller LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Proveedor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Listacosto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Comprob LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Letracomp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ordendesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ordenhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Procdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prochasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Gestdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Gesthasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine