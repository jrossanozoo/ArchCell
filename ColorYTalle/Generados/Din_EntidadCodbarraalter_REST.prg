
define class Din_EntidadCodbarraalter_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Codbarraalter"
	cClaseResponse = this.cNamespaceDTOs + ".CodbarraalterResponse"
	cClaseModelo = "CodbarraalterModelo"
	cEntidad = "Codbarraalter"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CodbarraalterModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CodbarraalterModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CodbarraalterListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CodbarraalterListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CodbarraalterModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitado", toEntidad, "Habilitado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Utilizasecuencial", toEntidad, "Utilizasecuencial" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Controlaunicidad", toEntidad, "Controlaunicidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearDetalleCodbardetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCodBarDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CodBarDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CodBarDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CodBarDetalle.LimpiarItem()
			else
				try
					toEntidad.CodBarDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CodBarDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Nombre", toEntidad.CodBarDetalle.oItem, "Nombre" )
			this.SetearAtributoModeloEnEntidad( loItem, "Atributo", toEntidad.CodBarDetalle.oItem, "Atributo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Posicioninicial", toEntidad.CodBarDetalle.oItem, "PosicionInicial" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidadcaracteres", toEntidad.CodBarDetalle.oItem, "CantidadCaracteres" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidaddecimales", toEntidad.CodBarDetalle.oItem, "CantidadDecimales" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valorbandera", toEntidad.CodBarDetalle.oItem, "ValorBandera" )
			toEntidad.CodBarDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Habilitado", toEntidad.Habilitado)
			this.SetearAtributo( toModeloResponse, "UtilizaSecuencial", toEntidad.UtilizaSecuencial)
			this.SetearAtributoInteger( toModeloResponse, "ControlaUnicidad", toEntidad.ControlaUnicidad)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.CargarColeccionModeloCodBarDetalle( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCodBarDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CodBarDetalle" ) 
		with toEntidad
			for lnI = 1 to .CodBarDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCodbarraalter" )
				this.SetearAtributoString( loItem, "Codigo", .CodBarDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Nombre", .CodBarDetalle.Item(lnI).Nombre)
				this.SetearAtributoString( loItem, "Atributo", .CodBarDetalle.Item(lnI).Atributo)
				this.SetearAtributoInteger( loItem, "PosicionInicial", .CodBarDetalle.Item(lnI).PosicionInicial)
				this.SetearAtributoInteger( loItem, "CantidadCaracteres", .CodBarDetalle.Item(lnI).CantidadCaracteres)
				this.SetearAtributoInteger( loItem, "CantidadDecimales", .CodBarDetalle.Item(lnI).CantidadDecimales)
				this.SetearAtributoString( loItem, "ValorBandera", .CodBarDetalle.Item(lnI).ValorBandera)
				this.SetearAtributoInteger( loItem, "NroItem", .CodBarDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "CODDESC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitado", "HABILITADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Utilizasecuencial", "USASECUEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Controlaunicidad", "CTRLUNI")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Coddesc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine