
define class Din_EntidadCaeainforma_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Caeainforma"
	cClaseResponse = this.cNamespaceDTOs + ".CaeainformaResponse"
	cClaseModelo = "CaeainformaModelo"
	cEntidad = "Caeainforma"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CaeainformaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CaeainformaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CaeainformaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CaeainformaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CaeainformaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerointerno", toEntidad, "Numerointerno" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codcaea", toEntidad, "Codcaea_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciadesde", toEntidad, "Fechavigenciadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavigenciahasta", toEntidad, "Fechavigenciahasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechatope", toEntidad, "Fechatope" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ptoventa", toEntidad, "Ptoventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Periodocaea", toEntidad, "Periodocaea" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Quincena", toEntidad, "Quincena" )
			this.SetearDetalleCaeinformadetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Resultado2", toEntidad, "Resultado2" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaproceso2", toEntidad, "Fechaproceso2" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCaeInformaDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CaeInformaDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CaeInformaDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CaeInformaDetalle.LimpiarItem()
			else
				try
					toEntidad.CaeInformaDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CaeInformaDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.CaeInformaDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocomp", toEntidad.CaeInformaDetalle.oItem, "TipoComp" )
			this.SetearAtributoModeloEnEntidad( loItem, "Totalcomp", toEntidad.CaeInformaDetalle.oItem, "TotalComp" )
			this.SetearAtributoModeloEnEntidad( loItem, "Resultado", toEntidad.CaeInformaDetalle.oItem, "Resultado" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechaproceso", toEntidad.CaeInformaDetalle.oItem, "FechaProceso" )
			this.SetearAtributoModeloEnEntidad( loItem, "Comentariosafip", toEntidad.CaeInformaDetalle.oItem, "ComentariosAFIP" )
			toEntidad.CaeInformaDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoLong( toModeloResponse, "NumeroInterno", toEntidad.NumeroInterno)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoLong( toModeloResponse, "CodCAEA", toEntidad.CodCAEA_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaDesde", toEntidad.FechaVigenciaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVigenciaHasta", toEntidad.FechaVigenciaHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaTope", toEntidad.FechaTope)
			this.SetearAtributoInteger( toModeloResponse, "PtoVenta", toEntidad.PtoVenta)
			this.SetearAtributoString( toModeloResponse, "PeriodoCAEA", toEntidad.PeriodoCAEA)
			this.SetearAtributoInteger( toModeloResponse, "Quincena", toEntidad.Quincena)
			this.CargarColeccionModeloCaeInformaDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Resultado2", toEntidad.Resultado2)
			this.SetearAtributoDateTime( toModeloResponse, "FechaProceso2", toEntidad.FechaProceso2)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCaeInformaDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CaeInformaDetalle" ) 
		with toEntidad
			for lnI = 1 to .CaeInformaDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCaeainforma" )
				this.SetearAtributoString( loItem, "Codigo", .CaeInformaDetalle.Item(lnI).Codigo)
				this.SetearAtributoDatetime( loItem, "Fecha", .CaeInformaDetalle.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "TipoComp", .CaeInformaDetalle.Item(lnI).TipoComp)
				this.SetearAtributoDecimal( loItem, "TotalComp", .CaeInformaDetalle.Item(lnI).TotalComp)
				this.SetearAtributoString( loItem, "Resultado", .CaeInformaDetalle.Item(lnI).Resultado)
				this.SetearAtributoDatetime( loItem, "FechaProceso", .CaeInformaDetalle.Item(lnI).FechaProceso)
				this.SetearAtributoString( loItem, "ComentariosAFIP", .CaeInformaDetalle.Item(lnI).ComentariosAFIP)
				this.SetearAtributoInteger( loItem, "NroItem", .CaeInformaDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerointerno", "NUMINT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codcaea", "CAEA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciadesde", "VIGENCIAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavigenciahasta", "VIGENCIAH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechatope", "FECHATOPE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ptoventa", "PTOVTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Periodocaea", "PERIODO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Quincena", "QUINCENA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Resultado2", "RESULTADO2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaproceso2", "FECHAPROC2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBSAFIP)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Periodo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Resultado2 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obsafip LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine