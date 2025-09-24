
define class Din_EntidadPropiedadeslistados_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Propiedadeslistados"
	cClaseResponse = this.cNamespaceDTOs + ".PropiedadeslistadosResponse"
	cClaseModelo = "PropiedadeslistadosModelo"
	cEntidad = "Propiedadeslistados"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PropiedadeslistadosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "PropiedadeslistadosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "PropiedadeslistadosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PropiedadeslistadosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "PropiedadeslistadosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nombre", toEntidad, "Nombre" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Etiqueta", toEntidad, "Etiqueta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Longitud", toEntidad, "Longitud" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Decimalesreporte", toEntidad, "Decimalesreporte" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocalculo", toEntidad, "Tipocalculo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mostrarceros", toEntidad, "Mostrarceros" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puedecrecer", toEntidad, "Puedecrecer" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ocultarepetido", toEntidad, "Ocultarepetido" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Lineavertical", toEntidad, "Lineavertical" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Anchoimagen", toEntidad, "Anchoimagen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tamañooriginalimagen", toEntidad, "Tamañooriginalimagen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Altoimagen", toEntidad, "Altoimagen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Criteriodeinicializacion", toEntidad, "Criteriodeinicializacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diashaciaatras", toEntidad, "Diashaciaatras" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valornumericoinicial_desde", toEntidad, "Valornumericoinicial_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valornumericoinicial_hasta", toEntidad, "Valornumericoinicial_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valorcaracterinicial_desde", toEntidad, "Valorcaracterinicial_desde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valorcaracterinicial_hasta", toEntidad, "Valorcaracterinicial_hasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valorbooleanoinicial", toEntidad, "Valorbooleanoinicial" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valorsinoinicial", toEntidad, "Valorsinoinicial" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sololectura", toEntidad, "Sololectura" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Noinformar", toEntidad, "Noinformar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nomostrar", toEntidad, "Nomostrar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Titulolistado", toEntidad, "Titulolistado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagenlistado", toEntidad, "Imagenlistado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imprimefechadeimpresion", toEntidad, "Imprimefechadeimpresion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imprimehoradeimpresion", toEntidad, "Imprimehoradeimpresion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estilo", toEntidad, "Estilo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margenderecho", toEntidad, "Margenderecho" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margenizquierdo", toEntidad, "Margenizquierdo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margencabecera", toEntidad, "Margencabecera" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Margenpie", toEntidad, "Margenpie" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Orientacion", toEntidad, "Orientacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferenciardetalle", toEntidad, "Diferenciardetalle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Colorparaelsombreado", toEntidad, "Colorparaelsombreado" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Nombre", toEntidad.Nombre)
			this.SetearAtributoString( toModeloResponse, "Etiqueta", toEntidad.Etiqueta)
			this.SetearAtributoInteger( toModeloResponse, "Longitud", toEntidad.Longitud)
			this.SetearAtributoInteger( toModeloResponse, "DecimalesReporte", toEntidad.DecimalesReporte)
			this.SetearAtributoString( toModeloResponse, "TipoCalculo", toEntidad.TipoCalculo)
			this.SetearAtributo( toModeloResponse, "MostrarCeros", toEntidad.MostrarCeros)
			this.SetearAtributo( toModeloResponse, "PuedeCrecer", toEntidad.PuedeCrecer)
			this.SetearAtributo( toModeloResponse, "OcultaRepetido", toEntidad.OcultaRepetido)
			this.SetearAtributo( toModeloResponse, "LineaVertical", toEntidad.LineaVertical)
			this.SetearAtributoDecimal( toModeloResponse, "AnchoImagen", toEntidad.AnchoImagen)
			this.SetearAtributo( toModeloResponse, "TamañoOriginalImagen", toEntidad.TamañoOriginalImagen)
			this.SetearAtributoDecimal( toModeloResponse, "AltoImagen", toEntidad.AltoImagen)
			this.SetearAtributoInteger( toModeloResponse, "CriterioDeInicializacion", toEntidad.CriterioDeInicializacion)
			this.SetearAtributoInteger( toModeloResponse, "DiasHaciaAtras", toEntidad.DiasHaciaAtras)
			this.SetearAtributoDecimal( toModeloResponse, "ValorNumericoInicial_Desde", toEntidad.ValorNumericoInicial_Desde)
			this.SetearAtributoDecimal( toModeloResponse, "ValorNumericoInicial_Hasta", toEntidad.ValorNumericoInicial_Hasta)
			this.SetearAtributoString( toModeloResponse, "ValorCaracterInicial_Desde", toEntidad.ValorCaracterInicial_Desde)
			this.SetearAtributoString( toModeloResponse, "ValorCaracterInicial_Hasta", toEntidad.ValorCaracterInicial_Hasta)
			this.SetearAtributoInteger( toModeloResponse, "ValorBooleanoInicial", toEntidad.ValorBooleanoInicial)
			this.SetearAtributoInteger( toModeloResponse, "ValorSiNoInicial", toEntidad.ValorSiNoInicial)
			this.SetearAtributo( toModeloResponse, "SoloLectura", toEntidad.SoloLectura)
			this.SetearAtributo( toModeloResponse, "NoInformar", toEntidad.NoInformar)
			this.SetearAtributo( toModeloResponse, "NoMostrar", toEntidad.NoMostrar)
			this.SetearAtributoString( toModeloResponse, "TituloListado", toEntidad.TituloListado)
			this.SetearAtributoString( toModeloResponse, "ImagenListado", toEntidad.ImagenListado)
			this.SetearAtributo( toModeloResponse, "ImprimeFechaDeImpresion", toEntidad.ImprimeFechaDeImpresion)
			this.SetearAtributo( toModeloResponse, "ImprimeHoraDeImpresion", toEntidad.ImprimeHoraDeImpresion)
			this.SetearAtributoString( toModeloResponse, "Estilo", toEntidad.Estilo_PK)
			this.SetearAtributoInteger( toModeloResponse, "MargenDerecho", toEntidad.MargenDerecho)
			this.SetearAtributoInteger( toModeloResponse, "MargenIzquierdo", toEntidad.MargenIzquierdo)
			this.SetearAtributoInteger( toModeloResponse, "MargenCabecera", toEntidad.MargenCabecera)
			this.SetearAtributoInteger( toModeloResponse, "MargenPie", toEntidad.MargenPie)
			this.SetearAtributoInteger( toModeloResponse, "Orientacion", toEntidad.Orientacion)
			this.SetearAtributo( toModeloResponse, "DiferenciarDetalle", toEntidad.DiferenciarDetalle)
			this.SetearAtributoInteger( toModeloResponse, "ColorParaElSombreado", toEntidad.ColorParaElSombreado)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nombre", "NOMBRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Etiqueta", "ETIQUETA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Longitud", "LONGITUD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Decimalesreporte", "DECIMALES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipocalculo", "CALCULO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mostrarceros", "MCEROS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puedecrecer", "PCRECER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ocultarepetido", "OREPETIDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Lineavertical", "LVERTICAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Anchoimagen", "WIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tamañooriginalimagen", "MIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Altoimagen", "HIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Criteriodeinicializacion", "CRITEINIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diashaciaatras", "DIASATRAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valornumericoinicial_desde", "VNIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valornumericoinicial_hasta", "VNIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valorcaracterinicial_desde", "VCIDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valorcaracterinicial_hasta", "VCIHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valorbooleanoinicial", "VIBOOLEANO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valorsinoinicial", "VISINOBOOL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sololectura", "SLECTURA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Noinformar", "NOINFORMAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nomostrar", "NOMOSTRAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Titulolistado", "TITULO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagenlistado", "IMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imprimefechadeimpresion", "FECHAIMPRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imprimehoradeimpresion", "HORAIMPRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estilo", "CESTILO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margenderecho", "MDERECHO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margenizquierdo", "MIZQUIERDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margencabecera", "MCABE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Margenpie", "MPIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Orientacion", "ORIEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diferenciardetalle", "DDETALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Colorparaelsombreado", "COLORSOMBR")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nombre LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Etiqueta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Calculo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vcidesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vcihasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Titulo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Imagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cestilo LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine