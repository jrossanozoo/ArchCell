

define class Mock_din_Registros as custom
	oDatos = null

	nNodo = 0
	lAccess = .f.
	lDestroy = .f.

	Adnimplant = null
	Dibujante = null
	Felino = null
	Generadores = null
	Nucleo = null

	function init() as void
		with this
			.oDatos = newobject( 'mockDatosParametros' )
			.Adnimplant = newobject( "Parametros_Adnimplant") 
			.Dibujante = newobject( "Parametros_Dibujante") 
			.Felino = newobject( "Parametros_Felino") 
			.Generadores = newobject( "Parametros_Generadores") 
			.Nucleo = newobject( "Parametros_Nucleo") 
		endwith
	endfunc

enddefine


define class Parametros_Adnimplant as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class Parametros_Dibujante as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	ModoDeComportamiento = null
	Acomodador = null
	Zoogrillaextensible = null
	Listados = null
	Codigodebarras = null
	Reportes = null

	EspacioVerticalSubgrupo = 3
	Imagendefaultdelaempresa = ''
	Iconodefaultdelosformularios = 'zooIcon.ico'
	Detalleitemparte = 50
	Colorparaadvertenciasvisuales = 255
	Fuenteestilo1nombre = 'DIN MITTELSCHRIFT STD'
	Fuenteestilo1tamanio = 14
	Fuenteestilo2tamanio = 8
	Fuenteestilo2nombre = 'TAHOMA'
	Teclaaccesorapidobuscadorespecifico = 'F4'
	Margentextboxestilo1 = 4
	Margentextboxestilo2 = 4
	Backcolormenu = 13160660
	Colordeetiquetasdeshabilitadas = 8421504
	Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras = '!'
	Teclaaccesorapidoaccionesespecificas = 'F9'
	Teclaaccesorapidograbar = -6
	Permitirtodotipodecaracteresenobservacion = .T.

	function init() as void
		with this
			.ModoDeComportamiento = newobject( "DIBUJANTE_ModoDeComportamiento") 
			.Acomodador = newobject( "DIBUJANTE_Acomodador") 
			.Zoogrillaextensible = newobject( "DIBUJANTE_Zoogrillaextensible") 
			.Listados = newobject( "DIBUJANTE_Listados") 
			.Codigodebarras = newobject( "DIBUJANTE_Codigodebarras") 
			.Reportes = newobject( "DIBUJANTE_Reportes") 
		endwith
	endfunc

enddefine


define class DIBUJANTE_ModoDeComportamiento as custom

	nNodo = 2
	lAccess = .f.
	lDestroy = .f.

	SinChequeos = 1
	ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco = 2
	ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco = 3
	ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco = 4
	ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera = 5
	ConBusquedaDejandoPasarCualquiera = 6
	ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco = 7
	ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado = 8
	ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado = 9

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class DIBUJANTE_Acomodador as custom

	nNodo = 3
	lAccess = .f.
	lDestroy = .f.

	AltoSatusBar = 20
	AltoMenu = 25

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class DIBUJANTE_Zoogrillaextensible as custom

	nNodo = 4
	lAccess = .f.
	lDestroy = .f.

	Descripcionultimalinea = 'Items:'
	Porcentajevisualdedetallepordefecto = 50

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class DIBUJANTE_Listados as custom

	nNodo = 5
	lAccess = .f.
	lDestroy = .f.

	Porcentajeizquierdodeajusteaderecha = 75
	Diferenciatitulo = 2
	Diferenciapie = -2
	Diferenciapiedeinforme = -3
	Porcentajeanchootros = 30
	Margenderecho = 40
	Multiploensanchedetotales = 2
	Margensuperiorsubtotal = 100
	Delegarordenamientodesubtotalesacrystalreport = .F.
	Margenizquierdototal = 50

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class DIBUJANTE_Codigodebarras as custom

	nNodo = 6
	lAccess = .f.
	lDestroy = .f.

	Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres = 30
	Cantidaddecaracteresparalecturadecodigodebarras = 50

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class DIBUJANTE_Reportes as custom

	nNodo = 7
	lAccess = .f.
	lDestroy = .f.

	Twipspormilimetro = 56.7

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class Parametros_Felino as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	EspacioVerticalSubgrupo = 0
	Situacionfiscalempresainscripto = 1
	Situacionfiscalempresanoinscripto = 2
	Situacionfiscalempresamonotributo = 3
	Situacionfiscalclienteinscripto = 1
	Situacionfiscalclientenoinscripto = 2
	Situacionfiscalclienteconsumidorfinal = 3
	Situacionfiscalclienteexento = 4
	Situacionfiscalclienteinscriptonoresponsable = 5
	Situacionfiscalclienteliberado = 6
	Situacionfiscalclientemonotributo = 7
	Situacionfiscalclientemonotributistasocial = 8
	Situacionfiscalclientepequenocontribuyenteeventual = 9
	Situacionfiscalclientepequenocontribuyenteeventualsocial = 10
	Situacionfiscalclientenocategorizado = 11
	Tipodecomprobantepermitidoa = 1
	Tipodecomprobantepermitidob = 2
	Tipodecomprobantepermitidoc = 3
	Tipodecomprobantepermitidoe = 4
	Tipodecomprobantepermitidom = 5
	Tipodeivaventagravadofijo = 1
	Tipodeivaventanogravado = 2
	Tipodeivaventagravadolibre = 3
	Listadepreciosivaincluido = 1
	Listadepreciosmasiva = 2
	Situacionfiscalempresaexento = 4
	Situacionfiscalempresainscriptonoresponsable = 5
	Situacionfiscalempresaliberado = 6
	ArticuloEnOferta = 2
	CmlLogCantidadDeRegistrosQueNoSePuedenAchicar = 0
	VisualizaImpuestosComprobanteA = .T.
	VisualizaImpuestosComprobanteB = .T.
	VisualizaImpuestosComprobanteC = .T.
	VisualizaImpuestosComprobanteE = .T.
	VisualizaImpuestosComprobanteM = .T.
	Decimalespararedondeoencomprobantes = 10
	Cotizacionpordefault = 1
	Grupodevalorpordefecto = 'Varios'
	Diferenciapermitidaentretotalyticket = 0.20
	Procesoimportacion = 'importacion04974'
	Etiquetainformacionadicionalcomprobantesafectados = 'Afectado'
	Etiquetainformacionadicionalcomprobantesafectantes = 'Afectante'
	Descripcionpagoacuenta = 'Pago a cuenta'
	Reintentoscapturarcf = 30
	Tiempoentrereintentodecaptura = 1
	Charvalidosdigito3 = '24,16,25,17,50,48,51,49'
	Preciosparapreviewredondeodeprecios = '945,950,951,1915,1950,1975,'
	Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras = 'LecturaAcumulacionCB.wav'
	Cantidadpordefectoenlecturadecodigodebarras = 1
	Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras = '*'
	Codigodearticulosena = 'SE—A'
	Tipodecuponpordefectoparacomprobantesdesignopositivo = 'C'
	Tipodecuponpordefectoparacomprobantesdesignonegativo = 'D'
	Facturacionelectronicapaisargentina = 200
	Codigoverificadorpromociones = ''
	Dispositivopostamanopaquete = 10000
	Dispositivopostiempoentremensajes = 3000
	Dispositivopostiempodechequeoentremensajes = 1
	Dispositivopostimeoutrecepcion = 3000
	Cantidadmaximadevaloresencomprobantesfiscales = 5
	Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo = 'AC'
	Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo = 'AD'
	Proveedordeservicioparaobtenerferiados = 'NoLaborables'
	Situacionfiscalempresanoalcanzado = 7
	Situacionfiscalclientenoalcanzado = 12
	Idsponsormercadopagopoint = '272112295'
	Interfazsanjustoshoppingtiempoentremensajes = 0.25
	Interfazsanjustoshoppingcantidaddereintentos = 10
	Tipodeivaventagravadofijoreducido = 4
	Vigenciacambioscot = {^2019-6-3}
	Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking = {^2021-12-31}
	Estadoparametroforzarqrcontinuo = .T.
	Estadoparametroforzarqrnocontinuo = .F.
	Feuruguaymodocontingenciaactivado = .F.
	Tiempodedemoradeleventoaplicarpromocionautomatica = 150
	Urldeventademercadolibre = 'www.mercadolibre.com.ar/ventas/#NroDeOrden#/detalle'
	Femodocaeaactivado = .F.
	Actualizotipodeentregaporpuesto = .F.
	Diasrestringidosporafipparainformarcaea = '1,16'
	Idcomprobanteequidadarca = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class Parametros_Generadores as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class Parametros_Nucleo as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	Seguridad = null
	Transferencias = null
	Importaciones = null
	Sc = null
	Actualizaciones = null
	Serviciorest = null
	SonidosYNotificaciones = null
	EnvioDeMails = null

	VersionDeEstructuraDeDatos = 0
	FormularioprincipalAncho = 800
	FormularioprincipalAlto = 600
	Cantidaddeitemsdedetallepordefecto = 999
	Rutaregistrosorganizacion = ''
	Minutosregistroterminal = 60000
	Cambiarelfocoalhacermas = .T.
	Timeoutdesconectarterminal = 120
	Milisegundosbascula = 1000
	Faltangenerados = .F.
	Cantidadtimerbase = 10
	Precisiontimerbase = 200
	Extensionesaceptadasparalogueomonitor = 'ZIP-TXT'
	Registrosutilizadosporautocompletar = 20
	Fechaenblancoparasqlserver = '{01/01/1900 00:00:00}'
	Version = '00.0000.0000'
	Tiempodeesperaparareintentoconexion = 0
	Numerodereintentosdeconexion = 0
	Repositorioparalogueopordefecto = 'log.err'
	Nivelparalogueopordefecto = 4
	Rutalogueopordefecto = '.\LOG\'
	Cantidadcortesrepositorioparalogueopordefecto = 2
	Volumenrepositorioparalogueopordefecto = 1000
	Rutadedisenos = '\disenos'
	Cadenadecaracteresvalidos = '1234567890ABCDEFGHIJKLMN—OPQRSTUVWXYZ_ abcdefghijklmnÒopqrstuvwxyz∫\™!@#$%&/()=?ø*{}[]<>,.;:-·ÈÌÛ˙¡…Õ”⁄+-"'
	Prefijotablasauditoria = 'ADT_'
	Caracteresvalidosadicionalesparaclavesprimarias = '\/!@#$%&()*{}[]<>,;:+'
	Formularioprincipalestado = 0
	Archivoparalogueointerno = 'LogInterno.log'
	Tiempodeesperaparacerraraplicacion = 60
	Tiempodeltimerpararefrescodemensajes = 500
	Usarservicioregistroterminal = .T.
	Cadenadeletrasvalidas = 'ABCDEFGHIJKLMN—OPQRSTUVWXYZ'
	Cadenadenumerosvalidos = '0123456789'
	Cadenadecaracteresespecialesvalidos = '∫\™!@#$%&() =?ø*{}[]<>,;:-·ÈÌÛ˙¡…Õ”⁄+"'
	Cadenadecaracteresbasicosvalidos = '-. /'
	Tamanodepapelminimoparaimprimirlistados = 5040
	Numerovistapreviacodigosugerido = 1
	Mensajeerrorcuandonosepuedehacervistaprevia = 'EXCEDE EL ANCHO A SUGERIR'
	Codigosasciiparaarmarexpresionestipostring = '39,93 ,91,34'
	Cantidaddeelementosensentenciainsql = 10000
	Ejecutarcheckpointalhacercommittransaction = .F.
	Ultimafechavalidacioncorrectabdsucursal = {  /  /    }
	Ultimafechavalidacioncorrectabdorganizacion = {  /  /    }
	Cantidaddediasultimafechavalidacioncorrectabd = 3
	Fechadehabilitaciondetrazaextendida = {  /  /    }
	Versionbasededatossucursal = ''
	Versionbasededatosorganizacion = ''
	Defaulttiempodeesperasmtp = 100
	Reintentosdeobtenciondenumerocontalonariousado = 3
	Rutaplantillasdedisenoexportacion = 'plantillas\'
	Cantidaddeelementosensegmentoaimportar = 50000
	Habilitararticulototalizador = .F.
	Usardragonfishcloud = .F.
	Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes = 2600
	Mayorprecisiondecimalencantidad = .F.
	Separadordecolumnascsv = ';'
	Delimitadordecaracterescsv = '"'
	Delimitadorinicialdeatributosparamacrosustitucion = '{'
	Delimitadorfinaldeatributosparamacrosustitucion = '}'

	function init() as void
		with this
			.Seguridad = newobject( "NUCLEO_Seguridad") 
			.Transferencias = newobject( "NUCLEO_Transferencias") 
			.Importaciones = newobject( "NUCLEO_Importaciones") 
			.Sc = newobject( "NUCLEO_Sc") 
			.Actualizaciones = newobject( "NUCLEO_Actualizaciones") 
			.Serviciorest = newobject( "NUCLEO_Serviciorest") 
			.SonidosYNotificaciones = newobject( "NUCLEO_SonidosYNotificaciones") 
			.EnvioDeMails = newobject( "NUCLEO_EnvioDeMails") 
		endwith
	endfunc

enddefine


define class NUCLEO_Seguridad as custom

	nNodo = 2
	lAccess = .f.
	lDestroy = .f.

	Numerodeintentosdelogueo = 5
	Ultimousuariologueado = ''
	Estadodelsistema = '_20g0sh7mj'
	Checksum = ''
	Tiempodeexpiraciondeacceso = 30
	Factormultiplicaciontiempobloqueoautomatico = 2
	Tiempodebloqueo = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Transferencias as custom

	nNodo = 3
	lAccess = .f.
	lDestroy = .f.

	Password = ''
	Forzarelusodelaaoentiempodedesarrollo = .F.
	Passwordlince = 'pirulaxia'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Importaciones as custom

	nNodo = 4
	lAccess = .f.
	lDestroy = .f.

	Extensionparaarchivosconerrores = 'ERR'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Sc as custom

	nNodo = 5
	lAccess = .f.
	lDestroy = .f.

	Cantidaddeintententosfallidosalpedircodigo = 0
	Pedirscautomaticamente = .T.
	Cantidadmaximadeintentosfallidossc = 4

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Actualizaciones as custom

	nNodo = 6
	lAccess = .f.
	lDestroy = .f.

	Urlparaactualizaciones = 'https://update.zoologic.com.ar/'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Serviciorest as custom

	nNodo = 7
	lAccess = .f.
	lDestroy = .f.

	Desactivaroptimizaciondeframeworknet = .F.
	Maximacantidaddediasenlogueosrestapi = 30
	Tiempodevidaentidad = 1000

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_SonidosYNotificaciones as custom

	nNodo = 8
	lAccess = .f.
	lDestroy = .f.

	Fechaultimologueonotificacioneswindows = {^2022-1-1}

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_EnvioDeMails as custom

	nNodo = 9
	lAccess = .f.
	lDestroy = .f.

	Iddeclienteparaenviodemailsmycrosoftapi = 'B703C014C91F92204E11B4D8296B6CD9023D5F02B109F56138BC6664B94B9D625B443AA357479F4D7B0D63BEC7F11666'

	function init() as void
		with this
		endwith
	endfunc

enddefine


*-----------------------------------------------------------------------------------------
define class ConsultaParametro as custom
	Nivel = 0
	idNodo = 0
	Parametro = ''
	Proyecto = ''
	TipoDato = ''
	Default = null
	idCabecera = 0
	IdUnico = ''
enddefine
*-----------------------------------
define class mockDatosParametros as custom
*-----------------------------------
	function EventoConfigurarLogo( tlConfigura as boolean ) as void
	endfunc
*-----------------------------------
	function cambioparametros()
	endfunc
*-----------------------------------
	function AntesDeCargarNodosDeParametros()
	endfunc
*-----------------------------------
	function ResetearBuffers()
	endfunc
*-----------------------------------
	function SetearMinutosVencimiento( tnMinutos as Integer )
	endfunc
enddefine