
define class Din_EntidadEmail_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Email"
	cClaseResponse = this.cNamespaceDTOs + ".EmailResponse"
	cClaseModelo = "EmailModelo"
	cEntidad = "Email"
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
				lcRetorno = this.cNamespaceDTOs + "." + "EmailModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "EmailModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "EmailListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "EmailListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "EmailModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Asunto", toEntidad, "Asunto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Texto", toEntidad, "Texto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Servidor", toEntidad, "Servidor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailpara", toEntidad, "Mailpara" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailcopia", toEntidad, "Mailcopia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailcopiaoculta", toEntidad, "Mailcopiaoculta" )
			this.SetearDetalleArchivosdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleEntidades( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Enviaralguardar", toEntidad, "Enviaralguardar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Confirmaenvio", toEntidad, "Confirmaenvio" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleArchivosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ArchivosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ArchivosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ArchivosDetalle.LimpiarItem()
			else
				try
					toEntidad.ArchivosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ArchivosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Archivo", toEntidad.ArchivosDetalle.oItem, "Archivo" )
			toEntidad.ArchivosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleEntidades( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Entidades" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Entidades[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Entidades.LimpiarItem()
			else
				try
					toEntidad.Entidades.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Entidades.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Entidad", toEntidad.Entidades.oItem, "Entidad" )
			toEntidad.Entidades.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "Asunto", toEntidad.Asunto)
			this.SetearAtributo( toModeloResponse, "Texto", toEntidad.Texto)
			this.SetearAtributo( toModeloResponse, "observacion", toEntidad.observacion)
			this.SetearAtributoString( toModeloResponse, "Servidor", toEntidad.Servidor_PK)
			this.SetearAtributoString( toModeloResponse, "MailPara", toEntidad.MailPara)
			this.SetearAtributoString( toModeloResponse, "MailCopia", toEntidad.MailCopia)
			this.SetearAtributoString( toModeloResponse, "MailCopiaOculta", toEntidad.MailCopiaOculta)
			this.CargarColeccionModeloArchivosDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloEntidades( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "EnviarAlGuardar", toEntidad.EnviarAlGuardar)
			this.SetearAtributoInteger( toModeloResponse, "ConfirmaEnvio", toEntidad.ConfirmaEnvio)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloArchivosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ArchivosDetalle" ) 
		with toEntidad
			for lnI = 1 to .ArchivosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemArchivosmail" )
				this.SetearAtributoString( loItem, "Codigo", .ArchivosDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Archivo", .ArchivosDetalle.Item(lnI).Archivo)
				this.SetearAtributoInteger( loItem, "NroItem", .ArchivosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloEntidades( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Entidades" ) 
		with toEntidad
			for lnI = 1 to .Entidades.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemEntidadesmail" )
				this.SetearAtributoString( loItem, "Codigo", .Entidades.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Entidad", .Entidades.Item(lnI).Entidad)
				this.SetearAtributoInteger( loItem, "NroItem", .Entidades.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Asunto", "ASUNTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Texto", "CONVERT( VARCHAR(MAX), TEXTO)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Servidor", "SERV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailpara", "MPARA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailcopia", "MCC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailcopiaoculta", "MCCO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Enviaralguardar", "ENVGUAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Confirmaenvio", "ENVIO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descr LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Asunto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Texto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serv LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mpara LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mcc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mcco LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine