
define class Din_EntidadSucursal_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Sucursal"
	cClaseResponse = this.cNamespaceDTOs + ".SucursalResponse"
	cClaseModelo = "SucursalModelo"
	cEntidad = "Sucursal"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SucursalModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SucursalModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SucursalListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SucursalListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SucursalModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nombre", toEntidad, "Nombre" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Direccion", toEntidad, "Direccion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Piso", toEntidad, "Piso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Departamento", toEntidad, "Departamento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Localidad", toEntidad, "Localidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigopostal", toEntidad, "Codigopostal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Provincia", toEntidad, "Provincia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefono", toEntidad, "Telefono" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fax", toEntidad, "Fax" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Email", toEntidad, "Email" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Paginaweb", toEntidad, "Paginaweb" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contacto", toEntidad, "Contacto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagen", toEntidad, "Imagen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacion", toEntidad, "Clasificacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Nombre", toEntidad.Nombre)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "Direccion", toEntidad.Direccion)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Piso", toEntidad.Piso)
			this.SetearAtributoString( toModeloResponse, "Departamento", toEntidad.Departamento)
			this.SetearAtributoString( toModeloResponse, "Localidad", toEntidad.Localidad)
			this.SetearAtributoString( toModeloResponse, "CodigoPostal", toEntidad.CodigoPostal)
			this.SetearAtributoString( toModeloResponse, "Provincia", toEntidad.Provincia_PK)
			this.SetearAtributoString( toModeloResponse, "Telefono", toEntidad.Telefono)
			this.SetearAtributoString( toModeloResponse, "Fax", toEntidad.Fax)
			this.SetearAtributoString( toModeloResponse, "EMail", toEntidad.EMail)
			this.SetearAtributoString( toModeloResponse, "PaginaWeb", toEntidad.PaginaWeb)
			this.SetearAtributoString( toModeloResponse, "Contacto", toEntidad.Contacto)
			this.SetearAtributoString( toModeloResponse, "Imagen", toEntidad.Imagen)
			this.SetearAtributoString( toModeloResponse, "Clasificacion", toEntidad.Clasificacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nombre", "CLNOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Direccion", "CLDIR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "CLNUM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Piso", "CLPISO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Departamento", "CLDEPTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Localidad", "CLLOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigopostal", "CLCP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Provincia", "CLPRV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefono", "CLTLF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fax", "CLFAX")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Email", "CLEMAIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Paginaweb", "CLPAGEWEB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contacto", "CLCONTAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagen", "CIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacion", "CLIMPD")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cldir LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpiso LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cldepto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clloc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clprv LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltlf LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clfax LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clemail LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpageweb LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcontac LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cimagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Climpd LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine