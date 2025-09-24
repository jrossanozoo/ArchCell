
define class Din_EntidadCategoriasecommerce_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Categoriasecommerce"
	cClaseResponse = this.cNamespaceDTOs + ".CategoriasecommerceResponse"
	cClaseModelo = "CategoriasecommerceModelo"
	cEntidad = "Categoriasecommerce"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CategoriasecommerceModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CategoriasecommerceModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CategoriasecommerceListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CategoriasecommerceListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CategoriasecommerceModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Categoria", toEntidad, "Categoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Essubcategoriade", toEntidad, "Essubcategoriade_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Orden", toEntidad, "Orden" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rama", toEntidad, "Rama" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Categoriags", toEntidad, "Categoriags_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tituloseo", toEntidad, "Tituloseo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcionseo", toEntidad, "Descripcionseo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Url", toEntidad, "Url" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Arbolcategorias", toEntidad, "Arbolcategorias" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Categoria", toEntidad.Categoria)
			this.SetearAtributoString( toModeloResponse, "EsSubcategoriaDe", toEntidad.EsSubcategoriaDe_PK)
			this.SetearAtributoInteger( toModeloResponse, "Orden", toEntidad.Orden)
			this.SetearAtributoString( toModeloResponse, "Rama", toEntidad.Rama)
			this.SetearAtributoString( toModeloResponse, "CategoriaGS", toEntidad.CategoriaGS_PK)
			this.SetearAtributoString( toModeloResponse, "TituloSEO", toEntidad.TituloSEO)
			this.SetearAtributoString( toModeloResponse, "DescripcionSEO", toEntidad.DescripcionSEO)
			this.SetearAtributoString( toModeloResponse, "URL", toEntidad.URL)
			this.SetearAtributoString( toModeloResponse, "ArbolCategorias", toEntidad.ArbolCategorias)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Categoria", "CATEG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Essubcategoriade", "SUBCATDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Orden", "ORDEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rama", "RAMA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Categoriags", "CATGS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tituloseo", "TITULOSEO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcionseo", "DESCSEO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Url", "URL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Categ LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Subcatde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rama LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Catgs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tituloseo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descseo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Url LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine