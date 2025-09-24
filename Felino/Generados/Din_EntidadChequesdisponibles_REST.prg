
define class Din_EntidadChequesdisponibles_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Chequesdisponibles"
	cClaseResponse = this.cNamespaceDTOs + ".ChequesdisponiblesResponse"
	cClaseModelo = "ChequesdisponiblesModelo"
	cEntidad = "Chequesdisponibles"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ChequesdisponiblesModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ChequesdisponiblesModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ChequesdisponiblesListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ChequesdisponiblesListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ChequesdisponiblesModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estado", toEntidad, "Estado" )
			this.SetearDetalleCheques( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCheques( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Cheques" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Cheques[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Cheques.LimpiarItem()
			else
				try
					toEntidad.Cheques.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Cheques.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Interno", toEntidad.Cheques.oItem, "Interno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.Cheques.oItem, "Numero" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.Cheques.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Seleccionado", toEntidad.Cheques.oItem, "Seleccionado" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.Cheques.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Estado", toEntidad.Cheques.oItem, "Estado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinanciera", toEntidad.Cheques.oItem, "EntidadFinanciera_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Entidadfinancieradetalle", toEntidad.Cheques.oItem, "EntidadFinancieraDetalle" )
			toEntidad.Cheques.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Estado", toEntidad.Estado)
			this.CargarColeccionModeloCheques( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCheques( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Cheques" ) 
		with toEntidad
			for lnI = 1 to .Cheques.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemChequedisponible" )
				this.SetearAtributoString( loItem, "Codigo", .Cheques.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Interno", .Cheques.Item(lnI).Interno)
				this.SetearAtributoInteger( loItem, "Numero", .Cheques.Item(lnI).Numero)
				this.SetearAtributoDecimal( loItem, "Monto", .Cheques.Item(lnI).Monto)
				this.SetearAtributo( loItem, "Seleccionado", .Cheques.Item(lnI).Seleccionado)
				this.SetearAtributoDatetime( loItem, "Fecha", .Cheques.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Estado", .Cheques.Item(lnI).Estado)
				this.SetearAtributoString( loItem, "EntidadFinanciera", .Cheques.Item(lnI).EntidadFinanciera_PK)
				this.SetearAtributoString( loItem, "EntidadFinancieraDetalle", .Cheques.Item(lnI).EntidadFinancieraDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .Cheques.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
		endif
	
		return lcRetorno 
	endfunc
	

enddefine