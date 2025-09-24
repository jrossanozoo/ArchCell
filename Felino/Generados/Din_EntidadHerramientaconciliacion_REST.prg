
define class Din_EntidadHerramientaconciliacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Herramientaconciliacion"
	cClaseResponse = this.cNamespaceDTOs + ".HerramientaconciliacionResponse"
	cClaseModelo = "HerramientaconciliacionModelo"
	cEntidad = "Herramientaconciliacion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "HerramientaconciliacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "HerramientaconciliacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "HerramientaconciliacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "HerramientaconciliacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "HerramientaconciliacionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuentabancaria", toEntidad, "Cuentabancaria_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocuenta", toEntidad, "Numerocuenta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordenamiento", toEntidad, "Ordenamiento" )
			this.SetearDetalleDetallemovimientos( toEntidad, toModeloEnRequest )
			this.SetearDetalleDetalleregistros( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferencia", toEntidad, "Diferencia" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleMovimientos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleMovimientos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleMovimientos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleMovimientos.LimpiarItem()
			else
				try
					toEntidad.DetalleMovimientos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleMovimientos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Movimiento", toEntidad.DetalleMovimientos.oItem, "Movimiento_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.DetalleMovimientos.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Conceptocodigo", toEntidad.DetalleMovimientos.oItem, "ConceptoCodigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Concepto", toEntidad.DetalleMovimientos.oItem, "Concepto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Conceptodetalle", toEntidad.DetalleMovimientos.oItem, "ConceptoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.DetalleMovimientos.oItem, "Numero" )
			this.SetearAtributoModeloEnEntidad( loItem, "Importe", toEntidad.DetalleMovimientos.oItem, "Importe" )
			this.SetearAtributoModeloEnEntidad( loItem, "Seleccion", toEntidad.DetalleMovimientos.oItem, "Seleccion" )
			toEntidad.DetalleMovimientos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleRegistros( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleRegistros" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleRegistros[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleRegistros.LimpiarItem()
			else
				try
					toEntidad.DetalleRegistros.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleRegistros.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Registro", toEntidad.DetalleRegistros.oItem, "Registro_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.DetalleRegistros.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Comprobante", toEntidad.DetalleRegistros.oItem, "Comprobante" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechadeoperacion", toEntidad.DetalleRegistros.oItem, "FechaDeOperacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipovalor", toEntidad.DetalleRegistros.oItem, "TipoValor" )
			this.SetearAtributoModeloEnEntidad( loItem, "Importe", toEntidad.DetalleRegistros.oItem, "Importe" )
			this.SetearAtributoModeloEnEntidad( loItem, "Seleccion", toEntidad.DetalleRegistros.oItem, "Seleccion" )
			toEntidad.DetalleRegistros.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "CuentaBancaria", toEntidad.CuentaBancaria_PK)
			this.SetearAtributoString( toModeloResponse, "NumeroCuenta", toEntidad.NumeroCuenta)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoInteger( toModeloResponse, "Ordenamiento", toEntidad.Ordenamiento)
			this.CargarColeccionModeloDetalleMovimientos( toModeloResponse, toEntidad )
			this.CargarColeccionModeloDetalleRegistros( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoDecimal( toModeloResponse, "Diferencia", toEntidad.Diferencia)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleMovimientos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleMovimientos" ) 
		with toEntidad
			for lnI = 1 to .DetalleMovimientos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemMovbancariostool" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleMovimientos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Movimiento", .DetalleMovimientos.Item(lnI).Movimiento_PK)
				this.SetearAtributoDatetime( loItem, "Fecha", .DetalleMovimientos.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "ConceptoCodigo", .DetalleMovimientos.Item(lnI).ConceptoCodigo)
				this.SetearAtributoString( loItem, "Concepto", .DetalleMovimientos.Item(lnI).Concepto)
				this.SetearAtributoString( loItem, "ConceptoDetalle", .DetalleMovimientos.Item(lnI).ConceptoDetalle)
				this.SetearAtributoLong( loItem, "Numero", .DetalleMovimientos.Item(lnI).Numero)
				this.SetearAtributoDecimal( loItem, "Importe", .DetalleMovimientos.Item(lnI).Importe)
				this.SetearAtributo( loItem, "Seleccion", .DetalleMovimientos.Item(lnI).Seleccion)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleMovimientos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleRegistros( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleRegistros" ) 
		with toEntidad
			for lnI = 1 to .DetalleRegistros.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRegconciliablestool" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleRegistros.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Registro", .DetalleRegistros.Item(lnI).Registro_PK)
				this.SetearAtributoDatetime( loItem, "Fecha", .DetalleRegistros.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Comprobante", .DetalleRegistros.Item(lnI).Comprobante)
				this.SetearAtributoDatetime( loItem, "FechaDeOperacion", .DetalleRegistros.Item(lnI).FechaDeOperacion)
				this.SetearAtributoInteger( loItem, "TipoValor", .DetalleRegistros.Item(lnI).TipoValor)
				this.SetearAtributoDecimal( loItem, "Importe", .DetalleRegistros.Item(lnI).Importe)
				this.SetearAtributo( loItem, "Seleccion", .DetalleRegistros.Item(lnI).Seleccion)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleRegistros.Item(lnI).NroItem )
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