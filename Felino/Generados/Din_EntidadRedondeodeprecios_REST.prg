
define class Din_EntidadRedondeodeprecios_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Redondeodeprecios"
	cClaseResponse = this.cNamespaceDTOs + ".RedondeodepreciosResponse"
	cClaseModelo = "RedondeodepreciosModelo"
	cEntidad = "Redondeodeprecios"
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
				lcRetorno = this.cNamespaceDTOs + "." + "RedondeodepreciosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "RedondeodepreciosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "RedondeodepreciosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "RedondeodepreciosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "RedondeodepreciosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitaredondearnormal", toEntidad, "Habilitaredondearnormal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Redondeonormal", toEntidad, "Redondeonormal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitaredonearprecios", toEntidad, "Habilitaredonearprecios" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Redondeoportabla", toEntidad, "Redondeoportabla" )
			this.SetearDetalleDetredondeoportabla( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitaredondeartermcentavos", toEntidad, "Habilitaredondeartermcentavos" )
			this.SetearDetalleDetredondeoporcentavo( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitaredondeartermenteros", toEntidad, "Habilitaredondeartermenteros" )
			this.SetearDetalleDetredondeoporentero( toEntidad, toModeloEnRequest )
			this.SetearDetalleDetprueba( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetRedondeoPorTabla( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetRedondeoPorTabla" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetRedondeoPorTabla[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetRedondeoPorTabla.LimpiarItem()
			else
				try
					toEntidad.DetRedondeoPorTabla.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetRedondeoPorTabla.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Redondearen", toEntidad.DetRedondeoPorTabla.oItem, "RedondearEn" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desdeprecio", toEntidad.DetRedondeoPorTabla.oItem, "DesdePrecio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hastaprecio", toEntidad.DetRedondeoPorTabla.oItem, "HastaPrecio" )
			toEntidad.DetRedondeoPorTabla.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetRedondeoPorCentavo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetRedondeoPorCentavo" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetRedondeoPorCentavo[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetRedondeoPorCentavo.LimpiarItem()
			else
				try
					toEntidad.DetRedondeoPorCentavo.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetRedondeoPorCentavo.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Terminacioncaracter", toEntidad.DetRedondeoPorCentavo.oItem, "TerminacionCaracter" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desde", toEntidad.DetRedondeoPorCentavo.oItem, "Desde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hasta", toEntidad.DetRedondeoPorCentavo.oItem, "Hasta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desdeprecio", toEntidad.DetRedondeoPorCentavo.oItem, "DesdePrecio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hastaprecio", toEntidad.DetRedondeoPorCentavo.oItem, "HastaPrecio" )
			toEntidad.DetRedondeoPorCentavo.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetRedondeoPorEntero( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetRedondeoPorEntero" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetRedondeoPorEntero[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetRedondeoPorEntero.LimpiarItem()
			else
				try
					toEntidad.DetRedondeoPorEntero.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetRedondeoPorEntero.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Terminacioncaracter", toEntidad.DetRedondeoPorEntero.oItem, "TerminacionCaracter" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desde", toEntidad.DetRedondeoPorEntero.oItem, "Desde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hasta", toEntidad.DetRedondeoPorEntero.oItem, "Hasta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desdeprecio", toEntidad.DetRedondeoPorEntero.oItem, "DesdePrecio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hastaprecio", toEntidad.DetRedondeoPorEntero.oItem, "HastaPrecio" )
			toEntidad.DetRedondeoPorEntero.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalledetPrueba( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "detPrueba" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"detPrueba[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.detPrueba.LimpiarItem()
			else
				try
					toEntidad.detPrueba.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.detPrueba.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.detPrueba.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Resultado", toEntidad.detPrueba.oItem, "Resultado" )
			toEntidad.detPrueba.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "codigo", toEntidad.codigo)
			this.SetearAtributoString( toModeloResponse, "descripcion", toEntidad.descripcion)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributo( toModeloResponse, "HabilitaRedondearNormal", toEntidad.HabilitaRedondearNormal)
			this.SetearAtributoInteger( toModeloResponse, "redondeonormal", toEntidad.redondeonormal)
			this.SetearAtributo( toModeloResponse, "HabilitaRedonearPrecios", toEntidad.HabilitaRedonearPrecios)
			this.SetearAtributoInteger( toModeloResponse, "redondeoportabla", toEntidad.redondeoportabla)
			this.CargarColeccionModeloDetRedondeoPorTabla( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "HabilitaRedondearTermCentavos", toEntidad.HabilitaRedondearTermCentavos)
			this.CargarColeccionModeloDetRedondeoPorCentavo( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "HabilitaRedondearTermEnteros", toEntidad.HabilitaRedondearTermEnteros)
			this.CargarColeccionModeloDetRedondeoPorEntero( toModeloResponse, toEntidad )
			this.CargarColeccionModelodetPrueba( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetRedondeoPorTabla( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetRedondeoPorTabla" ) 
		with toEntidad
			for lnI = 1 to .DetRedondeoPorTabla.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRedondeotabla" )
				this.SetearAtributoString( loItem, "codigo", .DetRedondeoPorTabla.Item(lnI).codigo)
				this.SetearAtributoDecimal( loItem, "RedondearEn", .DetRedondeoPorTabla.Item(lnI).RedondearEn)
				this.SetearAtributoDecimal( loItem, "DesdePrecio", .DetRedondeoPorTabla.Item(lnI).DesdePrecio)
				this.SetearAtributoDecimal( loItem, "HastaPrecio", .DetRedondeoPorTabla.Item(lnI).HastaPrecio)
				this.SetearAtributoInteger( loItem, "NroItem", .DetRedondeoPorTabla.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetRedondeoPorCentavo( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetRedondeoPorCentavo" ) 
		with toEntidad
			for lnI = 1 to .DetRedondeoPorCentavo.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRedondeocentavos" )
				this.SetearAtributoString( loItem, "Codigo", .DetRedondeoPorCentavo.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "TerminacionCaracter", .DetRedondeoPorCentavo.Item(lnI).TerminacionCaracter)
				this.SetearAtributoInteger( loItem, "Desde", .DetRedondeoPorCentavo.Item(lnI).Desde)
				this.SetearAtributoInteger( loItem, "Hasta", .DetRedondeoPorCentavo.Item(lnI).Hasta)
				this.SetearAtributoDecimal( loItem, "DesdePrecio", .DetRedondeoPorCentavo.Item(lnI).DesdePrecio)
				this.SetearAtributoDecimal( loItem, "HastaPrecio", .DetRedondeoPorCentavo.Item(lnI).HastaPrecio)
				this.SetearAtributoInteger( loItem, "NroItem", .DetRedondeoPorCentavo.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetRedondeoPorEntero( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetRedondeoPorEntero" ) 
		with toEntidad
			for lnI = 1 to .DetRedondeoPorEntero.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRedondeoenteros" )
				this.SetearAtributoString( loItem, "Codigo", .DetRedondeoPorEntero.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "TerminacionCaracter", .DetRedondeoPorEntero.Item(lnI).TerminacionCaracter)
				this.SetearAtributoLong( loItem, "Desde", .DetRedondeoPorEntero.Item(lnI).Desde)
				this.SetearAtributoLong( loItem, "Hasta", .DetRedondeoPorEntero.Item(lnI).Hasta)
				this.SetearAtributoDecimal( loItem, "DesdePrecio", .DetRedondeoPorEntero.Item(lnI).DesdePrecio)
				this.SetearAtributoDecimal( loItem, "HastaPrecio", .DetRedondeoPorEntero.Item(lnI).HastaPrecio)
				this.SetearAtributoInteger( loItem, "NroItem", .DetRedondeoPorEntero.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModelodetPrueba( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "detPrueba" ) 
		with toEntidad
			for lnI = 1 to .detPrueba.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPruebaredondeo" )
				this.SetearAtributoString( loItem, "Codigo", .detPrueba.Item(lnI).Codigo)
				this.SetearAtributoDecimal( loItem, "Precio", .detPrueba.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Resultado", .detPrueba.Item(lnI).Resultado)
				this.SetearAtributoInteger( loItem, "NroItem", .detPrueba.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), ROBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitaredondearnormal", "REDOENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Redondeonormal", "RNORMAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitaredonearprecios", "REDOPRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Redondeoportabla", "RTABLA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitaredondeartermcentavos", "REDOTCENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitaredondeartermenteros", "REDOTENT")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Robs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine