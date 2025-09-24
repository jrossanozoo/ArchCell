
define class Din_EntidadTransferenciaentrecuentas_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Transferenciaentrecuentas"
	cClaseResponse = this.cNamespaceDTOs + ".TransferenciaentrecuentasResponse"
	cClaseModelo = "TransferenciaentrecuentasModelo"
	cEntidad = "Transferenciaentrecuentas"
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
				lcRetorno = this.cNamespaceDTOs + "." + "TransferenciaentrecuentasModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "TransferenciaentrecuentasModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "TransferenciaentrecuentasListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "TransferenciaentrecuentasListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "TransferenciaentrecuentasModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaingreso", toEntidad, "Fechaingreso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuentabancariatransfiere", toEntidad, "Cuentabancariatransfiere_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacuentatransfiere", toEntidad, "Monedacuentatransfiere" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechatransfiere", toEntidad, "Fechatransfiere" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horatransfiere", toEntidad, "Horatransfiere" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montotransfiere", toEntidad, "Montotransfiere" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Identificadortransfiere", toEntidad, "Identificadortransfiere" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigotransfiere", toEntidad, "Codigotransfiere" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuentabancariarecibe", toEntidad, "Cuentabancariarecibe_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacuentarecibe", toEntidad, "Monedacuentarecibe" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecharecibe", toEntidad, "Fecharecibe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horarecibe", toEntidad, "Horarecibe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montorecibe", toEntidad, "Montorecibe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Identificadorrecibe", toEntidad, "Identificadorrecibe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigorecibe", toEntidad, "Codigorecibe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "FechaIngreso", toEntidad.FechaIngreso)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "CuentaBancariaTransfiere", toEntidad.CuentaBancariaTransfiere_PK)
			this.SetearAtributoString( toModeloResponse, "MonedaCuentaTransfiere", toEntidad.MonedaCuentaTransfiere)
			this.SetearAtributoDateTime( toModeloResponse, "FechaTransfiere", toEntidad.FechaTransfiere)
			this.SetearAtributoString( toModeloResponse, "HoraTransfiere", toEntidad.HoraTransfiere)
			this.SetearAtributoDecimal( toModeloResponse, "MontoTransfiere", toEntidad.MontoTransfiere)
			this.SetearAtributoString( toModeloResponse, "IdentificadorTransfiere", toEntidad.IdentificadorTransfiere)
			this.SetearAtributoString( toModeloResponse, "CodigoTransfiere", toEntidad.CodigoTransfiere)
			this.SetearAtributoString( toModeloResponse, "CuentaBancariaRecibe", toEntidad.CuentaBancariaRecibe_PK)
			this.SetearAtributoString( toModeloResponse, "MonedaCuentaRecibe", toEntidad.MonedaCuentaRecibe)
			this.SetearAtributoDateTime( toModeloResponse, "FechaRecibe", toEntidad.FechaRecibe)
			this.SetearAtributoString( toModeloResponse, "HoraRecibe", toEntidad.HoraRecibe)
			this.SetearAtributoDecimal( toModeloResponse, "MontoRecibe", toEntidad.MontoRecibe)
			this.SetearAtributoString( toModeloResponse, "IdentificadorRecibe", toEntidad.IdentificadorRecibe)
			this.SetearAtributoString( toModeloResponse, "CodigoRecibe", toEntidad.CodigoRecibe)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaingreso", "INGRESO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuentabancariatransfiere", "CTATRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechatransfiere", "FECTRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horatransfiere", "HORATRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montotransfiere", "MONTOTRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Identificadortransfiere", "IDTRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigotransfiere", "CODTRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuentabancariarecibe", "CTAREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecharecibe", "FECREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horarecibe", "HORAREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montorecibe", "MONTOREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Identificadorrecibe", "IDREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigorecibe", "CODREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descri LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctatran LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Horatran LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idtran LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codtran LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctarec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Horarec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idrec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codrec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine