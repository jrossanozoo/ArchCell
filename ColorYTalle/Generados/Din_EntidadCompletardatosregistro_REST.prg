
define class Din_EntidadCompletardatosregistro_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Completardatosregistro"
	cClaseResponse = this.cNamespaceDTOs + ".CompletardatosregistroResponse"
	cClaseModelo = "CompletardatosregistroModelo"
	cEntidad = "Completardatosregistro"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardatosregistroModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardatosregistroModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardatosregistroListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardatosregistroListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CompletardatosregistroModelo"
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
			this.SetearDetalleDetalledatosregistros( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleDatosRegistros( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleDatosRegistros" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleDatosRegistros[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleDatosRegistros.LimpiarItem()
			else
				try
					toEntidad.DetalleDatosRegistros.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleDatosRegistros.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.DetalleDatosRegistros.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.DetalleDatosRegistros.oItem, "ValorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Importe", toEntidad.DetalleDatosRegistros.oItem, "Importe" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cuentabancaria", toEntidad.DetalleDatosRegistros.oItem, "CuentaBancaria_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.DetalleDatosRegistros.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hora", toEntidad.DetalleDatosRegistros.oItem, "Hora" )
			this.SetearAtributoModeloEnEntidad( loItem, "Identificador", toEntidad.DetalleDatosRegistros.oItem, "Identificador" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codigobanco", toEntidad.DetalleDatosRegistros.oItem, "CodigoBanco" )
			toEntidad.DetalleDatosRegistros.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloDetalleDatosRegistros( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleDatosRegistros( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleDatosRegistros" ) 
		with toEntidad
			for lnI = 1 to .DetalleDatosRegistros.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDatosregistro" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleDatosRegistros.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Valor", .DetalleDatosRegistros.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .DetalleDatosRegistros.Item(lnI).ValorDetalle)
				this.SetearAtributoDecimal( loItem, "Importe", .DetalleDatosRegistros.Item(lnI).Importe)
				this.SetearAtributoString( loItem, "CuentaBancaria", .DetalleDatosRegistros.Item(lnI).CuentaBancaria_PK)
				this.SetearAtributoDatetime( loItem, "Fecha", .DetalleDatosRegistros.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Hora", .DetalleDatosRegistros.Item(lnI).Hora)
				this.SetearAtributoString( loItem, "Identificador", .DetalleDatosRegistros.Item(lnI).Identificador)
				this.SetearAtributoString( loItem, "CodigoBanco", .DetalleDatosRegistros.Item(lnI).CodigoBanco)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleDatosRegistros.Item(lnI).NroItem )
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