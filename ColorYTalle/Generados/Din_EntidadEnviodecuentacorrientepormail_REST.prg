
define class Din_EntidadEnviodecuentacorrientepormail_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Enviodecuentacorrientepormail"
	cClaseResponse = this.cNamespaceDTOs + ".EnviodecuentacorrientepormailResponse"
	cClaseModelo = "EnviodecuentacorrientepormailModelo"
	cEntidad = "Enviodecuentacorrientepormail"
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
		toEntidad.Codigo = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodecuentacorrientepormailModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodecuentacorrientepormailModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodecuentacorrientepormailListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodecuentacorrientepormailListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "EnviodecuentacorrientepormailModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedesde", toEntidad, "Clientedesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientehasta", toEntidad, "Clientehasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comprobantespendientes", toEntidad, "Comprobantespendientes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Saldosdecuentasincancelar", toEntidad, "Saldosdecuentasincancelar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Saldo", toEntidad, "Saldo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Agruparsaldos", toEntidad, "Agruparsaldos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Chequesdeterceros", toEntidad, "Chequesdeterceros" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Combopersonalizacion", toEntidad, "Combopersonalizacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoInteger( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoString( toModeloResponse, "ClienteDesde", toEntidad.ClienteDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteHasta", toEntidad.ClienteHasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "ComprobantesPendientes", toEntidad.ComprobantesPendientes)
			this.SetearAtributoInteger( toModeloResponse, "SaldosDeCuentaSinCancelar", toEntidad.SaldosDeCuentaSinCancelar)
			this.SetearAtributoLong( toModeloResponse, "Saldo", toEntidad.Saldo)
			this.SetearAtributo( toModeloResponse, "AgruparSaldos", toEntidad.AgruparSaldos)
			this.SetearAtributo( toModeloResponse, "ChequesDeTerceros", toEntidad.ChequesDeTerceros)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributoLong( toModeloResponse, "ComboPersonalizacion", toEntidad.ComboPersonalizacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FECHAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FECHAH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedesde", "FPERSOND")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientehasta", "FPERSONH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comprobantespendientes", "COMPPEND")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Saldosdecuentasincancelar", "SALSINCAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Saldo", "SALDOPN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Agruparsaldos", "AGRUSALDOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Chequesdeterceros", "CHEQTERC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "CBDATOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Combopersonalizacion", "LISTADOS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fpersond LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fpersonh LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cbdatos LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine