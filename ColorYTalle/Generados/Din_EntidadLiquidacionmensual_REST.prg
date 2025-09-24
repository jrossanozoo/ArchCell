
define class Din_EntidadLiquidacionmensual_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Liquidacionmensual"
	cClaseResponse = this.cNamespaceDTOs + ".LiquidacionmensualResponse"
	cClaseModelo = "LiquidacionmensualModelo"
	cEntidad = "Liquidacionmensual"
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
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidacionmensualModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidacionmensualModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidacionmensualListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidacionmensualListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "LiquidacionmensualModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numint", toEntidad, "Numint" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Operadora", toEntidad, "Operadora_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaliq", toEntidad, "Fechaliq" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventaliquidacion", toEntidad, "Puntodeventaliquidacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeroliquidacion", toEntidad, "Numeroliquidacion" )
			this.SetearDetalleConceptosdiarios( toEntidad, toModeloEnRequest )
			this.SetearDetalleConceptosgenerales( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totalliquidacion", toEntidad, "Totalliquidacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleConceptosdiarios( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Conceptosdiarios" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Conceptosdiarios[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Conceptosdiarios.LimpiarItem()
			else
				try
					toEntidad.Conceptosdiarios.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Conceptosdiarios.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Liquidacion", toEntidad.Conceptosdiarios.oItem, "Liquidacion_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.Conceptosdiarios.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.Conceptosdiarios.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Neto", toEntidad.Conceptosdiarios.oItem, "Neto" )
			toEntidad.Conceptosdiarios.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleConceptosgenerales( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Conceptosgenerales" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Conceptosgenerales[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Conceptosgenerales.LimpiarItem()
			else
				try
					toEntidad.Conceptosgenerales.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Conceptosgenerales.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Concepto", toEntidad.Conceptosgenerales.oItem, "Concepto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Conceptodetalle", toEntidad.Conceptosgenerales.oItem, "ConceptoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.Conceptosgenerales.oItem, "Monto" )
			toEntidad.Conceptosgenerales.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "NumInt", toEntidad.NumInt)
			this.SetearAtributoString( toModeloResponse, "Operadora", toEntidad.Operadora_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaLiq", toEntidad.FechaLiq)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaLiquidacion", toEntidad.PuntoDeVentaLiquidacion)
			this.SetearAtributoLong( toModeloResponse, "NumeroLiquidacion", toEntidad.NumeroLiquidacion)
			this.CargarColeccionModeloConceptosdiarios( toModeloResponse, toEntidad )
			this.CargarColeccionModeloConceptosgenerales( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "TotalLiquidacion", toEntidad.TotalLiquidacion)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloConceptosdiarios( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Conceptosdiarios" ) 
		with toEntidad
			for lnI = 1 to .Conceptosdiarios.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemLiqdiaria" )
				this.SetearAtributoString( loItem, "Codigo", .Conceptosdiarios.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Liquidacion", .Conceptosdiarios.Item(lnI).Liquidacion_PK)
				this.SetearAtributoDecimal( loItem, "Monto", .Conceptosdiarios.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "Descuento", .Conceptosdiarios.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "Neto", .Conceptosdiarios.Item(lnI).Neto)
				this.SetearAtributoInteger( loItem, "NroItem", .Conceptosdiarios.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloConceptosgenerales( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Conceptosgenerales" ) 
		with toEntidad
			for lnI = 1 to .Conceptosgenerales.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemLiqgeneral" )
				this.SetearAtributoString( loItem, "Codigo", .Conceptosgenerales.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Concepto", .Conceptosgenerales.Item(lnI).Concepto_PK)
				this.SetearAtributoString( loItem, "ConceptoDetalle", .Conceptosgenerales.Item(lnI).ConceptoDetalle)
				this.SetearAtributoDecimal( loItem, "Monto", .Conceptosgenerales.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .Conceptosgenerales.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numint", "NUMINT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Operadora", "OPERADORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FECHADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FECHAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaliq", "FECHALIQ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventaliquidacion", "PTOVENTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeroliquidacion", "NROLIQ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Totalliquidacion", "TOTALLIQ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Operadora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine