
define class Din_EntidadModificacionprecios_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Modificacionprecios"
	cClaseResponse = this.cNamespaceDTOs + ".ModificacionpreciosResponse"
	cClaseModelo = "ModificacionpreciosModelo"
	cEntidad = "Modificacionprecios"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ModificacionpreciosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ModificacionpreciosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ModificacionpreciosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ModificacionpreciosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ModificacionpreciosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechabase", toEntidad, "Fechabase" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigencia", toEntidad, "Fechavigencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearDetalleModprecios( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleModPrecios( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ModPrecios" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ModPrecios[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ModPrecios.LimpiarItem()
			else
				try
					toEntidad.ModPrecios.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ModPrecios.LimpiarItem()
				endtry 
			endif
			if goParametros.Felino.CodigosDeBarras.HabilitarLectura
				if toEntidad.ModPrecios.oItem.lUtilizaLecturaDeCodigoDeBarras != goParametros.Felino.CodigosDeBarras.HabilitarLectura
					toEntidad.ModPrecios.oItem.lUtilizaLecturaDeCodigoDeBarras = goParametros.Felino.CodigosDeBarras.HabilitarLectura
				endif
				try
					this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ModPrecios.oItem, "CodigoDeBarras" )
				catch to loError
					try
						this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ModPrecios.oItem, "Articulo_PK" )
					catch
						goServicios.Errores.LevantarExcepcion( loError )
					endtry
				endtry
			else
				this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ModPrecios.oItem, "Articulo_PK" )
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.ModPrecios.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ModPrecios.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ModPrecios.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ModPrecios.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Listadeprecio", toEntidad.ModPrecios.oItem, "ListaDePrecio_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Preciodelista", toEntidad.ModPrecios.oItem, "PrecioDeLista" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precioact", toEntidad.ModPrecios.oItem, "PrecioAct" )
			toEntidad.ModPrecios.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaBase", toEntidad.FechaBase)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigencia", toEntidad.FechaVigencia)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.CargarColeccionModeloModPrecios( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloModPrecios( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ModPrecios" ) 
		with toEntidad
			for lnI = 1 to .ModPrecios.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemModificacionprecios" )
				this.SetearAtributoString( loItem, "Codigo", .ModPrecios.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .ModPrecios.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .ModPrecios.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .ModPrecios.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ModPrecios.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ModPrecios.Item(lnI).Talle)
				this.SetearAtributoString( loItem, "ListaDePrecio", .ModPrecios.Item(lnI).ListaDePrecio_PK)
				this.SetearAtributoDecimal( loItem, "PrecioDeLista", .ModPrecios.Item(lnI).PrecioDeLista)
				this.SetearAtributoDecimal( loItem, "PrecioAct", .ModPrecios.Item(lnI).PrecioAct)
				this.SetearAtributoInteger( loItem, "NroItem", .ModPrecios.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechabase", "FECHABASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigencia", "FECHAVIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), MOBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine