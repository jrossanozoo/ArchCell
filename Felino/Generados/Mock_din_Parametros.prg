

define class Mock_din_Parametros as custom
	oDatos = null

	nNodo = 0
	lAccess = .f.
	lDestroy = .f.

	Andimplant = null
	Dibujante = null
	Felino = null
	Generadores = null
	Nucleo = null

	function init() as void
		with this
			.oDatos = newobject( 'mockDatosParametros' )
			.Andimplant = newobject( "Parametros_Andimplant") 
			.Dibujante = newobject( "Parametros_Dibujante") 
			.Felino = newobject( "Parametros_Felino") 
			.Generadores = newobject( "Parametros_Generadores") 
			.Nucleo = newobject( "Parametros_Nucleo") 
		endwith
	endfunc

enddefine


define class Parametros_Andimplant as custom

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

	Estilo = 2
	Modoavanzado = .T.
	Utilizaidentificadordesucursalencodigodecliente = .F.
	Permitenombredeclienterepetido = .T.
	Imagendefaultdelaempresa = ''
	Advertirinexistenciadesubentidad = .T.
	Desdeano = 1940
	Modelobascula = ''
	Rutaorigendelaimportaciondedatos = 'c:\'
	Permitiringresoprecioencomprobantes = .F.
	Formatoparafecha = 1
	Mostrarseparadordemiles = .F.
	Permitednicuitdeclienterepetido = 1
	Permitednicuitdeproveedorrepetido = 1
	Permitemaildeclienterepetido = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class Parametros_Felino as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	Altas = null
	ControladoresFiscales = null
	CodigosDeBarras = null
	DatosGenerales = null
	DatosImpositivos = null
	Fechas = null
	Generales = null
	GestionDeVentas = null
	Herramientas = null
	Impresiones = null
	Numeraciones = null
	Precios = null
	Sugerencias = null
	Transferencias = null
	Dispositivos = null
	MovimientosDeStock = null
	Interfases = null
	Backup = null
	GestionDeCompras = null
	Picking = null
	Fondos = null
	Znube = null

	function init() as void
		with this
			.Altas = newobject( "FELINO_Altas") 
			.ControladoresFiscales = newobject( "FELINO_ControladoresFiscales") 
			.CodigosDeBarras = newobject( "FELINO_CodigosDeBarras") 
			.DatosGenerales = newobject( "FELINO_DatosGenerales") 
			.DatosImpositivos = newobject( "FELINO_DatosImpositivos") 
			.Fechas = newobject( "FELINO_Fechas") 
			.Generales = newobject( "FELINO_Generales") 
			.GestionDeVentas = newobject( "FELINO_GestionDeVentas") 
			.Herramientas = newobject( "FELINO_Herramientas") 
			.Impresiones = newobject( "FELINO_Impresiones") 
			.Numeraciones = newobject( "FELINO_Numeraciones") 
			.Precios = newobject( "FELINO_Precios") 
			.Sugerencias = newobject( "FELINO_Sugerencias") 
			.Transferencias = newobject( "FELINO_Transferencias") 
			.Dispositivos = newobject( "FELINO_Dispositivos") 
			.MovimientosDeStock = newobject( "FELINO_MovimientosDeStock") 
			.Interfases = newobject( "FELINO_Interfases") 
			.Backup = newobject( "FELINO_Backup") 
			.GestionDeCompras = newobject( "FELINO_GestionDeCompras") 
			.Picking = newobject( "FELINO_Picking") 
			.Fondos = newobject( "FELINO_Fondos") 
			.Znube = newobject( "FELINO_Znube") 
		endwith
	endfunc

enddefine


define class FELINO_Altas as custom

	nNodo = 2
	lAccess = .f.
	lDestroy = .f.

	Prefijocliente = ''
	Formadeaplicareldescuentoasociadoalcliente = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_ControladoresFiscales as custom

	nNodo = 3
	lAccess = .f.
	lDestroy = .f.

	DatosGeneralesDelCf = null
	EncabezadoYPieDePagina = null
	DatosArticulo = null
	ComprobanteParaCambios = null
	OrdenDeCompra = null
	TicketAdicional = null

	Codigo = 0
	Puerto = 1
	Puntodeventa = 1
	Secuenciaparareiniciodelamemoriafiscal = ''
	Limitetotaldeuncomprobanteticketsinpersonalizar = 1000
	Limitetotaldeuncomprobanteticketapersonalizado = 25000
	Limitetotaldeuncomprobanteticketbpersonalizado = 5000
	Restringircargadeitemssegunlimitedemontototaldecomprobantesticket = .F.
	Imprimirtickettestigo = 1
	Cantidadmaximapermitidadelineasporcomprobantenofiscal = 30
	Imprimirchequesdespuesdegrabar = 3
	Descuentomaximopermitido = 50
	Obtenercodigogtin = .F.
	Velocidaddeconexionhostserie = '115200'
	Direccionip = '192.168.1.1'
	Socket = 80
	Rutadelxmldeconfiguraciondelproxyfiscal = 'C:\ProxyFiscal'
	Imprimirarticulocolorytalleenunaunicalineahasarp320f = .F.
	Limitarlacargaaunahojaenlafacturacionhasarp320f = .F.
	Compatibilidadconfirmwaredeprecadoshasar715 = .F.

	function init() as void
		with this
			.DatosGeneralesDelCf = newobject( "FELINO_DatosGeneralesDelCf") 
			.EncabezadoYPieDePagina = newobject( "FELINO_EncabezadoYPieDePagina") 
			.DatosArticulo = newobject( "FELINO_DatosArticulo") 
			.ComprobanteParaCambios = newobject( "FELINO_ComprobanteParaCambios") 
			.OrdenDeCompra = newobject( "FELINO_OrdenDeCompra") 
			.TicketAdicional = newobject( "FELINO_TicketAdicional") 
		endwith
	endfunc

enddefine


define class FELINO_DatosGeneralesDelCf as custom

	nNodo = 49
	lAccess = .f.
	lDestroy = .f.

	Nombredefantasia1 = ''
	Nombredefantasia2 = ''
	Nombredefantasia3 = ''
	Nombredefantasia4 = ''
	Nombredefantasia5 = ''
	Domiciliocomercial1 = ''
	Domiciliocomercial2 = ''
	Domiciliocomercial3 = ''
	Domiciliofiscal1 = ''
	Domiciliofiscal2 = ''
	Domiciliofiscal3 = ''
	Otrasleyendascomerciales1 = ''
	Otrasleyendascomerciales2 = ''
	Otrasleyendascomerciales3 = ''
	Iibb1 = ''
	Iibb2 = ''
	Iibb3 = ''
	Archivologo = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_EncabezadoYPieDePagina as custom

	nNodo = 50
	lAccess = .f.
	lDestroy = .f.

	Encabezado1 = ''
	Encabezado2 = ''
	Encabezado3 = ''
	Encabezado4 = ''
	Encabezado5 = ''
	Encabezado6 = ''
	Encabezado7 = ''
	Encabezado8 = ''
	Encabezado9 = ''
	Encabezado10 = ''
	Piedepagina1 = ''
	Piedepagina2 = ''
	Piedepagina3 = ''
	Piedepagina4 = ''
	Piedepagina5 = ''
	Piedepagina6 = ''
	Piedepagina7 = ''
	Piedepagina8 = ''
	Piedepagina9 = ''
	Piedepagina10 = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_DatosArticulo as custom

	nNodo = 51
	lAccess = .f.
	lDestroy = .f.

	Leyenda1 = ''
	Leyenda2 = ''
	Leyenda3 = ''
	Atributo1 = ''
	Atributo2 = ''
	Atributo3 = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_ComprobanteParaCambios as custom

	nNodo = 62
	lAccess = .f.
	lDestroy = .f.

	Encabezado1 = ''
	Encabezado2 = ''
	Encabezado3 = ''
	Encabezado4 = ''
	Encabezado5 = ''
	Encabezado6 = ''
	Encabezado7 = ''
	Encabezado8 = ''
	Encabezado9 = ''
	Encabezado10 = ''
	Piedepagina1 = ''
	Piedepagina2 = ''
	Piedepagina3 = ''
	Piedepagina4 = ''
	Piedepagina5 = ''
	Piedepagina6 = ''
	Piedepagina7 = ''
	Piedepagina8 = ''
	Piedepagina9 = ''
	Piedepagina10 = ''
	Habilitartipoimpresion = 1
	Habilitarimpresionenfacturafiscal = 1
	Habilitarimpresionennotadecreditofiscal = 1
	Habilitarimpresionennotadedebitofiscal = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_OrdenDeCompra as custom

	nNodo = 63
	lAccess = .f.
	lDestroy = .f.

	Habilitalaimpresiondeordenesdecompra = .T.
	Opciondesalida = 1
	Encabezado1 = ''
	Encabezado2 = ''
	Encabezado3 = ''
	Encabezado4 = ''
	Encabezado5 = ''
	Encabezado6 = ''
	Encabezado7 = ''
	Encabezado8 = ''
	Encabezado9 = ''
	Encabezado10 = ''
	Piedepagina1 = ''
	Piedepagina2 = ''
	Piedepagina3 = ''
	Piedepagina4 = ''
	Piedepagina5 = ''
	Piedepagina6 = ''
	Piedepagina7 = ''
	Piedepagina8 = ''
	Piedepagina9 = ''
	Piedepagina10 = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_TicketAdicional as custom

	nNodo = 90
	lAccess = .f.
	lDestroy = .f.

	Encabezado3 = ''
	Encabezado1 = ''
	Encabezado2 = ''
	Encabezado4 = ''
	Encabezado5 = ''
	Encabezado6 = ''
	Encabezado7 = ''
	Encabezado8 = ''
	Encabezado9 = ''
	Encabezado10 = ''
	Piedepagina1 = ''
	Piedepagina2 = ''
	Piedepagina3 = ''
	Piedepagina4 = ''
	Piedepagina5 = ''
	Piedepagina6 = ''
	Piedepagina7 = ''
	Piedepagina8 = ''
	Piedepagina9 = ''
	Piedepagina10 = ''
	Definiciondedetalle = ''
	Impresiondeticketadicional = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_CodigosDeBarras as custom

	nNodo = 4
	lAccess = .f.
	lDestroy = .f.

	Verificarexistenciadeequivalenciaenlectura = .F.
	Permitirrealizarcomprobantessinequivalencias = .T.
	Habilitarlectura = .F.
	Completarlectura = .F.
	Anchorequerido = 14
	Completarlecturaala = 1
	Caracteresderelleno = ''
	Acumularcantidades = .T.
	Mostrarefectovisualalacumular = .T.
	Reproducirefectosonoroalacumular = .T.
	Mostrarprimercoincidenciaenlabusquedadecodigosdebarra = .F.
	Ultimonumerodesecuencialimpreso = 0
	Acumularcantidadesalvolverdelaprecarga = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_DatosGenerales as custom

	nNodo = 5
	lAccess = .f.
	lDestroy = .f.

	Situacionfiscal = 1
	Cuit = ''
	Ib = ''
	Cbu = ''
	Tipodecomprobanteaemitircomoresponsableinscripto = 1
	Jurisdiccionreal = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_DatosImpositivos as custom

	nNodo = 6
	lAccess = .f.
	lDestroy = .f.

	Ivainscriptos = 21
	Ivanoinscriptos = 0
	Tiposituacionfiscal1 = 'Responsable Inscripto'
	Tiposituacionfiscal3 = 'Consumidor Final'
	Tiposituacionfiscal4 = 'Exento'
	Tiposituacionfiscal5 = 'No Responsable'
	Tiposituacionfiscal7 = 'Responsable Monotributo'
	Tiposituacionfiscal12 = 'No Alcanzado'
	Codigodedatofiscalautilizar = ''
	Cuitvalidoobligatorioenelaltadeclientes = 3
	Ivaalicuotareducida = 0

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Fechas as custom

	nNodo = 7
	lAccess = .f.
	lDestroy = .f.

	Desdefecha = {  /  /    }
	Hastafecha = {  /  /    }
	Desdemes = 1
	Hastames = 12
	Desdefechadecomprobantesdecompra = {  /  /    }

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Generales as custom

	nNodo = 8
	lAccess = .f.
	lDestroy = .f.

	Habilitacontrolstock = .T.
	Permitirgenerarstocknegativoentomadeinventario = .T.
	Habilitarcompatibilidaddememoriaparafacturafiscal = .F.
	Accesodirectoaconsulta = 'Stock y precios'
	Permitirpasarsinstock = .F.
	Monedasistema = 'PESOS'
	Utilizaasignaciondevendedorabasededatos = .F.
	Aperturaautomaticadecombos = .T.
	Decimalesamostrarenproduccion = '2'
	Listadecostospreferenteparacotizacionesyliquidacionesdeproduccion = ''
	Codigovalorutilizadoparaliquidaciondetalleres = ''
	Articulodefaultliquidacionprocesoproduccion = ''
	Articulodefaultliquidacionprocesodescarte = ''
	Articulodefaultliquidacioninsumosproduccion = ''
	Articulodefaultliquidacioninsumosdescarte = ''
	Actualizarelcostodelsemielaboradoalmodificarloenlacotizacion = .F.
	Actualizarelcostodelsemielaboradoalmodificarloenlaliquidacion = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_GestionDeVentas as custom

	nNodo = 20
	lAccess = .f.
	lDestroy = .f.

	Minorista = null
	MovMer = null
	CuentaCorriente = null
	Tarjetas = null
	FacturacionElectronica = null
	ChequeDeTerceros = null
	AjusteDeCupon = null
	Recibo = null
	ComercioExterior = null

	Utilizarvalordelcomprobanteparadarvuelto = .T.
	Pedirdatospararg1547enventasycompras = .F.
	Pedircotizacionparalafechadelcomprobante = .T.
	Controldesaldosnegativosdecaja = 1
	Numerodecaja = 1
	Obtenerautomaticamentelimiteparacomprobantessinpersonalizar = .T.
	Limitetotaldeuncomprobantesinpersonalizar = 5000
	Letrasugeridaparabusquedadefactura = 'B'
	Letrasugeridaparabusquedadenotadecredito = ''
	Letrasugeridaparabusquedadenotadedebito = ''
	Letrasugeridaparabusquedadeticketfactura = 'B'
	Letrasugeridaparabusquedadeticketnotadecredito = ''
	Letrasugeridaparabusquedadeticketnotadedebito = ''
	Letrasugeridaparabusquedaderemito = 'X'
	Letrasugeridaparabusquedadefacturaelectronica = 'B'
	Letrasugeridaparabusquedadenotadecreditoelectronica = ''
	Letrasugeridaparabusquedadenotadedebitoelectronica = ''
	Letrasugeridaparabusquedadepedido = 'X'
	Letrasugeridaparabusquedadepresupuesto = 'X'
	Letrasugeridaparabusquedadepreparaciondemercaderia = 'X'
	Permitegrabarcomprobanteconprecioencero = .T.
	Cantidaddediasparaelvencimientodelvaledecambio = 30
	Generarsisuperamonto = 0
	Retirarvaloresalrealizarelcierredecaja = .T.
	Generarcomprobantedecajaautomaticamentealcerrarlacaja = .F.
	Incluirloschequesenelcomprobantedecajageneradoporcierreautomatico = .F.
	Conceptosugeridoparaelcierredecaja = ''
	Origendestinosugeridoparaelcierredecaja = ''
	Utilizafondofijo = .F.
	Valorsugeridoparaelfondofijo = ''
	Montosugeridodelfondofijo = 0
	Vendedorsugeridoparaelcierredecaja = ''
	Aperturaautomaticadecaja = .T.
	Almodificarelcomprobanteposicionarseenelprimeritemdisponible = .F.
	Agrupamientoparaadministracionconjuntadecajas = ''
	Restringiringresodedecimalesencantidad = .F.
	Daravisoporstockinferioralminimodestockestablecidofacturanotadebynotacred = .F.
	Daravisoporstockinferioralminimodestockestablecidoremitos = .F.
	Daravisoporstockinferioralminimodestockestablecidomovimientodestock = .F.
	Generarcomprobantedecajadespuesderealizararqueo = 3
	Nopermitirfacturarconfechadistintaaladelacajaabierta = .F.
	Horasdetoleranciaparafacturacionsegunfechadeaperturadecaja = 5
	Permitefacturarenmonedaextranjera = .F.
	Permiteremitirenmonedaextranjera = .F.
	Permitepedidosenmonedaextranjera = .F.
	Trasladarelvendedoreninsertardesde = .F.
	Cancelarpedidosapagarencajapendientesdefacturaralcerrarcaja = 2
	Entregaposteriorenfacturas = 1
	Habilitacomprobanteasociado = .T.
	Obligalacargamanualdelvalorantesdefinalizarelcomprobante = .F.
	Sugieretipodeentregaonline = .F.
	Restringirenremitoselingresodeclientesasociadosabuzones = .F.
	Rutaparageneraciondepdfdeenvioecommerce = ''
	Ingresarmontodedescuentoconivaincluidoencomprobantesa = .F.
	Habilitacomprobantesletraaparamonotributistasrg500321afip = {^2021-7-1}
	Habilitarcolortallekits = .F.
	Habilitarcircuitodeconsignaciones = .F.
	Sugieretipodeentrega = 1
	Controldeseniasvencidasalcierredecaja = 1
	Sugieretipoentregaporpuesto = 1
	Actualizarfechadelcomprobantealafechadeldiaalgrabar = 1
	Habilitacircuitoimplementativogiftcard = .F.
	Articulodelcomprobante = ''
	Cantidaddediasparaelvencimientodelagiftcard = 180
	Agruparautomaticamentelosarticulosdetipopackalrealizarunafacturadeventa = 1
	Motivosugeridoalagruparautomaticamentelosarticulosdetipopack = ''
	Limitetotaldeuncomprobsinpersonalizarusandotarjdecreddebopagoelectronico = 191624
	Porcentajedesenaminimo = 0
	Permitepresupuestosenmonedaextranjera = .F.

	function init() as void
		with this
			.Minorista = newobject( "FELINO_Minorista") 
			.MovMer = newobject( "FELINO_MovMer") 
			.CuentaCorriente = newobject( "FELINO_CuentaCorriente") 
			.Tarjetas = newobject( "FELINO_Tarjetas") 
			.FacturacionElectronica = newobject( "FELINO_FacturacionElectronica") 
			.ChequeDeTerceros = newobject( "FELINO_ChequeDeTerceros") 
			.AjusteDeCupon = newobject( "FELINO_AjusteDeCupon") 
			.Recibo = newobject( "FELINO_Recibo") 
			.ComercioExterior = newobject( "FELINO_ComercioExterior") 
		endwith
	endfunc

enddefine


define class FELINO_Minorista as custom

	nNodo = 26
	lAccess = .f.
	lDestroy = .f.

	NuevoEnBaseA = null
	Promociones = null

	Forzarcargademailingdeclientes = .F.
	Antiguedaddeloscomprobantesbuscadosparaelbasadoen = 180
	Recalcularpreciodearticulosconsenavigente = 1
	Recalcularpreciodearticulosconsenavencida = 1
	Permitiringresarmontodesenaenfacturasaivaincluido = .F.
	Realizarcambiosdearticulosconlamismacombinacion = 1
	Recalcularpreciodearticulosconsenaporcambiodelistadeprecios = .F.
	Generarcomprobanteparacambioenfactura = 1
	Generarcomprobanteparacambioennotadecredito = 1
	Generarcomprobanteparacambioennotadedebito = 1
	Generaruncomprobanteparacambioporarticulo = 1
	Generaruncomprobanteparacambioporunidad = 1
	Noactualizarelmailenelaltadeclientes = .F.
	Actualizarelmailenelaltadeclientes = 1

	function init() as void
		with this
			.NuevoEnBaseA = newobject( "FELINO_NuevoEnBaseA") 
			.Promociones = newobject( "FELINO_Promociones") 
		endwith
	endfunc

enddefine


define class FELINO_NuevoEnBaseA as custom

	nNodo = 55
	lAccess = .f.
	lDestroy = .f.

	FacturaTicketFactura = null
	NotaDeCreditoTicketNCredito = null
	Cancelacion = null
	Remito = null
	Pedido = null
	Chile = null

	Facturadefaultcombocomprobanteafectado = 'Remito de venta'
	Facturadefaultcombofiltro = 'por número'
	Facturaticketfacturadefaultcomboseleccionoperatoria = 1
	Facturacontrolinicial = 'Número'
	Notadecreditodefaultcombocomprobanteafectado = 'Factura manual de venta'
	Notadecreditodefaultcombofiltro = 'por número'
	Notadecreditoticketnotadecreditodefaultcomboseleccionoperatoria = 1
	Notadecreditocontrolinicial = 'Número'
	Devoluciondefaultcombocomprobanteafectado = 'Remito de venta'
	Devoluciondefaultcombofiltro = 'por número'
	Cancelaciondefaultcomboseleccionoperatoria = 1
	Remitodefaultcombocomprobanteafectado = 'Pedido de venta'
	Remitodefaultcombofiltro = 'por número'
	Remitodefaultcomboseleccionoperatoria = 1
	Remitocontrolinicial = 'Número'
	Pedidodefaultcombocomprobanteafectado = 'Presupuesto de venta'
	Pedidodefaultcombofiltro = 'por número'
	Pedidodefaultcomboseleccionoperatoria = 1
	Pedidocontrolinicial = 'Número'
	Remitochiledefaultcombocomprobanteafectado = 'Pedido de venta'
	Remitochiledefaultcombofiltro = 'por número'
	Remitochilecontrolinicial = 'Número'
	Pedidochiledefaultcombocomprobanteafectado = 'Presupuesto de venta'
	Pedidochiledefaultcombofiltro = 'por número'
	Pedidochilecontrolinicial = 'Número'
	Remitoelectronicochiledefaultcombocomprobanteafectado = 'Pedido de venta'
	Remitoelectronicochiledefaultcombofiltro = 'por número'
	Remitoelectronicochilecontrolinicial = 'Número'
	Actualizarpreciosencomprobantesnuevosenbaseaventa = 1
	Permitircargadecomprobantesdedistintosclientes = 1
	Remitopermitirenbaseapedidospreparados = .T.
	Pedidonopermiteagregar = .F.
	Remitonopermiteagregar = .F.
	Facturanopermiteagregar = .F.
	Devolucioncontrolinicial = 'Número'
	Notadecreditonopermiteagregar = .F.
	Preparaciondemercaderiadefaultcombocomprobanteafectado = 'Pedido de venta'
	Preparaciondemercaderiadefaultcombofiltro = 'por número'
	Preparaciondemercaderiadefaultcomboseleccionoperatoria = 1
	Preparaciondemercaderiacontrolinicial = 'Número'
	Preparaciondemercaderianopermiteagregar = .F.
	Permitircargadecomprobantesconfechadepresupuestovencida = 1
	Notadecreditosugerirmediodepagodelafacturaencomprobantecondtoorec = .F.

	function init() as void
		with this
			.FacturaTicketFactura = newobject( "FELINO_FacturaTicketFactura") 
			.NotaDeCreditoTicketNCredito = newobject( "FELINO_NotaDeCreditoTicketNCredito") 
			.Cancelacion = newobject( "FELINO_Cancelacion") 
			.Remito = newobject( "FELINO_Remito") 
			.Pedido = newobject( "FELINO_Pedido") 
			.Chile = newobject( "FELINO_Chile") 
		endwith
	endfunc

enddefine


define class FELINO_FacturaTicketFactura as custom

	nNodo = 128
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_NotaDeCreditoTicketNCredito as custom

	nNodo = 129
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Cancelacion as custom

	nNodo = 130
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Remito as custom

	nNodo = 131
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Pedido as custom

	nNodo = 132
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Chile as custom

	nNodo = 133
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Promociones as custom

	nNodo = 118
	lAccess = .f.
	lDestroy = .f.

	Mostrarasistente = .F.
	Aplicarpromosautomaticasalsalirdeldetalle = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_MovMer as custom

	nNodo = 27
	lAccess = .f.
	lDestroy = .f.

	Fechaultimatomadeinventario = {  /  /    }

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_CuentaCorriente as custom

	nNodo = 56
	lAccess = .f.
	lDestroy = .f.

	Elsaldoadeudadonopuedeexceder = 0
	Agregarpagoacuentaalconciliar = 1
	Incluirchequesdetercerosnovencidosalsaldodeudor = .T.
	Mostrarsaldodelacuentacorrienteenfacturandebyncred = .F.
	Advertiralsuperarellimitedecredito = .F.
	Permitefacturarconcuentacorrientevencidaimpaga = 1
	Permiteremitirconcuentacorrientevencidaimpaga = 1
	Controldelimitedecredito = 1
	Incluirremitosdeventasencontroldelimitedecredito = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Tarjetas as custom

	nNodo = 64
	lAccess = .f.
	lDestroy = .f.

	Pedirdatosextradetarjeta = .F.
	Dispositivoposdefault = ''
	Recargoentarjetadecredito = 2
	Formadeseleccionpararecargosmultiples = 1
	Clienteautilizarenaplicaciondecuponeshuerfanos = ''
	Sugerirdatosdelclienteencupon = .F.
	Dispositivoelectronicodefault = ''
	Dispositivomercadopagoqrdefault = ''
	Realizarcierredeloteslaposalefectuarelcierredecaja = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_FacturacionElectronica as custom

	nNodo = 65
	lAccess = .f.
	lDestroy = .f.

	Nacional = null
	Exportacion = null
	Uruguay = null

	Pedircaealfinalizarelcomprobante = .T.
	Preguntapedircaealfinalizarelcomprobante = .F.
	Sugierepedircaealfinalizarelcomprobante = 1
	Timeout = 15000
	Urllogin = 'https://wsaa.afip.gov.ar/ws/services/LoginCms'
	Rutadelcertificado = ''
	Utilizarconexionporproxy = .F.
	Servidor = ''
	Puerto = 80
	Usuario = ''
	Contrasena = ''
	Concuantosdiasdeanticipaciondeseaqueelsistemaaviseelvencimientodelcertificado = 10
	Fechadevencimientosugeridaparaloscomprobantesdecreditoendias = 30
	Forzarlaimpresiondecodigoqrendisenosconcantidaddinamicadelineas = .T.
	Forzarlaimpresiondecodigoqrendisenosconcantidadfijadelineas = .F.
	Opciondetransmisionparacomprobantesdecreditomipyme = 1
	Generarcomprobanteparacambioenfacturaelectronica = 1
	Generarcomprobanteparacambioennotadecreditoelectronica = 1
	Generarcomprobanteparacambioennotadedebitoelectronica = 1
	Generaruncomprobanteparacambioporarticulo = 1
	Generaruncomprobanteparacambioporunidad = 1

	function init() as void
		with this
			.Nacional = newobject( "FELINO_Nacional") 
			.Exportacion = newobject( "FELINO_Exportacion") 
			.Uruguay = newobject( "FELINO_Uruguay") 
		endwith
	endfunc

enddefine


define class FELINO_Nacional as custom

	nNodo = 66
	lAccess = .f.
	lDestroy = .f.

	RG2969 = null

	Habilitarfacturacionelectronicaparaelmercadointerno = .F.
	Nombredelservicio = 'wsfe'
	Urldelservidor = 'https://servicios1.afip.gov.ar/wsfev1/service.asmx'
	Puntodeventa = 1
	Tipodewebserviceparafacturacionelectronicanacional = 1
	Habilitarfacturacionelectronicamipyme = .F.
	Urldelservidormipyme = 'https://serviciosjava.afip.gob.ar/wsfecred/FECredService'
	Puntodeventamipyme = 1
	Nombredelserviciodelwebservicemipyme = 'wsfecred'
	Habilitarfacturacionelectronicaanticipadacaea = .F.
	Puntodeventacaea = 2
	Solicitarautomaticamentecaea = .F.
	Presentacionautomaticadecomprobantesconcaea = 2
	Caeaporcontingencia = .T.
	Emisionautomaticadecomprobantesconcaea = .F.
	Clienteautilizarennotasdecreditodecomprobantessinpersonalizar = ''
	Articuloautilizarencomprobantes = ''
	Valorautilizarencomprobante = ''

	function init() as void
		with this
			.RG2969 = newobject( "FELINO_RG2969") 
		endwith
	endfunc

enddefine


define class FELINO_RG2969 as custom

	nNodo = 75
	lAccess = .f.
	lDestroy = .f.

	Unidaddemedida = 98
	Unidades = 1
	Codigogtindelarticulo = 2
	Codigodeproducto = '7790001001054'
	Avisarsinoexistecodigo = .F.
	Permitecontinuar = 2
	Descuentopreferencialgtingenerico = '7790001001030'
	Codigogtinelitemderecargo = '7790001001054'
	Descripciongenericodelitemderecargo = 'Recargos generales'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Exportacion as custom

	nNodo = 67
	lAccess = .f.
	lDestroy = .f.

	Habilitarfacturacionelectronicadeexportacion = .F.
	Nombredelservicio = 'wsfex'
	Urldelservidor = 'https://servicios1.afip.gov.ar/wsfexV1/service.asmx'
	Puntodeventa = 1
	Incoterms = ''
	Codigodemonedaextranjerasugerida = 'DOLAR'
	Unidaddemedida = 98
	Idioma = 1
	Tipodeexportacion = 3
	Listadepreciossugerida = 'LISTA4'
	Sugerircotizaciondemoneda = .F.
	Cantidaddediasparalafechadevencimientodepago = 30

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Uruguay as custom

	nNodo = 142
	lAccess = .f.
	lDestroy = .f.

	Habilitarfacturacionelectronicaparauruguay = .F.
	Pedircaealfinalizarelcomprobante = .T.
	Preguntapedircaealfinalizarelcomprobante = 3
	Tiempodeesperaenseg = 60
	Urldelservidor = 'https://sc.212efactura.info/ws/ws_efacturainfo_ventas.php?wsdl'
	Usuario = ''
	Contrasena = ''
	Carpeta = ''
	Codigodgidesucursal = ''
	Iddepuestodetrabajo = ''
	Deshabilitarmediodepagotipocredito = .F.
	Puntodeventacomprobanteselectronicos = 0
	Puntodeventacomprobantesdecontingencia = 0
	Seriedefacturasdecontingencia = ''
	Seriedeticketsdecontingencia = ''
	Opciondeimpresion = 1
	Unidaddemedidapordefecto = 'N/A'
	Enviarunidaddemedidaconfiguradaenelarticulo = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_ChequeDeTerceros as custom

	nNodo = 76
	lAccess = .f.
	lDestroy = .f.

	Restringiringresodechequesduplicados = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_AjusteDeCupon as custom

	nNodo = 80
	lAccess = .f.
	lDestroy = .f.

	Tipodecomprobanteagenerar = ''
	Clienteautilizarencomprobantessinpersonalizar = ''
	Utilizarelclientedelafacturaencomprobantespersonalizados = .T.
	Articuloautilizarencomprobantes = ''
	Valorautilizarencomprobantes = ''
	Momentodegeneraciondeloscomprobantes = 'Al cerrar la caja'
	Montomaximodenotadecredito = 0
	Vendedorautilizarennotasdecredito = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Recibo as custom

	nNodo = 81
	lAccess = .f.
	lDestroy = .f.

	Recargo = null
	Descuento = null

	Habilitartooltipendetalle = .F.

	function init() as void
		with this
			.Recargo = newobject( "FELINO_Recargo") 
			.Descuento = newobject( "FELINO_Descuento") 
		endwith
	endfunc

enddefine


define class FELINO_Recargo as custom

	nNodo = 82
	lAccess = .f.
	lDestroy = .f.

	Tipodecomprobante = 'NOTADEDEBITO'
	Articulodelcomprobante = ''
	Valordelcomprobante = ''
	Generaciondelcomprobante = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Descuento as custom

	nNodo = 120
	lAccess = .f.
	lDestroy = .f.

	Tipodecomprobante = 'TICKETNOTADECREDITO'
	Articulodelcomprobante = ''
	Valordelcomprobante = ''
	Generaciondelcomprobante = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_ComercioExterior as custom

	nNodo = 89
	lAccess = .f.
	lDestroy = .f.

	Solicitadespachodeimportacion = .T.
	Permitecontinuarsinoposeedespachodeimportacion = .T.
	Puntodeventa = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Herramientas as custom

	nNodo = 28
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Impresiones as custom

	nNodo = 29
	lAccess = .f.
	lDestroy = .f.

	Verificarlaexistenciadelacombinacionenlaimpresiondeetiquetas = .F.
	Impresiondirectaapuerto = 'COM1'
	Impresoradepuestonumero1 = ''
	Impresoradepuestonumero2 = ''
	Impresoradepuestonumero3 = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Numeraciones as custom

	nNodo = 37
	lAccess = .f.
	lDestroy = .f.

	Bocadeexpendio = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Precios as custom

	nNodo = 38
	lAccess = .f.
	lDestroy = .f.

	ListasDePrecios = null

	Accionmodificacionesdepreciosexpandirporcombinacion = 2
	Usarpreciosconvigencia = .T.

	function init() as void
		with this
			.ListasDePrecios = newobject( "FELINO_ListasDePrecios") 
		endwith
	endfunc

enddefine


define class FELINO_ListasDePrecios as custom

	nNodo = 40
	lAccess = .f.
	lDestroy = .f.

	Listadepreciospreferente = 'LISTA1'
	Alertarporcambioalalistadefaultcuandolalistapreferentedelclienteesinexistente = .T.
	Listadepreciospreferentecompras = ''
	Alertarporcambioalalistadefaultcuandolalistapreferentedelproveedoresinexistente = .T.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Sugerencias as custom

	nNodo = 44
	lAccess = .f.
	lDestroy = .f.

	Cambiodeturno = 1400
	Diasdesena = 15
	Codigovalorutilizadoalfinalizarelcomprobante = '0'
	Codigodevalorsugeridoparavuelto = ''
	Cantidadsugeridaparaarticulosenfacturanotadecreditoynotadedebito = 1
	Cantidadsugeridaparaarticulosenremito = 1
	Cantidadsugeridaparaarticulosenmovimientodestock = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Transferencias as custom

	nNodo = 45
	lAccess = .f.
	lDestroy = .f.

	Ventas = null
	RemitoDeVenta = null
	MovimientoDeStock = null
	MercaderiaEnTransito = null
	ComprobanteDeCaja = null
	PedidoDeCompra = null
	ValoresEnTransito = null

	function init() as void
		with this
			.Ventas = newobject( "FELINO_Ventas") 
			.RemitoDeVenta = newobject( "FELINO_RemitoDeVenta") 
			.MovimientoDeStock = newobject( "FELINO_MovimientoDeStock") 
			.MercaderiaEnTransito = newobject( "FELINO_MercaderiaEnTransito") 
			.ComprobanteDeCaja = newobject( "FELINO_ComprobanteDeCaja") 
			.PedidoDeCompra = newobject( "FELINO_PedidoDeCompra") 
			.ValoresEnTransito = newobject( "FELINO_ValoresEnTransito") 
		endwith
	endfunc

enddefine


define class FELINO_Ventas as custom

	nNodo = 48
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_RemitoDeVenta as custom

	nNodo = 73
	lAccess = .f.
	lDestroy = .f.

	Empaquetarcomprobantedespuesdegrabar = .T.
	Permitirempaquetarcomoremito = .F.
	Empaquetarcomprobantedespuesdeimportar = .F.
	Empaquetarcomporobantesdespuesdegrabarentregademercaderia = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_MovimientoDeStock as custom

	nNodo = 74
	lAccess = .f.
	lDestroy = .f.

	Empaquetarcomprobantedespuesdegrabar = .T.
	Empaquetarcomprobantedespuesdeimportar = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_MercaderiaEnTransito as custom

	nNodo = 84
	lAccess = .f.
	lDestroy = .f.

	Empaquetarcomprobantedespuesderechazar = .T.
	Confirmarstockdemaneraautomatica = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_ComprobanteDeCaja as custom

	nNodo = 123
	lAccess = .f.
	lDestroy = .f.

	Empaquetarcomprobantedespuesdegrabar = .F.
	Permitirempaquetarcomprobantesdecajaconelmismoorigendestinoqueeldelabasededatosactiva = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_PedidoDeCompra as custom

	nNodo = 126
	lAccess = .f.
	lDestroy = .f.

	Empaquetarcomprobantedespuesdegrabar = .F.
	Empaquetarcomprobantedespuesdeimportar = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_ValoresEnTransito as custom

	nNodo = 127
	lAccess = .f.
	lDestroy = .f.

	Empaquetarvaloresentransitodespuesderechazar = .T.
	Confirmarvaloresentransitodemaneraautomatica = .T.
	Vendedorsugeridoparalaconfirmacionautomaticadevaloresentransito = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Dispositivos as custom

	nNodo = 52
	lAccess = .f.
	lDestroy = .f.

	Basculas = null

	function init() as void
		with this
			.Basculas = newobject( "FELINO_Basculas") 
		endwith
	endfunc

enddefine


define class FELINO_Basculas as custom

	nNodo = 53
	lAccess = .f.
	lDestroy = .f.

	Cantidaddereintentosparalecturadepeso = 20
	Puertocom = 1
	Bitsporsegundobaudios = '9600'
	Bitsdedatos = '8'
	Paridad = 1
	Bitsdeparada = '1'
	Tiempodeesperaparacapturarelpuerto = 400
	Cantidaddedecimales = 2

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_MovimientosDeStock as custom

	nNodo = 54
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Interfases as custom

	nNodo = 57
	lAccess = .f.
	lDestroy = .f.

	Afip = null
	SolutionsMalls = null
	Apsa = null
	RemitoElectronico = null
	Cliente02404 = null
	DisplayVfd460 = null
	CaballitoShopping = null
	LasPiedrasShopping = null

	Repositoriopadrones = ''

	function init() as void
		with this
			.Afip = newobject( "FELINO_Afip") 
			.SolutionsMalls = newobject( "FELINO_SolutionsMalls") 
			.Apsa = newobject( "FELINO_Apsa") 
			.RemitoElectronico = newobject( "FELINO_RemitoElectronico") 
			.Cliente02404 = newobject( "FELINO_Cliente02404") 
			.DisplayVfd460 = newobject( "FELINO_DisplayVfd460") 
			.CaballitoShopping = newobject( "FELINO_CaballitoShopping") 
			.LasPiedrasShopping = newobject( "FELINO_LasPiedrasShopping") 
		endwith
	endfunc

enddefine


define class FELINO_Afip as custom

	nNodo = 68
	lAccess = .f.
	lDestroy = .f.

	RG452319Sire = null
	LibroIvaElectronico = null
	RG366814DatosAdicionalesClaseA = null

	function init() as void
		with this
			.RG452319Sire = newobject( "FELINO_RG452319Sire") 
			.LibroIvaElectronico = newobject( "FELINO_LibroIvaElectronico") 
			.RG366814DatosAdicionalesClaseA = newobject( "FELINO_RG366814DatosAdicionalesClaseA") 
		endwith
	endfunc

enddefine


define class FELINO_RG452319Sire as custom

	nNodo = 71
	lAccess = .f.
	lDestroy = .f.

	Habilitarretenciones = .F.
	Habilitarpercepciones = .F.
	Urllogin = 'https://wsaa.afip.gov.ar/ws/services/LoginCms'
	Rutadelcertificado = ''
	Urldelservidor = 'https://ws-aplicativos-reca.afip.gob.ar/sire/ws/v1/c2005/2005'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_LibroIvaElectronico as custom

	nNodo = 72
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_RG366814DatosAdicionalesClaseA as custom

	nNodo = 121
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_SolutionsMalls as custom

	nNodo = 69
	lAccess = .f.
	lDestroy = .f.

	Habilitarexportaciontotalsale = .F.
	Numerocliente = ''
	Numeropos = ''
	Numerorubro = ''
	Carpetaaplicacion = 'C:\'
	Nombrearchivoaplicacion = ''
	Rutadebackup = 'C:\'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Apsa as custom

	nNodo = 70
	lAccess = .f.
	lDestroy = .f.

	Habilitarexportacionapsa = .F.
	Numerodelocal = ''
	Numerodecontrato = ''
	Numeroderubro = '0000'
	Numeropos = ''
	Tipodocumento = 'DNI'
	Numerodedocumento = '000000000'
	Rutabackup = 'C:\'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_RemitoElectronico as custom

	nNodo = 88
	lAccess = .f.
	lDestroy = .f.

	Servicioderegistro = 'ARBA'
	Urlregistroremito = 'https://cot.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do'
	Usuario = ''
	Contrasena = ''
	Archivocertificado = ''
	Archivoclave = ''
	Urlautorizacionacceso = 'https://lb.agip.gob.ar/claveciudad/webservice/LoginWS'
	Productogenerico = ''
	Planta = 0
	Puerta = 0
	Numerodesecuencia = 0
	Letrasugeridaparaeltalonariodelcomprobante = 'R'
	Codigo = 91
	Carpetadetrabajo = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Cliente02404 as custom

	nNodo = 122
	lAccess = .f.
	lDestroy = .f.

	Solicitarmotivodedescuentoodevolucionencomprobantesdeventa = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_DisplayVfd460 as custom

	nNodo = 124
	lAccess = .f.
	lDestroy = .f.

	Puerto = 1
	Mensajedepresentacionprimeralinea = ''
	Mensajedepresentacionsegundalinea = ''
	Mensajedefinalizaciondecomprobanteprimeralinea = ''
	Mensajedefinalizaciondecomprobantesegundalinea = ''
	Tiempodeespera = 0
	Mostrarmontosconseparadordemiles = .T.
	Activainterfazcondisplay = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_CaballitoShopping as custom

	nNodo = 125
	lAccess = .f.
	lDestroy = .f.

	Habilitarexportacioncaballitoshopping = .F.
	Nombrearchivo = ''
	Rutaservidor = ''
	Numerodelocal = 0
	Numerodecontrato = 0
	Numerodecaja = 0
	Numeroderubro = 0000

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_LasPiedrasShopping as custom

	nNodo = 143
	lAccess = .f.
	lDestroy = .f.

	Usuario = ''
	Contrasena = ''
	Habilitarexportacionlaspiedrasshopping = .F.
	Urlparametrizacionporrut = 'https://ventas.laspiedrasshopping.com.uy/soap/NodumLocales/services/sim/v1.3/wsConsxRUT'
	Urlparametrizacionporcontrato = 'https://ventas.laspiedrasshopping.com.uy/soap/NodumLocales/services/sim/v1.3/wsConsxCont'
	Urlinformarventas = 'https://ventas.laspiedrasshopping.com.uy/soap/NodumLocales/services/forms/v1.3/wsDeclaVtas2'
	Codigoshopping = ''
	Numerocontrato = 0
	Codigorubro = ''
	Codigocanal = ''
	Secuencial = 1
	Horarioprimeraejecucionenviodiferido = ''
	Horariosegundaejecucionenviodiferido = ''
	Cantidaddediasaincluirenenviodiferido = 30

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Backup as custom

	nNodo = 77
	lAccess = .f.
	lDestroy = .f.

	Ejecutartareasdebackupdeformaautomatizada = .T.
	Estepuestodetrabajorealizaelbackupdeformaautomatica = .T.
	Horadeejecuciondelbackup = 11
	Notificarlaausenciaderegistrodebackup = .T.
	Notificarelfaltantedebackupsluegodedias = 2
	Protegerlascopiasdeseguridadconestepassword = ''
	Memoriadisponibleparaelservidordedatos = 'Administrado en el motor de bases de datos (Recomendado)'

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_GestionDeCompras as custom

	nNodo = 78
	lAccess = .f.
	lDestroy = .f.

	Nuevobasadoen = null

	Generarpagoautomaticoalemitirunaordendepago = .T.
	Fechaautilizarenelcomprobantedepago = 1
	Anularchequespropiosencomprobantes = .F.
	Actualizapreciosalmodificarlafechadelafactura = 1
	Permiteingresarretencionesencomprobantes = .T.
	Restringirelingresodedecimalesencantidadcompras = .F.
	Solicitardatosdetransaccionbancariaenordendepago = .T.
	Nopermitirelingresodefacturasdecomprarepetidas = .F.
	Nopermitirelingresoderemitosdecomprarepetidos = .F.
	Incluirchequespropiosnovencidosensaldoacreedor = .T.
	Nrodechequeengrilladevaloresdeordenesdepago = .F.
	Permitecargarcomprobantesdecompraenmonedaextranjera = .F.

	function init() as void
		with this
			.Nuevobasadoen = newobject( "FELINO_Nuevobasadoen") 
		endwith
	endfunc

enddefine


define class FELINO_Nuevobasadoen as custom

	nNodo = 79
	lAccess = .f.
	lDestroy = .f.

	Factura = null
	NotaDeCredito = null
	Cancelacion = null
	Remito = null
	Pedido = null
	Presupuesto = null
	Solicitud = null

	Solicituddecompradefaultcombocomprobanteafectado = 'Requerimiento de compra'
	Solicituddecompradefaultcombofiltro = 'por número'
	Solicituddecompradefaultcomboseleccionoperatoria = 1
	Presupuestodecompradefaultcombocomprobanteafectado = 'Solicitud de compra'
	Presupuestodecompradefaultcombofiltro = 'por número'
	Presupuestodecompradefaultcomboseleccionoperatoria = 1
	Pedidodecompradefaultcombocomprobanteafectado = 'Presupuesto de compra'
	Pedidodecompradefaultcombofiltro = 'por número'
	Pedidodecompradefaultcomboseleccionoperatoria = 1
	Pedidodecompracontrolinicial = 'Número'
	Remitodecompradefaultcombocomprobanteafectado = 'Pedido de compra'
	Remitodecompradefaultcombofiltro = 'por número'
	Remitodecompradefaultcomboseleccionoperatoria = 1
	Remitodecompracontrolinicial = 'Número'
	Cancelaciondecompradefaultcombocomprobanteafectado = 'Remito de compra'
	Cancelaciondecompradefaultcombofiltro = 'por número'
	Cancelaciondecompradefaultcomboseleccionoperatoria = 1
	Facturadecompradefaultcombocomprobanteafectado = 'Remito de compra'
	Facturadecompradefaultcombofiltro = 'por número'
	Facturadecompradefaultcomboseleccionoperatoria = 1
	Facturadecompracontrolinicial = 'Número'
	Notadecreditocompradefaultcombocomprobanteafectado = 'Factura de compra'
	Notadecreditocompradefaultcombofiltro = 'por número'
	Notadecreditodecompradefaultcomboseleccionoperatoria = 1
	Notadecreditocompracontrolinicial = 'Número'
	Actualizarpreciosencomprobantesnuevosenbaseacompra = 1
	Pedidodecompranopermiteagregar = .F.
	Remitodecompranopermiteagregar = .F.
	Facturadecompranopermiteagregar = .F.
	Notadecreditocompranopermiteagregar = .F.
	Cancelaciondecompracontrolinicial = 'Número'
	Solicituddecompracontrolinicial = 'Número'
	Presupuestodecompracontrolinicial = 'Número'

	function init() as void
		with this
			.Factura = newobject( "FELINO_Factura") 
			.NotaDeCredito = newobject( "FELINO_NotaDeCredito") 
			.Cancelacion = newobject( "FELINO_Cancelacion") 
			.Remito = newobject( "FELINO_Remito") 
			.Pedido = newobject( "FELINO_Pedido") 
			.Presupuesto = newobject( "FELINO_Presupuesto") 
			.Solicitud = newobject( "FELINO_Solicitud") 
		endwith
	endfunc

enddefine


define class FELINO_Factura as custom

	nNodo = 134
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_NotaDeCredito as custom

	nNodo = 135
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Cancelacion as custom

	nNodo = 136
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Remito as custom

	nNodo = 137
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Pedido as custom

	nNodo = 138
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Presupuesto as custom

	nNodo = 139
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Solicitud as custom

	nNodo = 140
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Picking as custom

	nNodo = 83
	lAccess = .f.
	lDestroy = .f.

	Tipodefacturaparaaccionesdepicking = 1
	Comprobantedefaultparanuevopicking = 'MERCADERIAENTRANSITO'
	Recibirparcialmentelamercaderia = .F.
	Motivodemovimientogeneradoporrecepcionparcialdemercaderia = ''
	Ejecutaraccioncargarcomprobantesacontrolarautomaticamente = .F.
	Comprobanteparaprocesardiferencias = 'Movimiento de stock'
	Accionfacturar = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Fondos as custom

	nNodo = 86
	lAccess = .f.
	lDestroy = .f.

	Margendeerrorporredondeoenconciliacionbancaria = 0.00

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class FELINO_Znube as custom

	nNodo = 119
	lAccess = .f.
	lDestroy = .f.

	Omnicanalidad = null

	Actualizarlainformaciondelabasededatosenlanubealcerrarcaja = .T.

	function init() as void
		with this
			.Omnicanalidad = newobject( "FELINO_Omnicanalidad") 
		endwith
	endfunc

enddefine


define class FELINO_Omnicanalidad as custom

	nNodo = 141
	lAccess = .f.
	lDestroy = .f.

	Urlparaobtenertoken = 'https://www.znube.com.ar/Settings/AppSignIn'
	Tokendeconfiguracion = ''

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
	Buscador = null
	Transferencias = null
	Listados = null
	Backup = null
	DatosGenerales = null
	Importacion = null
	Administradorbd = null
	Logueos = null
	Actualizaciones = null
	Sc = null
	SonidosYNotificaciones = null
	Comunicaciones = null
	Altas = null
	Generales = null

	Origendedatospreferente = 'PAISES'
	Permitecodigosenminusculas = .F.
	Habilitarautoimpresor = .F.
	Prefijobasededatos = ''
	Sucursal = ''
	Agrupamientoparaconsultadestock = ''
	Avisaralcancelarunaentidadmediantelateclaesc = 3
	Mododeparametrosdepuesto = 1

	function init() as void
		with this
			.Seguridad = newobject( "NUCLEO_Seguridad") 
			.Buscador = newobject( "NUCLEO_Buscador") 
			.Transferencias = newobject( "NUCLEO_Transferencias") 
			.Listados = newobject( "NUCLEO_Listados") 
			.Backup = newobject( "NUCLEO_Backup") 
			.DatosGenerales = newobject( "NUCLEO_DatosGenerales") 
			.Importacion = newobject( "NUCLEO_Importacion") 
			.Administradorbd = newobject( "NUCLEO_Administradorbd") 
			.Logueos = newobject( "NUCLEO_Logueos") 
			.Actualizaciones = newobject( "NUCLEO_Actualizaciones") 
			.Sc = newobject( "NUCLEO_Sc") 
			.SonidosYNotificaciones = newobject( "NUCLEO_SonidosYNotificaciones") 
			.Comunicaciones = newobject( "NUCLEO_Comunicaciones") 
			.Altas = newobject( "NUCLEO_Altas") 
			.Generales = newobject( "NUCLEO_Generales") 
		endwith
	endfunc

enddefine


define class NUCLEO_Seguridad as custom

	nNodo = 2
	lAccess = .f.
	lDestroy = .f.

	Sugerirultimousuariologueado = .T.
	Numerodeusuariosmostradosenlogin = 4
	Activarlaseguridadalsalir = .F.
	Recordarusuario = .F.
	Utilizarbasededatospreferente = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Buscador as custom

	nNodo = 3
	lAccess = .f.
	lDestroy = .f.

	Mostrarformulariodeimagenesenelbuscador = .T.
	Cantidadmaximaderesultadosenelbuscador = 1000
	Realizarbusquedainicial = .T.
	Resultadosquesemuestranseguncantidadmaximaseleccionada = 'Últimos'
	Cantidadmaximaderesultadosenlasconsultas = 1000

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Transferencias as custom

	nNodo = 4
	lAccess = .f.
	lDestroy = .f.

	Password = '1234'
	Rutarecepcion = ''
	Rutadeenvio = ''
	Actualizarsubentidadesalrecibir = .F.
	Codigoorigendesucursal = 'DEMO'
	Diasatransferirpordefecto = 3
	Enviarelprocesodeempaquetadoalagentedeaccionesorganic = .T.
	Procesarpaquetesprovenientesdeusuariossinaccesoalabasededatos = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Listados as custom

	nNodo = 5
	lAccess = .f.
	lDestroy = .f.

	Fuente = 'TAHOMA'
	Tamanodelafuente = 9
	Ocultarvaloresceroenlistados = .T.
	Zoom = 122
	Rutasugeridaalguardarendisco = ''
	Usarseparadordemiles = .T.
	Separadordemiles = ''
	Separadordecimal = ''
	Negativosencolorrojo = .T.
	Permitiraccesoamasdetalle = .T.
	Habilitarformatosdesalidaatablaparalistadostipocomprobante = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Backup as custom

	nNodo = 6
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_DatosGenerales as custom

	nNodo = 7
	lAccess = .f.
	lDestroy = .f.

	Nombredelaempresa = ''
	Razonsocialdelaempresa = ''
	Logodelaempresa = ''
	Telefonodelaempresa = ''
	Direcciondelaempresa = ''
	Pais = 1
	Localidaddelaempresa = ''
	Codigopostaldelaempresa = ''
	Provinciadelaempresa = ''
	Iniciodeactividades = {  /  /    }
	Email = ''
	Paginaweb = ''
	Nombredelsitio = ''

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Importacion as custom

	nNodo = 8
	lAccess = .f.
	lDestroy = .f.

	Tipodelog = 1

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Administradorbd as custom

	nNodo = 9
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Logueos as custom

	nNodo = 10
	lAccess = .f.
	lDestroy = .f.

	Smtphost = ''
	Puerto = 25
	Modoautenticacion = 'Basic'
	Usuario = ''
	Password = '1234'
	Remitente = ''
	Destinatario = ''
	Asunto = ''
	Habilitarlogueointerno = .F.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Actualizaciones as custom

	nNodo = 11
	lAccess = .f.
	lDestroy = .f.

	Origendedescarga = 1
	Rutadedescarga = ''
	Descargarlasactualizacionesdelawebparapublicarlasenelservidorpropio = .F.
	Publicarautomaticamentelasnuevasactualizaciones = .F.
	Notificarmedeactualizacionesqueestenpendientesdepublicar = .F.
	Buscaractualizacionesaliniciar = .T.
	Descargarautomaticamenteactualizacionesaliniciar = .T.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Sc as custom

	nNodo = 12
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_SonidosYNotificaciones as custom

	nNodo = 13
	lAccess = .f.
	lDestroy = .f.

	Windows = null

	Reproducirsonidos = .T.
	Avisarporfaltadeconfiguraciondelossiguientesparametros = .T.
	Cuentadeenviodemailsanteproblemasdeejecucionesdesatendidas = ''
	Mailsdedestinoanteproblemasdeejecucionesdesatendidas = ''
	Enviodemailsanteproblemasenlaherramientadegeneraciondecomprobantesecommerce = .T.
	Enviodemailsanteproblemasenlaobtenciondecae = .T.
	Enviodemailsanteproblemasenelenviodepdfdecomprobantes = .T.

	function init() as void
		with this
			.Windows = newobject( "NUCLEO_Windows") 
		endwith
	endfunc

enddefine


define class NUCLEO_Windows as custom

	nNodo = 17
	lAccess = .f.
	lDestroy = .f.

	Activarnotificaciones = .T.
	Mostrarbannerdenotificaciones = .T.
	Duraciondelbannerdenotificaciones = 1
	Notificacionesanteproblemasenenviodeemails = .T.
	Notificacionesanteproblemasenrecepciondetransferencias = .T.
	Notificacionesanteproblemasenobtenciondecae = .T.
	Notificacionesanteproblemasenenviodecomprobanteamercadolibre = .T.
	Notificacionesalprocesarpaquetesdedatosdepreciosdearticulos = .F.
	Notificacionesanteproblemasenpresentaciondecomprobantescaea = .T.
	Notificacionesanteproblemasalenviarinformedeventaalaspiedrasshopping = .T.
	Rangovencimientocais = 10

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Comunicaciones as custom

	nNodo = 15
	lAccess = .f.
	lDestroy = .f.

	Enviarrecibiryprocesarautomaticamente = .T.
	Frecuenciaenminutos = 20
	Procesarpaquetesdeltipoabasededatosenlabasededatos = '[PREF]'
	Empaquetarresumendeldiaalcerrarlacaja = .F.
	Enviaryrecibirpaquetesdedatosluegodeempaquetarresumendeldiaalcerrarlacaja = .F.
	Enviaralosbuzones = ''
	Preguntarrespectodelaautomatizaciondelempaquetadodelresumendeldia = 2

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Altas as custom

	nNodo = 16
	lAccess = .f.
	lDestroy = .f.

	Carpetaimagenes = ''
	Permiteutilizardirectoriodistintoarutacarpetaimagenes = .T.

	function init() as void
		with this
		endwith
	endfunc

enddefine


define class NUCLEO_Generales as custom

	nNodo = 18
	lAccess = .f.
	lDestroy = .f.

	Ejecuciondeprocesosensegundoplanoconbajaprioridad = .F.
	Agregaalusuariologueadoelultimousuarioqueinvocalaseguridad = .F.
	Tenantid = ''
	Applicationid = ''

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