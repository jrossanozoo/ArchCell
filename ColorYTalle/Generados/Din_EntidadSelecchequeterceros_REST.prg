
define class Din_EntidadSelecchequeterceros_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Selecchequeterceros"
	cClaseResponse = this.cNamespaceDTOs + ".SelecchequetercerosResponse"
	cClaseModelo = "SelecchequetercerosModelo"
	cEntidad = "Selecchequeterceros"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SelecchequetercerosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SelecchequetercerosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SelecchequetercerosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SelecchequetercerosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SelecchequetercerosModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fchemdesde", toEntidad, "Fchemdesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fchemhasta", toEntidad, "Fchemhasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numindesde", toEntidad, "Numindesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numinhasta", toEntidad, "Numinhasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodesde", toEntidad, "Montodesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montohasta", toEntidad, "Montohasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mondesde", toEntidad, "Mondesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monhasta", toEntidad, "Monhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clidesde", toEntidad, "Clidesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clihasta", toEntidad, "Clihasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numdesde", toEntidad, "Numdesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numhasta", toEntidad, "Numhasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entfindesde", toEntidad, "Entfindesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entfinhasta", toEntidad, "Entfinhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codvaldesde", toEntidad, "Codvaldesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codvalhasta", toEntidad, "Codvalhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuitdesde", toEntidad, "Cuitdesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuithasta", toEntidad, "Cuithasta" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FchEmDesde", toEntidad.FchEmDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FchEmHasta", toEntidad.FchEmHasta)
			this.SetearAtributoInteger( toModeloResponse, "NumInDesde", toEntidad.NumInDesde)
			this.SetearAtributoInteger( toModeloResponse, "NumInHasta", toEntidad.NumInHasta)
			this.SetearAtributoLong( toModeloResponse, "MontoDesde", toEntidad.MontoDesde)
			this.SetearAtributoLong( toModeloResponse, "MontoHasta", toEntidad.MontoHasta)
			this.SetearAtributoString( toModeloResponse, "MonDesde", toEntidad.MonDesde_PK)
			this.SetearAtributoString( toModeloResponse, "MonHasta", toEntidad.MonHasta_PK)
			this.SetearAtributoString( toModeloResponse, "CliDesde", toEntidad.CliDesde_PK)
			this.SetearAtributoString( toModeloResponse, "CliHasta", toEntidad.CliHasta_PK)
			this.SetearAtributoInteger( toModeloResponse, "NumDesde", toEntidad.NumDesde)
			this.SetearAtributoInteger( toModeloResponse, "NumHasta", toEntidad.NumHasta)
			this.SetearAtributoString( toModeloResponse, "EntFinDesde", toEntidad.EntFinDesde_PK)
			this.SetearAtributoString( toModeloResponse, "EntFinHasta", toEntidad.EntFinHasta_PK)
			this.SetearAtributoString( toModeloResponse, "CodValDesde", toEntidad.CodValDesde_PK)
			this.SetearAtributoString( toModeloResponse, "CodValHasta", toEntidad.CodValHasta_PK)
			this.SetearAtributoString( toModeloResponse, "CuitDesde", toEntidad.CuitDesde)
			this.SetearAtributoString( toModeloResponse, "CuitHasta", toEntidad.CuitHasta)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FCHDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FCHHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fchemdesde", "FCHEMIDESD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fchemhasta", "FCHEMIHAST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numindesde", "NUMINTDESD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numinhasta", "NUMINTHAST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodesde", "MNTODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montohasta", "MNTOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mondesde", "MONDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monhasta", "MONHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clidesde", "CLIEDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clihasta", "CLIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numdesde", "NUMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numhasta", "NUMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entfindesde", "ENTFDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entfinhasta", "ENTFHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codvaldesde", "CODVALDESD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codvalhasta", "CODVALHAST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuitdesde", "CUITDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuithasta", "CUITHASTA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mondesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Monhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliedesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entfdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entfhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codvaldesd LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codvalhast LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cuitdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cuithasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine