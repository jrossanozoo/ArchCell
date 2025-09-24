
define class Din_EntidadBasededatos_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Basededatos"
	cClaseResponse = this.cNamespaceDTOs + ".BasededatosResponse"
	cClaseModelo = "BasededatosModelo"
	cEntidad = "Basededatos"
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
				lcRetorno = this.cNamespaceDTOs + "." + "BasededatosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "BasededatosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "BasededatosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "BasededatosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "BasededatosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutacompleta", toEntidad, "Rutacompleta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutamdf", toEntidad, "Rutamdf" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Origendestino", toEntidad, "Origendestino_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sucursal", toEntidad, "Sucursal_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Color", toEntidad, "Color" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preferente", toEntidad, "Preferente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Procesapaquetes", toEntidad, "Procesapaquetes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Realizabackup", toEntidad, "Realizabackup" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutabackup", toEntidad, "Rutabackup" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Conectada", toEntidad, "Conectada" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Replica", toEntidad, "Replica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idbasededatos", toEntidad, "Idbasededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "RutaCompleta", toEntidad.RutaCompleta)
			this.SetearAtributoString( toModeloResponse, "RutaMDF", toEntidad.RutaMDF)
			this.SetearAtributoString( toModeloResponse, "OrigenDestino", toEntidad.OrigenDestino_PK)
			this.SetearAtributoString( toModeloResponse, "Sucursal", toEntidad.Sucursal_PK)
			this.SetearAtributoInteger( toModeloResponse, "Color", toEntidad.Color)
			this.SetearAtributo( toModeloResponse, "Preferente", toEntidad.Preferente)
			this.SetearAtributo( toModeloResponse, "ProcesaPaquetes", toEntidad.ProcesaPaquetes)
			this.SetearAtributo( toModeloResponse, "RealizaBackup", toEntidad.RealizaBackup)
			this.SetearAtributoString( toModeloResponse, "RutaBackup", toEntidad.RutaBackup)
			this.SetearAtributo( toModeloResponse, "Conectada", toEntidad.Conectada)
			this.SetearAtributo( toModeloResponse, "Replica", toEntidad.Replica)
			this.SetearAtributoString( toModeloResponse, "IDBaseDeDatos", toEntidad.IDBaseDeDatos)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutamdf", "CRUTAMDF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Origendestino", "NC1")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Color", "COLOR_BD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Realizabackup", "HACEBACK")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutabackup", "RUTABACK")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Replica", "REPLICA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), COBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Empcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Crutamdf LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nc1 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rutaback LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine