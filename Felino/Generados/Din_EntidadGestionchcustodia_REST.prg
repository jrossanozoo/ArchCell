
define class Din_EntidadGestionchcustodia_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Gestionchcustodia"
	cClaseResponse = this.cNamespaceDTOs + ".GestionchcustodiaResponse"
	cClaseModelo = "GestionchcustodiaModelo"
	cEntidad = "Gestionchcustodia"
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
				lcRetorno = this.cNamespaceDTOs + "." + "GestionchcustodiaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "GestionchcustodiaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "GestionchcustodiaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "GestionchcustodiaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "GestionchcustodiaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesdeemi", toEntidad, "Fechadesdeemi" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahastaemi", toEntidad, "Fechahastaemi" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesdepago", toEntidad, "Fechadesdepago" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahastapago", toEntidad, "Fechahastapago" )
			this.SetearDetalleDetallechcustodia( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleChCustodia( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleChCustodia" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleChCustodia[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleChCustodia.LimpiarItem()
			else
				try
					toEntidad.DetalleChCustodia.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleChCustodia.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Numerointerno", toEntidad.DetalleChCustodia.oItem, "NumeroInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinanciera", toEntidad.DetalleChCustodia.oItem, "EntidadFinanciera_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinancieradescripcion", toEntidad.DetalleChCustodia.oItem, "EntidadFinancieraDescripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.DetalleChCustodia.oItem, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechaemision", toEntidad.DetalleChCustodia.oItem, "FechaEmision" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechapago", toEntidad.DetalleChCustodia.oItem, "FechaPago" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cuitlibrador", toEntidad.DetalleChCustodia.oItem, "CUITLibrador" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cliente", toEntidad.DetalleChCustodia.oItem, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedescripcion", toEntidad.DetalleChCustodia.oItem, "ClienteDescripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.DetalleChCustodia.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Seleccion", toEntidad.DetalleChCustodia.oItem, "Seleccion" )
			toEntidad.DetalleChCustodia.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesdeEmi", toEntidad.FechaDesdeEmi)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHastaEmi", toEntidad.FechaHastaEmi)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesdePago", toEntidad.FechaDesdePago)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHastaPago", toEntidad.FechaHastaPago)
			this.CargarColeccionModeloDetalleChCustodia( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleChCustodia( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleChCustodia" ) 
		with toEntidad
			for lnI = 1 to .DetalleChCustodia.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemChcustodia" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleChCustodia.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "NumeroInterno", .DetalleChCustodia.Item(lnI).NumeroInterno)
				this.SetearAtributoString( loItem, "EntidadFinanciera", .DetalleChCustodia.Item(lnI).EntidadFinanciera_PK)
				this.SetearAtributoString( loItem, "EntidadFinancieraDescripcion", .DetalleChCustodia.Item(lnI).EntidadFinancieraDescripcion)
				this.SetearAtributoInteger( loItem, "Numero", .DetalleChCustodia.Item(lnI).Numero)
				this.SetearAtributoDatetime( loItem, "FechaEmision", .DetalleChCustodia.Item(lnI).FechaEmision)
				this.SetearAtributoDatetime( loItem, "FechaPago", .DetalleChCustodia.Item(lnI).FechaPago)
				this.SetearAtributoString( loItem, "CUITLibrador", .DetalleChCustodia.Item(lnI).CUITLibrador)
				this.SetearAtributoString( loItem, "Cliente", .DetalleChCustodia.Item(lnI).Cliente_PK)
				this.SetearAtributoString( loItem, "ClienteDescripcion", .DetalleChCustodia.Item(lnI).ClienteDescripcion)
				this.SetearAtributoDecimal( loItem, "Monto", .DetalleChCustodia.Item(lnI).Monto)
				this.SetearAtributo( loItem, "Seleccion", .DetalleChCustodia.Item(lnI).Seleccion)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleChCustodia.Item(lnI).NroItem )
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine