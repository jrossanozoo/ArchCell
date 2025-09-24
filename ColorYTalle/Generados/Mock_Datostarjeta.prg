
define class Mock_datostarjeta as MockBase of MockBase.prg

	lNuevo = .f. 
	lEdicion = .f. 
	lDestroy = .f. 
	cContexto = '' 

	cClase = 'datostarjeta'

	
	AplicaRecargo = .F.                                                                                                                                                                                                                                       
	AutorizacionPOS = .F.                                                                                                                                                                                                                                     
	AutorizacionTelefonica = ""                                                                                                                                                                                                                               
	AutorizacionTelefonicaOffLine = 0                                                                                                                                                                                                                         
	BASEDEDATOSALTAFW = ""                                                                                                                                                                                                                                    
	BASEDEDATOSMODIFICACIONFW = ""                                                                                                                                                                                                                            
	BloquearRegistro = .f.                                                                                                                                                                                                                                    
	CamposEquivalenciaLince = ""                                                                                                                                                                                                                              
	ClaseDeTarjeta = ""                                                                                                                                                                                                                                       
	Cliente = null                                                                                                                                                                                                                                            
	Cliente_PK = ""                                                                                                                                                                                                                                           
	Codigo = ""                                                                                                                                                                                                                                               
	CodigoPlan = ""                                                                                                                                                                                                                                           
	Cuotas = 0                                                                                                                                                                                                                                                
	CuponReferente = 0                                                                                                                                                                                                                                        
	DescuentoMontoSinImpuestos = 0                                                                                                                                                                                                                            
	DetallePlanes = null                                                                                                                                                                                                                                      
	DispositivoMovil = ""                                                                                                                                                                                                                                     
	ESTADOTRANSFERENCIA = ""                                                                                                                                                                                                                                  
	EntidadFinanciera = null                                                                                                                                                                                                                                  
	EntidadFinanciera_PK = ""                                                                                                                                                                                                                                 
	FECHAALTAFW = ctod( '  /  /    ' )                                                                                                                                                                                                                        
	FECHAEXPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAIMPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )                                                                                                                                                                                                                
	FECHATRANSFERENCIA = ctod( '  /  /    ' )                                                                                                                                                                                                                 
	FechaAltaFW = {}                                                                                                                                                                                                                                          
	FechaModificacionFW = {}                                                                                                                                                                                                                                  
	FechaReferente = ctod( '  /  /    ' )                                                                                                                                                                                                                     
	HORAALTAFW = ""                                                                                                                                                                                                                                           
	HORAEXPO = ""                                                                                                                                                                                                                                             
	HORAIMPO = ""                                                                                                                                                                                                                                             
	HORAMODIFICACIONFW = ""                                                                                                                                                                                                                                   
	IdExternoClover = ""                                                                                                                                                                                                                                      
	IdGoCuotas = ""                                                                                                                                                                                                                                           
	IdOrdenClover = ""                                                                                                                                                                                                                                        
	IdPagoClover = ""                                                                                                                                                                                                                                         
	IdPuestoQR = ""                                                                                                                                                                                                                                           
	IdSmartLaPos = ""                                                                                                                                                                                                                                         
	InformacionInteractiva = ""                                                                                                                                                                                                                               
	Integrado = ""                                                                                                                                                                                                                                            
	LoteReferente = 0                                                                                                                                                                                                                                         
	Moneda = null                                                                                                                                                                                                                                             
	Moneda_PK = ""                                                                                                                                                                                                                                            
	Monto = 0                                                                                                                                                                                                                                                 
	NombreTitular = ""                                                                                                                                                                                                                                        
	NroDocumentoTitular = ""                                                                                                                                                                                                                                  
	NumeroCierreDeLote = 0                                                                                                                                                                                                                                    
	NumeroComprobante = 0                                                                                                                                                                                                                                     
	NumeroCupon = 0                                                                                                                                                                                                                                           
	NumeroLote = 0                                                                                                                                                                                                                                            
	NumeroTarjetaReferente = ""                                                                                                                                                                                                                               
	NumeroUnico = 0                                                                                                                                                                                                                                           
	NumeroUnicoReferente = 0                                                                                                                                                                                                                                  
	Observacion = ""                                                                                                                                                                                                                                          
	POS = null                                                                                                                                                                                                                                                
	POS_PK = ""                                                                                                                                                                                                                                               
	PesosAlCambio = 0                                                                                                                                                                                                                                         
	PorcentajeDescuento = 0                                                                                                                                                                                                                                   
	PorcentajeRecargo = 0                                                                                                                                                                                                                                     
	PuntoDeVentaComprobante = 0                                                                                                                                                                                                                               
	QRTranfDebinIDPosnet = ""                                                                                                                                                                                                                                 
	QRTransactionIDPosnet = ""                                                                                                                                                                                                                                
	RecargoMontoSinImpuestos = 0                                                                                                                                                                                                                              
	ReferenciaExterna = ""                                                                                                                                                                                                                                    
	RetornoExtension = .t.                                                                                                                                                                                                                                    
	SERIEALTAFW = ""                                                                                                                                                                                                                                          
	SERIEMODIFICACIONFW = ""                                                                                                                                                                                                                                  
	Serial = ""                                                                                                                                                                                                                                               
	Tarjeta = null                                                                                                                                                                                                                                            
	Tarjeta_PK = ""                                                                                                                                                                                                                                           
	TelefonoTitular = ""                                                                                                                                                                                                                                      
	TerminalesSmartLaPos = ""                                                                                                                                                                                                                                 
	TicketICard = ""                                                                                                                                                                                                                                          
	TicketICardCl = ""                                                                                                                                                                                                                                        
	TipoCupon = ""                                                                                                                                                                                                                                            
	TipoDocumentoTitular = ""                                                                                                                                                                                                                                 
	TipoPagoLaPos = 0                                                                                                                                                                                                                                         
	TipoPagoPosnet = 0                                                                                                                                                                                                                                        
	TipoPagoSmartLaPos = 0                                                                                                                                                                                                                                    
	TotalConRecargo = 0                                                                                                                                                                                                                                       
	TotalConRecargoPorCuota = 0                                                                                                                                                                                                                               
	TotalDescuento = 0                                                                                                                                                                                                                                        
	TotalRecargo = 0                                                                                                                                                                                                                                          
	USUARIOALTAFW = ""                                                                                                                                                                                                                                        
	USUARIOMODIFICACIONFW = ""                                                                                                                                                                                                                                
	UltimosDigitos = ""                                                                                                                                                                                                                                       
	VERSIONALTAFW = ""                                                                                                                                                                                                                                        
	VERSIONMODIFICACIONFW = ""                                                                                                                                                                                                                                
	Validacion = .F.                                                                                                                                                                                                                                          
	ZADSFW = ""                                                                                                                                                                                                                                               
	cAtributoAAuditar = ""                                                                                                                                                                                                                                    
	cAtributoPK = ""                                                                                                                                                                                                                                          
	cAtributoVendedor = ''                                                                                                                                                                                                                                    
	cCaracteres = ""                                                                                                                                                                                                                                          
	cContexto = ""                                                                                                                                                                                                                                            
	cDescripcion =  "Datos de cobros con tarjetas"                                                                                                                                                                                                            
	cDescripcionSingular = ""                                                                                                                                                                                                                                 
	cEvento = ""                                                                                                                                                                                                                                              
	cFormatoFechaNet = ""                                                                                                                                                                                                                                     
	cIdentificadorConexion = ""                                                                                                                                                                                                                               
	cNombre = ""                                                                                                                                                                                                                                              
	cNombre = 'DATOSTARJETA'                                                                                                                                                                                                                                  
	cNombreTitularMemoria = ""                                                                                                                                                                                                                                
	cNroDocumentoTitularMemoria = ""                                                                                                                                                                                                                          
	cPrefijoImportar = ""                                                                                                                                                                                                                                     
	cPrefijoRecibir = ""                                                                                                                                                                                                                                      
	cTelefonoTitularMemoria = ""                                                                                                                                                                                                                              
	cTipoDocumentoTitularMemoria = ""                                                                                                                                                                                                                         
	cUsuarioQueAutorizoSeguridad = ""                                                                                                                                                                                                                         
	lAccionAutomaticaTipoAntes = .F.                                                                                                                                                                                                                          
	lActivando = .f.                                                                                                                                                                                                                                          
	lActualizaRecepcion = .T.                                                                                                                                                                                                                                 
	lActualizarSoloEquivalenciasDeLince = .f.                                                                                                                                                                                                                 
	lAnular = .f.                                                                                                                                                                                                                                             
	lAplicaPromoPorMedioDePago = .f.                                                                                                                                                                                                                          
	lAplicaPromocion = .f.                                                                                                                                                                                                                                    
	lAplicoBeneficioPromo = .f.                                                                                                                                                                                                                               
	lBuscandoCodigo = .f.                                                                                                                                                                                                                                     
	lCanceloOperacionBilleteraSantaFe = .f.                                                                                                                                                                                                                   
	lCanceloOperacionMercadoPago = .f.                                                                                                                                                                                                                        
	lCargando = .f.                                                                                                                                                                                                                                           
	lCargandoAnulacionDeCupon = .f.                                                                                                                                                                                                                           
	lConfirmarImpresion = 0                                                                                                                                                                                                                                   
	lControlaSecuencialEnCodBarAlt = .F.                                                                                                                                                                                                                      
	lDebeRenumerarAlEnviarABaseDeDatos = .F.                                                                                                                                                                                                                  
	lDesarrollo = .f.                                                                                                                                                                                                                                         
	lDestroy = .f.                                                                                                                                                                                                                                            
	lEdicion = .F.                                                                                                                                                                                                                                            
	lEligioUnCodigoDeLaLista = .F.                                                                                                                                                                                                                            
	lEliminar = .T.                                                                                                                                                                                                                                           
	lEntidadEditable =  .t.                                                                                                                                                                                                                                   
	lEntidadEditable = .t.                                                                                                                                                                                                                                    
	lEnviaMailErroresSegundoPlanoHerramientaEcommerce = .f.                                                                                                                                                                                                   
	lEnviaMailTiquetDeCambioEnSegundoPlano = .f.                                                                                                                                                                                                              
	lEsEntidadConEdicionRestringida = .f.                                                                                                                                                                                                                     
	lEsExe = .f.                                                                                                                                                                                                                                              
	lEsSubEntidad = .f.                                                                                                                                                                                                                                       
	lEstaAnulandoDirectamente = .f.                                                                                                                                                                                                                           
	lEstaSeteandoValorSugerido = .f.                                                                                                                                                                                                                          
	lEstaVisibleDispositivoMovil = .t.                                                                                                                                                                                                                        
	lEstaVisibleIdPagoClover = .t.                                                                                                                                                                                                                            
	lEstaVisibleIdSmartLaPos = .t.                                                                                                                                                                                                                            
	lEstaVisiblePuestoQR = .t.                                                                                                                                                                                                                                
	lEstaVisibleTerminalesSmartLaPos = .t.                                                                                                                                                                                                                    
	lEstaVisibleTipoPagoLaPos = .t.                                                                                                                                                                                                                           
	lEstaVisibleTipoPagoPosnet = .t.                                                                                                                                                                                                                          
	lHabilitaEnviarAlGrabar = .f.                                                                                                                                                                                                                             
	lHabilitarAutorizacionTelefonica = .T.                                                                                                                                                                                                                    
	lHabilitarAutorizacionTelefonicaOffLine = .T.                                                                                                                                                                                                             
	lHabilitarClaseDeTarjeta = .T.                                                                                                                                                                                                                            
	lHabilitarCodigoPlan = .T.                                                                                                                                                                                                                                
	lHabilitarCuotas = .T.                                                                                                                                                                                                                                    
	lHabilitarCuponReferente = .T.                                                                                                                                                                                                                            
	lHabilitarDispositivoMovil = .T.                                                                                                                                                                                                                          
	lHabilitarEntidadFinanciera_PK = .T.                                                                                                                                                                                                                      
	lHabilitarFechaReferente = .T.                                                                                                                                                                                                                            
	lHabilitarIdGoCuotas = .T.                                                                                                                                                                                                                                
	lHabilitarIdOrdenClover = .T.                                                                                                                                                                                                                             
	lHabilitarIdPagoClover = .T.                                                                                                                                                                                                                              
	lHabilitarIdPuestoQR = .T.                                                                                                                                                                                                                                
	lHabilitarIdSmartLaPos = .T.                                                                                                                                                                                                                              
	lHabilitarLoteReferente = .T.                                                                                                                                                                                                                             
	lHabilitarMoneda_PK = .T.                                                                                                                                                                                                                                 
	lHabilitarMonto = .T.                                                                                                                                                                                                                                     
	lHabilitarNombreTitular = .T.                                                                                                                                                                                                                             
	lHabilitarNroDocumentoTitular = .T.                                                                                                                                                                                                                       
	lHabilitarNumeroCierreDeLote = .T.                                                                                                                                                                                                                        
	lHabilitarNumeroCupon = .T.                                                                                                                                                                                                                               
	lHabilitarNumeroLote = .T.                                                                                                                                                                                                                                
	lHabilitarPOS_PK = .T.                                                                                                                                                                                                                                    
	lHabilitarQRTranfDebinIDPosnet = .T.                                                                                                                                                                                                                      
	lHabilitarQRTransactionIDPosnet = .T.                                                                                                                                                                                                                     
	lHabilitarTarjeta_PK = .T.                                                                                                                                                                                                                                
	lHabilitarTelefonoTitular = .T.                                                                                                                                                                                                                           
	lHabilitarTerminalesSmartLaPos = .T.                                                                                                                                                                                                                      
	lHabilitarTipoCupon = .T.                                                                                                                                                                                                                                 
	lHabilitarTipoDocumentoTitular = .T.                                                                                                                                                                                                                      
	lHabilitarTipoPagoLaPos = .T.                                                                                                                                                                                                                             
	lHabilitarTipoPagoPosnet = .T.                                                                                                                                                                                                                            
	lHabilitarTipoPagoSmartLaPos = .T.                                                                                                                                                                                                                        
	lHabilitarUltimosDigitos = .T.                                                                                                                                                                                                                            
	lHabilitarmailGoCuotas = .T.                                                                                                                                                                                                                              
	lIgnorarCamposObligatoriosDefinidosPorUsuario = .F.                                                                                                                                                                                                       
	lIgnorarClaveprimariaEnRecepcionBD = .f.                                                                                                                                                                                                                  
	lInicializando = .t.                                                                                                                                                                                                                                      
	lInicializarCodigoSugeridoHabilitado = .f.                                                                                                                                                                                                                
	lInstanciarSubEntidadaDemanda = .t.                                                                                                                                                                                                                       
	lLanzarEventoCambioDeValor = .f.                                                                                                                                                                                                                          
	lLimpiando = .f.                                                                                                                                                                                                                                          
	lLoguear = .T.                                                                                                                                                                                                                                            
	lLogueoPropio = .T.                                                                                                                                                                                                                                       
	lNoCheckSessionOpen = .f. && para omitir el objeto del analisis de sessiones abiertas de test de foxunit                                                                                                                                                  
	lNoLoguearRestAPI = .F.                                                                                                                                                                                                                                   
	lNuevo = .F.                                                                                                                                                                                                                                              
	lOmiteObligatorioEnPack = .f.                                                                                                                                                                                                                             
	lPermiteCompraNoIntegradaConDispositivoElectronico = .f.                                                                                                                                                                                                  
	lPermiteMinusculasPK = .f.                                                                                                                                                                                                                                
	lProcesando = .F.                                                                                                                                                                                                                                         
	lReAsignarPk_Con_CC = .F.                                                                                                                                                                                                                                 
	lRetiraEfectivo = .f.                                                                                                                                                                                                                                     
	lTieneAccionesAutomaticas = .f.                                                                                                                                                                                                                           
	lTieneDiseñosParaEnviarMail = .t.                                                                                                                                                                                                                         
	lTieneVendedorComoClaveForanea = .f.                                                                                                                                                                                                                      
	lWHEliminar = .f.                                                                                                                                                                                                                                         
	lWHIngresar = .f.                                                                                                                                                                                                                                         
	lWHModificar = .f.                                                                                                                                                                                                                                        
	lcCodigoDeCuponReferente = ""                                                                                                                                                                                                                             
	llNoCambiarTipoPagoPosnet = .f.                                                                                                                                                                                                                           
	mailGoCuotas = ""                                                                                                                                                                                                                                         
	nItemOriginal = 0                                                                                                                                                                                                                                         
	nMontoBeneficioPromoMedioDePago = 0                                                                                                                                                                                                                       
	nSeteoPreguntaTipoPago = 0                                                                                                                                                                                                                                
	oAD = null                                                                                                                                                                                                                                                
	oAtributosAnulacion = null                                                                                                                                                                                                                                
	oAtributosAuditoria = null                                                                                                                                                                                                                                
	oAtributosConEdicionRestringida= null                                                                                                                                                                                                                     
	oColAtributosObligatoriosDefinidosPorUsuario = null                                                                                                                                                                                                       
	oColaboradorPOS = null                                                                                                                                                                                                                                    
	oColaboradorPromocionBancaria = null                                                                                                                                                                                                                      
	oColaboradorPromocionMedioDePago = null                                                                                                                                                                                                                   
	oColaboradorRetiroDeEfectivo = null                                                                                                                                                                                                                       
	oColeccionVS = null                                                                                                                                                                                                                                       
	oColeccionVSFW = null                                                                                                                                                                                                                                     
	oComportamientoCodigoSugerido = null                                                                                                                                                                                                                      
	oComprobante = null                                                                                                                                                                                                                                       
	oCupon = null                                                                                                                                                                                                                                             
	oCuponDeAnulacion = null                                                                                                                                                                                                                                  
	oCuponParaAnular = null                                                                                                                                                                                                                                   
	oDetalleValores = null                                                                                                                                                                                                                                    
	oExtension = null                                                                                                                                                                                                                                         
	oGestorDeMail = null                                                                                                                                                                                                                                      
	oHelperPlanDeCuotas = null                                                                                                                                                                                                                                
	oInformacion = null                                                                                                                                                                                                                                       
	oLogueo = null                                                                                                                                                                                                                                            
	oMensaje = null                                                                                                                                                                                                                                           
	oNumeraciones =  null                                                                                                                                                                                                                                     
	oObservadoresDeImportacion = null                                                                                                                                                                                                                         
	oProveedorAtributosAnulacion = null                                                                                                                                                                                                                       
	oRegistrosDeActividadesAlGrabar = Null                                                                                                                                                                                                                    
	oTalle = null                                                                                                                                                                                                                                             
	oValidacionDominios= null                                                                                                                                                                                                                                 
	oValidadorTarjeta = null                                                                                                                                                                                                                                  
	oValidadoresComp = null                                                                                                                                                                                                                                   
	
	*-----------------------------------------------------------------------------------------
	function Inicializar() as boolean
		this.InciarPropiedades()
	endfunc

	*-----------------------------------------------------------------------------------------
	function InciarPropiedades() as Void
		local lnIdMock as Integer, i as Integer, lcPropiedad as String
		lnIdMock = _Screen.Mocks.BuscarMock( this.cClase )
		if lnIdMock > 0
			for i = 1 to _Screen.Mocks[ lnIdMock ].oPropiedades.Count
				_Screen.Mocks.SetearResultadoPropiedad( this, lnIdMock, i )
			endfor
		endif
	endfunc

	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	    function debeanulargocuotas() as boolean                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debeanulargocuotas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    function debeanularpoint() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debeanularpoint', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    function debeanulartiendacrypto() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debeanulartiendacrypto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    function eventoreacomodarcontrolesdatoscupon() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoreacomodarcontrolesdatoscupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    function eventosetearvisibilidadsegundispositivo() as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventosetearvisibilidadsegundispositivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    function eventoverificarvisibilidadterminalessmartlapos() as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoverificarvisibilidadterminalessmartlapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    function pedirautorizacion() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Pedirautorizacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    protected function validarcodigosidendevolucionparaclover() as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcodigosidendevolucionparaclover', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    protected function validarcuponreferenteendevolucionparaintegrados() as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcuponreferenteendevolucionparaintegrados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	    protected function validardispositivogocuotasendevolucionparaintegrados() as boolean                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validardispositivogocuotasendevolucionparaintegrados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function accionesautomatizadas( tcmetodo as string ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcmetodo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Accionesautomatizadas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function accionesparaenviodeemail() as boolean                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Accionesparaenviodeemail', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizarcombo() as void                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizarcombo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizarcomboclasedetarjeta() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizarcomboclasedetarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizarestado() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizarestado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizargrilla() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizargrilla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizargrillacomprobante() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizargrillacomprobante', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizarprogressbar( tnvalor as integer ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnvalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Actualizarprogressbar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarestimulo( tc1 ) as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tc1

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarestimulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarinformacion( tcinformacion as string, tnnumero as integer, txinfoextra as variant ) as void                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcinformacion
		lxParam2 = tnnumero
		lxParam3 = txinfoextra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarinformaciondeexcepcion( toerror as exception ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toerror

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarinformaciondeexcepcion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarobservadordeimportacion( toprocesoimportacion as procesoimportacion of procesoimportacion.prg ) as void                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toprocesoimportacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarobservadordeimportacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarreferencia( tcassembly as string ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcassembly

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarreferencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarvalidador( lovalidador as object ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = lovalidador

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarvalidador', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ajustarobjetobusqueda( tobusqueda as object ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tobusqueda

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Ajustarobjetobusqueda', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function anterior () as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Anterior', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function antesdeanular() as void                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Antesdeanular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function antesdefinalizarrecibir() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Antesdefinalizarrecibir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function antesdegrabar() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Antesdegrabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function anular() as void                                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Anular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function aplicapromocionautomatica() as boolean                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Aplicapromocionautomatica', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function aplicarecargo_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'aplicarecargo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'aplicarecargo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Aplicarecargo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Aplicarecargo( lxVal )				this.Setear_Aplicarecargo( lxVal )			EndIf		Else			This.Setear_Aplicarecargo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function asignarvaloressugeridosatributosclavecandidatanovisibles() as void                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Asignarvaloressugeridosatributosclavecandidatanovisibles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function asignarvaloressugeridosatributosclavedebusquedanovisibles() as void                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Asignarvaloressugeridosatributosclavedebusquedanovisibles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function autorizacionpos_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'autorizacionpos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'autorizacionpos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Autorizacionpos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Autorizacionpos( lxVal )				this.Setear_Autorizacionpos( lxVal )			EndIf		Else			This.Setear_Autorizacionpos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function autorizaciontelefonica_assign( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'autorizaciontelefonica_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'autorizaciontelefonica_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Autorizaciontelefonica		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Autorizaciontelefonica( lxVal )				if ( this.lHabilitarAutorizaciontelefonica or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Autorizaciontelefonica( lxVal )				else					this.Autorizaciontelefonica = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Autorizaciontelefonica)" )				endif			EndIf		Else			This.Setear_Autorizaciontelefonica( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function autorizaciontelefonicaoffline_assign( txval as variant ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'autorizaciontelefonicaoffline_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'autorizaciontelefonicaoffline_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Autorizaciontelefonicaoffline		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Autorizaciontelefonicaoffline( lxVal )				if ( this.lHabilitarAutorizaciontelefonicaoffline or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Autorizaciontelefonicaoffline( lxVal )				else					this.Autorizaciontelefonicaoffline = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Autorizaciontelefonicaoffline)" )				endif			EndIf		Else			This.Setear_Autorizaciontelefonicaoffline( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_access() as date                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosAltaFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosaltafw( lxVal )				this.Setear_Basededatosaltafw( lxVal )			EndIf		Else			This.Setear_Basededatosaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_access() as date                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosModificacionFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosmodificacionfw( lxVal )				this.Setear_Basededatosmodificacionfw( lxVal )			EndIf		Else			This.Setear_Basededatosmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function bindearevento(toobjetosource, tcevento, toobjetohandler, tcdelegado) as void                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = toobjetosource
		lxParam2 = tcevento
		lxParam3 = toobjetohandler
		lxParam4 = tcdelegado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Bindearevento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function borrararchivoqr() as void                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Borrararchivoqr', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function buscar( ) as void                                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Buscar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function buscarclase( tcclase as string ) as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'BuscarClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'BuscarClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.		this.Crear_oClases()				if _screen.oClases.GetKey( sys(2007, alltrim( lower( tcClase )),0,1)) > 0			llRetorno = .t.		else			if this.ExisteArchivoClase( tcClase )				this.AgregarClaseAColeccion( tcClase )				llRetorno = .t.			endif		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetalledetalleplanes() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetalledetalleplanes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosumarizado() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosumarizado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cancelar() as void                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cancelar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargamanual() as boolean                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargamanual', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargar() as boolean                                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargaratributosanulacion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargaratributosanulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargardatosdelclienteencupon() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargardatosdelclienteencupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargardatosdetitular() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargardatosdetitular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargardatosdeultimatarjeta() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargardatosdeultimatarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargardatositemvalor( lnsigno ) as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = lnsigno

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargardatositemvalor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargarinformacion( toinformacion as zooinformacion of zooinformacion.prg ) as void                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toinformacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargarinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function clasedetarjeta_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'clasedetarjeta_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'clasedetarjeta_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Clasedetarjeta		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Clasedetarjeta( lxVal )				if ( this.lHabilitarClasedetarjeta or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Clasedetarjeta( lxVal )				else					this.Clasedetarjeta = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Clasedetarjeta)" )				endif			EndIf		Else			This.Setear_Clasedetarjeta( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cliente_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cliente_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cliente_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Cliente ) = 'O' or isnull( this.Cliente ) )					this.Cliente = _Screen.zoo.instanciarentidad( 'Cliente' )					this.Cliente.lEsSubEntidad = .t.					this.enlazar( 'Cliente.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Cliente.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Cliente.CODIGO # this.Cliente_PK						this.Cliente.CODIGO = this.Cliente_PK					endif				endif			endif		endif		return this.Cliente
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cliente_pk_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cliente_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cliente_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Cliente_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Cliente.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Cliente_PK = lxVal		if this.Validar_Cliente( lxVal, lxValOld )			This.Setear_Cliente( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigo_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigo_assign', lcParametros )			endif		endif		This.Codigo = txVal
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigoplan_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigoplan_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigoplan_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Codigoplan		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Codigoplan( lxVal )				if ( this.lHabilitarCodigoplan or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Codigoplan( lxVal )				else					this.Codigoplan = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Codigoplan)" )				endif			EndIf		Else			This.Setear_Codigoplan( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function condicionesparaelenviodeemailalimportar() as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Condicionesparaelenviodeemailalimportar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function consultarporclavecandidata() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Consultarporclavecandidata', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crear_oclases() as void                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Crear_oClases', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Crear_oClases', lcParametros )			endif		endif		if !pemstatus( _screen, "oClases", 5 )				_screen.AddObject( "oClases", "Collection" )		endif				if !vartype( _screen.oClases ) = 'O' and isnull( _screen.oClases )			_screen.oClases = newobject( "Collection" )		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crearobjeto( tcclase as string, tclibreria as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant )                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9, lxParam10lnParametros = pcount()lxParam1 = tcclaselxParam2 = tclibrerialxParam3 = tvpar1lxParam4 = tvpar2lxParam5 = tvpar3lxParam6 = tvpar4lxParam7 = tvpar5lxParam8 = tvpar6lxParam9 = tvpar7lxParam10 = tvpar8lcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'crearobjeto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'crearobjeto', lcParametros )			endif		endif		Local loReturn As Object, lnParametrosReales As Integer, lcClase as String, lcConstructor as string, lcComando as String, ;			lnParamAux as Integer, lcClase as String, lcLibreria as String , lcSetProcedure as String,;			loErrorBase as Exception, loEx as Exception, loRetorno as object, lcConstructor as String, lcProcedure as String,;			lcSetClassLib as String, lcSet as String, loMock as Object, lcClaseProxy as String					loReturn = Null		lcLibreria = tcLibreria		lcClaseProxy = ""				*-------------------------------------------------------------------		if pemstatus(_screen, "Mocks", 5 ) and vartype( _Screen.Mocks ) = "O"				*Instanciación de Mocks			*Objeto solo instanciado en DESARROLLO.			if _screen.Mocks.lUtilizarMockV2 and this.buscarClase( forceext( "MockV2_" + tcClase, "prg" ) )				lcClase = "MockV2_" + tcClase			else				if _screen.Mocks.lUtilizarMockV1					local lnItem as Integer					lcClase = this.ObtenerNombreClase( tcClase )					lnItem = _Screen.Mocks.BuscarMock( lcClase )										if !empty( lnItem )						loMock = _Screen.Mocks.Item[lnItem]						loMock.lUsado = .t.						lcClase = loMock.cNombreClaseMock												if empty( loMock.cNombrePrgMock )							lcLibreria = iif( empty( lcLibreria ), "", "Mock_" + justfname( lcLibreria ) )						else							lcLibreria = loMock.cNombrePrgMock						endif					else						lcClase = tcClase					endif				else					lcClase = tcClase				endif			endif		else			lcClase = tcClase		endif		*-------------------------------------------------------------------		If empty( lcLibreria )			lcLibreria = forceext( lcClase, "prg" )		endif				If Pcount() > 1			lnParamAux = 2		Else			lnParamAux = 1		EndIf		lnParametrosReales = Pcount() - lnParamAux			loRetorno = null				try			if this.EsClaseNet( lcClase )				if !pemstatus( _screen, "NetExtender", 5 )					goServicios.Errores.LevantarExcepcion( "Para instanciar un objeto net debe haber iniciado la aplicación." )				endif				lcComando = this.ObtenerSentenciaConDesgloseParametros( "ClrCreateObject", lcClase, "", "", lnParametrosReales )				loRetorno = this.CrearObjetoNet( lcComando, tvPar1, tvPar2, tvPar3, tvPar4, tvPar5, tvPar6, tvPar7, tvPar8 )			else				lcClase = justfname( lcClase )								if lnParametrosReales = 0 and vartype( _Screen.Zoo ) = "O" and !isnull( _Screen.Zoo ) and !isnull( _screen.Zoo.oConstructor )					lcClaseProxy = _screen.Zoo.oConstructor.ObtenerNombreClaseProxy( lcClase, lcLibreria )				endif				if !empty( lcClaseProxy )					loRetorno = _screen.Zoo.oConstructor.CrearObjeto( lcClaseProxy, set( "Datasession" ) )				else					lcSetProcedure = set('Procedure')					lcSetClassLib = set("Classlib")												if upper( justext( lcLibreria )) = "VCX"						lcSet  = "SET CLASSLIB TO "					else						lcSet = "SET PROCEDURE TO "					endif													if this.lEsExe and upper( justext( lcLibreria ) ) == "PRG"						&& En el Exe solo se pueden instanciar los archivos FXP, si no se fuerza la extensión recorre todo el path buscando el PRG.						lcLibreria = forceext( lcLibreria, "fxp" )						lcProcedure = lcLibreria					else						lcProcedure = forceext( lcLibreria, "" )					endif												lcSet = lcSet + "'" + lcProcedure + "'"										if this.BuscarClase( lcLibreria )						&lcSet					endif																			if lnParametrosReales > 0						lcComando = this.ObtenerSentenciaConDesgloseParametros( "NewObject", lcClase, lcLibreria , "", lnParametrosReales )						loRetorno = &lcComando					else						loRetorno = newobject( lcClase, lcLibreria )					endif									if !(lower(lcSetClassLib) == lower(set("Classlib")))						set classlib to &lcSetClassLib					endif						set procedure to &lcSetProcedure				endif			endif		Catch To loErrorBase				local lnError as Integer			lnError = 0						if loErrorBase.ErrorNo = 1 and left( lower( lcLibreria ), 4 ) == "din_"				do case					case !this.BuscarClase( strtran( lower( lcLibreria ), ".prg", ".fxp" ) )						lnError = 10					case !this.BuscarClase( lcLibreria )						lnError	= 20				endcase			endif			loEx = Newobject( "ZooException", "ZooException.prg" )			With loEx				.Grabar( loErrorBase )				.nZooErrorNo = lnError				.Throw()			EndWith		EndTry		return loRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cuotas_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cuotas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cuotas_assign', lcParametros )			endif		endif		Local lLHabilitado as Boolean		lLHabilitado = this.lHabilitarCuotas		this.lHabilitarCuotas = .t.		dodefault( txVal )		this.lHabilitarCuotas = lLHabilitado
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cupongrabadoesunaanulacion() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cupongrabadoesunaanulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cuponreferente_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cuponreferente_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cuponreferente_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Cuponreferente		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Cuponreferente( lxVal )				if ( this.lHabilitarCuponreferente or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Cuponreferente( lxVal )				else					this.Cuponreferente = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Cuponreferente)" )				endif			EndIf		Else			This.Setear_Cuponreferente( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cursoraxml( tcnombrecursor) as string                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcnombrecursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cursoraxml', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function debecrearvaloresparaatributos() as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debecrearvaloresparaatributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function debegenerarpdfsdedisenosautomaticamente() as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debegenerarpdfsdedisenosautomaticamente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function debeimprimirdisenosautomaticamente() as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debeimprimirdisenosautomaticamente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function debesugerircodigo() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debesugerircodigo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function debodeshabilitartipopagoposnet() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debodeshabilitartipopagoposnet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function desbindearevento( topublicador as object, tcevento as string, tomanejador as object, tcdelegado as string ) as void                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = topublicador
		lxParam2 = tcevento
		lxParam3 = tomanejador
		lxParam4 = tcdelegado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Desbindearevento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function deshabilitarcargamanualdenumerodecuponpoint() as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Deshabilitarcargamanualdenumerodecuponpoint', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function deshabilitartipopagoposnet( tldeshabilitar as boolean ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tldeshabilitar

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Deshabilitartipopagoposnet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function despuesdeanular() as void                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Despuesdeanular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function despuesdegrabar() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Despuesdegrabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function detalleplanes_access() as variant                                                                                                                                                                                                                
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'detalleplanes_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'detalleplanes_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Detalleplanes ) = 'O' or isnull( this.Detalleplanes ) )			this.Detalleplanes = this.crearobjeto( 'Din_DetalleDatostarjetaDetalleplanes' )			this.Detalleplanes.inicializar()			this.enlazar( 'Detalleplanes.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Detalleplanes.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Detalleplanes, 'CambioSumarizado', this, 'CambiosDetalleDetalleplanes', 1)			this.enlazar( 'Detalleplanes.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Detalleplanes.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')			this.Detalleplanes.lVerificarLimitesEnDisenoImpresion = .t.		endif		return this.Detalleplanes
	EndFunc

	*-----------------------------------------------------------------------------------------
	function dispositivomovil_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'dispositivomovil_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'dispositivomovil_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Dispositivomovil		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Dispositivomovil( lxVal )				if ( this.lHabilitarDispositivomovil or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Dispositivomovil( lxVal )				else					this.Dispositivomovil = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Dispositivomovil)" )				endif			EndIf		Else			This.Setear_Dispositivomovil( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ejecutarregladenegociopersonalizadaimportacion( toconexion as object ) as void                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toconexion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Ejecutarregladenegociopersonalizadaimportacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function elatributodebeserobligatorio( tcatributo as string ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Elatributodebeserobligatorio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eliminar() as void                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eliminarvalordeanulaciondelagrilla() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminarvalordeanulaciondelagrilla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function enlazar( tcdelegando as string , tcdelegado as string ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcdelegando
		lxParam2 = tcdelegado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Enlazar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function entidadfinanciera_access() as variant                                                                                                                                                                                                            
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'entidadfinanciera_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'entidadfinanciera_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Entidadfinanciera ) = 'O' or isnull( this.Entidadfinanciera ) )					this.Entidadfinanciera = _Screen.zoo.instanciarentidad( 'Entidadfinanciera' )					this.Entidadfinanciera.lEsSubEntidad = .t.					this.enlazar( 'Entidadfinanciera.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Entidadfinanciera.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Entidadfinanciera.CODIGO # this.Entidadfinanciera_PK						this.Entidadfinanciera.CODIGO = this.Entidadfinanciera_PK					endif				endif			endif		endif		return this.Entidadfinanciera
	EndFunc

	*-----------------------------------------------------------------------------------------
	function entidadfinanciera_pk_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'entidadfinanciera_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'entidadfinanciera_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Entidadfinanciera_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )		this.Entidadfinanciera_PK = lxVal		if this.Validar_Entidadfinanciera( lxVal, lxValOld )			if ( this.lHabilitarEntidadfinanciera_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )				This.Setear_Entidadfinanciera( lxVal )				This.Entidadfinanciera_PK_DespuesDeAsignar()			else				this.Entidadfinanciera_PK = lxValOld				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Entidadfinanciera)" )			endif		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function entidadfinanciera_pk_despuesdeasignar() as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Entidadfinanciera_pk_despuesdeasignar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function enviapdfpersonalizadopormail() as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Enviapdfpersonalizadopormail', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function enviaraccionesautomatizadas( tcmetodo as string ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcmetodo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Enviaraccionesautomatizadas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function enviarmail( tlnopreguntarconfirmaenviodemail as boolean ) as void                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlnopreguntarconfirmaenviodemail

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Enviarmail', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function enviarmailalgrabar() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Enviarmailalgrabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function erroralgrabar() as void                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Erroralgrabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function erroralvalidar() as void                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Erroralvalidar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esanulaciondecupon() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esanulaciondecupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esatributoeditableenentidadconedicionrestringida( tcnombreatributo as string ) as boolean                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcnombreatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esatributoeditableenentidadconedicionrestringida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function escargamanual() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Escargamanual', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esclasebase( tcclase as string, tclibreria as string ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcclase
		lxParam2 = tclibreria

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esclasebase', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function escuponconanulacion() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Escuponconanulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esdevoluciondecupon() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esdevoluciondecupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esedicion() as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esedicion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esnotadecredito() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esnotadecredito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esnuevo() as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esnuevo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esobjetonet( toobjeto as object ) as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toobjeto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esobjetonet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esregistroeditable() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esregistroeditable', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaanulado() as boolean                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estaanulado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaaplicandocondiciondepago() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estaaplicandocondiciondepago', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estadotransferencia_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estadotransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estadotransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Estadotransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Estadotransferencia( lxVal )				this.Setear_Estadotransferencia( lxVal )			EndIf		Else			This.Setear_Estadotransferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaenproceso() as boolean                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estaenproceso', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estaenproceso', lcParametros )			endif		endif		local lRetorno as Boolean		with this			lRetorno = ( .lProcesando or .lCargando or .lLimpiando or .lDestroy )		endwith		return lRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esvalortipopagoelectronico() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esvalortipopagoelectronico', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function evaluapromocionespormediodepago() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Evaluapromocionespormediodepago', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function evaluarenviodemailenprocesoprevio() as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Evaluarenviodemailenprocesoprevio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizarcantidaddecuotassinrecargo() as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizarcantidaddecuotassinrecargo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizarcomboclasedetarjeta() as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizarcomboclasedetarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizarcombocuotas() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizarcombocuotas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizarcombomoviles() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizarcombomoviles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizarcomboplanes() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizarcomboplanes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizarcombotipocupon() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizarcombotipocupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoadvertirlimitepordiseno( toinfoauxiliar ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toinfoauxiliar

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoadvertirlimitepordiseno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoanularcupon() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoanularcupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventobuscarcupon() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventobuscarcupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventocancelarcargalimitepordiseno( tcdetalle as string ) as void                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcdetalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventocancelarcargalimitepordiseno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventocargarmontoretiroenefectivo( lovalor as object ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = lovalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventocargarmontoretiroenefectivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventocerrarmensaje() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventocerrarmensaje', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventodespuesdeinyectarentidades() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventodespuesdeinyectarentidades', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoestaseteandovalorsugerido( lcatributo as string ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = lcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoestaseteandovalorsugerido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoevaluaractualizaraplicaciondepromocion() as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoevaluaractualizaraplicaciondepromocion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoevaluaraplicaciondepromocion() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoevaluaraplicaciondepromocion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoevaluarpromocionpormediodepago() as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoevaluarpromocionpormediodepago', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventohabilitarmenudeshabilitarcargamanualdenumerodecuponpoint() as void                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventohabilitarmenudeshabilitarcargamanualdenumerodecuponpoint', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventohabilitarmenuhabilitarcargamanualdenumerodecuponpoint() as void                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventohabilitarmenuhabilitarcargamanualdenumerodecuponpoint', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventomensajedenegarmodificar_anular_eliminarempaquetado( tctexto as string ) as void                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventomensajedenegarmodificar_anular_eliminarempaquetado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventomensajeria( tcmensaje as string, tncantidaddepasos as integer ) as void                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tncantidaddepasos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventomensajeria', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventomostrarmensajeconexionpos( tcmensaje as string ) as void                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcmensaje

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventomostrarmensajeconexionpos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventomostrarmensajeesperaconbotoncancelar( tcmensaje as string, tctitulo as string, tntimeout as number ) as void                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tctitulo
		lxParam3 = tntimeout

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventomostrarmensajeesperaconbotoncancelar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoobtenerinformacion( toyomismo as object ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toyomismo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoobtenerinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoobtenerlogueo( toyomismo as object ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toyomismo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoobtenerlogueo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoporinsertar() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoporinsertar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventopreguntaranular( tcmensaje as string ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcmensaje

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventopreguntaranular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventopreguntareliminar() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventopreguntareliminar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventopreguntarsirealizaretiroenefectivo() as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventopreguntarsirealizaretiroenefectivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventopreguntartipopago( tnseteopreguntatipopago as integer ) as void                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnseteopreguntatipopago

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventopreguntartipopago', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoreacomodarcontrolesdispositivopos() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoreacomodarcontrolesdispositivopos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventorefrescardetalle( tcdetalle as string ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcdetalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventorefrescardetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventorefrescargrillaplanes() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventorefrescargrillaplanes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventosetearinputmasknrotarjeta(tlsacarmascara) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlsacarmascara

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventosetearinputmasknrotarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventosetearobligatoriedaddeatributosparadispositivoselectronicos( tlespagoelectronico as boolean, tlpermitecompranointegradacondispositivoelectronico as boolean ) as void                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tlespagoelectronico
		lxParam2 = tlpermitecompranointegradacondispositivoelectronico

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventosetearobligatoriedaddeatributosparadispositivoselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventosetearobligatoriedaddeatributosparapos( tlposestaintegrado as boolean, tctipocupon as string, tlesdispositivoclover as boolean, tlesdispositivosmartlapos as boolean) as void                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tlposestaintegrado
		lxParam2 = tctipocupon
		lxParam3 = tlesdispositivoclover
		lxParam4 = tlesdispositivosmartlapos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventosetearobligatoriedaddeatributosparapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventosetearultimaaccionyestado(tcaccion as string, tcestado as string) as void                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcaccion
		lxParam2 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventosetearultimaaccionyestado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventotalonariolleno() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventotalonariolleno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoverificarlimitesendisenoimpresion( tcdetalle as string ) as void                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcdetalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoverificarlimitesendisenoimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoverificarvisibilidadclover() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoverificarvisibilidadclover', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoverificarvisibilidaddispositivomovil() as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoverificarvisibilidaddispositivomovil', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoverificarvisibilidadidsmartlapos() as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoverificarvisibilidadidsmartlapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoverificarvisibilidadpuestoqr() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoverificarvisibilidadpuestoqr', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoverificarvisibilidadtipopagolapos() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoverificarvisibilidadtipopagolapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoverificarvisibilidadtipopagoposnet() as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoverificarvisibilidadtipopagoposnet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventovisibilidadticketicard() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventovisibilidadticketicard', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function existearchivoclase( tcfile as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcfilelcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ExisteArchivoClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ExisteArchivoClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.				if _VFP.StartMode = 5 and !_screen.zoo.EsBuildAutomatico &&and "FOXEXTENDER" $ upper( sys( 16 ) )			try				do ( tcFile )				llRetorno = .t.			catch			endtry		else			llRetorno = file( tcFile )		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_access', lcParametros )			endif		endif		if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.FechaAltaFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaaltafw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaaltafw( lxVal )			EndIf		Else			This.Setear_Fechaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaexpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaexpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaexpo( lxVal )			EndIf		Else			This.Setear_Fechaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaimpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaimpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaimpo( lxVal )			EndIf		Else			This.Setear_Fechaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			This.FechaModificacionFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechamodificacionfw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechamodificacionfw( lxVal )			EndIf		Else			This.Setear_Fechamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechareferente_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechareferente_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechareferente_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechareferente		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechareferente( lxVal )				if ( this.lHabilitarFechareferente or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Fechareferente( lxVal )				else					this.Fechareferente = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Fechareferente)" )				endif			EndIf		Else			This.Setear_Fechareferente( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechatransferencia_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechatransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechatransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechatransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechatransferencia( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechatransferencia( lxVal )			EndIf		Else			This.Setear_Fechatransferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function finalizar()                                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Finalizar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function finalizarlogueo() as void                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Finalizarlogueo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function formatearcodigosugerido( txval as string ) as string                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Formatearcodigosugerido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function generarpdf() as boolean                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generarpdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function grabar() as void                                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Grabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitaranulaciondecupon( tlanulacion as boolean ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlanulacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Habilitaranulaciondecupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitarcargamanualdenumerodecuponpoint() as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Habilitarcargamanualdenumerodecuponpoint', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function haydatos() as boolean                                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Haydatos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hayinformacion() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hayinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaaltafw_access() as string                                                                                                                                                                                                                    
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_access', lcParametros )			endif		endif				if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			this.HoraAltaFW = goLibrerias.ObtenerHora()		endif		return this.HoraAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaaltafw( lxVal )				this.Setear_Horaaltafw( lxVal )			EndIf		Else			This.Setear_Horaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaexpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaexpo( lxVal )				this.Setear_Horaexpo( lxVal )			EndIf		Else			This.Setear_Horaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaimpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaimpo( lxVal )				this.Setear_Horaimpo( lxVal )			EndIf		Else			This.Setear_Horaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_access() as string                                                                                                                                                                                                            
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			this.HoraModificacionFW = goServicios.Librerias.ObtenerHora()		endif		return this.HoraModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horamodificacionfw( lxVal )				this.Setear_Horamodificacionfw( lxVal )			EndIf		Else			This.Setear_Horamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idexternoclover_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idexternoclover_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idexternoclover_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idexternoclover		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idexternoclover( lxVal )				this.Setear_Idexternoclover( lxVal )			EndIf		Else			This.Setear_Idexternoclover( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idgocuotas_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idgocuotas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idgocuotas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idgocuotas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idgocuotas( lxVal )				if ( this.lHabilitarIdgocuotas or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Idgocuotas( lxVal )				else					this.Idgocuotas = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Idgocuotas)" )				endif			EndIf		Else			This.Setear_Idgocuotas( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idordenclover_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idordenclover_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idordenclover_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idordenclover		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idordenclover( lxVal )				if ( this.lHabilitarIdordenclover or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Idordenclover( lxVal )				else					this.Idordenclover = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Idordenclover)" )				endif			EndIf		Else			This.Setear_Idordenclover( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idpagoclover_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idpagoclover_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idpagoclover_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idpagoclover		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idpagoclover( lxVal )				if ( this.lHabilitarIdpagoclover or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Idpagoclover( lxVal )				else					this.Idpagoclover = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Idpagoclover)" )				endif			EndIf		Else			This.Setear_Idpagoclover( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idpuestoqr_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idpuestoqr_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idpuestoqr_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idpuestoqr		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idpuestoqr( lxVal )				if ( this.lHabilitarIdpuestoqr or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Idpuestoqr( lxVal )				else					this.Idpuestoqr = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Idpuestoqr)" )				endif			EndIf		Else			This.Setear_Idpuestoqr( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idsmartlapos_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idsmartlapos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idsmartlapos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idsmartlapos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idsmartlapos( lxVal )				if ( this.lHabilitarIdsmartlapos or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Idsmartlapos( lxVal )				else					this.Idsmartlapos = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Idsmartlapos)" )				endif			EndIf		Else			This.Setear_Idsmartlapos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function importar( tcxmldatos as string, tlcompletoconvalidaciones as boolean ) as void                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcxmldatos
		lxParam2 = tlcompletoconvalidaciones

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Importar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function importar_sintransaccion( tcxmldatos as string ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcxmldatos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Importar_sintransaccion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimir() as boolean                                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Imprimir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimirdespuesdegrabar() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Imprimirdespuesdegrabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function informacioninteractiva_assign( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'informacioninteractiva_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'informacioninteractiva_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Informacioninteractiva		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Informacioninteractiva( lxVal )				this.Setear_Informacioninteractiva( lxVal )			EndIf		Else			This.Setear_Informacioninteractiva( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function informarerroresimportacion( tccursorinformacionerrores as string ) as void                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccursorinformacionerrores

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Informarerroresimportacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function iniciaraccionesautomaticas() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Iniciaraccionesautomaticas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function init( t1, t2, t3, t4 ) as boolean                                                                                                                                                                                                                
		this.Inicializar()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function integrado_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'integrado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'integrado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Integrado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Integrado( lxVal )				this.Setear_Integrado( lxVal )			EndIf		Else			This.Setear_Integrado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function invocarmetodoestatico( tcclase as string, tcmetodo as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant ) as variant               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9, lxParam10

		lnParametros = pcount()
		lxParam1 = tcclase
		lxParam2 = tcmetodo
		lxParam3 = tvpar1
		lxParam4 = tvpar2
		lxParam5 = tvpar3
		lxParam6 = tvpar4
		lxParam7 = tvpar5
		lxParam8 = tvpar6
		lxParam9 = tvpar7
		lxParam10 = tvpar8

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Invocarmetodoestatico', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inyectarentidades( toentidad as ent_comprobantedeventasconvalores of ent_comprobantedeventasconvalores.prg,  todetalle as detalle of detalle.prg, tocupon as ent_cupon of ent_cupon.prg ) as void                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = toentidad
		lxParam2 = todetalle
		lxParam3 = tocupon

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectarentidades', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inyectarinformacion( toquienllama as object ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toquienllama

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectarinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inyectarlogueo( toquienllama as object ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toquienllama

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectarlogueo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lanzareventopreguntaranular() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Lanzareventopreguntaranular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lesentidadconedicionrestringida_access() as boolean                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lesentidadconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lesentidadconedicionrestringida_access', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = .f.		if vartype( this.oAtributosConEdicionRestringida ) = 'O' and this.oAtributosConEdicionRestringida.Count > 0			llRetorno = .t.		endif		return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function limpiar( tlforzar as boolean ) as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlforzar

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Limpiar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function limpiaratributosvirtuales() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limpiaratributosvirtuales', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function limpiardatostarjetaenmemoria() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limpiardatostarjetaenmemoria', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function limpiarestimulos() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limpiarestimulos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function limpiarflag() as void                                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limpiarflag', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function limpiarinformacion() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limpiarinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function loguear( tctexto as string, tnnivel as integer ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tctexto
		lxParam2 = tnnivel

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Loguear', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lotereferente_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lotereferente_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lotereferente_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Lotereferente		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Lotereferente( lxVal )				if ( this.lHabilitarLotereferente or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Lotereferente( lxVal )				else					this.Lotereferente = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Lotereferente)" )				endif			EndIf		Else			This.Setear_Lotereferente( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mailgocuotas_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mailgocuotas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mailgocuotas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mailgocuotas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mailgocuotas( lxVal )				if ( this.lHabilitarMailgocuotas or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.ValidarDominio_Mail( lxVal )					this.Setear_Mailgocuotas( lxVal )				else					this.Mailgocuotas = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Mailgocuotas)" )				endif			EndIf		Else			This.Setear_Mailgocuotas( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mensagelogueoinicial() as string                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Mensagelogueoinicial', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function modificar() as void                                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Modificar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function modificarmontocuponsegunbeneficio( tnbeneficio as decimal ) as void                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnbeneficio

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Modificarmontocuponsegunbeneficio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function moneda_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'moneda_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'moneda_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Moneda ) = 'O' or isnull( this.Moneda ) )					this.Moneda = _Screen.zoo.instanciarentidad( 'Moneda' )					this.Moneda.lEsSubEntidad = .t.					this.enlazar( 'Moneda.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Moneda.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Moneda.CODIGO # this.Moneda_PK						this.Moneda.CODIGO = this.Moneda_PK					endif				endif			endif		endif		return this.Moneda
	EndFunc

	*-----------------------------------------------------------------------------------------
	function moneda_pk_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'moneda_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'moneda_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Moneda_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Moneda_PK = lxVal		if this.Validar_Moneda( lxVal, lxValOld )			if ( this.lHabilitarMoneda_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )				This.Setear_Moneda( lxVal )			else				this.Moneda_PK = lxValOld				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Moneda)" )			endif		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function monto_assign( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'monto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'monto_assign', lcParametros )			endif		endif		local lnValorAnt as String, lLHabilitado as Boolean		lnValorAnt = this.Monto		lLHabilitado = this.lHabilitarMonto		this.lHabilitarMonto = .t.		dodefault( txVal )				if !this.lLimpiando and !this.lInicializando			this.Tarjeta.VerificarSiElValorEstaDisponibleParaMonto( this.Monto )			if lnValorAnt != txVal				this.ActualizarGrilla()				this.Cuotas = iif( this.ExisteCuotaEnPlan( this.Cuotas ), this.Cuotas, this.ObtenerCuotaGrilla( 1 ) )				this.CargarTotales()			endif		endif		this.lHabilitarMonto = lLHabilitado
	EndFunc

	*-----------------------------------------------------------------------------------------
	function noesanulaciondevolucionmercadopagov2( tlanulacion as boolean ) as boolean                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlanulacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Noesanulaciondevolucionmercadopagov2', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nombretitular_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nombretitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nombretitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nombretitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Nombretitular( lxVal )				if ( this.lHabilitarNombretitular or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Nombretitular( lxVal )				else					this.Nombretitular = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Nombretitular)" )				endif			EndIf		Else			This.Setear_Nombretitular( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function novalidardetalleporoperatoriaenbasea() as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Novalidardetalleporoperatoriaenbasea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nrodocumentotitular_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nrodocumentotitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nrodocumentotitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nrodocumentotitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Nrodocumentotitular( lxVal )				if ( this.lHabilitarNrodocumentotitular or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Nrodocumentotitular( lxVal )				else					this.Nrodocumentotitular = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Nrodocumentotitular)" )				endif			EndIf		Else			This.Setear_Nrodocumentotitular( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nuevo() as boolean                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Nuevo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerocierredelote_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerocierredelote_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerocierredelote_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerocierredelote		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerocierredelote( lxVal )				if ( this.lHabilitarNumerocierredelote or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Numerocierredelote( lxVal )				else					this.Numerocierredelote = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Numerocierredelote)" )				endif			EndIf		Else			This.Setear_Numerocierredelote( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerocomprobante_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerocomprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerocomprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerocomprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerocomprobante( lxVal )				this.ValidarDominio_Numericononegativo( lxVal )				this.Setear_Numerocomprobante( lxVal )			EndIf		Else			This.Setear_Numerocomprobante( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerocupon_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerocupon_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerocupon_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerocupon		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerocupon( lxVal )				if ( this.lHabilitarNumerocupon or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Numerocupon( lxVal )				else					this.Numerocupon = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Numerocupon)" )				endif			EndIf		Else			This.Setear_Numerocupon( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerolote_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerolote_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerolote_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerolote		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerolote( lxVal )				if ( this.lHabilitarNumerolote or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Numerolote( lxVal )				else					this.Numerolote = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Numerolote)" )				endif			EndIf		Else			This.Setear_Numerolote( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerotarjetareferente_assign( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerotarjetareferente_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerotarjetareferente_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerotarjetareferente		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerotarjetareferente( lxVal )				this.Setear_Numerotarjetareferente( lxVal )			EndIf		Else			This.Setear_Numerotarjetareferente( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerounico_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerounico_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerounico_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerounico		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerounico( lxVal )				this.Setear_Numerounico( lxVal )			EndIf		Else			This.Setear_Numerounico( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerounicoreferente_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerounicoreferente_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerounicoreferente_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerounicoreferente		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerounicoreferente( lxVal )				this.Setear_Numerounicoreferente( lxVal )			EndIf		Else			This.Setear_Numerounicoreferente( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oad_access() as variant                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oad_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oad_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )			this.oAD = this.crearobjeto( 'AccesoDatosCustom', 'Ent_DatosTarjeta.prg' )		endif		return this.oAD
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oatributosconedicionrestringida_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oatributosconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oatributosconedicionrestringida_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oAtributosConEdicionRestringida ) = 'O'			this.oAtributosConEdicionRestringida = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oAtributosConEdicionRestringida
	EndFunc

	*-----------------------------------------------------------------------------------------
	function observacion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'observacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'observacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Observacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Observacion( lxVal )				this.Setear_Observacion( lxVal )			EndIf		Else			This.Setear_Observacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoclaveprimaria() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obteneratributoclaveprimaria', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obteneratributoclaveprimaria', lcParametros )			endif		endif		return this.cAtributoPK
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributodetalleainsertar() as detalle of detalle.prg                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributodetalleainsertar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributosanulacion() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributosanulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoscombinacion() as object                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributoscombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributosobligatorios() as zoocoleccion                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributosobligatorios', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercampossegunequivalencia( taest ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = taest

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercampossegunequivalencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercantidadderegistrosconfiltro( tchaving as string ) as void                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tchaving

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercantidadderegistrosconfiltro', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercantidaditemsinfoadicional() as integer                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercantidaditemsinfoadicional', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercantidadregistros() as integer                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercantidadregistros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercodigoerrorparavalidaciontimestamp() as integer                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercodigoerrorparavalidaciontimestamp', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercolaboradorpromociones() as object                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercolaboradorpromociones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercolaboradorpromocionespormediodepago() as object                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercolaboradorpromocionespormediodepago', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdatosentidad( tcatributos as string, tchaving as string, tcorder as string , tcfunc as string, tntope as integer ) as string                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tcatributos
		lxParam2 = tchaving
		lxParam3 = tcorder
		lxParam4 = tcfunc
		lxParam5 = tntope

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerdatosentidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdescripcion() as string                                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenerdescripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenerdescripcion', lcParametros )			endif		endif		return this.cDescripcion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdetalleafectacioinfoadicional() as object                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdetalleafectacioinfoadicional', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdetalleainsertar() as detalle of detalle.prg                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdetalleainsertar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerfuncionalidades() as string                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerfuncionalidades', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerinformacion() as zooinformacion of zooinformacion.prg                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenermensajeclavecandidataexistente() as string                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenermensajeclavecandidataexistente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenernombre() as string                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombre', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenernombredetallesconprepantalla() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombredetallesconprepantalla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenernombreoriginal() as string                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombreoriginal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenernombretransferencia() as string                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombretransferencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerobjetobusquedaespecial( tcatributo as string ) as object                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerobjetobusquedaespecial', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerproximonumeroenstring() as string                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerproximonumeroenstring', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerrutadepdfpersonalizadoparaenviodemail() as string                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerrutadepdfpersonalizadoparaenviodemail', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasdelete() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenersentenciasdelete', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasinsert() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenersentenciasinsert', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasupdate() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenersentenciasupdate', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersiguientenumerico() as integer                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenersiguientenumerico', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenertipotarjetadelcupon() as string                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertipotarjetadelcupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenertooltiptalle( tccodigotalle as string ) as string                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccodigotalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenertooltiptalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenertotalconrecargo( tntotal ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tntotal

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenertotalconrecargo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimamodificacionenregistros() as datetime                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerultimamodificacionenregistros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenervalorpropiedadestatica( tcclase as string, tcpropiedad as string ) as variant                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcclase
		lxParam2 = tcpropiedad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenervalorpropiedadestatica', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerwhereadicionalparasentenciaupdate() as string                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerwhereadicionalparasentenciaupdate', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocolaboradorpos_access() as object                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolaboradorpos_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolaboradorpos_access', lcParametros )			endif		endif		local loFactory as object, lcPrestador as stringif !this.lDestroyloFactory = _screen.Zoo.CrearObjeto( "FactoryColaboradoresDispositivoPOS" )lcPrestador = iif(alltrim(this.POS.Prestador) = "FISERV", this.POS.dispositivofiserv, this.POS.Prestador)if type( "this.oColaboradorPOS" ) <> "O" or isnull( this.oColaboradorPOS )this.oColaboradorPOS = loFactory.ColaboradorSegunPrestador( lcPrestador )				this.oColaboradorPOS.InyectarEntidadPos( this.POS )				this.enlazar( 'oColaboradorPOS.EventoObtenerInformacion', 'inyectarInformacion' )			else				if ( !empty( lcPrestador ) and this.POS.Prestador <> this.oColaboradorPOS.cPrestador) or ( empty( lcPrestador ) and this.oColaboradorPOS.cPrestador <> "LAPOS" )					this.oColaboradorPOS.oEntidadPos = null					this.oColaboradorPOS.release()this.oColaboradorPOS = loFactory.ColaboradorSegunPrestador( lcPrestador )					this.oColaboradorPOS.InyectarEntidadPos( this.POS )					this.enlazar( 'oColaboradorPOS.EventoObtenerInformacion', 'inyectarInformacion' )				endif			endif		endifreturn this.oColaboradorPOS
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocolaboradorretirodeefectivo_access() as void                                                                                                                                                                                                    
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolaboradorretirodeefectivo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolaboradorretirodeefectivo_access', lcParametros )			endif		endif		if !this.lDestroy and !( vartype( this.oColaboradorRetiroDeEfectivo ) == "O" )			this.oColaboradorRetiroDeEfectivo = _screen.Zoo.CrearObjeto( "ColaboradorRetiroDeEfectivo", "", this )		endif				Return this.oColaboradorRetiroDeEfectivo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocolatributosobligatoriosdefinidosporusuario_access() as object                                                                                                                                                                                  
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			endif		endif		local loRetorno as Object				loRetorno = null		if !this.lDestroy					loRetorno = goServicios.SaltosDeCampoyValoresSugeridos.ObtenerColeccionAtributosObligatorios( this.ObtenerNombre() )		endif				return loRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocomportamientocodigosugerido_access() as void                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocomportamientocodigosugerido_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocomportamientocodigosugerido_access', lcParametros )			endif		endif		local loComportamientoCodigoSugerido as Object		if !this.ldestroy and !vartype( this.oComportamientoCodigoSugerido ) = 'O'			loComportamientoCodigoSugerido = _Screen.zoo.CrearObjeto( "DecoradorDeCodigosDeEntidades" )			this.InicializarComportamientoCodigoSugerido(loComportamientoCodigoSugerido )			this.oComportamientoCodigoSugerido = loComportamientoCodigoSugerido		endif		return this.oComportamientoCodigoSugerido
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ogestordemail_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ogestordemail_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ogestordemail_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oGestorDeMail ) = 'O'			this.oGestorDeMail = _Screen.zoo.CrearObjeto( "GestorDeMail" )		endif		return this.oGestorDeMail
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ohelperplandecuotas_access() as variant                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ohelperplandecuotas_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ohelperplandecuotas_access', lcParametros )			endif		endif		If !this.ldestroy and ( !Vartype( this.oHelperPlanDeCuotas ) = 'O' or Isnull( this.oHelperPlanDeCuotas ) )			this.oHelperPlanDeCuotas = _screen.zoo.CrearObjeto( "HelperPlanDeCuotas" )		Endif		Return this.oHelperPlanDeCuotas
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oinformacion_access() as variant                                                                                                                                                                                                                 
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oinformacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oinformacion_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )				this.eventoObtenerInformacion( this )				if !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )					.oInformacion = this.CrearObjeto( "ZooInformacion" )				endif				endif		endwith		return this.oInformacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ologueo_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ologueo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ologueo_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oLogueo ) = 'O' and isnull( .oLogueo ) and vartype( goServicios ) = 'O'				this.eventoObtenerLogueo( this )				if !vartype( .oLogueo ) = 'O' and isnull( .oLogueo )					.oLogueo = goServicios.Logueos.obtenerObjetoLogueo( this )					.SetearAccion()					.lLogueoPropio = .T.				else					.lLogueoPropio = .F.								endif				endif		endwith		return this.oLogueo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function omensaje_access() as void                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'omensaje_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'omensaje_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oMensaje ) = 'O' or isnull( this.oMensaje ) )			this.oMensaje = _screen.zoo.crearobjeto( "mensajeentidad", "", this )		endif				return this.oMensaje
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oobservadoresdeimportacion_access() as variant                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oobservadoresdeimportacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oobservadoresdeimportacion_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oObservadoresDeImportacion ) = 'O' or isnull( this.oObservadoresDeImportacion ) )			this.oObservadoresDeImportacion = _Screen.zoo.crearobjeto( 'ZooColeccion' )		endif		return this.oObservadoresDeImportacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oregistrosdeactividadesalgrabar_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oregistrosdeactividadesalgrabar_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oregistrosdeactividadesalgrabar_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oRegistrosDeActividadesAlGrabar ) = 'O'			this.oRegistrosDeActividadesAlGrabar = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oRegistrosDeActividadesAlGrabar
	EndFunc

	*-----------------------------------------------------------------------------------------
	function otalle_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'otalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'otalle_access', lcParametros )			endif		endif		if this.ldestroy		else			if ( !vartype( this.oTalle ) = 'O' or isnull( this.oTalle ) )				this.oTalle = _Screen.zoo.instanciarentidad( 'Talle' )			endif		endif		return this.oTalle
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ovalidadorescomp_access() as object                                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ovalidadorescomp_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ovalidadorescomp_access', lcParametros )			endif		endif		if !this.lDestroy and !( vartype( this.oValidadoresComp ) == "O" )			this.oValidadoresComp = _screen.Zoo.Crearobjeto( "ZooColeccion" )		endif				return this.oValidadoresComp
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ovalidadortarjeta_access() as void                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ovalidadortarjeta_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ovalidadortarjeta_access', lcParametros )			endif		endifif this.ldestroyelseif !vartype( this.oValidadorTarjeta ) = 'O' or isnull( this.oValidadorTarjeta )				this.oValidadorTarjeta = _screen.zoo.crearobjeto( "ValidadorAceptacionDeValoresTarjetaDeCredito" )				this.oValidadorTarjeta.Inyectarentidad( This.oComprobante )				this.oValidadorTarjeta.oDatosTarjeta = this				this.enlazar( 'oValidadorTarjeta.EventoObtenerInformacion', 'inyectarInformacion' )		  else		  	    if !vartype( this.oValidadorTarjeta.oEntidad ) = 'O' or isnull( this.oValidadorTarjeta.oEntidad )			  		this.oValidadorTarjeta.Inyectarentidad( This.oComprobante )		  						  	endifendifendifreturn this.oValidadorTarjeta
	EndFunc

	*-----------------------------------------------------------------------------------------
	function parsearfecha( txfecha as variant ) as date                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txfecha

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Parsearfecha', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function permiteejecutartriggers() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Permiteejecutartriggers', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function permitegenerarpdf() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Permitegenerarpdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function porcentajedescuento_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'porcentajedescuento_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'porcentajedescuento_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Porcentajedescuento		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Porcentajedescuento( lxVal )				this.Setear_Porcentajedescuento( lxVal )			EndIf		Else			This.Setear_Porcentajedescuento( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function porcentajerecargo_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'porcentajerecargo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'porcentajerecargo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Porcentajerecargo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Porcentajerecargo( lxVal )				this.Setear_Porcentajerecargo( lxVal )			EndIf		Else			This.Setear_Porcentajerecargo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function pos_access() as variant                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'pos_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'pos_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Pos ) = 'O' or isnull( this.Pos ) )					this.Pos = _Screen.zoo.instanciarentidad( 'Pos' )					this.Pos.lEsSubEntidad = .t.					this.enlazar( 'Pos.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Pos.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Pos.CODIGO # this.Pos_PK						this.Pos.CODIGO = this.Pos_PK					endif				endif			endif		endif		return this.Pos
	EndFunc

	*-----------------------------------------------------------------------------------------
	function pos_pk_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'pos_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'pos_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Pos_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Pos_PK = lxVal		if this.Validar_Pos( lxVal, lxValOld )			if ( this.lHabilitarPos_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )				This.Setear_Pos( lxVal )				This.Pos_PK_DespuesDeAsignar()			else				this.Pos_PK = lxValOld				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Pos)" )			endif		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function pos_pk_despuesdeasignar() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Pos_pk_despuesdeasignar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function preguntarconfirmacionimpresion( tcmensaje as string, tnbotones as integer, tnrespuestasugerida as integer ) as void s                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tnbotones
		lxParam3 = tnrespuestasugerida

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Preguntarconfirmacionimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function preparacionevaluacionaplicaciondepromocion() as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Preparacionevaluacionaplicaciondepromocion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function preparardatosparaanulaciondecupon() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Preparardatosparaanulaciondecupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function preprocesarcursorparaimportacionenbloque( tcnombrecursor as string ) as void                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcnombrecursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Preprocesarcursorparaimportacionenbloque', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function primero() as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Primero', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function procesardespuesdesetearpos() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Procesardespuesdesetearpos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function procesardespuesdeseteartarjeta() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Procesardespuesdeseteartarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function procesarenviodeemailalimportarporbuffer() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Procesarenviodeemailalimportarporbuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function puntodeventacomprobante_assign( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'puntodeventacomprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'puntodeventacomprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Puntodeventacomprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Puntodeventacomprobante( lxVal )				this.ValidarDominio_Numericononegativo( lxVal )				this.Setear_Puntodeventacomprobante( lxVal )			EndIf		Else			This.Setear_Puntodeventacomprobante( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function qrtranfdebinidposnet_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'qrtranfdebinidposnet_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'qrtranfdebinidposnet_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Qrtranfdebinidposnet		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Qrtranfdebinidposnet( lxVal )				if ( this.lHabilitarQrtranfdebinidposnet or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Qrtranfdebinidposnet( lxVal )				else					this.Qrtranfdebinidposnet = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Qrtranfdebinidposnet)" )				endif			EndIf		Else			This.Setear_Qrtranfdebinidposnet( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function qrtransactionidposnet_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'qrtransactionidposnet_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'qrtransactionidposnet_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Qrtransactionidposnet		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Qrtransactionidposnet( lxVal )				if ( this.lHabilitarQrtransactionidposnet or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Qrtransactionidposnet( lxVal )				else					this.Qrtransactionidposnet = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Qrtransactionidposnet)" )				endif			EndIf		Else			This.Setear_Qrtransactionidposnet( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function reasignarpk_con_cc() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Reasignarpk_con_cc', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function reasignarvaloresalitemporcuotassinrecargo( tlcargapromo ) as void                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlcargapromo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Reasignarvaloresalitemporcuotassinrecargo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function reasignarvalorsugeridoencasodeconcurrencia() as string                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Reasignarvalorsugeridoencasodeconcurrencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function recibir( tolistatablas as zoocoleccion of zoocoleccion.prg, tlloguear as boolean ) as void                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tolistatablas
		lxParam2 = tlloguear

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Recibir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function referenciaexterna_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'referenciaexterna_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'referenciaexterna_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Referenciaexterna		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Referenciaexterna( lxVal )				this.Setear_Referenciaexterna( lxVal )			EndIf		Else			This.Setear_Referenciaexterna( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurargenhabilitar() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurargenhabilitar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurarmontocuponsegunbeneficio() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurarmontocuponsegunbeneficio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function sedebeestimular() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Sedebeestimular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function sedebeloguear() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Sedebeloguear', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seguridadenentidadmenucondosoperaciones(tcoperacion as string, tcaccion as string, tcestado as string ) as void                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcoperacion
		lxParam2 = tcaccion
		lxParam3 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Seguridadenentidadmenucondosoperaciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function serial_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'serial_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'serial_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Serial		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Serial( lxVal )				this.Setear_Serial( lxVal )			EndIf		Else			This.Setear_Serial( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.SerieAltaFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriealtafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriealtafw( lxVal )				this.Setear_Seriealtafw( lxVal )			EndIf		Else			This.Setear_Seriealtafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.SerieModificacionFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriemodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriemodificacionfw( lxVal )				this.Setear_Seriemodificacionfw( lxVal )			EndIf		Else			This.Setear_Seriemodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_aplicarecargo( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_aplicarecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_aplicarecargo', lcParametros )			endif		endif		this.Aplicarecargo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_autorizacionpos( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_autorizacionpos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_autorizacionpos', lcParametros )			endif		endif		this.Autorizacionpos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_autorizaciontelefonica( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_autorizaciontelefonica', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_autorizaciontelefonica', lcParametros )			endif		endif		this.Autorizaciontelefonica = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_autorizaciontelefonicaoffline( txval as variant ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_autorizaciontelefonicaoffline', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_autorizaciontelefonicaoffline', lcParametros )			endif		endif		this.Autorizaciontelefonicaoffline = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosaltafw( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosaltafw', lcParametros )			endif		endif		this.Basededatosaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosmodificacionfw( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosmodificacionfw', lcParametros )			endif		endif		this.Basededatosmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_clasedetarjeta( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_clasedetarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_clasedetarjeta', lcParametros )			endif		endif		this.Clasedetarjeta = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cliente( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_cliente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_cliente', lcParametros )			endif		endif		this.Cliente.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_codigoplan( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_codigoplan', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_codigoplan', lcParametros )			endif		endif		this.Codigoplan = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cuotas( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_cuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_cuotas', lcParametros )			endif		endif		dodefault( txVal )		if !this.lLimpiando			this.CargarTotales()		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cuponreferente( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_cuponreferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_cuponreferente', lcParametros )			endif		endif		local lnValorAnterior as Integer, loCupon as ent_cupon of ent_cupon.prg, loValor as Object, ;				loColeccion as zoocoleccion OF zoocoleccion.prg, loError as Object		lnValorAnterior = this.Cuponreferentedodefault( txVal )if ( !this.lCargandoAnulacionDeCupon and !this.lLimpiando and !this.lInicializando ) and ( this.Cuponreferente # lnValorAnterior and !empty( this.Cuponreferente ) )and !this.Pos.EsDispositivoSmartLapos()			loCupon = _Screen.Zoo.InstanciarEntidad( "Cupon" )			loColeccion = loCupon.ObtenerColeccionDeCuponesParaAfectar( txVal )			this.lcCodigoDeCuponReferente = ""			if loColeccion.Count > 0				try					this.Monto = abs( loColeccion[1].Monto ) - abs( loColeccion[1].RecargoMonto )					this.Cuotas = loColeccion[1].Cuotas					this.TipoDocumentoTitular = loColeccion[1].TipoDocumentoTitular					this.NroDocumentoTitular = loColeccion[1].NroDocumentoTitular					this.NombreTitular = loColeccion[1].NombreTitular					this.TelefonoTitular = loColeccion[1].TelefonoTitular					this.EntidadFinanciera_PK = loColeccion[1].EntidadFinanciera					this.lcCodigoDeCuponReferente = loColeccion[1].Codigo					this.FechaReferente = loColeccion[1].FechaCupon						this.NumeroUnicoReferente = loColeccion[1].NumeroReferencia					this.NumeroTarjetaReferente = loColeccion[1].UltimosDigitos					this.CodigoPlan = loColeccion[1].CodigoPlan				catch to loError				endtry			elsethis.Cuponreferente = 0goServicios.Errores.LevantarExcepcionTexto("El número de referencia ingresado no corresponde a un cupón disponible para su devolución.")				endif		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_dispositivomovil( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_dispositivomovil', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_dispositivomovil', lcParametros )			endif		endif		this.Dispositivomovil = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_entidadfinanciera( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_entidadfinanciera', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_entidadfinanciera', lcParametros )			endif		endif		this.Entidadfinanciera.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_estadotransferencia( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_estadotransferencia', lcParametros )			endif		endif		this.Estadotransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaaltafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaaltafw', lcParametros )			endif		endif		this.Fechaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaexpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaexpo', lcParametros )			endif		endif		this.Fechaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaimpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaimpo', lcParametros )			endif		endif		this.Fechaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechamodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechamodificacionfw', lcParametros )			endif		endif		this.Fechamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechareferente( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechareferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechareferente', lcParametros )			endif		endif		if vartype( txVal ) = "T"			txVal = ttod( txVal )		endif		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechatransferencia( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechatransferencia', lcParametros )			endif		endif		this.Fechatransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaaltafw( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaaltafw', lcParametros )			endif		endif		this.Horaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaexpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaexpo', lcParametros )			endif		endif		this.Horaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaimpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaimpo', lcParametros )			endif		endif		this.Horaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horamodificacionfw( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horamodificacionfw', lcParametros )			endif		endif		this.Horamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idexternoclover( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idexternoclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idexternoclover', lcParametros )			endif		endif		this.Idexternoclover = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idgocuotas( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idgocuotas', lcParametros )			endif		endif		this.Idgocuotas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idordenclover( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idordenclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idordenclover', lcParametros )			endif		endif		this.Idordenclover = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idpagoclover( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idpagoclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idpagoclover', lcParametros )			endif		endif		this.Idpagoclover = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idpuestoqr( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idpuestoqr', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idpuestoqr', lcParametros )			endif		endif		this.Idpuestoqr = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idsmartlapos( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idsmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idsmartlapos', lcParametros )			endif		endif		this.Idsmartlapos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_informacioninteractiva( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_informacioninteractiva', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_informacioninteractiva', lcParametros )			endif		endif		this.Informacioninteractiva = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_integrado( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_integrado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_integrado', lcParametros )			endif		endif		this.Integrado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_lotereferente( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_lotereferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_lotereferente', lcParametros )			endif		endif		this.Lotereferente = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mailgocuotas( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mailgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mailgocuotas', lcParametros )			endif		endif		this.Mailgocuotas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_moneda( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_moneda', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_moneda', lcParametros )			endif		endif		this.Moneda.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_monto( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_monto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_monto', lcParametros )			endif		endif		this.Monto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nombretitular( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nombretitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nombretitular', lcParametros )			endif		endif		this.Nombretitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nrodocumentotitular( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nrodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nrodocumentotitular', lcParametros )			endif		endif		this.Nrodocumentotitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerocierredelote( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerocierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerocierredelote', lcParametros )			endif		endif		this.Numerocierredelote = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerocomprobante( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerocomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerocomprobante', lcParametros )			endif		endif		this.Numerocomprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerocupon( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerocupon', lcParametros )			endif		endif		this.Numerocupon = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerolote( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerolote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerolote', lcParametros )			endif		endif		this.Numerolote = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerotarjetareferente( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerotarjetareferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerotarjetareferente', lcParametros )			endif		endif		this.Numerotarjetareferente = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerounico( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerounico', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerounico', lcParametros )			endif		endif		this.Numerounico = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerounicoreferente( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerounicoreferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerounicoreferente', lcParametros )			endif		endif		this.Numerounicoreferente = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_observacion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_observacion', lcParametros )			endif		endif		this.Observacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_porcentajedescuento( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_porcentajedescuento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_porcentajedescuento', lcParametros )			endif		endif		this.Porcentajedescuento = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_porcentajerecargo( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_porcentajerecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_porcentajerecargo', lcParametros )			endif		endif		this.Porcentajerecargo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_pos( txval as variant ) as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_pos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_pos', lcParametros )			endif		endif		local lxValOld as Variant, lcMensaje as String		lcMensaje = ""with this			if !empty( txVal )  and !empty( this.Pos.Codigo )								if ( !this.Pos.PagoElectronico and this.Tarjeta.Tipo = 11 ) or ;				   ( this.Pos.PagoElectronico and ( this.Tarjeta.Tipo = 3 or this.Pos.Prestador != this.Tarjeta.Prestador ) )					lcMensaje = "No se puede utilizar el dispositivo "  + alltrim( this.Pos.Codigo ) + " para el valor " + alltrim( this.Tarjeta.Codigo )				endif			endif			if !empty( lcMensaje )				.Pos_PK = ""				.Pos.Codigo = ""goServicios.Errores.LevantarExcepcionTexto( lcMensaje )			endif		endwith		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_puntodeventacomprobante( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_puntodeventacomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_puntodeventacomprobante', lcParametros )			endif		endif		this.Puntodeventacomprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_qrtranfdebinidposnet( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_qrtranfdebinidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_qrtranfdebinidposnet', lcParametros )			endif		endif		this.Qrtranfdebinidposnet = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_qrtransactionidposnet( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_qrtransactionidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_qrtransactionidposnet', lcParametros )			endif		endif		this.Qrtransactionidposnet = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_referenciaexterna( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_referenciaexterna', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_referenciaexterna', lcParametros )			endif		endif		this.Referenciaexterna = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_serial( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_serial', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_serial', lcParametros )			endif		endif		this.Serial = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriealtafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriealtafw', lcParametros )			endif		endif		this.Seriealtafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriemodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriemodificacionfw', lcParametros )			endif		endif		this.Seriemodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tarjeta( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tarjeta', lcParametros )			endif		endif		local lxValOld as Variant, lcMensaje as string		lcMensaje = ""		dodefault( txVal )		with this			if !empty( txVal )										do case					case .Tarjeta.Tipo = 3						if !empty( this.Pos.Codigo ) and this.Pos.PagoElectronico							lcMensaje = "No se pueden utilizar valores que no sean de tipo " + .Tarjeta.oTipoDeValores.ObtenerDescripcion( 11 ) + "."						endif											case .Tarjeta.Tipo = 11						if !empty( this.Pos.Codigo )												if !this.Pos.PagoElectronico								lcMensaje = "No se pueden utilizar valores que no sean de tipo " + .Tarjeta.oTipoDeValores.ObtenerDescripcion( 3 ) + "."							else								if this.Tarjeta.Prestador != this.Pos.Prestador									lcMensaje = "El valor ingresado no corresponde al código de dispositivo elegido."								endif							endif						endif																otherwise						lcMensaje = "No se pueden utilizar valores que no sean de tipo " + .Tarjeta.oTipoDeValores.ObtenerDescripcion( 3 ) + "."								endcase						endif			if !empty( lcMensaje )				.Tarjeta_PK = ""				.Tarjeta.Codigo = ""				goServicios.Errores.LevantarExcepcionTexto( lcMensaje )			endif		endwith
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_telefonotitular( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_telefonotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_telefonotitular', lcParametros )			endif		endif		this.Telefonotitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_terminalessmartlapos( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_terminalessmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_terminalessmartlapos', lcParametros )			endif		endif		this.Terminalessmartlapos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ticketicard( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ticketicard', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ticketicard', lcParametros )			endif		endif		this.Ticketicard = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ticketicardcl( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ticketicardcl', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ticketicardcl', lcParametros )			endif		endif		this.Ticketicardcl = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipocupon( lxval ) as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = lxvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipocupon', lcParametros )			endif		endif		dodefault( lxVal )		do case		case this.tipoCupon = 'C'			this.lHabilitarCuponReferente = .F.			this.lHabilitarFechaReferente = .F.		case this.tipoCupon = 'D'			this.lHabilitarCuponReferente = .T.			this.lHabilitarFechaReferente = .T.		case inlist( this.tipoCupon, 'AC', 'AD', 'A' )			this.lHabilitarCuponReferente = .T.			this.lHabilitarFechaReferente = .T.this.lHabiliTARIDORDENCLOVER = .T.this.lHabiliTARIDPAGOCLOVER = .T.this.lHabilitarIdSmartLaPos = .T.		endcase
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipodocumentotitular( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipodocumentotitular', lcParametros )			endif		endif		this.Tipodocumentotitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipopagolapos( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipopagolapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipopagolapos', lcParametros )			endif		endif		this.Tipopagolapos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipopagoposnet( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipopagoposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipopagoposnet', lcParametros )			endif		endif		this.Tipopagoposnet = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipopagosmartlapos( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipopagosmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipopagosmartlapos', lcParametros )			endif		endif		this.Tipopagosmartlapos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_totalconrecargo( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_totalconrecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_totalconrecargo', lcParametros )			endif		endif		this.Totalconrecargo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_totalconrecargoporcuota( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_totalconrecargoporcuota', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_totalconrecargoporcuota', lcParametros )			endif		endif		this.Totalconrecargoporcuota = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_totaldescuento( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_totaldescuento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_totaldescuento', lcParametros )			endif		endif		this.Totaldescuento = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_totalrecargo( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_totalrecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_totalrecargo', lcParametros )			endif		endif		this.Totalrecargo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ultimosdigitos( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ultimosdigitos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ultimosdigitos', lcParametros )			endif		endif		this.Ultimosdigitos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuarioaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuarioaltafw', lcParametros )			endif		endif		this.Usuarioaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuariomodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuariomodificacionfw', lcParametros )			endif		endif		this.Usuariomodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_validacion( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_validacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_validacion', lcParametros )			endif		endif		this.Validacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionaltafw', lcParametros )			endif		endif		this.Versionaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionmodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionmodificacionfw', lcParametros )			endif		endif		this.Versionmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_zadsfw( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_zadsfw', lcParametros )			endif		endif		this.Zadsfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearaccion() as string                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearaccion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearcoleccionsentenciasanterior_anular() as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearcoleccionsentenciasanterior_anular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearcoleccionsentenciasanterior_eliminar() as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearcoleccionsentenciasanterior_eliminar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearcoleccionsentenciasanterior_modificar() as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearcoleccionsentenciasanterior_modificar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearcoleccionsentenciasanterior_nuevo() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearcoleccionsentenciasanterior_nuevo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearcomponentes() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearcomponentes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteardatosdelcupon( tcaccion as string ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcaccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Seteardatosdelcupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearenviodeemailalimportarporbuffer() as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearenviodeemailalimportarporbuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearestadoedicionenitems() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearestadoedicionenitems', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearestadonuevoenitems() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearestadonuevoenitems', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearinformacion( toinformacion as object ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toinformacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearlogueo( tologueo as object ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tologueo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearlogueo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearmascaraennrotarjeta() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearmascaraennrotarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearposdefault() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearposdefault', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteartipopagopos() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Seteartipopagopos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteartipopagopossegunprestador( tntipopago as integer ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tntipopago

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Seteartipopagopossegunprestador', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteartipotarjetaencupon( tctipotarjeta as string ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipotarjeta

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Seteartipotarjetaencupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearvaloressugeridos() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearvaloressugeridos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearvalorpropiedadestatica( tcclase as string, tcpropiedad as string, tvpar1 as variant ) as variant                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcclase
		lxParam2 = tcpropiedad
		lxParam3 = tvpar1

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearvalorpropiedadestatica', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteosprivados() as void                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Seteosprivados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function siguiente () as boolean                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Siguiente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function soportabusquedaextendida( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'soportabusquedaextendida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'soportabusquedaextendida', lcParametros )			endif		endif		return This.oComportamientoCodigoSugerido.SoportaBusquedaExtendida()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tarjeta_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tarjeta_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tarjeta_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Tarjeta ) = 'O' or isnull( this.Tarjeta ) )					this.Tarjeta = _Screen.zoo.instanciarentidad( 'Valor' )					this.Tarjeta.lEsSubEntidad = .t.					this.enlazar( 'Tarjeta.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Tarjeta.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Tarjeta.CODIGO # this.Tarjeta_PK						this.Tarjeta.CODIGO = this.Tarjeta_PK					endif				endif			endif		endif		return this.Tarjeta
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tarjeta_pk_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tarjeta_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tarjeta_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tarjeta_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )		this.Tarjeta_PK = lxVal		if this.Validar_Tarjeta( lxVal, lxValOld )			if ( this.lHabilitarTarjeta_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )				This.Setear_Tarjeta( lxVal )				This.Tarjeta_PK_DespuesDeAsignar()			else				this.Tarjeta_PK = lxValOld				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Tarjeta)" )			endif		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tarjeta_pk_despuesdeasignar() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tarjeta_pk_despuesdeasignar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function telefonotitular_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'telefonotitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'telefonotitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Telefonotitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Telefonotitular( lxVal )				if ( this.lHabilitarTelefonotitular or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Telefonotitular( lxVal )				else					this.Telefonotitular = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Telefonotitular)" )				endif			EndIf		Else			This.Setear_Telefonotitular( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function terminalessmartlapos_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'terminalessmartlapos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'terminalessmartlapos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Terminalessmartlapos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Terminalessmartlapos( lxVal )				if ( this.lHabilitarTerminalessmartlapos or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Terminalessmartlapos( lxVal )				else					this.Terminalessmartlapos = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Terminalessmartlapos)" )				endif			EndIf		Else			This.Setear_Terminalessmartlapos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ticketicard_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ticketicard_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ticketicard_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ticketicard		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ticketicard( lxVal )				this.Setear_Ticketicard( lxVal )				 This.Ticketicard_DespuesDeAsignar()			EndIf		Else			This.Setear_Ticketicard( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ticketicard_despuesdeasignar() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ticketicard_despuesdeasignar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ticketicardcl_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ticketicardcl_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ticketicardcl_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ticketicardcl		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ticketicardcl( lxVal )				this.Setear_Ticketicardcl( lxVal )			EndIf		Else			This.Setear_Ticketicardcl( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienecontratadoelservicio( tnservicio as integer ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnservicio

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Tienecontratadoelservicio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienecuponyainicializado() as boolean                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienecuponyainicializado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienedetallecomprobantecargado() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienedetallecomprobantecargado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienedetallesconprepantalla() as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienedetallesconprepantalla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienequeloguearexcepciones() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienequeloguearexcepciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipocupon_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipocupon_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipocupon_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipocupon		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipocupon( lxVal )				if ( this.lHabilitarTipocupon or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Tipocupon( lxVal )				else					this.Tipocupon = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Tipocupon)" )				endif			EndIf		Else			This.Setear_Tipocupon( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipodocumentotitular_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipodocumentotitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipodocumentotitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipodocumentotitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipodocumentotitular( lxVal )				if ( this.lHabilitarTipodocumentotitular or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Tipodocumentotitular( lxVal )				else					this.Tipodocumentotitular = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Tipodocumentotitular)" )				endif			EndIf		Else			This.Setear_Tipodocumentotitular( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipopagolapos_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipopagolapos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipopagolapos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipopagolapos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipopagolapos( lxVal )				if ( this.lHabilitarTipopagolapos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Tipopagolapos( lxVal )				else					this.Tipopagolapos = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Tipopagolapos)" )				endif			EndIf		Else			This.Setear_Tipopagolapos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipopagoposnet_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipopagoposnet_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipopagoposnet_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipopagoposnet		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipopagoposnet( lxVal )				if ( this.lHabilitarTipopagoposnet or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Tipopagoposnet( lxVal )				else					this.Tipopagoposnet = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Tipopagoposnet)" )				endif			EndIf		Else			This.Setear_Tipopagoposnet( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipopagosmartlapos_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipopagosmartlapos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipopagosmartlapos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipopagosmartlapos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipopagosmartlapos( lxVal )				if ( this.lHabilitarTipopagosmartlapos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Tipopagosmartlapos( lxVal )				else					this.Tipopagosmartlapos = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Tipopagosmartlapos)" )				endif			EndIf		Else			This.Setear_Tipopagosmartlapos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function totalconrecargo_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'totalconrecargo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'totalconrecargo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Totalconrecargo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Totalconrecargo( lxVal )				this.Setear_Totalconrecargo( lxVal )			EndIf		Else			This.Setear_Totalconrecargo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function totalconrecargoporcuota_assign( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'totalconrecargoporcuota_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'totalconrecargoporcuota_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Totalconrecargoporcuota		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Totalconrecargoporcuota( lxVal )				this.Setear_Totalconrecargoporcuota( lxVal )			EndIf		Else			This.Setear_Totalconrecargoporcuota( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function totaldescuento_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'totaldescuento_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'totaldescuento_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Totaldescuento		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Totaldescuento( lxVal )				this.Setear_Totaldescuento( lxVal )			EndIf		Else			This.Setear_Totaldescuento( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function totalrecargo_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'totalrecargo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'totalrecargo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Totalrecargo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Totalrecargo( lxVal )				this.Setear_Totalrecargo( lxVal )			EndIf		Else			This.Setear_Totalrecargo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ultimo () as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ultimo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ultimosdigitos_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ultimosdigitos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ultimosdigitos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ultimosdigitos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ultimosdigitos( lxVal )				if ( this.lHabilitarUltimosdigitos or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Ultimosdigitos( lxVal )				else					this.Ultimosdigitos = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Datos de cobros con tarjetas - Atributo: Ultimosdigitos)" )				endif			EndIf		Else			This.Setear_Ultimosdigitos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_access() as date                                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.UsuarioAltaFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() ) + this.UsuarioAutorizante()		endif		return This.UsuarioAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuarioaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuarioaltafw( lxVal )				this.Setear_Usuarioaltafw( lxVal )			EndIf		Else			This.Setear_Usuarioaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioautorizante() as string                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Usuarioautorizante', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuariomodificacionfw_access() as date                                                                                                                                                                                                           
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.UsuarioModificacionFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() )  + this.UsuarioAutorizante()		endif		return This.UsuarioModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuariomodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuariomodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuariomodificacionfw( lxVal )				this.Setear_Usuariomodificacionfw( lxVal )			EndIf		Else			This.Setear_Usuariomodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validacion_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Validacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Validacion( lxVal )				this.Setear_Validacion( lxVal )			EndIf		Else			This.Setear_Validacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validacionatributos() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validacionatributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validacionbasica() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validacionbasica', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaciondetalles() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaciondetalles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validacionesdecomprobante() as boolean                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validacionesdecomprobante', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validacionesderetiroenefectivo() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validacionesderetiroenefectivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaciontimestamp() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaciontimestamp', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar() as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_aplicarecargo( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_aplicarecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_aplicarecargo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_autorizacionpos( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_autorizacionpos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_autorizacionpos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_autorizaciontelefonica( txval as variant ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_autorizaciontelefonica', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_autorizaciontelefonica', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_autorizaciontelefonicaoffline( txval as variant ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_autorizaciontelefonicaoffline', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_autorizaciontelefonicaoffline', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosaltafw( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_clasedetarjeta( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_clasedetarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_clasedetarjeta', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cliente( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_cliente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_cliente', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion)
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_codigoplan( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_codigoplan', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_codigoplan', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cuotas( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_cuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_cuotas', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = .f.		if this.cuotas != txVal			llRetorno = dodefault( txVal )		endif		return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cuponreferente( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_cuponreferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_cuponreferente', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_dispositivomovil( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_dispositivomovil', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_dispositivomovil', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_entidadfinanciera( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_entidadfinanciera', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_entidadfinanciera', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_estadotransferencia( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_estadotransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaaltafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaexpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaimpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechareferente( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechareferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechareferente', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechatransferencia( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechatransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaaltafw( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaexpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaimpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idexternoclover( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idexternoclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idexternoclover', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idgocuotas( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idgocuotas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idordenclover( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idordenclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idordenclover', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idpagoclover( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idpagoclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idpagoclover', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idpuestoqr( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idpuestoqr', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idpuestoqr', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idsmartlapos( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idsmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idsmartlapos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_informacioninteractiva( txval as variant ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_informacioninteractiva', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_informacioninteractiva', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_integrado( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_integrado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_integrado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_lotereferente( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_lotereferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_lotereferente', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mailgocuotas( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mailgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mailgocuotas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_moneda( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_moneda', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_moneda', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_monto( txval as variant ) as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_monto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_monto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nombretitular( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nombretitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nombretitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nrodocumentotitular( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nrodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nrodocumentotitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerocierredelote( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerocierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerocierredelote', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerocomprobante( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerocomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerocomprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerocupon( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerocupon', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerolote( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerolote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerolote', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerotarjetareferente( txval as variant ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerotarjetareferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerotarjetareferente', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerounico( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerounico', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerounico', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerounicoreferente( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerounicoreferente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerounicoreferente', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_observacion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_observacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_porcentajedescuento( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_porcentajedescuento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_porcentajedescuento', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_porcentajerecargo( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_porcentajerecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_porcentajerecargo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_pos( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_pos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_pos', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_puntodeventacomprobante( txval as variant ) as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_puntodeventacomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_puntodeventacomprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_qrtranfdebinidposnet( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_qrtranfdebinidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_qrtranfdebinidposnet', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_qrtransactionidposnet( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_qrtransactionidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_qrtransactionidposnet', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_referenciaexterna( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_referenciaexterna', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_referenciaexterna', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_serial( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_serial', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_serial', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriealtafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriealtafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriemodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriemodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tarjeta( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tarjeta', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_telefonotitular( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_telefonotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_telefonotitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_terminalessmartlapos( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_terminalessmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_terminalessmartlapos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ticketicard( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ticketicard', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ticketicard', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ticketicardcl( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ticketicardcl', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ticketicardcl', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipocupon( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipocupon', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipodocumentotitular( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipodocumentotitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipopagolapos( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipopagolapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipopagolapos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipopagoposnet( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipopagoposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipopagoposnet', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipopagosmartlapos( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipopagosmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipopagosmartlapos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_totalconrecargo( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_totalconrecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_totalconrecargo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_totalconrecargoporcuota( txval as variant ) as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_totalconrecargoporcuota', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_totalconrecargoporcuota', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_totaldescuento( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_totaldescuento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_totaldescuento', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_totalrecargo( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_totalrecargo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_totalrecargo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ultimosdigitos( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ultimosdigitos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ultimosdigitos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuarioaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuarioaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuariomodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuariomodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_validacion( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_validacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_validacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_zadsfw( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_zadsfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaranulacion() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaranulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcamposobligatoriosdefinidosporusuario() as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcamposobligatoriosdefinidosporusuario', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcaracter(tccaracter as character, tlpermitecaracterespecial as boolean ) as boolean                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tccaracter
		lxParam2 = tlpermitecaracterespecial

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarcaracter', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcliente() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcliente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcuotas() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcuotas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validardominio_fecha( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validardominio_fecha', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validardominio_mail( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validardominio_mail', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validardominio_numericononegativo( txval as variant ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validardominio_numericononegativo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarelenviodeemailalimportarporbuffer() as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarelenviodeemailalimportarporbuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarentidadfinanciera() as boolean                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarentidadfinanciera', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarextension() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarextension', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaringreso( tctexto as string, tlpermitecaracterespecial as boolean ) as boolean                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tctexto
		lxParam2 = tlpermitecaracterespecial

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validaringreso', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarmoneda() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarmoneda', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarmontoparaintegrados() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarmontoparaintegrados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarpk() as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarpk', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarpos() as boolean                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarpos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarsipermiteretiroenefectivoencuponesintegrados() as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarsipermiteretiroenefectivoencuponesintegrados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validartarjeta() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validartarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoautorizaciontelefonica() as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoautorizaciontelefonica', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoautorizaciontelefonicaoffline() as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoautorizaciontelefonicaoffline', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoclasedetarjeta() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoclasedetarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocodigoplan() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocodigoplan', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocuotas() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocuotas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocuponreferente() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocuponreferente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodispositivomovil() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodispositivomovil', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoentidadfinanciera() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoentidadfinanciera', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofechareferente() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofechareferente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwpos() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwpos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwtipopagolapos() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwtipopagolapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwtipopagoposnet() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwtipopagoposnet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwtipopagosmartlapos() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwtipopagosmartlapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoidordenclover() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoidordenclover', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoidpagoclover() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoidpagoclover', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoidpuestoqr() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoidpuestoqr', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoidsmartlapos() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoidsmartlapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoinformacioninteractiva() as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoinformacioninteractiva', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridolotereferente() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridolotereferente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomailgocuotas() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomailgocuotas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomonto() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomonto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonombretitular() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonombretitular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonrodocumentotitular() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonrodocumentotitular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonumerocupon() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonumerocupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonumerolote() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonumerolote', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoobservacion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoobservacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopos() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotarjeta() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotelefonotitular() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotelefonotitular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoterminalessmartlapos() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoterminalessmartlapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotipodocumentotitular() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotipodocumentotitular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotipopagolapos() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotipopagolapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotipopagoposnet() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotipopagoposnet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotipopagosmartlapos() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotipopagosmartlapos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoultimosdigitos() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoultimosdigitos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarcontexto( tctipos as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tctiposlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'verificarcontexto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'verificarcontexto', lcParametros )			endif		endif		local llRetorno as boolean, i as Integer, lcLetra as string				if empty( tcTipos )			llRetorno = empty( this.cContexto )		else			tcTipos = upper( alltrim( tcTipos ) )			llRetorno = .f.			for i = 1 to len( tcTipos )				lcLetra = substr( tcTipos, i, 1 )				llRetorno = ( lcLetra $ this.cContexto ) or llRetorno				if llRetorno					exit				endif			endfor		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarexistenciaclaveprimaria( txval as variant ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificarexistenciaclaveprimaria', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarlimitesendisenoimpresion( tcdetalle as string ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcdetalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificarlimitesendisenoimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionaltafw_access() as string                                                                                                                                                                                                                 
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.VersionAltaFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionaltafw( lxVal )				this.Setear_Versionaltafw( lxVal )			EndIf		Else			This.Setear_Versionaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_access() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.VersionModificacionFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionmodificacionfw( lxVal )				this.Setear_Versionmodificacionfw( lxVal )			EndIf		Else			This.Setear_Versionmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function votacioncambioestadoanular( tcestado as string ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Votacioncambioestadoanular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function votacioncambioestadocancelar( tcestado as string ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Votacioncambioestadocancelar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function votacioncambioestadoeliminar( tcestado as string ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Votacioncambioestadoeliminar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function votacioncambioestadograbar( tcestado as string ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Votacioncambioestadograbar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function votacioncambioestadomodificar( tcestado as string ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Votacioncambioestadomodificar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function votacioncambioestadonuevo( tcestado as string ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Votacioncambioestadonuevo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function xmlacursor( tcxml as string, tcnombrecursor as string ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcxml
		lxParam2 = tcnombrecursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Xmlacursor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function zadsfw_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'zadsfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'zadsfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Zadsfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Zadsfw( lxVal )				this.Setear_Zadsfw( lxVal )			EndIf		Else			This.Setear_Zadsfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function crearobjetonet( tccomando as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant ) as variant                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9

		lnParametros = pcount()
		lxParam1 = tccomando
		lxParam2 = tvpar1
		lxParam3 = tvpar2
		lxParam4 = tvpar3
		lxParam5 = tvpar4
		lxParam6 = tvpar5
		lxParam7 = tvpar6
		lxParam8 = tvpar7
		lxParam9 = tvpar8

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Crearobjetonet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function esclasenet( tcclase as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'esclasenet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'esclasenet', lcParametros )			endif		endif		return "." $ tcClase
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenernombreclase( tcclase ) as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenernombreclase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenernombreclase', lcParametros )			endif		endif		Local lcRetorno as String, lcNombreApp as String		if upper( substr( alltrim( tcClase ), len( alltrim( tcClase ) ) - 1 ) ) = "UO"			if !this.lEsExe and this.BuscarClase( alltrim( tcClase ) + "UO.prg" )				lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			else				lcRetorno = tcClase			endif		else			if type( "_screen.zoo.app.cProyecto" ) = "C"				lcNombreApp = upper( _screen.zoo.app.cProyecto )			else				lcNombreApp = ""			endif							do case				case upper( left( tcClase, 4 ) ) = "ENT_"					lcRetorno = strtran( upper( tcClase ), "ENT_","" ,1 ,1 )				case upper( left( tcClase, 4 + len( lcNombreApp ) ) ) = "ENT" + lcNombreApp + "_"					lcRetorno = strtran( upper( tcClase ), "ENT" + lcNombreApp + "_", "", 1 ,1 )				case upper( left( tcClase, 11 ) ) = "DIN_ENTIDAD"					lcRetorno = strtran( tcClase, "Din_Entidad","" ,1 ,1 )				otherwise					lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			endcase		endif		return lcRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenersentenciacondesgloseparametros( tccomando as string, tcclase as string, tclibreria as string, tcapp as string, tnparametros as integer )                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5lnParametros = pcount()lxParam1 = tccomandolxParam2 = tcclaselxParam3 = tclibrerialxParam4 = tcapplxParam5 = tnparametroslcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenersentenciaCondesgloseparametros', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenersentenciaCondesgloseparametros', lcParametros )			endif		endif		local lcRetorno as string, lni as integer, lcLibreria as string, lcApp as string				if empty( tcLibreria )			lcLibreria = ""		else			lcLibreria = alltrim( tcLibreria )		endif				if empty( tcApp )			lcApp = ""		else			lcApp = alltrim( tcApp )		endif		if inlist( upper( tcComando ), "CLRCREATEOBJECT", "CLRINVOKESTATICMETHOD" )			lcRetorno = tcComando + "( '" + tcClase + "'"		else			if empty( tnParametros ) and empty( tcApp )				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "'"			else				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "', '" + tcApp + "'"			endif		endif				for lni = 1 to tnParametros			lcRetorno = lcRetorno + ", tvPar" + transform( lni )		endfor		lcRetorno = lcRetorno + " )"		return lcRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _buscar() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_buscar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _cancelar() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_cancelar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _eliminarsinvalidaciones() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_eliminarsinvalidaciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _entidadeditable() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_entidadeditable', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _esentidadquepermitenuevo() as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_esentidadquepermitenuevo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _esregistroanulable() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_esregistroanulable', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _esregistroeliminable() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_esregistroeliminable', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _esregistromodificable() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_esregistromodificable', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _modificar() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_modificar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _nuevo() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_nuevo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function actualizarcuponreferido() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizarcuponreferido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function agregarclaseacoleccion( tcclase as string ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'AgregarClaseAColeccion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'AgregarClaseAColeccion', lcParametros )			endif		endif		if !alltrim( upper( "mock" ) )$alltrim( upper( tcClase ) )			_screen.oClases.Add( tcClase, sys(2007, alltrim( lower( tcClase )),0,1))		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function cargartotales() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargartotales', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function consultarporclaveprimariasugerida() as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Consultarporclaveprimariasugerida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function deboimprimir() as boolean                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Deboimprimir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function eliminarregistrosdeactividad() as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminarregistrosdeactividad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function eliminarsinvalidaciones() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminarsinvalidaciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esatributoobligatorioexistente( tcatributo as string ) as boolean                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esatributoobligatorioexistente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esextensionvalidaparafox( tcnombre as string ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcnombre

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esextensionvalidaparafox', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esitemgiftcard( todetalle as object, tnitem as integer ) as void                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = todetalle
		lxParam2 = tnitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esitemgiftcard', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esitempack( todetalle as object, tnitem as integer ) as void                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = todetalle
		lxParam2 = tnitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esitempack', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esitemsenia( todetalle as object, tnitem as integer ) as void                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = todetalle
		lxParam2 = tnitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esitemsenia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esregistrobloqueado() as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esregistrobloqueado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esregistroinactivo() as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esregistroinactivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function establecertiemposenregistrodeactividad( tcitem as string ) as void                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Establecertiemposenregistrodeactividad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function establecertiemposenregistrodeactividadextendido( tcitem as string ) as void                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Establecertiemposenregistrodeactividadextendido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function estamodificandounregistrodelince() as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estamodificandounregistrodelince', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esvalidoatributoobligatorio( tcatributo as string, tcdescatrib as string, tcdetalle as string ) as boolean                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = tcdescatrib
		lxParam3 = tcdetalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esvalidoatributoobligatorio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function existeatributo( tcatributo as string ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Existeatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function existeatributopk( tcatributopk as string ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributopk

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Existeatributopk', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function existecuotaenplan( tncuota as integer ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tncuota

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Existecuotaenplan', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function finalizarregistrosdeactividad( tcagrupadordeactividad as string ) as void                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcagrupadordeactividad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Finalizarregistrosdeactividad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function generarpdfsdespuesdegrabar() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generarpdfsdespuesdegrabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function habilitarcontrolesseguncupon() as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Habilitarcontrolesseguncupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function inicializandoentidadcomportamientosugerido( toentidadcomportamientosugerido as entidad of entidad.prg ) as void                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toentidadcomportamientosugerido

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inicializandoentidadcomportamientosugerido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function inicializarcomponentes( tllimpiar as boolean ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tllimpiar

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inicializarcomponentes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function inicializarcomportamientocodigosugerido( tocomportamientocodigosugerido as object ) as void                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocomportamientocodigosugerido

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inicializarcomportamientocodigosugerido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function iniciarregistrodeactividad( tcactividad as string) as void                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcactividad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Iniciarregistrodeactividad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function iniciarregistrodeactividadextendido( tcactividad as string) as void                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcactividad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Iniciarregistrodeactividadextendido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function instanciarextension() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Instanciarextension', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function limpiarregistrosdeactividadalgrabar() as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limpiarregistrosdeactividadalgrabar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function loguearaccion() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Loguearaccion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercaracteresvalidos() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercaracteresvalidos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercondiciondepagoaaplicar() as string                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercondiciondepagoaaplicar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercuotagrilla( tnitem as integer ) as integer                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercuotagrilla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerestado() as string                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerestado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerextensiones( tcruta as string ) as zoocoleccion of zoocoleccion.prg                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcruta

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerextensiones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerextensionesvalidasparafox() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerextensionesvalidasparafox', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenermontodescuento() as number                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenermontodescuento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenermontoparacupon( tnmonto as number ) as number                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnmonto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenermontoparacupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenermontoparaitemvalor( tnmonto as number ) as number                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnmonto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenermontoparaitemvalor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenermontoparamostrar( tnmonto as number ) as number                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnmonto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenermontoparamostrar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function preparacupon() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Preparacupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function recuperardatosdelcupon( tcaccion as string ) as void                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcaccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Recuperardatosdelcupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function recuperardatosparaanular() as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Recuperardatosparaanular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function sepuedeanularelcupon() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Sepuedeanularelcupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function setearcuponreferenteparaanulacion( tccodigo as string ) as void                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccodigo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearcuponreferenteparaanulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function seteardatosdelcomprobante() as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Seteardatosdelcomprobante', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function transformaralasignar( txval as variant ) as variant                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DATOSTARJETA' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Transformaralasignar', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Transformaralasignar', lcParametros )			endif		endif		return txVal
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validacionescompuestas() as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validacionescompuestas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validaragrupamientopublicaciones() as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaragrupamientopublicaciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarantesdeanular() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarantesdeanular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarcampoobligatorioendetalle( todetalle as object, tcatributo as string, tcatributoprincipal as string ) as boolean                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = todetalle
		lxParam2 = tcatributo
		lxParam3 = tcatributoprincipal

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarcampoobligatorioendetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarcargadecuponparapagoselectronicos() as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcargadecuponparapagoselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarcargadedispositivoparapagoselectronicos() as boolean                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcargadedispositivoparapagoselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarcupondepagoelectroniconointegrado() as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcupondepagoelectroniconointegrado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarcuponnorepetido() as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcuponnorepetido', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarexistencia() as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarexistencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarundetalle( todetalle as detalle of detalle.prg, tcetiqueta as string ) as boolean                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = todetalle
		lxParam2 = tcetiqueta

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarundetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function verificaeinforma( tvexpresion1 as variant, tvexpresion2 as variant, tcdescripcion as string ) as boolean                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tvexpresion1
		lxParam2 = tvexpresion2
		lxParam3 = tcdescripcion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificaeinforma', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function verificaragrupublidetallesindatos() as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificaragrupublidetallesindatos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function verificardisponibilidadtalonario() as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificardisponibilidadtalonario', lcParametros )
	EndFunc


enddefine