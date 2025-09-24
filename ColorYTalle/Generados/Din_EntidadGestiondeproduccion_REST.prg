
define class Din_EntidadGestiondeproduccion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Gestiondeproduccion"
	cClaseResponse = this.cNamespaceDTOs + ".GestiondeproduccionResponse"
	cClaseModelo = "GestiondeproduccionModelo"
	cEntidad = "Gestiondeproduccion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "GestiondeproduccionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "GestiondeproduccionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "GestiondeproduccionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "GestiondeproduccionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "GestiondeproduccionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendeproduccion", toEntidad, "Ordendeproduccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proceso", toEntidad, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Taller", toEntidad, "Taller_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Inventarioorigen", toEntidad, "Inventarioorigen_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Inventariodestino", toEntidad, "Inventariodestino_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearDetalleGestioncurva( toEntidad, toModeloEnRequest )
			this.SetearDetalleGestioninsumos( toEntidad, toModeloEnRequest )
			this.SetearDetalleGestiondescartes( toEntidad, toModeloEnRequest )
			this.SetearDetalleGestioninsumosdescartes( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleGestionCurva( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "GestionCurva" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"GestionCurva[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.GestionCurva.LimpiarItem()
			else
				try
					toEntidad.GestionCurva.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.GestionCurva.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.GestionCurva.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.GestionCurva.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.GestionCurva.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.GestionCurva.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.GestionCurva.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.GestionCurva.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.GestionCurva.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.GestionCurva.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.GestionCurva.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.GestionCurva.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Partida", toEntidad.GestionCurva.oItem, "Partida" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantproducida", toEntidad.GestionCurva.oItem, "CantProducida" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantdescarte", toEntidad.GestionCurva.oItem, "CantDescarte" )
			toEntidad.GestionCurva.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleGestionInsumos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "GestionInsumos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"GestionInsumos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.GestionInsumos.LimpiarItem()
			else
				try
					toEntidad.GestionInsumos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.GestionInsumos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.GestionInsumos.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.GestionInsumos.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.GestionInsumos.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.GestionInsumos.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.GestionInsumos.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.GestionInsumos.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.GestionInsumos.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.GestionInsumos.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.GestionInsumos.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.GestionInsumos.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Partida", toEntidad.GestionInsumos.oItem, "Partida" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.GestionInsumos.oItem, "Cantidad" )
			toEntidad.GestionInsumos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleGestionDescartes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "GestionDescartes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"GestionDescartes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.GestionDescartes.LimpiarItem()
			else
				try
					toEntidad.GestionDescartes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.GestionDescartes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.GestionDescartes.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.GestionDescartes.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.GestionDescartes.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.GestionDescartes.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.GestionDescartes.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.GestionDescartes.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.GestionDescartes.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.GestionDescartes.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.GestionDescartes.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.GestionDescartes.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Partida", toEntidad.GestionDescartes.oItem, "Partida" )
			this.SetearAtributoModeloEnEntidad( loItem, "Motdescarte", toEntidad.GestionDescartes.oItem, "MotDescarte_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Motdescartedetalle", toEntidad.GestionDescartes.oItem, "MotDescarteDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Inventariodest", toEntidad.GestionDescartes.oItem, "InventarioDest_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Inventariodestdetalle", toEntidad.GestionDescartes.oItem, "InventarioDestDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantdescarte", toEntidad.GestionDescartes.oItem, "CantDescarte" )
			toEntidad.GestionDescartes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleGestionInsumosDescartes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "GestionInsumosDescartes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"GestionInsumosDescartes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.GestionInsumosDescartes.LimpiarItem()
			else
				try
					toEntidad.GestionInsumosDescartes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.GestionInsumosDescartes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.GestionInsumosDescartes.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.GestionInsumosDescartes.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.GestionInsumosDescartes.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.GestionInsumosDescartes.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.GestionInsumosDescartes.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.GestionInsumosDescartes.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.GestionInsumosDescartes.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.GestionInsumosDescartes.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.GestionInsumosDescartes.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.GestionInsumosDescartes.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Partida", toEntidad.GestionInsumosDescartes.oItem, "Partida" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.GestionInsumosDescartes.oItem, "Cantidad" )
			toEntidad.GestionInsumosDescartes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "OrdenDeProduccion", toEntidad.OrdenDeProduccion_PK)
			this.SetearAtributoString( toModeloResponse, "Proceso", toEntidad.Proceso_PK)
			this.SetearAtributoString( toModeloResponse, "Taller", toEntidad.Taller_PK)
			this.SetearAtributoString( toModeloResponse, "InventarioOrigen", toEntidad.InventarioOrigen_PK)
			this.SetearAtributoString( toModeloResponse, "InventarioDestino", toEntidad.InventarioDestino_PK)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.CargarColeccionModeloGestionCurva( toModeloResponse, toEntidad )
			this.CargarColeccionModeloGestionInsumos( toModeloResponse, toEntidad )
			this.CargarColeccionModeloGestionDescartes( toModeloResponse, toEntidad )
			this.CargarColeccionModeloGestionInsumosDescartes( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloGestionCurva( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "GestionCurva" ) 
		with toEntidad
			for lnI = 1 to .GestionCurva.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemGestioncurva" )
				this.SetearAtributoString( loItem, "Codigo", .GestionCurva.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .GestionCurva.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .GestionCurva.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "ColorM", .GestionCurva.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .GestionCurva.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .GestionCurva.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "Insumo", .GestionCurva.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .GestionCurva.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .GestionCurva.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .GestionCurva.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .GestionCurva.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "Partida", .GestionCurva.Item(lnI).Partida)
				this.SetearAtributoDecimal( loItem, "CantProducida", .GestionCurva.Item(lnI).CantProducida)
				this.SetearAtributoDecimal( loItem, "CantDescarte", .GestionCurva.Item(lnI).CantDescarte)
				this.SetearAtributoInteger( loItem, "NroItem", .GestionCurva.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloGestionInsumos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "GestionInsumos" ) 
		with toEntidad
			for lnI = 1 to .GestionInsumos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemGestioninsumo" )
				this.SetearAtributoString( loItem, "Codigo", .GestionInsumos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .GestionInsumos.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .GestionInsumos.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "ColorM", .GestionInsumos.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .GestionInsumos.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .GestionInsumos.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "Insumo", .GestionInsumos.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .GestionInsumos.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .GestionInsumos.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .GestionInsumos.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .GestionInsumos.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "Partida", .GestionInsumos.Item(lnI).Partida)
				this.SetearAtributoDecimal( loItem, "Cantidad", .GestionInsumos.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .GestionInsumos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloGestionDescartes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "GestionDescartes" ) 
		with toEntidad
			for lnI = 1 to .GestionDescartes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemGestiondescarte" )
				this.SetearAtributoString( loItem, "Codigo", .GestionDescartes.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .GestionDescartes.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .GestionDescartes.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "ColorM", .GestionDescartes.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .GestionDescartes.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .GestionDescartes.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "Insumo", .GestionDescartes.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .GestionDescartes.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .GestionDescartes.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .GestionDescartes.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .GestionDescartes.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "Partida", .GestionDescartes.Item(lnI).Partida)
				this.SetearAtributoString( loItem, "MotDescarte", .GestionDescartes.Item(lnI).MotDescarte_PK)
				this.SetearAtributoString( loItem, "MotDescarteDetalle", .GestionDescartes.Item(lnI).MotDescarteDetalle)
				this.SetearAtributoString( loItem, "InventarioDest", .GestionDescartes.Item(lnI).InventarioDest_PK)
				this.SetearAtributoString( loItem, "InventarioDestDetalle", .GestionDescartes.Item(lnI).InventarioDestDetalle)
				this.SetearAtributoDecimal( loItem, "CantDescarte", .GestionDescartes.Item(lnI).CantDescarte)
				this.SetearAtributoInteger( loItem, "NroItem", .GestionDescartes.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloGestionInsumosDescartes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "GestionInsumosDescartes" ) 
		with toEntidad
			for lnI = 1 to .GestionInsumosDescartes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemGestioninsdesc" )
				this.SetearAtributoString( loItem, "Codigo", .GestionInsumosDescartes.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .GestionInsumosDescartes.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .GestionInsumosDescartes.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "ColorM", .GestionInsumosDescartes.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .GestionInsumosDescartes.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .GestionInsumosDescartes.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "Insumo", .GestionInsumosDescartes.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .GestionInsumosDescartes.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .GestionInsumosDescartes.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .GestionInsumosDescartes.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .GestionInsumosDescartes.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "Partida", .GestionInsumosDescartes.Item(lnI).Partida)
				this.SetearAtributoDecimal( loItem, "Cantidad", .GestionInsumosDescartes.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .GestionInsumosDescartes.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendeproduccion", "ORDENDEPRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proceso", "PROCESO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Taller", "TALLER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Inventarioorigen", "INVENTORIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Inventariodestino", "INVENTDEST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ordendepro LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Proceso LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taller LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Inventorig LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Inventdest LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine