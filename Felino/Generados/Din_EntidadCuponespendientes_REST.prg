
define class Din_EntidadCuponespendientes_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Cuponespendientes"
	cClaseResponse = this.cNamespaceDTOs + ".CuponespendientesResponse"
	cClaseModelo = "CuponespendientesModelo"
	cEntidad = "Cuponespendientes"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CuponespendientesModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CuponespendientesModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CuponespendientesListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CuponespendientesListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CuponespendientesModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valor", toEntidad, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dispositivopos", toEntidad, "Dispositivopos_PK" )
			this.SetearDetalleCupones( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCupones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Cupones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Cupones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Cupones.LimpiarItem()
			else
				try
					toEntidad.Cupones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Cupones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.Cupones.oItem, "Numero" )
			this.SetearAtributoModeloEnEntidad( loItem, "Interno", toEntidad.Cupones.oItem, "Interno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocupon", toEntidad.Cupones.oItem, "TipoCupon" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.Cupones.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hora", toEntidad.Cupones.oItem, "Hora" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cuotas", toEntidad.Cupones.oItem, "Cuotas" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.Cupones.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Comprobante", toEntidad.Cupones.oItem, "Comprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Incluido", toEntidad.Cupones.oItem, "Incluido" )
			toEntidad.Cupones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Valor", toEntidad.Valor_PK)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoString( toModeloResponse, "DispositivoPos", toEntidad.DispositivoPos_PK)
			this.CargarColeccionModeloCupones( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCupones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Cupones" ) 
		with toEntidad
			for lnI = 1 to .Cupones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCupon" )
				this.SetearAtributoString( loItem, "Codigo", .Cupones.Item(lnI).Codigo)
				this.SetearAtributoLong( loItem, "Numero", .Cupones.Item(lnI).Numero)
				this.SetearAtributoString( loItem, "Interno", .Cupones.Item(lnI).Interno)
				this.SetearAtributoString( loItem, "TipoCupon", .Cupones.Item(lnI).TipoCupon)
				this.SetearAtributoDatetime( loItem, "Fecha", .Cupones.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Hora", .Cupones.Item(lnI).Hora)
				this.SetearAtributoInteger( loItem, "Cuotas", .Cupones.Item(lnI).Cuotas)
				this.SetearAtributoDecimal( loItem, "Monto", .Cupones.Item(lnI).Monto)
				this.SetearAtributoString( loItem, "Comprobante", .Cupones.Item(lnI).Comprobante)
				this.SetearAtributo( loItem, "Incluido", .Cupones.Item(lnI).Incluido)
				this.SetearAtributoInteger( loItem, "NroItem", .Cupones.Item(lnI).NroItem )
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