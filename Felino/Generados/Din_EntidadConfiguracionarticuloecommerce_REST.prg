
define class Din_EntidadConfiguracionarticuloecommerce_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Configuracionarticuloecommerce"
	cClaseResponse = this.cNamespaceDTOs + ".ConfiguracionarticuloecommerceResponse"
	cClaseModelo = "ConfiguracionarticuloecommerceModelo"
	cEntidad = "Configuracionarticuloecommerce"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ConfiguracionarticuloecommerceModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ConfiguracionarticuloecommerceModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ConfiguracionarticuloecommerceListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ConfiguracionarticuloecommerceListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ConfiguracionarticuloecommerceModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulo", toEntidad, "Articulo_PK" )
			this.SetearDetalleCategoriasecom( toEntidad, toModeloEnRequest )
			this.SetearDetalleEtiquetasecom( toEntidad, toModeloEnRequest )
			this.SetearDetalleDimensionesecom( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCategoriasEcom( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CategoriasEcom" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CategoriasEcom[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CategoriasEcom.LimpiarItem()
			else
				try
					toEntidad.CategoriasEcom.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CategoriasEcom.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Plataforma", toEntidad.CategoriasEcom.oItem, "Plataforma_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codcategoria", toEntidad.CategoriasEcom.oItem, "CodCategoria_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desccategoria", toEntidad.CategoriasEcom.oItem, "DescCategoria" )
			toEntidad.CategoriasEcom.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleEtiquetasEcom( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "EtiquetasEcom" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"EtiquetasEcom[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.EtiquetasEcom.LimpiarItem()
			else
				try
					toEntidad.EtiquetasEcom.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.EtiquetasEcom.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Plataforma", toEntidad.EtiquetasEcom.oItem, "Plataforma_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codetiqueta", toEntidad.EtiquetasEcom.oItem, "CodEtiqueta_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descetiqueta", toEntidad.EtiquetasEcom.oItem, "DescEtiqueta" )
			toEntidad.EtiquetasEcom.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDimensionesEcom( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DimensionesEcom" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DimensionesEcom[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DimensionesEcom.LimpiarItem()
			else
				try
					toEntidad.DimensionesEcom.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DimensionesEcom.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.DimensionesEcom.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.DimensionesEcom.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.DimensionesEcom.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Peso", toEntidad.DimensionesEcom.oItem, "Peso" )
			this.SetearAtributoModeloEnEntidad( loItem, "Largo", toEntidad.DimensionesEcom.oItem, "Largo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Ancho", toEntidad.DimensionesEcom.oItem, "Ancho" )
			this.SetearAtributoModeloEnEntidad( loItem, "Alto", toEntidad.DimensionesEcom.oItem, "Alto" )
			toEntidad.DimensionesEcom.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Articulo", toEntidad.Articulo_PK)
			this.CargarColeccionModeloCategoriasEcom( toModeloResponse, toEntidad )
			this.CargarColeccionModeloEtiquetasEcom( toModeloResponse, toEntidad )
			this.CargarColeccionModeloDimensionesEcom( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCategoriasEcom( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CategoriasEcom" ) 
		with toEntidad
			for lnI = 1 to .CategoriasEcom.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCategoriasecom" )
				this.SetearAtributoString( loItem, "Codigo", .CategoriasEcom.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Plataforma", .CategoriasEcom.Item(lnI).Plataforma_PK)
				this.SetearAtributoString( loItem, "CodCategoria", .CategoriasEcom.Item(lnI).CodCategoria_PK)
				this.SetearAtributoString( loItem, "DescCategoria", .CategoriasEcom.Item(lnI).DescCategoria)
				this.SetearAtributoInteger( loItem, "NroItem", .CategoriasEcom.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloEtiquetasEcom( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "EtiquetasEcom" ) 
		with toEntidad
			for lnI = 1 to .EtiquetasEcom.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemEtiquetasecom" )
				this.SetearAtributoString( loItem, "Codigo", .EtiquetasEcom.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Plataforma", .EtiquetasEcom.Item(lnI).Plataforma_PK)
				this.SetearAtributoString( loItem, "CodEtiqueta", .EtiquetasEcom.Item(lnI).CodEtiqueta_PK)
				this.SetearAtributoString( loItem, "DescEtiqueta", .EtiquetasEcom.Item(lnI).DescEtiqueta)
				this.SetearAtributoInteger( loItem, "NroItem", .EtiquetasEcom.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDimensionesEcom( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DimensionesEcom" ) 
		with toEntidad
			for lnI = 1 to .DimensionesEcom.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDimensionesecom" )
				this.SetearAtributoString( loItem, "Codigo", .DimensionesEcom.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Color", .DimensionesEcom.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .DimensionesEcom.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .DimensionesEcom.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "Peso", .DimensionesEcom.Item(lnI).Peso)
				this.SetearAtributoDecimal( loItem, "Largo", .DimensionesEcom.Item(lnI).Largo)
				this.SetearAtributoDecimal( loItem, "Ancho", .DimensionesEcom.Item(lnI).Ancho)
				this.SetearAtributoDecimal( loItem, "Alto", .DimensionesEcom.Item(lnI).Alto)
				this.SetearAtributoInteger( loItem, "NroItem", .DimensionesEcom.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulo", "ARTIC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artic LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine