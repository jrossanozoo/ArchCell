
define class Din_EntidadMoneda_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Moneda"
	cClaseResponse = this.cNamespaceDTOs + ".MonedaResponse"
	cClaseModelo = "MonedaModelo"
	cEntidad = "Moneda"
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
				lcRetorno = this.cNamespaceDTOs + "." + "MonedaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "MonedaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "MonedaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "MonedaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "MonedaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Simbolo", toEntidad, "Simbolo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Equivalenciaafip", toEntidad, "Equivalenciaafip_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Equivalenciadgi", toEntidad, "Equivalenciadgi" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacotizacionafip", toEntidad, "Monedacotizacionafip_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cargaobligatoria", toEntidad, "Cargaobligatoria" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Toleranciapositiva", toEntidad, "Toleranciapositiva" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tolerancianegativa", toEntidad, "Tolerancianegativa" )
			this.SetearDetalleCotizaciones( toEntidad, toModeloEnRequest )
			this.SetearDetalleDenominaciones( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAgrupublidetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Agrupublidetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Agrupublidetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Agrupublidetalle.LimpiarItem()
			else
				try
					toEntidad.Agrupublidetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Agrupublidetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.Agrupublidetalle.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCotizaciones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Cotizaciones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Cotizaciones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Cotizaciones.LimpiarItem()
			else
				try
					toEntidad.Cotizaciones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Cotizaciones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.Cotizaciones.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hora", toEntidad.Cotizaciones.oItem, "Hora" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cotizacion", toEntidad.Cotizaciones.oItem, "Cotizacion" )
			toEntidad.Cotizaciones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDenominaciones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Denominaciones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Denominaciones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Denominaciones.LimpiarItem()
			else
				try
					toEntidad.Denominaciones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Denominaciones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.Denominaciones.oItem, "Valor" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.Denominaciones.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descri", toEntidad.Denominaciones.oItem, "Descri" )
			this.SetearAtributoModeloEnEntidad( loItem, "Orden", toEntidad.Denominaciones.oItem, "Orden" )
			toEntidad.Denominaciones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "Simbolo", toEntidad.Simbolo)
			this.SetearAtributoString( toModeloResponse, "EquivalenciaAfip", toEntidad.EquivalenciaAfip_PK)
			this.SetearAtributoString( toModeloResponse, "EquivalenciaDGI", toEntidad.EquivalenciaDGI)
			this.SetearAtributoString( toModeloResponse, "MonedaCotizacionAFIP", toEntidad.MonedaCotizacionAFIP_PK)
			this.SetearAtributo( toModeloResponse, "CargaObligatoria", toEntidad.CargaObligatoria)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoDecimal( toModeloResponse, "ToleranciaPositiva", toEntidad.ToleranciaPositiva)
			this.SetearAtributoDecimal( toModeloResponse, "ToleranciaNegativa", toEntidad.ToleranciaNegativa)
			this.CargarColeccionModeloCotizaciones( toModeloResponse, toEntidad )
			this.CargarColeccionModeloDenominaciones( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAgrupublidetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Agrupublidetalle" ) 
		with toEntidad
			for lnI = 1 to .Agrupublidetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAgrupapublic" )
				this.SetearAtributoString( loItem, "Codigo", .Agrupublidetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Agrupamiento", .Agrupublidetalle.Item(lnI).Agrupamiento_PK)
				this.SetearAtributoString( loItem, "AgrupamientoDetalle", .Agrupublidetalle.Item(lnI).AgrupamientoDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .Agrupublidetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCotizaciones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Cotizaciones" ) 
		with toEntidad
			for lnI = 1 to .Cotizaciones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemMoneda" )
				this.SetearAtributoString( loItem, "Codigo", .Cotizaciones.Item(lnI).Codigo)
				this.SetearAtributoDatetime( loItem, "Fecha", .Cotizaciones.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Hora", .Cotizaciones.Item(lnI).Hora)
				this.SetearAtributoDecimal( loItem, "Cotizacion", .Cotizaciones.Item(lnI).Cotizacion)
				this.SetearAtributoInteger( loItem, "NroItem", .Cotizaciones.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDenominaciones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Denominaciones" ) 
		with toEntidad
			for lnI = 1 to .Denominaciones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDenominaciones" )
				this.SetearAtributoString( loItem, "Codigo", .Denominaciones.Item(lnI).Codigo)
				this.SetearAtributoDecimal( loItem, "Valor", .Denominaciones.Item(lnI).Valor)
				this.SetearAtributoString( loItem, "Tipo", .Denominaciones.Item(lnI).Tipo)
				this.SetearAtributoString( loItem, "Descri", .Denominaciones.Item(lnI).Descri)
				this.SetearAtributoInteger( loItem, "Orden", .Denominaciones.Item(lnI).Orden)
				this.SetearAtributoInteger( loItem, "NroItem", .Denominaciones.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoagrupamientopublicaciones", "TIPAGRUPUB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Simbolo", "SIMBOLO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Equivalenciaafip", "EAFIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Equivalenciadgi", "EDGI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monedacotizacionafip", "MCOTAFIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cargaobligatoria", "COBLIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), MOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Toleranciapositiva", "TOLPOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tolerancianegativa", "TOLNEG")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Simbolo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Eafip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Edgi LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mcotafip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine