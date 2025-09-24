
define class Din_EntidadDisenoimpo_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Disenoimpo"
	cClaseResponse = this.cNamespaceDTOs + ".DisenoimpoResponse"
	cClaseModelo = "DisenoimpoModelo"
	cEntidad = "Disenoimpo"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Archivoentrada", toEntidad, "Archivoentrada" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoarchivo", toEntidad, "Tipoarchivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidad", toEntidad, "Entidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modo", toEntidad, "Modo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidaddelineasdecorte", toEntidad, "Cantidaddelineasdecorte" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comando", toEntidad, "Comando" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Parametroscomando", toEntidad, "Parametroscomando" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiporegistro", toEntidad, "Tiporegistro_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Delimitadores", toEntidad, "Delimitadores" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Detecciondetalle", toEntidad, "Detecciondetalle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ignorarinicio", toEntidad, "Ignorarinicio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ignorarfinal", toEntidad, "Ignorarfinal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ignorarlineasenblanco", toEntidad, "Ignorarlineasenblanco" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ignorarlineasqueempiezancon", toEntidad, "Ignorarlineasqueempiezancon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Accionconarchivoentradasinalertas", toEntidad, "Accionconarchivoentradasinalertas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutaprocesados", toEntidad, "Rutaprocesados" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Accionconarchivoentradaconalertas", toEntidad, "Accionconarchivoentradaconalertas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutaalertas", toEntidad, "Rutaalertas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Accionconarchivoerrores", toEntidad, "Accionconarchivoerrores" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutaerrores", toEntidad, "Rutaerrores" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sololineasqueempiezancon", toEntidad, "Sololineasqueempiezancon" )
			this.SetearDetalleAreas( toEntidad, toModeloEnRequest )
			this.SetearDetalleAtributos( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAreas( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Areas" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Areas[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Areas.LimpiarItem()
			else
				try
					toEntidad.Areas.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Areas.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Area", toEntidad.Areas.oItem, "Area" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.Areas.oItem, "Tipo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipodetalle", toEntidad.Areas.oItem, "TipoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Orden", toEntidad.Areas.oItem, "Orden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Detecciondetallevalor", toEntidad.Areas.oItem, "deteccionDetalleValor" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cargaparcial", toEntidad.Areas.oItem, "CargaParcial" )
			toEntidad.Areas.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAtributos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Atributos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Atributos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Atributos.LimpiarItem()
			else
				try
					toEntidad.Atributos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Atributos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Area", toEntidad.Atributos.oItem, "Area" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.Atributos.oItem, "Tipo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipodetalle", toEntidad.Atributos.oItem, "TipoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Atributo", toEntidad.Atributos.oItem, "Atributo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Orden", toEntidad.Atributos.oItem, "Orden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Ancho", toEntidad.Atributos.oItem, "Ancho" )
			this.SetearAtributoModeloEnEntidad( loItem, "Conversion", toEntidad.Atributos.oItem, "Conversion_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Formato", toEntidad.Atributos.oItem, "Formato_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Condicion", toEntidad.Atributos.oItem, "Condicion_PK" )
			toEntidad.Atributos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoString( toModeloResponse, "ArchivoEntrada", toEntidad.ArchivoEntrada)
			this.SetearAtributoString( toModeloResponse, "TipoArchivo", toEntidad.TipoArchivo_PK)
			this.SetearAtributoString( toModeloResponse, "Entidad", toEntidad.Entidad)
			this.SetearAtributoString( toModeloResponse, "Modo", toEntidad.Modo)
			this.SetearAtributoInteger( toModeloResponse, "CantidadDeLineasDeCorte", toEntidad.CantidadDeLineasDeCorte)
			this.SetearAtributoString( toModeloResponse, "Comando", toEntidad.Comando)
			this.SetearAtributoString( toModeloResponse, "ParametrosComando", toEntidad.ParametrosComando)
			this.SetearAtributoString( toModeloResponse, "TipoRegistro", toEntidad.TipoRegistro_PK)
			this.SetearAtributoString( toModeloResponse, "Delimitadores", toEntidad.Delimitadores)
			this.SetearAtributoString( toModeloResponse, "DeteccionDetalle", toEntidad.DeteccionDetalle)
			this.SetearAtributoInteger( toModeloResponse, "IgnorarInicio", toEntidad.IgnorarInicio)
			this.SetearAtributoInteger( toModeloResponse, "IgnorarFinal", toEntidad.IgnorarFinal)
			this.SetearAtributo( toModeloResponse, "IgnorarLineasEnBlanco", toEntidad.IgnorarLineasEnBlanco)
			this.SetearAtributoString( toModeloResponse, "IgnorarLineasQueEmpiezanCon", toEntidad.IgnorarLineasQueEmpiezanCon)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributoString( toModeloResponse, "AccionConArchivoEntradaSinAlertas", toEntidad.AccionConArchivoEntradaSinAlertas)
			this.SetearAtributoString( toModeloResponse, "RutaProcesados", toEntidad.RutaProcesados)
			this.SetearAtributoString( toModeloResponse, "AccionConArchivoEntradaConAlertas", toEntidad.AccionConArchivoEntradaConAlertas)
			this.SetearAtributoString( toModeloResponse, "RutaAlertas", toEntidad.RutaAlertas)
			this.SetearAtributoString( toModeloResponse, "AccionConArchivoErrores", toEntidad.AccionConArchivoErrores)
			this.SetearAtributoString( toModeloResponse, "RutaErrores", toEntidad.RutaErrores)
			this.SetearAtributoString( toModeloResponse, "SoloLineasQueEmpiezanCon", toEntidad.SoloLineasQueEmpiezanCon)
			this.CargarColeccionModeloAreas( toModeloResponse, toEntidad )
			this.CargarColeccionModeloAtributos( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAreas( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Areas" ) 
		with toEntidad
			for lnI = 1 to .Areas.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAreasimpo" )
				this.SetearAtributoString( loItem, "Codigo", .Areas.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Area", .Areas.Item(lnI).Area)
				this.SetearAtributoString( loItem, "Tipo", .Areas.Item(lnI).Tipo_PK)
				this.SetearAtributoString( loItem, "TipoDetalle", .Areas.Item(lnI).TipoDetalle)
				this.SetearAtributoInteger( loItem, "Orden", .Areas.Item(lnI).Orden)
				this.SetearAtributoString( loItem, "deteccionDetalleValor", .Areas.Item(lnI).deteccionDetalleValor)
				this.SetearAtributo( loItem, "CargaParcial", .Areas.Item(lnI).CargaParcial)
				this.SetearAtributoInteger( loItem, "NroItem", .Areas.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAtributos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Atributos" ) 
		with toEntidad
			for lnI = 1 to .Atributos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAtributosimpo" )
				this.SetearAtributoString( loItem, "Codigo", .Atributos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Area", .Atributos.Item(lnI).Area)
				this.SetearAtributoString( loItem, "Tipo", .Atributos.Item(lnI).Tipo_PK)
				this.SetearAtributoString( loItem, "TipoDetalle", .Atributos.Item(lnI).TipoDetalle)
				this.SetearAtributoString( loItem, "Atributo", .Atributos.Item(lnI).Atributo)
				this.SetearAtributoInteger( loItem, "Orden", .Atributos.Item(lnI).Orden)
				this.SetearAtributoInteger( loItem, "Ancho", .Atributos.Item(lnI).Ancho)
				this.SetearAtributoString( loItem, "Conversion", .Atributos.Item(lnI).Conversion_PK)
				this.SetearAtributoString( loItem, "Formato", .Atributos.Item(lnI).Formato_PK)
				this.SetearAtributoString( loItem, "Condicion", .Atributos.Item(lnI).Condicion_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .Atributos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "CDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), COBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Archivoentrada", "CARCHENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoarchivo", "CTIPARCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entidad", "CENTIDAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Modo", "CMODO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidaddelineasdecorte", "CANLINCORT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comando", "CCOMANDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Parametroscomando", "PARCOMA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiporegistro", "CTIPREG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Delimitadores", "CDELIMI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Detecciondetalle", "DETECDET")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ignorarinicio", "IGNORINI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ignorarfinal", "IGNORFIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ignorarlineasenblanco", "IGNORBLANC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ignorarlineasqueempiezancon", "CLINIGNOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "CBDATOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Accionconarchivoentradasinalertas", "ACCSINALER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutaprocesados", "CRUTAPROC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Accionconarchivoentradaconalertas", "ACCCONALER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutaalertas", "CRUTAALERT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Accionconarchivoerrores", "ACCCONERR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutaerrores", "CRUTAERR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sololineasqueempiezancon", "CSOLOLIN")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cdes LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Carchent LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctiparch LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Centidad LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cmodo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccomando LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Parcoma LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctipreg LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cdelimi LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Detecdet LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clinignor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cbdatos LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Accsinaler LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Crutaproc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Accconaler LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Crutaalert LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Accconerr LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Crutaerr LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Csololin LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine