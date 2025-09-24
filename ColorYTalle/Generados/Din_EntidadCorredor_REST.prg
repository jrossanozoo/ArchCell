
define class Din_EntidadCorredor_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Corredor"
	cClaseResponse = this.cNamespaceDTOs + ".CorredorResponse"
	cClaseModelo = "CorredorModelo"
	cEntidad = "Corredor"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CorredorModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CorredorModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CorredorListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CorredorListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CorredorModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Calle", toEntidad, "Calle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Piso", toEntidad, "Piso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Localidad", toEntidad, "Localidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Departamento", toEntidad, "Departamento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigopostal", toEntidad, "Codigopostal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Provincia", toEntidad, "Provincia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pais", toEntidad, "Pais_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefono", toEntidad, "Telefono" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movil", toEntidad, "Movil" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Email", toEntidad, "Email" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fax", toEntidad, "Fax" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contacto", toEntidad, "Contacto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagen", toEntidad, "Imagen" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechanacimiento", toEntidad, "Fechanacimiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodocumento", toEntidad, "Tipodocumento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrodocumento", toEntidad, "Nrodocumento" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaingreso", toEntidad, "Fechaingreso" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaegreso", toEntidad, "Fechaegreso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Situacionfiscal", toEntidad, "Situacionfiscal_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuit", toEntidad, "Cuit" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Nombre", toEntidad.Nombre)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "Calle", toEntidad.Calle)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Piso", toEntidad.Piso)
			this.SetearAtributoString( toModeloResponse, "Localidad", toEntidad.Localidad)
			this.SetearAtributoString( toModeloResponse, "Departamento", toEntidad.Departamento)
			this.SetearAtributoString( toModeloResponse, "CodigoPostal", toEntidad.CodigoPostal)
			this.SetearAtributoString( toModeloResponse, "Provincia", toEntidad.Provincia_PK)
			this.SetearAtributoString( toModeloResponse, "Pais", toEntidad.Pais_PK)
			this.SetearAtributoString( toModeloResponse, "Telefono", toEntidad.Telefono)
			this.SetearAtributoString( toModeloResponse, "Movil", toEntidad.Movil)
			this.SetearAtributoString( toModeloResponse, "EMail", toEntidad.EMail)
			this.SetearAtributoString( toModeloResponse, "Fax", toEntidad.Fax)
			this.SetearAtributoString( toModeloResponse, "Contacto", toEntidad.Contacto)
			this.SetearAtributoString( toModeloResponse, "Imagen", toEntidad.Imagen)
			this.SetearAtributoDateTime( toModeloResponse, "FechaNacimiento", toEntidad.FechaNacimiento)
			this.SetearAtributoString( toModeloResponse, "TipoDocumento", toEntidad.TipoDocumento)
			this.SetearAtributoString( toModeloResponse, "NroDocumento", toEntidad.NroDocumento)
			this.SetearAtributoDateTime( toModeloResponse, "FechaIngreso", toEntidad.FechaIngreso)
			this.SetearAtributoDateTime( toModeloResponse, "FechaEgreso", toEntidad.FechaEgreso)
			this.SetearAtributoInteger( toModeloResponse, "SituacionFiscal", toEntidad.SituacionFiscal_PK)
			this.SetearAtributoString( toModeloResponse, "CUIT", toEntidad.CUIT)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nombre", "CLNOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Calle", "CLDIR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "CLNUM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Piso", "CLPISO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Localidad", "CLLOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Departamento", "CLDEPTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigopostal", "CLCP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Provincia", "CLPRV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pais", "PPAIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefono", "CLTLF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Movil", "CLTLFM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Email", "CLEMAIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fax", "CLFAX")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contacto", "CLCONTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagen", "CIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechanacimiento", "CLFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodocumento", "CLTIPODOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nrodocumento", "CLNRODOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaingreso", "CLFING")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaegreso", "CLFEGR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Situacionfiscal", "CLIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuit", "CLCUIT")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cldir LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpiso LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clloc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cldepto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clprv LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ppais LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltlf LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltlfm LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clemail LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clfax LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clconta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cimagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltipodoc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnrodoc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcuit LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine