
define class Din_EntidadDisenoexpo_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Disenoexpo"
	cClaseResponse = this.cNamespaceDTOs + ".DisenoexpoResponse"
	cClaseModelo = "DisenoexpoModelo"
	cEntidad = "Disenoexpo"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoexpoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoexpoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoexpoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoexpoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoexpoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutasalida", toEntidad, "Rutasalida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Archivosalida", toEntidad, "Archivosalida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Agregarfh", toEntidad, "Agregarfh" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Appendarchivo", toEntidad, "Appendarchivo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutabackup", toEntidad, "Rutabackup" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Archivobackup", toEntidad, "Archivobackup" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Agregarfhbk", toEntidad, "Agregarfhbk" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Appendbackup", toEntidad, "Appendbackup" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoarchivo", toEntidad, "Tipoarchivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Extension", toEntidad, "Extension" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiporegistro", toEntidad, "Tiporegistro_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Delimitadores", toEntidad, "Delimitadores" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Agrupamiento", toEntidad, "Agrupamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Actualizarfechaexportacion", toEntidad, "Actualizarfechaexportacion" )
			this.SetearDetalleEntidades( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comandoexterno", toEntidad, "Comandoexterno" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Parametroscomando", toEntidad, "Parametroscomando" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Categoria", toEntidad, "Categoria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Favorito", toEntidad, "Favorito" )
			this.SetearDetalleAreas( toEntidad, toModeloEnRequest )
			this.SetearDetalleAtributos( toEntidad, toModeloEnRequest )
		endwith
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
			this.SetearAtributoString( toModeloResponse, "RutaSalida", toEntidad.RutaSalida)
			this.SetearAtributoString( toModeloResponse, "ArchivoSalida", toEntidad.ArchivoSalida)
			this.SetearAtributo( toModeloResponse, "AgregarFH", toEntidad.AgregarFH)
			this.SetearAtributo( toModeloResponse, "AppendArchivo", toEntidad.AppendArchivo)
			this.SetearAtributoString( toModeloResponse, "RutaBackup", toEntidad.RutaBackup)
			this.SetearAtributoString( toModeloResponse, "ArchivoBackup", toEntidad.ArchivoBackup)
			this.SetearAtributo( toModeloResponse, "AgregarFHBK", toEntidad.AgregarFHBK)
			this.SetearAtributo( toModeloResponse, "AppendBackup", toEntidad.AppendBackup)
			this.SetearAtributoString( toModeloResponse, "TipoArchivo", toEntidad.TipoArchivo_PK)
			this.SetearAtributoString( toModeloResponse, "Extension", toEntidad.Extension)
			this.SetearAtributoString( toModeloResponse, "TipoRegistro", toEntidad.TipoRegistro_PK)
			this.SetearAtributoString( toModeloResponse, "Delimitadores", toEntidad.Delimitadores)
			this.SetearAtributoString( toModeloResponse, "Agrupamiento", toEntidad.Agrupamiento)
			this.SetearAtributo( toModeloResponse, "ActualizarFechaExportacion", toEntidad.ActualizarFechaExportacion)
			this.CargarColeccionModeloEntidades( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "ComandoExterno", toEntidad.ComandoExterno)
			this.SetearAtributoString( toModeloResponse, "ParametrosComando", toEntidad.ParametrosComando)
			this.SetearAtributoInteger( toModeloResponse, "Categoria", toEntidad.Categoria)
			this.SetearAtributo( toModeloResponse, "Favorito", toEntidad.Favorito)
			this.CargarColeccionModeloAreas( toModeloResponse, toEntidad )
			this.CargarColeccionModeloAtributos( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloEntidades( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Entidades" ) 
		with toEntidad
			for lnI = 1 to .Entidades.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemEntidadesexpo" )
				this.SetearAtributoString( loItem, "Codigo", .Entidades.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Entidad", .Entidades.Item(lnI).Entidad)
				this.SetearAtributoInteger( loItem, "NroItem", .Entidades.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAreas( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Areas" ) 
		with toEntidad
			for lnI = 1 to .Areas.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAreasexpo" )
				this.SetearAtributoString( loItem, "Codigo", .Areas.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Area", .Areas.Item(lnI).Area)
				this.SetearAtributoString( loItem, "Tipo", .Areas.Item(lnI).Tipo_PK)
				this.SetearAtributoString( loItem, "TipoDetalle", .Areas.Item(lnI).TipoDetalle)
				this.SetearAtributoInteger( loItem, "Orden", .Areas.Item(lnI).Orden)
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAtributosexpo" )
				this.SetearAtributoString( loItem, "Codigo", .Atributos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Area", .Atributos.Item(lnI).Area)
				this.SetearAtributoString( loItem, "Tipo", .Atributos.Item(lnI).Tipo_PK)
				this.SetearAtributoString( loItem, "TipoDetalle", .Atributos.Item(lnI).TipoDetalle)
				this.SetearAtributoString( loItem, "Atributo", .Atributos.Item(lnI).Atributo)
				this.SetearAtributoInteger( loItem, "Orden", .Atributos.Item(lnI).Orden)
				this.SetearAtributoInteger( loItem, "Ancho", .Atributos.Item(lnI).Ancho)
				this.SetearAtributoString( loItem, "Conversion", .Atributos.Item(lnI).Conversion_PK)
				this.SetearAtributoString( loItem, "Formato", .Atributos.Item(lnI).Formato_PK)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutasalida", "CRUTASAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Archivosalida", "CARCHSAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Agregarfh", "LAGRFH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Appendarchivo", "APPENDARCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutabackup", "CRUTABKP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Archivobackup", "CARCHBKP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Agregarfhbk", "LAGRFHBP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Appendbackup", "APPENDBACK")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoarchivo", "CTIPARCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Extension", "CEXTEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiporegistro", "CTIPREG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Delimitadores", "CDELIMI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Agrupamiento", "AGRUP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Actualizarfechaexportacion", "ACTFECEXP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comandoexterno", "COMEXT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Parametroscomando", "PARCOMA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Categoria", "CATEGORIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Favorito", "FAVORITO")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Crutasal LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Carchsal LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Crutabkp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Carchbkp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctiparch LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cexten LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctipreg LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cdelimi LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Agrup LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Comext LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Parcoma LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine