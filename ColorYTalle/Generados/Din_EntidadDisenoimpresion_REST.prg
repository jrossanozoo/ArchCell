
define class Din_EntidadDisenoimpresion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Disenoimpresion"
	cClaseResponse = this.cNamespaceDTOs + ".DisenoimpresionResponse"
	cClaseModelo = "DisenoimpresionModelo"
	cEntidad = "Disenoimpresion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpresionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpresionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpresionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpresionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DisenoimpresionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estilo", toEntidad, "Estilo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicion", toEntidad, "Condicion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitasalidaaimpresora", toEntidad, "Habilitasalidaaimpresora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impresionautomatica", toEntidad, "Impresionautomatica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Series", toEntidad, "Series" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sugiere", toEntidad, "Sugiere" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Opciondesalida", toEntidad, "Opciondesalida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puerto", toEntidad, "Puerto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadcopias", toEntidad, "Cantidadcopias" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Aplicalimite", toEntidad, "Aplicalimite" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Advierte", toEntidad, "Advierte" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitasalidaapdf", toEntidad, "Habilitasalidaapdf" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pdfautomatico", toEntidad, "Pdfautomatico" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Confirmapdf", toEntidad, "Confirmapdf" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutapdf", toEntidad, "Rutapdf" )
			this.SetearDetalleEntidades( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Columnas", toEntidad, "Columnas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Segundos", toEntidad, "Segundos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margensup", toEntidad, "Margensup" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margenizq", toEntidad, "Margenizq" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margeninf", toEntidad, "Margeninf" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margender", toEntidad, "Margender" )
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
			this.SetearAtributoModeloEnEntidad( loItem, "Y", toEntidad.Areas.oItem, "y" )
			this.SetearAtributoModeloEnEntidad( loItem, "X", toEntidad.Areas.oItem, "x" )
			this.SetearAtributoModeloEnEntidad( loItem, "Ancho", toEntidad.Areas.oItem, "Ancho" )
			this.SetearAtributoModeloEnEntidad( loItem, "Alto", toEntidad.Areas.oItem, "Alto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Estilo", toEntidad.Areas.oItem, "Estilo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Condicion", toEntidad.Areas.oItem, "Condicion" )
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
			this.SetearAtributoModeloEnEntidad( loItem, "Contenido", toEntidad.Atributos.oItem, "Contenido" )
			this.SetearAtributoModeloEnEntidad( loItem, "Y", toEntidad.Atributos.oItem, "y" )
			this.SetearAtributoModeloEnEntidad( loItem, "X", toEntidad.Atributos.oItem, "x" )
			this.SetearAtributoModeloEnEntidad( loItem, "Orientacion", toEntidad.Atributos.oItem, "Orientacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Ancho", toEntidad.Atributos.oItem, "Ancho" )
			this.SetearAtributoModeloEnEntidad( loItem, "Estilo", toEntidad.Atributos.oItem, "Estilo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Mascara", toEntidad.Atributos.oItem, "Mascara" )
			this.SetearAtributoModeloEnEntidad( loItem, "Condicion", toEntidad.Atributos.oItem, "Condicion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Funcionagrupar", toEntidad.Atributos.oItem, "FuncionAgrupar" )
			this.SetearAtributoModeloEnEntidad( loItem, "Prioridadordenamiento", toEntidad.Atributos.oItem, "PrioridadOrdenamiento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipoordenamiento", toEntidad.Atributos.oItem, "TipoOrdenamiento" )
			toEntidad.Atributos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "Estilo", toEntidad.Estilo_PK)
			this.SetearAtributoString( toModeloResponse, "Condicion", toEntidad.Condicion)
			this.SetearAtributo( toModeloResponse, "HabilitaSalidaAImpresora", toEntidad.HabilitaSalidaAImpresora)
			this.SetearAtributo( toModeloResponse, "ImpresionAutomatica", toEntidad.ImpresionAutomatica)
			this.SetearAtributoString( toModeloResponse, "Series", toEntidad.Series)
			this.SetearAtributoInteger( toModeloResponse, "Sugiere", toEntidad.Sugiere)
			this.SetearAtributoInteger( toModeloResponse, "OpcionDeSalida", toEntidad.OpcionDeSalida)
			this.SetearAtributoString( toModeloResponse, "Puerto", toEntidad.Puerto)
			this.SetearAtributoInteger( toModeloResponse, "CantidadCopias", toEntidad.CantidadCopias)
			this.SetearAtributoInteger( toModeloResponse, "AplicaLimite", toEntidad.AplicaLimite)
			this.SetearAtributoInteger( toModeloResponse, "Advierte", toEntidad.Advierte)
			this.SetearAtributo( toModeloResponse, "HabilitaSalidaAPdf", toEntidad.HabilitaSalidaAPdf)
			this.SetearAtributo( toModeloResponse, "PdfAutomatico", toEntidad.PdfAutomatico)
			this.SetearAtributoInteger( toModeloResponse, "ConfirmaPdf", toEntidad.ConfirmaPdf)
			this.SetearAtributoString( toModeloResponse, "RutaPdf", toEntidad.RutaPdf)
			this.CargarColeccionModeloEntidades( toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Columnas", toEntidad.Columnas)
			this.SetearAtributoDecimal( toModeloResponse, "Segundos", toEntidad.Segundos)
			this.SetearAtributoDecimal( toModeloResponse, "MargenSup", toEntidad.MargenSup)
			this.SetearAtributoDecimal( toModeloResponse, "MargenIzq", toEntidad.MargenIzq)
			this.SetearAtributoDecimal( toModeloResponse, "MargenInf", toEntidad.MargenInf)
			this.SetearAtributoDecimal( toModeloResponse, "MargenDer", toEntidad.MargenDer)
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemEntidades" )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAreasimpresion" )
				this.SetearAtributoString( loItem, "Codigo", .Areas.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Area", .Areas.Item(lnI).Area)
				this.SetearAtributoString( loItem, "Tipo", .Areas.Item(lnI).Tipo_PK)
				this.SetearAtributoDecimal( loItem, "y", .Areas.Item(lnI).y)
				this.SetearAtributoDecimal( loItem, "x", .Areas.Item(lnI).x)
				this.SetearAtributoDecimal( loItem, "Ancho", .Areas.Item(lnI).Ancho)
				this.SetearAtributoDecimal( loItem, "Alto", .Areas.Item(lnI).Alto)
				this.SetearAtributoString( loItem, "Estilo", .Areas.Item(lnI).Estilo_PK)
				this.SetearAtributoString( loItem, "Condicion", .Areas.Item(lnI).Condicion)
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAtributosimpresion" )
				this.SetearAtributoString( loItem, "Codigo", .Atributos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Area", .Atributos.Item(lnI).Area)
				this.SetearAtributoString( loItem, "Tipo", .Atributos.Item(lnI).Tipo_PK)
				this.SetearAtributoString( loItem, "TipoDetalle", .Atributos.Item(lnI).TipoDetalle)
				this.SetearAtributoString( loItem, "Contenido", .Atributos.Item(lnI).Contenido)
				this.SetearAtributoDecimal( loItem, "y", .Atributos.Item(lnI).y)
				this.SetearAtributoDecimal( loItem, "x", .Atributos.Item(lnI).x)
				this.SetearAtributoInteger( loItem, "Orientacion", .Atributos.Item(lnI).Orientacion)
				this.SetearAtributoDecimal( loItem, "Ancho", .Atributos.Item(lnI).Ancho)
				this.SetearAtributoString( loItem, "Estilo", .Atributos.Item(lnI).Estilo_PK)
				this.SetearAtributoString( loItem, "Mascara", .Atributos.Item(lnI).Mascara)
				this.SetearAtributoString( loItem, "Condicion", .Atributos.Item(lnI).Condicion)
				this.SetearAtributoInteger( loItem, "FuncionAgrupar", .Atributos.Item(lnI).FuncionAgrupar)
				this.SetearAtributoInteger( loItem, "PrioridadOrdenamiento", .Atributos.Item(lnI).PrioridadOrdenamiento)
				this.SetearAtributoInteger( loItem, "TipoOrdenamiento", .Atributos.Item(lnI).TipoOrdenamiento)
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), COBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estilo", "CESTILO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicion", "CCONDICI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitasalidaaimpresora", "LHABIMPRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Impresionautomatica", "IMPAUTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Series", "CSERIES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sugiere", "NSUGIERE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Opciondesalida", "NOPTSAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puerto", "CPUERTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadcopias", "NCANTCOP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Aplicalimite", "NLIMITE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Advierte", "NADVIERTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitasalidaapdf", "LHABPDF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pdfautomatico", "LPDFAUTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Confirmapdf", "NCONFPDF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutapdf", "CRUTAPDF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Columnas", "NCANTCOL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Segundos", "NSEGUNDOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margensup", "NMARSUP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margenizq", "NMARIZQ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margeninf", "NMARINF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margender", "NMARDER")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cestilo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccondici LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cseries LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cpuerto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Crutapdf LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine