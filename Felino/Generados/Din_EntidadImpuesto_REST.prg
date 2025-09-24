
define class Din_EntidadImpuesto_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Impuesto"
	cClaseResponse = this.cNamespaceDTOs + ".ImpuestoResponse"
	cClaseModelo = "ImpuestoModelo"
	cEntidad = "Impuesto"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpuestoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpuestoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpuestoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpuestoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ImpuestoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Aplicacion", toEntidad, "Aplicacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipo", toEntidad, "Tipo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Jurisdiccion", toEntidad, "Jurisdiccion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Resolucion", toEntidad, "Resolucion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Regimenimpositivo", toEntidad, "Regimenimpositivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Escala", toEntidad, "Escala" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Minimo", toEntidad, "Minimo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentaje", toEntidad, "Porcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Segunconvenio", toEntidad, "Segunconvenio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Conveniolocal", toEntidad, "Conveniolocal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Conveniomultilateral", toEntidad, "Conveniomultilateral" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Conveniomultilextranajuris", toEntidad, "Conveniomultilextranajuris" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Convenionoinscripto", toEntidad, "Convenionoinscripto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basedecalculo", toEntidad, "Basedecalculo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajebase", toEntidad, "Porcentajebase" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pagoparcial", toEntidad, "Pagoparcial" )
			this.SetearDetalleEscaladetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg2616regimen", toEntidad, "Rg2616regimen_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg2616porcentaje", toEntidad, "Rg2616porcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg2616meses", toEntidad, "Rg2616meses" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg2616montomaximoservicios", toEntidad, "Rg2616montomaximoservicios" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg2616montomaximobienes", toEntidad, "Rg2616montomaximobienes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg1575regimen", toEntidad, "Rg1575regimen_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg1575porcentaje", toEntidad, "Rg1575porcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg1575basedecalculo", toEntidad, "Rg1575basedecalculo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg1575montominimoretencion", toEntidad, "Rg1575montominimoretencion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Iibbtuccoeficientecero", toEntidad, "Iibbtuccoeficientecero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Iibbtucreduccionalicuota", toEntidad, "Iibbtucreduccionalicuota" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Iibbtucalicuotanoinscriptos", toEntidad, "Iibbtucalicuotanoinscriptos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg5329aplicaporarticulo", toEntidad, "Rg5329aplicaporarticulo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rg5329porcentaje", toEntidad, "Rg5329porcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Iibbmenalicuotanoinscriptos", toEntidad, "Iibbmenalicuotanoinscriptos" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleEscalaDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "EscalaDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"EscalaDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.EscalaDetalle.LimpiarItem()
			else
				try
					toEntidad.EscalaDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.EscalaDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentaje", toEntidad.EscalaDetalle.oItem, "porcentaje" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sobreexcedente", toEntidad.EscalaDetalle.oItem, "sobreexcedente" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montofijo", toEntidad.EscalaDetalle.oItem, "montofijo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Mayora", toEntidad.EscalaDetalle.oItem, "mayora" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hasta", toEntidad.EscalaDetalle.oItem, "hasta" )
			toEntidad.EscalaDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "Aplicacion", toEntidad.Aplicacion)
			this.SetearAtributoString( toModeloResponse, "Tipo", toEntidad.Tipo_PK)
			this.SetearAtributoString( toModeloResponse, "Jurisdiccion", toEntidad.Jurisdiccion_PK)
			this.SetearAtributoString( toModeloResponse, "Resolucion", toEntidad.Resolucion)
			this.SetearAtributoString( toModeloResponse, "RegimenImpositivo", toEntidad.RegimenImpositivo_PK)
			this.SetearAtributo( toModeloResponse, "Escala", toEntidad.Escala)
			this.SetearAtributoDecimal( toModeloResponse, "Minimo", toEntidad.Minimo)
			this.SetearAtributoDecimal( toModeloResponse, "Monto", toEntidad.Monto)
			this.SetearAtributoDecimal( toModeloResponse, "Porcentaje", toEntidad.Porcentaje)
			this.SetearAtributo( toModeloResponse, "SegunConvenio", toEntidad.SegunConvenio)
			this.SetearAtributoDecimal( toModeloResponse, "ConvenioLocal", toEntidad.ConvenioLocal)
			this.SetearAtributoDecimal( toModeloResponse, "ConvenioMultilateral", toEntidad.ConvenioMultilateral)
			this.SetearAtributoDecimal( toModeloResponse, "ConvenioMultilExtranaJuris", toEntidad.ConvenioMultilExtranaJuris)
			this.SetearAtributoDecimal( toModeloResponse, "ConvenioNoInscripto", toEntidad.ConvenioNoInscripto)
			this.SetearAtributoString( toModeloResponse, "BaseDeCalculo", toEntidad.BaseDeCalculo)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeBase", toEntidad.PorcentajeBase)
			this.SetearAtributoInteger( toModeloResponse, "PagoParcial", toEntidad.PagoParcial)
			this.CargarColeccionModeloEscalaDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "RG2616Regimen", toEntidad.RG2616Regimen_PK)
			this.SetearAtributoDecimal( toModeloResponse, "RG2616Porcentaje", toEntidad.RG2616Porcentaje)
			this.SetearAtributoInteger( toModeloResponse, "RG2616Meses", toEntidad.RG2616Meses)
			this.SetearAtributoDecimal( toModeloResponse, "RG2616MontoMaximoServicios", toEntidad.RG2616MontoMaximoServicios)
			this.SetearAtributoDecimal( toModeloResponse, "RG2616MontoMaximoBienes", toEntidad.RG2616MontoMaximoBienes)
			this.SetearAtributoString( toModeloResponse, "RG1575Regimen", toEntidad.RG1575Regimen_PK)
			this.SetearAtributoDecimal( toModeloResponse, "RG1575Porcentaje", toEntidad.RG1575Porcentaje)
			this.SetearAtributoString( toModeloResponse, "RG1575BaseDeCalculo", toEntidad.RG1575BaseDeCalculo)
			this.SetearAtributoDecimal( toModeloResponse, "RG1575MontoMinimoRetencion", toEntidad.RG1575MontoMinimoRetencion)
			this.SetearAtributoDecimal( toModeloResponse, "IIBBTucCoeficienteCero", toEntidad.IIBBTucCoeficienteCero)
			this.SetearAtributoDecimal( toModeloResponse, "IIBBTucReduccionAlicuota", toEntidad.IIBBTucReduccionAlicuota)
			this.SetearAtributoDecimal( toModeloResponse, "IIBBTucAlicuotaNoInscriptos", toEntidad.IIBBTucAlicuotaNoInscriptos)
			this.SetearAtributo( toModeloResponse, "RG5329AplicaPorArticulo", toEntidad.RG5329AplicaPorArticulo)
			this.SetearAtributoDecimal( toModeloResponse, "RG5329Porcentaje", toEntidad.RG5329Porcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "IIBBMenAlicuotaNoInscriptos", toEntidad.IIBBMenAlicuotaNoInscriptos)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloEscalaDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "EscalaDetalle" ) 
		with toEntidad
			for lnI = 1 to .EscalaDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemEscala" )
				this.SetearAtributoString( loItem, "codigo", .EscalaDetalle.Item(lnI).codigo)
				this.SetearAtributoDecimal( loItem, "porcentaje", .EscalaDetalle.Item(lnI).porcentaje)
				this.SetearAtributoDecimal( loItem, "sobreexcedente", .EscalaDetalle.Item(lnI).sobreexcedente)
				this.SetearAtributoDecimal( loItem, "montofijo", .EscalaDetalle.Item(lnI).montofijo)
				this.SetearAtributoDecimal( loItem, "mayora", .EscalaDetalle.Item(lnI).mayora)
				this.SetearAtributoDecimal( loItem, "hasta", .EscalaDetalle.Item(lnI).hasta)
				this.SetearAtributoInteger( loItem, "NroItem", .EscalaDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Aplicacion", "APLICACION")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipo", "TIPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Jurisdiccion", "JURISDICCI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Resolucion", "RESOLU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Regimenimpositivo", "REGIMENIMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Escala", "ESCALA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Minimo", "MINIMO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monto", "MONTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentaje", "PORCENTAJE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Segunconvenio", "CONVENIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Conveniolocal", "CONVLOCAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Conveniomultilateral", "CONVMULTI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Conveniomultilextranajuris", "CONMULEXT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Convenionoinscripto", "CONVNOINSC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basedecalculo", "BASECALC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajebase", "PORCBASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pagoparcial", "PAGOCTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg2616regimen", "MONOREG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg2616porcentaje", "MONOPORC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg2616meses", "MONOMESES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg2616montomaximoservicios", "MAXSERV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg2616montomaximobienes", "MAXBIENES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg1575regimen", "COMPMREG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg1575porcentaje", "COMPMPORC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg1575basedecalculo", "COMPMBASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg1575montominimoretencion", "COMPMMIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Iibbtuccoeficientecero", "TUCCFCERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Iibbtucreduccionalicuota", "TUCREDALIC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Iibbtucalicuotanoinscriptos", "TUCALICNI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg5329aplicaporarticulo", "APLICAART")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rg5329porcentaje", "PORCEN5329")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Iibbmenalicuotanoinscriptos", "MENALICNI")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aplicacion LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Jurisdicci LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Resolu LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Regimenimp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Basecalc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Monoreg LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Compmreg LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Compmbase LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine