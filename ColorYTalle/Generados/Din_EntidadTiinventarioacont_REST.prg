
define class Din_EntidadTiinventarioacont_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Tiinventarioacont"
	cClaseResponse = this.cNamespaceDTOs + ".TiinventarioacontResponse"
	cClaseModelo = "TiinventarioacontModelo"
	cEntidad = "Tiinventarioacont"
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
				lcRetorno = this.cNamespaceDTOs + "." + "TiinventarioacontModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "TiinventarioacontModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "TiinventarioacontListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "TiinventarioacontListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "TiinventarioacontModelo"
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
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaaltafw", toEntidad, "Fechaaltafw" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulodesde", toEntidad, "Articulodesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulohasta", toEntidad, "Articulohasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Colordesde", toEntidad, "Colordesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Colorhasta", toEntidad, "Colorhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Talledesde", toEntidad, "Talledesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tallehasta", toEntidad, "Tallehasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedordesde", toEntidad, "Proveedordesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedorhasta", toEntidad, "Proveedorhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Materialdesde", toEntidad, "Materialdesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Materialhasta", toEntidad, "Materialhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Temporadadesde", toEntidad, "Temporadadesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Temporadahasta", toEntidad, "Temporadahasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Familiadesde", toEntidad, "Familiadesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Familiahasta", toEntidad, "Familiahasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Grupodesde", toEntidad, "Grupodesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Grupohasta", toEntidad, "Grupohasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Lineadesde", toEntidad, "Lineadesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Lineahasta", toEntidad, "Lineahasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Categoriadearticulodesde", toEntidad, "Categoriadearticulodesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Categoriadearticulohasta", toEntidad, "Categoriadearticulohasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificaciondesde", toEntidad, "Clasificaciondesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacionhasta", toEntidad, "Clasificacionhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodearticulodesde", toEntidad, "Tipodearticulodesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodearticulohasta", toEntidad, "Tipodearticulohasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoDateTime( toModeloResponse, "FechaAltaFW", toEntidad.FechaAltaFW)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoString( toModeloResponse, "ArticuloDesde", toEntidad.ArticuloDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ArticuloHasta", toEntidad.ArticuloHasta_PK)
			this.SetearAtributoString( toModeloResponse, "ColorDesde", toEntidad.ColorDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ColorHasta", toEntidad.ColorHasta_PK)
			this.SetearAtributoString( toModeloResponse, "TalleDesde", toEntidad.TalleDesde_PK)
			this.SetearAtributoString( toModeloResponse, "TalleHasta", toEntidad.TalleHasta_PK)
			this.SetearAtributoString( toModeloResponse, "ProveedorDesde", toEntidad.ProveedorDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ProveedorHasta", toEntidad.ProveedorHasta_PK)
			this.SetearAtributoString( toModeloResponse, "MaterialDesde", toEntidad.MaterialDesde_PK)
			this.SetearAtributoString( toModeloResponse, "MaterialHasta", toEntidad.MaterialHasta_PK)
			this.SetearAtributoString( toModeloResponse, "TemporadaDesde", toEntidad.TemporadaDesde_PK)
			this.SetearAtributoString( toModeloResponse, "TemporadaHasta", toEntidad.TemporadaHasta_PK)
			this.SetearAtributoString( toModeloResponse, "FamiliaDesde", toEntidad.FamiliaDesde_PK)
			this.SetearAtributoString( toModeloResponse, "FamiliaHasta", toEntidad.FamiliaHasta_PK)
			this.SetearAtributoString( toModeloResponse, "GrupoDesde", toEntidad.GrupoDesde_PK)
			this.SetearAtributoString( toModeloResponse, "GrupoHasta", toEntidad.GrupoHasta_PK)
			this.SetearAtributoString( toModeloResponse, "LineaDesde", toEntidad.LineaDesde_PK)
			this.SetearAtributoString( toModeloResponse, "LineaHasta", toEntidad.LineaHasta_PK)
			this.SetearAtributoString( toModeloResponse, "CategoriaDeArticuloDesde", toEntidad.CategoriaDeArticuloDesde_PK)
			this.SetearAtributoString( toModeloResponse, "CategoriaDeArticuloHasta", toEntidad.CategoriaDeArticuloHasta_PK)
			this.SetearAtributoString( toModeloResponse, "ClasificacionDesde", toEntidad.ClasificacionDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ClasificacionHasta", toEntidad.ClasificacionHasta_PK)
			this.SetearAtributoString( toModeloResponse, "TipoDeArticuloDesde", toEntidad.TipoDeArticuloDesde_PK)
			this.SetearAtributoString( toModeloResponse, "TipoDeArticuloHasta", toEntidad.TipoDeArticuloHasta_PK)
			this.SetearAtributoString( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaaltafw", "FALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FECHAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FECHAH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulodesde", "ARTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulohasta", "ARTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Colordesde", "COLDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Colorhasta", "COLHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Talledesde", "TALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tallehasta", "TALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedordesde", "PROVDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedorhasta", "PROVHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Materialdesde", "MATDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Materialhasta", "MATHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Temporadadesde", "TEMPDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Temporadahasta", "TEMPHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Familiadesde", "FAMDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Familiahasta", "FAMHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Grupodesde", "GRUPODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Grupohasta", "GRUPOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Lineadesde", "LINEADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Lineahasta", "LINEAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Categoriadearticulodesde", "CATEGDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Categoriadearticulohasta", "CATEGHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificaciondesde", "CLASDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacionhasta", "CLASHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodearticulodesde", "TIPODESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodearticulohasta", "TIPOHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "MOBS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arthasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Coldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Colhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taldesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Talhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Matdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mathasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tempdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Temphasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Famhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Grupodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Grupohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lineadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Lineahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Categdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Categhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clashasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipodesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipohasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine