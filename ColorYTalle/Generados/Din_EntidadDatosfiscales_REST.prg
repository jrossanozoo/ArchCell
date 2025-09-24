
define class Din_EntidadDatosfiscales_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Datosfiscales"
	cClaseResponse = this.cNamespaceDTOs + ".DatosfiscalesResponse"
	cClaseModelo = "DatosfiscalesModelo"
	cEntidad = "Datosfiscales"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatosfiscalesModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatosfiscalesModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatosfiscalesListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatosfiscalesListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DatosfiscalesModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obser", toEntidad, "Obser" )
			this.SetearDetallePerceiibb( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nroobligatorio", toEntidad, "Nroobligatorio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autocompletarjurisdic", toEntidad, "Autocompletarjurisdic" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autocompletarpercriesgo", toEntidad, "Autocompletarpercriesgo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Retpercsiempresegunjurisdiccion", toEntidad, "Retpercsiempresegunjurisdiccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Generacompiibbseparados", toEntidad, "Generacompiibbseparados" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Exportacionesautomaticasenop", toEntidad, "Exportacionesautomaticasenop" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosadicionalescomprobantesa", toEntidad, "Datosadicionalescomprobantesa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosadicionalessiprib", toEntidad, "Datosadicionalessiprib" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Artincisoretiene", toEntidad, "Artincisoretiene" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Artincisopercibe", toEntidad, "Artincisopercibe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Reintegro", toEntidad, "Reintegro" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montominimo", toEntidad, "Montominimo" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAgrupublidetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Agrupublidetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Agrupublidetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Agrupublidetalle.LimpiarItem()
			else
				try
					toEntidad.Agrupublidetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Agrupublidetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.Agrupublidetalle.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallePerceIIBB( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "PerceIIBB" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"PerceIIBB[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.PerceIIBB.LimpiarItem()
			else
				try
					toEntidad.PerceIIBB.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.PerceIIBB.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Impuesto", toEntidad.PerceIIBB.oItem, "Impuesto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Aplicacion", toEntidad.PerceIIBB.oItem, "Aplicacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.PerceIIBB.oItem, "Tipo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Jurisdiccion", toEntidad.PerceIIBB.oItem, "Jurisdiccion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Resolucion", toEntidad.PerceIIBB.oItem, "Resolucion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Regimenimpositivo", toEntidad.PerceIIBB.oItem, "RegimenImpositivo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Minimonoimponible", toEntidad.PerceIIBB.oItem, "MinimoNoImponible" )
			this.SetearAtributoModeloEnEntidad( loItem, "Minimoderetencion", toEntidad.PerceIIBB.oItem, "MinimoDeRetencion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Escala", toEntidad.PerceIIBB.oItem, "Escala" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentaje", toEntidad.PerceIIBB.oItem, "Porcentaje" )
			toEntidad.PerceIIBB.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obser", toEntidad.Obser)
			this.CargarColeccionModeloPerceIIBB( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "NroObligatorio", toEntidad.NroObligatorio)
			this.SetearAtributo( toModeloResponse, "AutocompletarJurisdic", toEntidad.AutocompletarJurisdic)
			this.SetearAtributo( toModeloResponse, "AutocompletarPercRiesgo", toEntidad.AutocompletarPercRiesgo)
			this.SetearAtributoString( toModeloResponse, "RetPercSiempreSegunJurisdiccion", toEntidad.RetPercSiempreSegunJurisdiccion_PK)
			this.SetearAtributo( toModeloResponse, "GeneraCompIIBBSeparados", toEntidad.GeneraCompIIBBSeparados)
			this.SetearAtributo( toModeloResponse, "ExportacionesAutomaticasEnOP", toEntidad.ExportacionesAutomaticasEnOP)
			this.SetearAtributo( toModeloResponse, "DatosAdicionalesComprobantesA", toEntidad.DatosAdicionalesComprobantesA)
			this.SetearAtributo( toModeloResponse, "DatosAdicionalesSiprib", toEntidad.DatosAdicionalesSiprib)
			this.SetearAtributoInteger( toModeloResponse, "ArtIncisoRetiene", toEntidad.ArtIncisoRetiene)
			this.SetearAtributoInteger( toModeloResponse, "ArtIncisoPercibe", toEntidad.ArtIncisoPercibe)
			this.SetearAtributo( toModeloResponse, "Reintegro", toEntidad.Reintegro)
			this.SetearAtributoDecimal( toModeloResponse, "MontoMinimo", toEntidad.MontoMinimo)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAgrupublidetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Agrupublidetalle" ) 
		with toEntidad
			for lnI = 1 to .Agrupublidetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAgrupapublic" )
				this.SetearAtributoString( loItem, "Codigo", .Agrupublidetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Agrupamiento", .Agrupublidetalle.Item(lnI).Agrupamiento_PK)
				this.SetearAtributoString( loItem, "AgrupamientoDetalle", .Agrupublidetalle.Item(lnI).AgrupamientoDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .Agrupublidetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloPerceIIBB( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "PerceIIBB" ) 
		with toEntidad
			for lnI = 1 to .PerceIIBB.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDatosfiscales" )
				this.SetearAtributoString( loItem, "Codigo", .PerceIIBB.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Impuesto", .PerceIIBB.Item(lnI).Impuesto_PK)
				this.SetearAtributoString( loItem, "Aplicacion", .PerceIIBB.Item(lnI).Aplicacion)
				this.SetearAtributoString( loItem, "Tipo", .PerceIIBB.Item(lnI).Tipo_PK)
				this.SetearAtributoString( loItem, "Jurisdiccion", .PerceIIBB.Item(lnI).Jurisdiccion)
				this.SetearAtributoString( loItem, "Resolucion", .PerceIIBB.Item(lnI).Resolucion)
				this.SetearAtributoString( loItem, "RegimenImpositivo", .PerceIIBB.Item(lnI).RegimenImpositivo)
				this.SetearAtributoDecimal( loItem, "MinimoNoImponible", .PerceIIBB.Item(lnI).MinimoNoImponible)
				this.SetearAtributoDecimal( loItem, "MinimoDeRetencion", .PerceIIBB.Item(lnI).MinimoDeRetencion)
				this.SetearAtributo( loItem, "Escala", .PerceIIBB.Item(lnI).Escala)
				this.SetearAtributoDecimal( loItem, "Porcentaje", .PerceIIBB.Item(lnI).Porcentaje)
				this.SetearAtributoInteger( loItem, "NroItem", .PerceIIBB.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoagrupamientopublicaciones", "TIPAGRUPUB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIPCIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obser", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nroobligatorio", "NROIIBBOBL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Autocompletarjurisdic", "AUTOJUR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Autocompletarpercriesgo", "AUTOPERR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Retpercsiempresegunjurisdiccion", "JURISDSIEM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Generacompiibbseparados", "SEPARAIIBB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Exportacionesautomaticasenop", "EXPOENOP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datosadicionalescomprobantesa", "AFIP366814")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datosadicionalessiprib", "DASIPRIB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Artincisoretiene", "RETSIPRIB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Artincisopercibe", "PERSIPRIB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Reintegro", "REINTEGRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montominimo", "MONTOMIN")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descripcio LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Jurisdsiem LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine