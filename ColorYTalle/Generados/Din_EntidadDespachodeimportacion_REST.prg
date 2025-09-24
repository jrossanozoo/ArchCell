
define class Din_EntidadDespachodeimportacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Despachodeimportacion"
	cClaseResponse = this.cNamespaceDTOs + ".DespachodeimportacionResponse"
	cClaseModelo = "DespachodeimportacionModelo"
	cEntidad = "Despachodeimportacion"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Despacho" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Despacho = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Despacho = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "DespachodeimportacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DespachodeimportacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DespachodeimportacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DespachodeimportacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DespachodeimportacionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Incoterms", toEntidad, "Incoterms_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantunidades", toEntidad, "Cantunidades" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fob", toEntidad, "Fob" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Flete", toEntidad, "Flete" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seguro", toEntidad, "Seguro" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Despacho", toEntidad, "Despacho" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaing", toEntidad, "Fechaing" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Oficializacion", toEntidad, "Oficializacion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Arribo", toEntidad, "Arribo" )
			this.SetearDetalleDetallearticulos( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleArticulos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleArticulos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleArticulos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleArticulos.LimpiarItem()
			else
				try
					toEntidad.DetalleArticulos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleArticulos.LimpiarItem()
				endtry 
			endif
			if goParametros.Felino.CodigosDeBarras.HabilitarLectura
				if toEntidad.DetalleArticulos.oItem.lUtilizaLecturaDeCodigoDeBarras != goParametros.Felino.CodigosDeBarras.HabilitarLectura
					toEntidad.DetalleArticulos.oItem.lUtilizaLecturaDeCodigoDeBarras = goParametros.Felino.CodigosDeBarras.HabilitarLectura
				endif
				try
					this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.DetalleArticulos.oItem, "CodigoDeBarras" )
				catch to loError
					try
						this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.DetalleArticulos.oItem, "Articulo_PK" )
					catch
						goServicios.Errores.LevantarExcepcion( loError )
					endtry
				endtry
			else
				this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.DetalleArticulos.oItem, "Articulo_PK" )
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.DetalleArticulos.oItem, "ArticuloDetalle" )
			toEntidad.DetalleArticulos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Incoterms", toEntidad.Incoterms_PK)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoString( toModeloResponse, "CantUnidades", toEntidad.CantUnidades)
			this.SetearAtributoDecimal( toModeloResponse, "FOB", toEntidad.FOB)
			this.SetearAtributoDecimal( toModeloResponse, "Flete", toEntidad.Flete)
			this.SetearAtributoDecimal( toModeloResponse, "Seguro", toEntidad.Seguro)
			this.SetearAtributoString( toModeloResponse, "Despacho", toEntidad.Despacho)
			this.SetearAtributoDateTime( toModeloResponse, "FechaIng", toEntidad.FechaIng)
			this.SetearAtributoDateTime( toModeloResponse, "Oficializacion", toEntidad.Oficializacion)
			this.SetearAtributoDateTime( toModeloResponse, "Arribo", toEntidad.Arribo)
			this.CargarColeccionModeloDetalleArticulos( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleArticulos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleArticulos" ) 
		with toEntidad
			for lnI = 1 to .DetalleArticulos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemArticulosdespacho" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleArticulos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .DetalleArticulos.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .DetalleArticulos.Item(lnI).ArticuloDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleArticulos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Incoterms", "INCOTERMS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Moneda", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantunidades", "CANTUNI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fob", "FOB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Flete", "FLETE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seguro", "SEGURO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaing", "FECHAING")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Oficializacion", "OFICIALIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Arribo", "ARRIBO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Total", "FTOTAL")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Incoterms LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cantuni LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Despacho LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine