
define class Din_EntidadListadospersonalizados_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Listadospersonalizados"
	cClaseResponse = this.cNamespaceDTOs + ".ListadospersonalizadosResponse"
	cClaseModelo = "ListadospersonalizadosModelo"
	cEntidad = "Listadospersonalizados"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ListadospersonalizadosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ListadospersonalizadosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ListadospersonalizadosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ListadospersonalizadosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ListadospersonalizadosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clistado", toEntidad, "Clistado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Esdefault", toEntidad, "Esdefault" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estilo", toEntidad, "Estilo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margenderecho", toEntidad, "Margenderecho" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margenizquierdo", toEntidad, "Margenizquierdo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margenpie", toEntidad, "Margenpie" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margencabecera", toEntidad, "Margencabecera" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Orientacion", toEntidad, "Orientacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Titulolistado", toEntidad, "Titulolistado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagenlistado", toEntidad, "Imagenlistado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Destinotipo", toEntidad, "Destinotipo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Destinoruta", toEntidad, "Destinoruta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Destinoarchivo", toEntidad, "Destinoarchivo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Destinofechahora", toEntidad, "Destinofechahora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferenciardetalle", toEntidad, "Diferenciardetalle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Colorparaelsombreado", toEntidad, "Colorparaelsombreado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordenadopor", toEntidad, "Ordenadopor" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoordenamiento", toEntidad, "Tipoordenamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatosdetallada", toEntidad, "Basededatosdetallada" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Subtotaldetallado", toEntidad, "Subtotaldetallado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailpara", toEntidad, "Mailpara" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailasunto", toEntidad, "Mailasunto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailconcopia", toEntidad, "Mailconcopia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailconcopiaoculta", toEntidad, "Mailconcopiaoculta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailmensaje", toEntidad, "Mailmensaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearDetalleFiltrosdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleCamposdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleSubtotaldetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleOrdenamientosdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleSalidasdetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleFiltrosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "FiltrosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"FiltrosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.FiltrosDetalle.LimpiarItem()
			else
				try
					toEntidad.FiltrosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.FiltrosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Identificador", toEntidad.FiltrosDetalle.oItem, "Identificador" )
			this.SetearAtributoModeloEnEntidad( loItem, "Idcampo", toEntidad.FiltrosDetalle.oItem, "idCampo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordesde", toEntidad.FiltrosDetalle.oItem, "ValorDesde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sololecturadesde", toEntidad.FiltrosDetalle.oItem, "SoloLecturaDesde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valorhasta", toEntidad.FiltrosDetalle.oItem, "ValorHasta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sololecturahasta", toEntidad.FiltrosDetalle.oItem, "SoloLecturaHasta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Norden", toEntidad.FiltrosDetalle.oItem, "nOrden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Activado", toEntidad.FiltrosDetalle.oItem, "Activado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Criteriodeinicializacion", toEntidad.FiltrosDetalle.oItem, "CriterioDeInicializacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Diashaciaatras", toEntidad.FiltrosDetalle.oItem, "DiasHaciaAtras" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valornumericoinicial_desde", toEntidad.FiltrosDetalle.oItem, "ValorNumericoInicial_Desde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valornumericoinicial_hasta", toEntidad.FiltrosDetalle.oItem, "ValorNumericoInicial_Hasta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valorcaracterinicial_desde", toEntidad.FiltrosDetalle.oItem, "ValorCaracterInicial_Desde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valorcaracterinicial_hasta", toEntidad.FiltrosDetalle.oItem, "ValorCaracterInicial_Hasta" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valorbooleanoinicial", toEntidad.FiltrosDetalle.oItem, "ValorBooleanoInicial" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valorsinoinicial", toEntidad.FiltrosDetalle.oItem, "ValorSiNoInicial" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sololectura", toEntidad.FiltrosDetalle.oItem, "SoloLectura" )
			this.SetearAtributoModeloEnEntidad( loItem, "Noinformar", toEntidad.FiltrosDetalle.oItem, "NoInformar" )
			this.SetearAtributoModeloEnEntidad( loItem, "Nomostrar", toEntidad.FiltrosDetalle.oItem, "NoMostrar" )
			toEntidad.FiltrosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCamposDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "CamposDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"CamposDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.CamposDetalle.LimpiarItem()
			else
				try
					toEntidad.CamposDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.CamposDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Identificador", toEntidad.CamposDetalle.oItem, "Identificador" )
			this.SetearAtributoModeloEnEntidad( loItem, "Idcampo", toEntidad.CamposDetalle.oItem, "idCampo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Etiquetareporte", toEntidad.CamposDetalle.oItem, "EtiquetaReporte" )
			this.SetearAtributoModeloEnEntidad( loItem, "Longitudreporte", toEntidad.CamposDetalle.oItem, "LongitudReporte" )
			this.SetearAtributoModeloEnEntidad( loItem, "Decimalesreporte", toEntidad.CamposDetalle.oItem, "DecimalesReporte" )
			this.SetearAtributoModeloEnEntidad( loItem, "Mostrarceros", toEntidad.CamposDetalle.oItem, "MostrarCeros" )
			this.SetearAtributoModeloEnEntidad( loItem, "Grupovisual", toEntidad.CamposDetalle.oItem, "GrupoVisual" )
			this.SetearAtributoModeloEnEntidad( loItem, "Expresionnueva", toEntidad.CamposDetalle.oItem, "ExpresionNueva_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocalculo", toEntidad.CamposDetalle.oItem, "TipoCalculo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Norden", toEntidad.CamposDetalle.oItem, "nOrden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Activado", toEntidad.CamposDetalle.oItem, "activado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Lineavertical", toEntidad.CamposDetalle.oItem, "LineaVertical" )
			this.SetearAtributoModeloEnEntidad( loItem, "Puedecrecer", toEntidad.CamposDetalle.oItem, "PuedeCrecer" )
			this.SetearAtributoModeloEnEntidad( loItem, "Ocultarepetido", toEntidad.CamposDetalle.oItem, "OcultaRepetido" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tamañooriginalimagen", toEntidad.CamposDetalle.oItem, "TamañoOriginalImagen" )
			this.SetearAtributoModeloEnEntidad( loItem, "Anchoimagen", toEntidad.CamposDetalle.oItem, "AnchoImagen" )
			this.SetearAtributoModeloEnEntidad( loItem, "Altoimagen", toEntidad.CamposDetalle.oItem, "AltoImagen" )
			toEntidad.CamposDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleSubtotalDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "SubtotalDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"SubtotalDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.SubtotalDetalle.LimpiarItem()
			else
				try
					toEntidad.SubtotalDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.SubtotalDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Identificador", toEntidad.SubtotalDetalle.oItem, "Identificador" )
			this.SetearAtributoModeloEnEntidad( loItem, "Idcampo", toEntidad.SubtotalDetalle.oItem, "idCampo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Lnuevapaginaantes", toEntidad.SubtotalDetalle.oItem, "lNuevaPaginaAntes" )
			this.SetearAtributoModeloEnEntidad( loItem, "Norden", toEntidad.SubtotalDetalle.oItem, "nOrden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Activado", toEntidad.SubtotalDetalle.oItem, "Activado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Nsubtotal", toEntidad.SubtotalDetalle.oItem, "nSubTotal" )
			this.SetearAtributoModeloEnEntidad( loItem, "Formula", toEntidad.SubtotalDetalle.oItem, "Formula" )
			this.SetearAtributoModeloEnEntidad( loItem, "Anchoformula", toEntidad.SubtotalDetalle.oItem, "AnchoFormula" )
			this.SetearAtributoModeloEnEntidad( loItem, "Etiquetaformula", toEntidad.SubtotalDetalle.oItem, "EtiquetaFormula" )
			toEntidad.SubtotalDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenamientosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenamientosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenamientosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenamientosDetalle.LimpiarItem()
			else
				try
					toEntidad.OrdenamientosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenamientosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Identificador", toEntidad.OrdenamientosDetalle.oItem, "Identificador" )
			this.SetearAtributoModeloEnEntidad( loItem, "Idcampo", toEntidad.OrdenamientosDetalle.oItem, "idCampo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Norden", toEntidad.OrdenamientosDetalle.oItem, "nOrden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Activado", toEntidad.OrdenamientosDetalle.oItem, "Activado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sentido", toEntidad.OrdenamientosDetalle.oItem, "Sentido" )
			toEntidad.OrdenamientosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleSalidasDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "SalidasDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"SalidasDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.SalidasDetalle.LimpiarItem()
			else
				try
					toEntidad.SalidasDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.SalidasDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.SalidasDetalle.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Extendido", toEntidad.SalidasDetalle.oItem, "Extendido" )
			this.SetearAtributoModeloEnEntidad( loItem, "Activado", toEntidad.SalidasDetalle.oItem, "Activado" )
			toEntidad.SalidasDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "cListado", toEntidad.cListado)
			this.SetearAtributo( toModeloResponse, "EsDefault", toEntidad.EsDefault)
			this.SetearAtributoString( toModeloResponse, "Estilo", toEntidad.Estilo_PK)
			this.SetearAtributoInteger( toModeloResponse, "MargenDerecho", toEntidad.MargenDerecho)
			this.SetearAtributoInteger( toModeloResponse, "MargenIzquierdo", toEntidad.MargenIzquierdo)
			this.SetearAtributoInteger( toModeloResponse, "MargenPie", toEntidad.MargenPie)
			this.SetearAtributoInteger( toModeloResponse, "MargenCabecera", toEntidad.MargenCabecera)
			this.SetearAtributoInteger( toModeloResponse, "Orientacion", toEntidad.Orientacion)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "TituloListado", toEntidad.TituloListado)
			this.SetearAtributoString( toModeloResponse, "ImagenListado", toEntidad.ImagenListado)
			this.SetearAtributoInteger( toModeloResponse, "DestinoTipo", toEntidad.DestinoTipo)
			this.SetearAtributoString( toModeloResponse, "DestinoRuta", toEntidad.DestinoRuta)
			this.SetearAtributoString( toModeloResponse, "DestinoArchivo", toEntidad.DestinoArchivo)
			this.SetearAtributo( toModeloResponse, "DestinoFechaHora", toEntidad.DestinoFechaHora)
			this.SetearAtributo( toModeloResponse, "DiferenciarDetalle", toEntidad.DiferenciarDetalle)
			this.SetearAtributoInteger( toModeloResponse, "ColorParaElSombreado", toEntidad.ColorParaElSombreado)
			this.SetearAtributoLong( toModeloResponse, "OrdenadoPor", toEntidad.OrdenadoPor)
			this.SetearAtributoInteger( toModeloResponse, "TipoOrdenamiento", toEntidad.TipoOrdenamiento)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributo( toModeloResponse, "BaseDeDatosDetallada", toEntidad.BaseDeDatosDetallada)
			this.SetearAtributo( toModeloResponse, "SubtotalDetallado", toEntidad.SubtotalDetallado)
			this.SetearAtributoString( toModeloResponse, "MailPara", toEntidad.MailPara)
			this.SetearAtributoString( toModeloResponse, "MailAsunto", toEntidad.MailAsunto)
			this.SetearAtributoString( toModeloResponse, "MailConCopia", toEntidad.MailConCopia)
			this.SetearAtributoString( toModeloResponse, "MailConCopiaOculta", toEntidad.MailConCopiaOculta)
			this.SetearAtributoString( toModeloResponse, "MailMensaje", toEntidad.MailMensaje)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.CargarColeccionModeloFiltrosDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloCamposDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloSubtotalDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloOrdenamientosDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloSalidasDetalle( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloFiltrosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "FiltrosDetalle" ) 
		with toEntidad
			for lnI = 1 to .FiltrosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemFiltropersonalizado" )
				this.SetearAtributoString( loItem, "codigo", .FiltrosDetalle.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Identificador", .FiltrosDetalle.Item(lnI).Identificador)
				this.SetearAtributoInteger( loItem, "idCampo", .FiltrosDetalle.Item(lnI).idCampo)
				this.SetearAtributoString( loItem, "ValorDesde", .FiltrosDetalle.Item(lnI).ValorDesde)
				this.SetearAtributo( loItem, "SoloLecturaDesde", .FiltrosDetalle.Item(lnI).SoloLecturaDesde)
				this.SetearAtributoString( loItem, "ValorHasta", .FiltrosDetalle.Item(lnI).ValorHasta)
				this.SetearAtributo( loItem, "SoloLecturaHasta", .FiltrosDetalle.Item(lnI).SoloLecturaHasta)
				this.SetearAtributoInteger( loItem, "nOrden", .FiltrosDetalle.Item(lnI).nOrden)
				this.SetearAtributo( loItem, "Activado", .FiltrosDetalle.Item(lnI).Activado)
				this.SetearAtributoInteger( loItem, "CriterioDeInicializacion", .FiltrosDetalle.Item(lnI).CriterioDeInicializacion)
				this.SetearAtributoInteger( loItem, "DiasHaciaAtras", .FiltrosDetalle.Item(lnI).DiasHaciaAtras)
				this.SetearAtributoDecimal( loItem, "ValorNumericoInicial_Desde", .FiltrosDetalle.Item(lnI).ValorNumericoInicial_Desde)
				this.SetearAtributoDecimal( loItem, "ValorNumericoInicial_Hasta", .FiltrosDetalle.Item(lnI).ValorNumericoInicial_Hasta)
				this.SetearAtributoString( loItem, "ValorCaracterInicial_Desde", .FiltrosDetalle.Item(lnI).ValorCaracterInicial_Desde)
				this.SetearAtributoString( loItem, "ValorCaracterInicial_Hasta", .FiltrosDetalle.Item(lnI).ValorCaracterInicial_Hasta)
				this.SetearAtributoInteger( loItem, "ValorBooleanoInicial", .FiltrosDetalle.Item(lnI).ValorBooleanoInicial)
				this.SetearAtributoInteger( loItem, "ValorSiNoInicial", .FiltrosDetalle.Item(lnI).ValorSiNoInicial)
				this.SetearAtributo( loItem, "SoloLectura", .FiltrosDetalle.Item(lnI).SoloLectura)
				this.SetearAtributo( loItem, "NoInformar", .FiltrosDetalle.Item(lnI).NoInformar)
				this.SetearAtributo( loItem, "NoMostrar", .FiltrosDetalle.Item(lnI).NoMostrar)
				this.SetearAtributoInteger( loItem, "NroItem", .FiltrosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCamposDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "CamposDetalle" ) 
		with toEntidad
			for lnI = 1 to .CamposDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCampopersonalizado" )
				this.SetearAtributoString( loItem, "codigo", .CamposDetalle.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Identificador", .CamposDetalle.Item(lnI).Identificador)
				this.SetearAtributoInteger( loItem, "idCampo", .CamposDetalle.Item(lnI).idCampo)
				this.SetearAtributoString( loItem, "EtiquetaReporte", .CamposDetalle.Item(lnI).EtiquetaReporte)
				this.SetearAtributoInteger( loItem, "LongitudReporte", .CamposDetalle.Item(lnI).LongitudReporte)
				this.SetearAtributoInteger( loItem, "DecimalesReporte", .CamposDetalle.Item(lnI).DecimalesReporte)
				this.SetearAtributoInteger( loItem, "MostrarCeros", .CamposDetalle.Item(lnI).MostrarCeros)
				this.SetearAtributoInteger( loItem, "GrupoVisual", .CamposDetalle.Item(lnI).GrupoVisual)
				this.SetearAtributoString( loItem, "ExpresionNueva", .CamposDetalle.Item(lnI).ExpresionNueva_PK)
				this.SetearAtributoString( loItem, "TipoCalculo", .CamposDetalle.Item(lnI).TipoCalculo)
				this.SetearAtributoLong( loItem, "nOrden", .CamposDetalle.Item(lnI).nOrden)
				this.SetearAtributo( loItem, "activado", .CamposDetalle.Item(lnI).activado)
				this.SetearAtributo( loItem, "LineaVertical", .CamposDetalle.Item(lnI).LineaVertical)
				this.SetearAtributo( loItem, "PuedeCrecer", .CamposDetalle.Item(lnI).PuedeCrecer)
				this.SetearAtributo( loItem, "OcultaRepetido", .CamposDetalle.Item(lnI).OcultaRepetido)
				this.SetearAtributo( loItem, "TamañoOriginalImagen", .CamposDetalle.Item(lnI).TamañoOriginalImagen)
				this.SetearAtributoDecimal( loItem, "AnchoImagen", .CamposDetalle.Item(lnI).AnchoImagen)
				this.SetearAtributoDecimal( loItem, "AltoImagen", .CamposDetalle.Item(lnI).AltoImagen)
				this.SetearAtributoInteger( loItem, "NroItem", .CamposDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloSubtotalDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "SubtotalDetalle" ) 
		with toEntidad
			for lnI = 1 to .SubtotalDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCamposubtotal" )
				this.SetearAtributoString( loItem, "codigo", .SubtotalDetalle.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Identificador", .SubtotalDetalle.Item(lnI).Identificador)
				this.SetearAtributoInteger( loItem, "idCampo", .SubtotalDetalle.Item(lnI).idCampo)
				this.SetearAtributo( loItem, "lNuevaPaginaAntes", .SubtotalDetalle.Item(lnI).lNuevaPaginaAntes)
				this.SetearAtributoLong( loItem, "nOrden", .SubtotalDetalle.Item(lnI).nOrden)
				this.SetearAtributo( loItem, "Activado", .SubtotalDetalle.Item(lnI).Activado)
				this.SetearAtributoInteger( loItem, "nSubTotal", .SubtotalDetalle.Item(lnI).nSubTotal)
				this.SetearAtributoString( loItem, "Formula", .SubtotalDetalle.Item(lnI).Formula)
				this.SetearAtributoInteger( loItem, "AnchoFormula", .SubtotalDetalle.Item(lnI).AnchoFormula)
				this.SetearAtributoString( loItem, "EtiquetaFormula", .SubtotalDetalle.Item(lnI).EtiquetaFormula)
				this.SetearAtributoInteger( loItem, "NroItem", .SubtotalDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenamientosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenamientosDetalle" ) 
		with toEntidad
			for lnI = 1 to .OrdenamientosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCampoordenamiento" )
				this.SetearAtributoString( loItem, "codigo", .OrdenamientosDetalle.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Identificador", .OrdenamientosDetalle.Item(lnI).Identificador)
				this.SetearAtributoInteger( loItem, "idCampo", .OrdenamientosDetalle.Item(lnI).idCampo)
				this.SetearAtributoLong( loItem, "nOrden", .OrdenamientosDetalle.Item(lnI).nOrden)
				this.SetearAtributo( loItem, "Activado", .OrdenamientosDetalle.Item(lnI).Activado)
				this.SetearAtributoInteger( loItem, "Sentido", .OrdenamientosDetalle.Item(lnI).Sentido)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenamientosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloSalidasDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "SalidasDetalle" ) 
		with toEntidad
			for lnI = 1 to .SalidasDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemFormatosalida" )
				this.SetearAtributoString( loItem, "codigo", .SalidasDetalle.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Tipo", .SalidasDetalle.Item(lnI).Tipo)
				this.SetearAtributo( loItem, "Extendido", .SalidasDetalle.Item(lnI).Extendido)
				this.SetearAtributo( loItem, "Activado", .SalidasDetalle.Item(lnI).Activado)
				this.SetearAtributoInteger( loItem, "NroItem", .SalidasDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clistado", "CLISTADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Esdefault", "ESDEFAULT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estilo", "CESTILO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margenderecho", "MDER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margenizquierdo", "MIZQ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margenpie", "MPIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margencabecera", "MCAB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Orientacion", "ORIEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Titulolistado", "TITULO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagenlistado", "IMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Destinotipo", "DSTNOTIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Destinoruta", "DSTNORUT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Destinoarchivo", "DSTNOARC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Destinofechahora", "DSTNOFH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diferenciardetalle", "DDETALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Colorparaelsombreado", "COLORSOMBR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordenadopor", "ORDPOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoordenamiento", "TIPORD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "DBDATO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatosdetallada", "DBDATOD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Subtotaldetallado", "SUBTDETALL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailpara", "MPARA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailasunto", "MASUNTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailconcopia", "MCC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailconcopiaoculta", "MCCO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailmensaje", "MENSAJE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clistado LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cestilo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Titulo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Imagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dstnorut LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dstnoarc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dbdato LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mpara LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Masunto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mcc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mcco LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mensaje LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine