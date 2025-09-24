
define class Din_EntidadProcesarncpendientepromobanco_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Procesarncpendientepromobanco"
	cClaseResponse = this.cNamespaceDTOs + ".ProcesarncpendientepromobancoResponse"
	cClaseModelo = "ProcesarncpendientepromobancoModelo"
	cEntidad = "Procesarncpendientepromobanco"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Numero" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Numero = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Numero = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "ProcesarncpendientepromobancoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ProcesarncpendientepromobancoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ProcesarncpendientepromobancoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ProcesarncpendientepromobancoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ProcesarncpendientepromobancoModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearDetalleCuponespendientes( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCuponesPendientes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CuponesPendientes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CuponesPendientes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CuponesPendientes.LimpiarItem()
			else
				try
					toEntidad.CuponesPendientes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CuponesPendientes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Caja", toEntidad.CuponesPendientes.oItem, "Caja" )
			this.SetearAtributoModeloEnEntidad( loItem, "Facttipo", toEntidad.CuponesPendientes.oItem, "FactTipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Idcliente", toEntidad.CuponesPendientes.oItem, "IdCliente_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedescripcion", toEntidad.CuponesPendientes.oItem, "ClienteDescripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tiponotadecredito", toEntidad.CuponesPendientes.oItem, "TipoNotaDeCredito" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montoajuste", toEntidad.CuponesPendientes.oItem, "MontoAjuste" )
			toEntidad.CuponesPendientes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.CargarColeccionModeloCuponesPendientes( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCuponesPendientes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CuponesPendientes" ) 
		with toEntidad
			for lnI = 1 to .CuponesPendientes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemNcpendientepromob" )
				this.SetearAtributoString( loItem, "Codigo", .CuponesPendientes.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "Caja", .CuponesPendientes.Item(lnI).Caja)
				this.SetearAtributoInteger( loItem, "FactTipo", .CuponesPendientes.Item(lnI).FactTipo)
				this.SetearAtributoString( loItem, "IdCliente", .CuponesPendientes.Item(lnI).IdCliente_PK)
				this.SetearAtributoString( loItem, "ClienteDescripcion", .CuponesPendientes.Item(lnI).ClienteDescripcion)
				this.SetearAtributoInteger( loItem, "TipoNotaDeCredito", .CuponesPendientes.Item(lnI).TipoNotaDeCredito)
				this.SetearAtributoDecimal( loItem, "MontoAjuste", .CuponesPendientes.Item(lnI).MontoAjuste)
				this.SetearAtributoInteger( loItem, "NroItem", .CuponesPendientes.Item(lnI).NroItem )
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