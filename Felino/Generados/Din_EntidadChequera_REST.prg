
define class Din_EntidadChequera_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Chequera"
	cClaseResponse = this.cNamespaceDTOs + ".ChequeraResponse"
	cClaseModelo = "ChequeraModelo"
	cEntidad = "Chequera"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ChequeraModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ChequeraModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ChequeraListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ChequeraListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ChequeraModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuentabancaria", toEntidad, "Cuentabancaria_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Chequeraelectronica", toEntidad, "Chequeraelectronica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeroinicial", toEntidad, "Numeroinicial" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadcheques", toEntidad, "Cantidadcheques" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadpersonalizada", toEntidad, "Cantidadpersonalizada" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferido", toEntidad, "Diferido" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecharecepcion", toEntidad, "Fecharecepcion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "CuentaBancaria", toEntidad.CuentaBancaria_PK)
			this.SetearAtributo( toModeloResponse, "ChequeraElectronica", toEntidad.ChequeraElectronica)
			this.SetearAtributoLong( toModeloResponse, "NumeroInicial", toEntidad.NumeroInicial)
			this.SetearAtributoInteger( toModeloResponse, "CantidadCheques", toEntidad.CantidadCheques)
			this.SetearAtributoInteger( toModeloResponse, "CantidadPersonalizada", toEntidad.CantidadPersonalizada)
			this.SetearAtributo( toModeloResponse, "Diferido", toEntidad.Diferido)
			this.SetearAtributoDateTime( toModeloResponse, "FechaRecepcion", toEntidad.FechaRecepcion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "CQDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CQOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuentabancaria", "CQCTABAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Chequeraelectronica", "CQELECTRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeroinicial", "CQNROINI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadcheques", "CQCANT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadpersonalizada", "CQCANTPERS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diferido", "CQDIF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecharecepcion", "CQFECREC")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cqcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cqdes LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cqobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cqctaban LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine