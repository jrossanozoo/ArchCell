
define class Mock_cupon as MockBase of MockBase.prg

	lNuevo = .f. 
	lEdicion = .f. 
	lDestroy = .f. 
	cContexto = '' 

	cClase = 'cupon'

	
	AutorizacionPOS = .F.                                                                                                                                                                                                                                     
	AutorizacionTelefonica = ""                                                                                                                                                                                                                               
	AutorizacionTelefonicaOffLine = 0                                                                                                                                                                                                                         
	BASEDEDATOSALTAFW = ""                                                                                                                                                                                                                                    
	BASEDEDATOSMODIFICACIONFW = ""                                                                                                                                                                                                                            
	BaseDeDatos = ""                                                                                                                                                                                                                                          
	BaseDeDatosBaja = ""                                                                                                                                                                                                                                      
	BloquearRegistro = .f.                                                                                                                                                                                                                                    
	CamposEquivalenciaLince = ""                                                                                                                                                                                                                              
	ClaseDeTarjeta = null                                                                                                                                                                                                                                     
	ClaseDeTarjeta_PK = ""                                                                                                                                                                                                                                    
	Cliente = null                                                                                                                                                                                                                                            
	Cliente_PK = ""                                                                                                                                                                                                                                           
	Codigo = ""                                                                                                                                                                                                                                               
	CodigoCierreDeLote = ""                                                                                                                                                                                                                                   
	CodigoPlan = ""                                                                                                                                                                                                                                           
	Comprobante = ""                                                                                                                                                                                                                                          
	Cotizacion = 0                                                                                                                                                                                                                                            
	Cuotas = 0                                                                                                                                                                                                                                                
	DescuentoMonto = 0                                                                                                                                                                                                                                        
	DescuentoPorcentaje = 0                                                                                                                                                                                                                                   
	DispositivoMovil = ""                                                                                                                                                                                                                                     
	ESTADOTRANSFERENCIA = ""                                                                                                                                                                                                                                  
	EntidadFinanciera = null                                                                                                                                                                                                                                  
	EntidadFinanciera_PK = ""                                                                                                                                                                                                                                 
	EsRetiroEfectivo = .F.                                                                                                                                                                                                                                    
	ExternalIdClover = ""                                                                                                                                                                                                                                     
	FECHAALTAFW = ctod( '  /  /    ' )                                                                                                                                                                                                                        
	FECHAEXPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAIMPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )                                                                                                                                                                                                                
	FECHATRANSFERENCIA = ctod( '  /  /    ' )                                                                                                                                                                                                                 
	FechaAltaFW = {}                                                                                                                                                                                                                                          
	FechaBaja = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FechaCierreDeLote = ctod( '  /  /    ' )                                                                                                                                                                                                                  
	FechaComprobante = ctod( '  /  /    ' )                                                                                                                                                                                                                   
	FechaCupon = ctod( '  /  /    ' )                                                                                                                                                                                                                         
	FechaDeCuponAfectado = ctod( '  /  /    ' )                                                                                                                                                                                                               
	FechaModificacionFW = {}                                                                                                                                                                                                                                  
	FechaNotadeCredito = ctod( '  /  /    ' )                                                                                                                                                                                                                 
	HORAALTAFW = ""                                                                                                                                                                                                                                           
	HORAEXPO = ""                                                                                                                                                                                                                                             
	HORAIMPO = ""                                                                                                                                                                                                                                             
	HORAMODIFICACIONFW = ""                                                                                                                                                                                                                                   
	HoraBaja = ""                                                                                                                                                                                                                                             
	HoraCierreDeLote = ""                                                                                                                                                                                                                                     
	HoraCupon = ""                                                                                                                                                                                                                                            
	IdCaja = null                                                                                                                                                                                                                                             
	IdCaja_PK = 0                                                                                                                                                                                                                                             
	IdGoCuotas = ""                                                                                                                                                                                                                                           
	IdOrdenClover = ""                                                                                                                                                                                                                                        
	IdPagoClover = ""                                                                                                                                                                                                                                         
	IdSmartLaPos = ""                                                                                                                                                                                                                                         
	LetraCanje = ""                                                                                                                                                                                                                                           
	LetraComprobante = ""                                                                                                                                                                                                                                     
	LetraNotadeCredito = ""                                                                                                                                                                                                                                   
	Lote = 0                                                                                                                                                                                                                                                  
	LoteAfectado = 0                                                                                                                                                                                                                                          
	Monto = 0                                                                                                                                                                                                                                                 
	NombreTitular = ""                                                                                                                                                                                                                                        
	NroDocumentoTitular = ""                                                                                                                                                                                                                                  
	NumeroCierreDeLote = 0                                                                                                                                                                                                                                    
	NumeroComercio = ""                                                                                                                                                                                                                                       
	NumeroComprobante = 0                                                                                                                                                                                                                                     
	NumeroCupon = 0                                                                                                                                                                                                                                           
	NumeroDeCanje = 0                                                                                                                                                                                                                                         
	NumeroDeCuponAfectado = 0                                                                                                                                                                                                                                 
	NumeroInterno = 0                                                                                                                                                                                                                                         
	NumeroNotadeCredito = 0                                                                                                                                                                                                                                   
	NumeroReferencia = 0                                                                                                                                                                                                                                      
	NumeroReferenciaAfectado = 0                                                                                                                                                                                                                              
	Observacion = ""                                                                                                                                                                                                                                          
	POS = null                                                                                                                                                                                                                                                
	POS_PK = ""                                                                                                                                                                                                                                               
	PromocionAplicada = ""                                                                                                                                                                                                                                    
	PuntoDeVenta = 0                                                                                                                                                                                                                                          
	PuntoDeVentaCanje = 0                                                                                                                                                                                                                                     
	PuntoDeVentaComprobante = 0                                                                                                                                                                                                                               
	PuntodeVentaNotadeCredito = 0                                                                                                                                                                                                                             
	QRTranfDebinIDPosnet = ""                                                                                                                                                                                                                                 
	QRTransactionIDPosnet = ""                                                                                                                                                                                                                                
	RecargoMonto = 0                                                                                                                                                                                                                                          
	RecargoPorcentaje = 0                                                                                                                                                                                                                                     
	ReferenciaExterna = ""                                                                                                                                                                                                                                    
	RetornoExtension = .t.                                                                                                                                                                                                                                    
	SERIEALTAFW = ""                                                                                                                                                                                                                                          
	SERIEMODIFICACIONFW = ""                                                                                                                                                                                                                                  
	Serial = ""                                                                                                                                                                                                                                               
	SerieBaja = ""                                                                                                                                                                                                                                            
	SerieOrigen = ""                                                                                                                                                                                                                                          
	SimboloMonetario = null                                                                                                                                                                                                                                   
	SimboloMonetario_PK = ""                                                                                                                                                                                                                                  
	TelefonoTitular = ""                                                                                                                                                                                                                                      
	TicketICard = ""                                                                                                                                                                                                                                          
	TicketICardCl = ""                                                                                                                                                                                                                                        
	TipoComprobante = 0                                                                                                                                                                                                                                       
	TipoCupon = ""                                                                                                                                                                                                                                            
	TipoDocumentoTitular = ""                                                                                                                                                                                                                                 
	TipoNotadeCredito = 0                                                                                                                                                                                                                                     
	TipoTarjeta = ""                                                                                                                                                                                                                                          
	USUARIOALTAFW = ""                                                                                                                                                                                                                                        
	USUARIOMODIFICACIONFW = ""                                                                                                                                                                                                                                
	UltimosDigitos = ""                                                                                                                                                                                                                                       
	VERSIONALTAFW = ""                                                                                                                                                                                                                                        
	VERSIONMODIFICACIONFW = ""                                                                                                                                                                                                                                
	Validacion = .F.                                                                                                                                                                                                                                          
	Valor = null                                                                                                                                                                                                                                              
	Valor_PK = ""                                                                                                                                                                                                                                             
	ZADSFW = ""                                                                                                                                                                                                                                               
	cAtributoAAuditar = ""                                                                                                                                                                                                                                    
	cAtributoPK = ""                                                                                                                                                                                                                                          
	cAtributoVendedor = ''                                                                                                                                                                                                                                    
	cCaracteres = ""                                                                                                                                                                                                                                          
	cContexto = ""                                                                                                                                                                                                                                            
	cCuponAnuladoParticular = ""                                                                                                                                                                                                                              
	cDescripcion =  "Cupones"                                                                                                                                                                                                                                 
	cDescripcionSingular = ""                                                                                                                                                                                                                                 
	cEvento = ""                                                                                                                                                                                                                                              
	cFormatoFechaNet = ""                                                                                                                                                                                                                                     
	cIdentificadorConexion = ""                                                                                                                                                                                                                               
	cNombre = ""                                                                                                                                                                                                                                              
	cNombre = 'CUPON'                                                                                                                                                                                                                                         
	cPrefijoImportar = ""                                                                                                                                                                                                                                     
	cPrefijoRecibir = ""                                                                                                                                                                                                                                      
	cUsuarioQueAutorizoSeguridad = ""                                                                                                                                                                                                                         
	lAccionAutomaticaTipoAntes = .F.                                                                                                                                                                                                                          
	lActivando = .f.                                                                                                                                                                                                                                          
	lActualizaRecepcion = .T.                                                                                                                                                                                                                                 
	lActualizarSoloEquivalenciasDeLince = .f.                                                                                                                                                                                                                 
	lAnular = .f.                                                                                                                                                                                                                                             
	lBuscandoCodigo = .f.                                                                                                                                                                                                                                     
	lCargando = .f.                                                                                                                                                                                                                                           
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
	lEstaSeteandoValorSugerido = .f.                                                                                                                                                                                                                          
	lHabilitaEnviarAlGrabar = .f.                                                                                                                                                                                                                             
	lHabilitarQRTranfDebinIDPosnet = .T.                                                                                                                                                                                                                      
	lHabilitarQRTransactionIDPosnet = .T.                                                                                                                                                                                                                     
	lIgnorarCamposObligatoriosDefinidosPorUsuario = .F.                                                                                                                                                                                                       
	lIgnorarClaveprimariaEnRecepcionBD = .f.                                                                                                                                                                                                                  
	lInicializado = .f.                                                                                                                                                                                                                                       
	lInicializarCodigoSugeridoHabilitado = .f.                                                                                                                                                                                                                
	lInstanciarSubEntidadaDemanda = .t.                                                                                                                                                                                                                       
	lLimpiando = .f.                                                                                                                                                                                                                                          
	lLoguear = .T.                                                                                                                                                                                                                                            
	lLogueoPropio = .T.                                                                                                                                                                                                                                       
	lNoCheckSessionOpen = .f. && para omitir el objeto del analisis de sessiones abiertas de test de foxunit                                                                                                                                                  
	lNoLoguearRestAPI = .F.                                                                                                                                                                                                                                   
	lNuevo = .F.                                                                                                                                                                                                                                              
	lOmiteObligatorioEnPack = .f.                                                                                                                                                                                                                             
	lPermiteMinusculasPK = .f.                                                                                                                                                                                                                                
	lProcesando = .F.                                                                                                                                                                                                                                         
	lReAsignarPk_Con_CC = .F.                                                                                                                                                                                                                                 
	lTieneAccionesAutomaticas = .f.                                                                                                                                                                                                                           
	lTieneDiseñosParaEnviarMail = .t.                                                                                                                                                                                                                         
	lTieneVendedorComoClaveForanea = .f.                                                                                                                                                                                                                      
	lWHEliminar = .f.                                                                                                                                                                                                                                         
	lWHIngresar = .f.                                                                                                                                                                                                                                         
	lWHModificar = .f.                                                                                                                                                                                                                                        
	mailGoCuotas = ""                                                                                                                                                                                                                                         
	nMontoOriginal = 0                                                                                                                                                                                                                                        
	oAD = null                                                                                                                                                                                                                                                
	oAtributosAnulacion = null                                                                                                                                                                                                                                
	oAtributosAuditoria = null                                                                                                                                                                                                                                
	oAtributosCC =  Null                                                                                                                                                                                                                                      
	oAtributosConEdicionRestringida= null                                                                                                                                                                                                                     
	oColAtributosObligatoriosDefinidosPorUsuario = null                                                                                                                                                                                                       
	oColaboradorPos = null                                                                                                                                                                                                                                    
	oColeccionVS = null                                                                                                                                                                                                                                       
	oColeccionVSFW = null                                                                                                                                                                                                                                     
	oComportamientoCodigoSugerido = null                                                                                                                                                                                                                      
	oExtension = null                                                                                                                                                                                                                                         
	oGestorDeMail = null                                                                                                                                                                                                                                      
	oInformacion = null                                                                                                                                                                                                                                       
	oLogueo = null                                                                                                                                                                                                                                            
	oMensaje = null                                                                                                                                                                                                                                           
	oNumeraciones =  null                                                                                                                                                                                                                                     
	oObservadoresDeImportacion = null                                                                                                                                                                                                                         
	oProveedorAtributosAnulacion = null                                                                                                                                                                                                                       
	oRegistrosDeActividadesAlGrabar = Null                                                                                                                                                                                                                    
	oTalle = null                                                                                                                                                                                                                                             
	oValidacionDominios= null                                                                                                                                                                                                                                 
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
	function actualizardatoscierredelote() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizardatoscierredelote', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizarestado() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizarestado', lcParametros )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'autorizacionpos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'autorizacionpos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Autorizacionpos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Autorizacionpos( lxVal )				this.Setear_Autorizacionpos( lxVal )			EndIf		Else			This.Setear_Autorizacionpos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function autorizaciontelefonica_assign( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'autorizaciontelefonica_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'autorizaciontelefonica_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Autorizaciontelefonica		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Autorizaciontelefonica( lxVal )				this.Setear_Autorizaciontelefonica( lxVal )			EndIf		Else			This.Setear_Autorizaciontelefonica( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function autorizaciontelefonicaoffline_assign( txval as variant ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'autorizaciontelefonicaoffline_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'autorizaciontelefonicaoffline_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Autorizaciontelefonicaoffline		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Autorizaciontelefonicaoffline( lxVal )				this.Setear_Autorizaciontelefonicaoffline( lxVal )			EndIf		Else			This.Setear_Autorizaciontelefonicaoffline( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatos_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatos( lxVal )				this.Setear_Basededatos( lxVal )			EndIf		Else			This.Setear_Basededatos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_access() as date                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosAltaFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosaltafw( lxVal )				this.Setear_Basededatosaltafw( lxVal )			EndIf		Else			This.Setear_Basededatosaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosbaja_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosbaja_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosbaja_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosbaja		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosbaja( lxVal )				this.Setear_Basededatosbaja( lxVal )			EndIf		Else			This.Setear_Basededatosbaja( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_access() as date                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosModificacionFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosmodificacionfw( lxVal )				this.Setear_Basededatosmodificacionfw( lxVal )			EndIf		Else			This.Setear_Basededatosmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'BuscarClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'BuscarClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.		this.Crear_oClases()				if _screen.oClases.GetKey( sys(2007, alltrim( lower( tcClase )),0,1)) > 0			llRetorno = .t.		else			if this.ExisteArchivoClase( tcClase )				this.AgregarClaseAColeccion( tcClase )				llRetorno = .t.			endif		endif				return llRetorno
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
	function cargar() as void                                                                                                                                                                                                                                 
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
	function clasedetarjeta_access() as variant                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'clasedetarjeta_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'clasedetarjeta_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Clasedetarjeta ) = 'O' or isnull( this.Clasedetarjeta ) )					this.Clasedetarjeta = _Screen.zoo.instanciarentidad( 'Clasedetarjeta' )					this.Clasedetarjeta.lEsSubEntidad = .t.					this.enlazar( 'Clasedetarjeta.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Clasedetarjeta.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Clasedetarjeta.CODIGO # this.Clasedetarjeta_PK						this.Clasedetarjeta.CODIGO = this.Clasedetarjeta_PK					endif				endif			endif		endif		return this.Clasedetarjeta
	EndFunc

	*-----------------------------------------------------------------------------------------
	function clasedetarjeta_pk_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'clasedetarjeta_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'clasedetarjeta_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Clasedetarjeta_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )		this.Clasedetarjeta_PK = lxVal		if this.Validar_Clasedetarjeta( lxVal, lxValOld )			This.Setear_Clasedetarjeta( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cliente_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cliente_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cliente_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Cliente ) = 'O' or isnull( this.Cliente ) )					this.Cliente = _Screen.zoo.instanciarentidad( 'Cliente' )					this.Cliente.lEsSubEntidad = .t.					this.enlazar( 'Cliente.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Cliente.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Cliente.CODIGO # this.Cliente_PK						this.Cliente.CODIGO = this.Cliente_PK					endif				endif			endif		endif		return this.Cliente
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cliente_pk_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cliente_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cliente_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Cliente_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Cliente.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )		this.Cliente_PK = lxVal		if this.Validar_Cliente( lxVal, lxValOld )			This.Setear_Cliente( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigo_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigo_assign', lcParametros )			endif		endif		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean		with this			llEdicion = .EsEdicion()			if !this.lPermiteMinusculasPK				try					txVal = upper( txVal )				Catch				Endtry			endif			if .lLimpiando or .lCargando				.Codigo = .TransformarAlAsignar( txVal )			else				if llEdicion				else					llNuevo = .EsNuevo()					.Codigo = .TransformarAlAsignar( txVal )					if empty( txVal ) and !llNuevo						.Limpiar()					else						if llNuevo							if .ValidarIngreso( txVal, llNuevo )							else								goServicios.Errores.LevantarExcepcion( 'Caracter inválido en el código.' )							endif						endif						llConsulta = .oAD.ConsultarPorClavePrimaria()						do case							case !llNuevo and llConsulta								.Cargar()							case !llNuevo and !llConsulta								.Limpiar()								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )							case llNuevo and llConsulta								.Codigo = []								goServicios.Errores.LevantarExcepcion( 'El código ' + alltrim( transform( txVal ) ) + ' ya existe.' )						endcase					endif				endif			endif		endwith
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigocierredelote_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigocierredelote_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigocierredelote_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Codigocierredelote		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Codigocierredelote( lxVal )				this.Setear_Codigocierredelote( lxVal )			EndIf		Else			This.Setear_Codigocierredelote( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigoplan_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigoplan_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigoplan_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Codigoplan		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Codigoplan( lxVal )				this.Setear_Codigoplan( lxVal )			EndIf		Else			This.Setear_Codigoplan( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function comprobante_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'comprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'comprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Comprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Comprobante( lxVal )				this.Setear_Comprobante( lxVal )			EndIf		Else			This.Setear_Comprobante( lxVal )		EndIf		dodefault( lxVal )
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
	function cotizacion_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cotizacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cotizacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Cotizacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Cotizacion( lxVal )				this.Setear_Cotizacion( lxVal )			EndIf		Else			This.Setear_Cotizacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crear_oclases() as void                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Crear_oClases', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Crear_oClases', lcParametros )			endif		endif		if !pemstatus( _screen, "oClases", 5 )				_screen.AddObject( "oClases", "Collection" )		endif				if !vartype( _screen.oClases ) = 'O' and isnull( _screen.oClases )			_screen.oClases = newobject( "Collection" )		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crearobjeto( tcclase as string, tclibreria as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant )                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9, lxParam10lnParametros = pcount()lxParam1 = tcclaselxParam2 = tclibrerialxParam3 = tvpar1lxParam4 = tvpar2lxParam5 = tvpar3lxParam6 = tvpar4lxParam7 = tvpar5lxParam8 = tvpar6lxParam9 = tvpar7lxParam10 = tvpar8lcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'crearobjeto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'crearobjeto', lcParametros )			endif		endif		Local loReturn As Object, lnParametrosReales As Integer, lcClase as String, lcConstructor as string, lcComando as String, ;			lnParamAux as Integer, lcClase as String, lcLibreria as String , lcSetProcedure as String,;			loErrorBase as Exception, loEx as Exception, loRetorno as object, lcConstructor as String, lcProcedure as String,;			lcSetClassLib as String, lcSet as String, loMock as Object, lcClaseProxy as String					loReturn = Null		lcLibreria = tcLibreria		lcClaseProxy = ""				*-------------------------------------------------------------------		if pemstatus(_screen, "Mocks", 5 ) and vartype( _Screen.Mocks ) = "O"				*Instanciación de Mocks			*Objeto solo instanciado en DESARROLLO.			if _screen.Mocks.lUtilizarMockV2 and this.buscarClase( forceext( "MockV2_" + tcClase, "prg" ) )				lcClase = "MockV2_" + tcClase			else				if _screen.Mocks.lUtilizarMockV1					local lnItem as Integer					lcClase = this.ObtenerNombreClase( tcClase )					lnItem = _Screen.Mocks.BuscarMock( lcClase )										if !empty( lnItem )						loMock = _Screen.Mocks.Item[lnItem]						loMock.lUsado = .t.						lcClase = loMock.cNombreClaseMock												if empty( loMock.cNombrePrgMock )							lcLibreria = iif( empty( lcLibreria ), "", "Mock_" + justfname( lcLibreria ) )						else							lcLibreria = loMock.cNombrePrgMock						endif					else						lcClase = tcClase					endif				else					lcClase = tcClase				endif			endif		else			lcClase = tcClase		endif		*-------------------------------------------------------------------		If empty( lcLibreria )			lcLibreria = forceext( lcClase, "prg" )		endif				If Pcount() > 1			lnParamAux = 2		Else			lnParamAux = 1		EndIf		lnParametrosReales = Pcount() - lnParamAux			loRetorno = null				try			if this.EsClaseNet( lcClase )				if !pemstatus( _screen, "NetExtender", 5 )					goServicios.Errores.LevantarExcepcion( "Para instanciar un objeto net debe haber iniciado la aplicación." )				endif				lcComando = this.ObtenerSentenciaConDesgloseParametros( "ClrCreateObject", lcClase, "", "", lnParametrosReales )				loRetorno = this.CrearObjetoNet( lcComando, tvPar1, tvPar2, tvPar3, tvPar4, tvPar5, tvPar6, tvPar7, tvPar8 )			else				lcClase = justfname( lcClase )								if lnParametrosReales = 0 and vartype( _Screen.Zoo ) = "O" and !isnull( _Screen.Zoo ) and !isnull( _screen.Zoo.oConstructor )					lcClaseProxy = _screen.Zoo.oConstructor.ObtenerNombreClaseProxy( lcClase, lcLibreria )				endif				if !empty( lcClaseProxy )					loRetorno = _screen.Zoo.oConstructor.CrearObjeto( lcClaseProxy, set( "Datasession" ) )				else					lcSetProcedure = set('Procedure')					lcSetClassLib = set("Classlib")												if upper( justext( lcLibreria )) = "VCX"						lcSet  = "SET CLASSLIB TO "					else						lcSet = "SET PROCEDURE TO "					endif													if this.lEsExe and upper( justext( lcLibreria ) ) == "PRG"						&& En el Exe solo se pueden instanciar los archivos FXP, si no se fuerza la extensión recorre todo el path buscando el PRG.						lcLibreria = forceext( lcLibreria, "fxp" )						lcProcedure = lcLibreria					else						lcProcedure = forceext( lcLibreria, "" )					endif												lcSet = lcSet + "'" + lcProcedure + "'"										if this.BuscarClase( lcLibreria )						&lcSet					endif																			if lnParametrosReales > 0						lcComando = this.ObtenerSentenciaConDesgloseParametros( "NewObject", lcClase, lcLibreria , "", lnParametrosReales )						loRetorno = &lcComando					else						loRetorno = newobject( lcClase, lcLibreria )					endif									if !(lower(lcSetClassLib) == lower(set("Classlib")))						set classlib to &lcSetClassLib					endif						set procedure to &lcSetProcedure				endif			endif		Catch To loErrorBase				local lnError as Integer			lnError = 0						if loErrorBase.ErrorNo = 1 and left( lower( lcLibreria ), 4 ) == "din_"				do case					case !this.BuscarClase( strtran( lower( lcLibreria ), ".prg", ".fxp" ) )						lnError = 10					case !this.BuscarClase( lcLibreria )						lnError	= 20				endcase			endif			loEx = Newobject( "ZooException", "ZooException.prg" )			With loEx				.Grabar( loErrorBase )				.nZooErrorNo = lnError				.Throw()			EndWith		EndTry		return loRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cuotas_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cuotas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cuotas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Cuotas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Cuotas( lxVal )				this.Setear_Cuotas( lxVal )			EndIf		Else			This.Setear_Cuotas( lxVal )		EndIf		dodefault( lxVal )
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
	function descuentomonto_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descuentomonto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descuentomonto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descuentomonto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descuentomonto( lxVal )				this.Setear_Descuentomonto( lxVal )			EndIf		Else			This.Setear_Descuentomonto( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function descuentoporcentaje_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descuentoporcentaje_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descuentoporcentaje_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descuentoporcentaje		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descuentoporcentaje( lxVal )				this.Setear_Descuentoporcentaje( lxVal )			EndIf		Else			This.Setear_Descuentoporcentaje( lxVal )		EndIf		dodefault( lxVal )
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
	function dispositivomovil_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'dispositivomovil_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'dispositivomovil_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Dispositivomovil		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Dispositivomovil( lxVal )				this.Setear_Dispositivomovil( lxVal )			EndIf		Else			This.Setear_Dispositivomovil( lxVal )		EndIf		dodefault( lxVal )
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
	function eliminar() as void                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminar', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'entidadfinanciera_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'entidadfinanciera_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Entidadfinanciera ) = 'O' or isnull( this.Entidadfinanciera ) )					this.Entidadfinanciera = _Screen.zoo.instanciarentidad( 'Entidadfinanciera' )					this.Entidadfinanciera.lEsSubEntidad = .t.					this.enlazar( 'Entidadfinanciera.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Entidadfinanciera.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Entidadfinanciera.CODIGO # this.Entidadfinanciera_PK						this.Entidadfinanciera.CODIGO = this.Entidadfinanciera_PK					endif				endif			endif		endif		return this.Entidadfinanciera
	EndFunc

	*-----------------------------------------------------------------------------------------
	function entidadfinanciera_pk_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'entidadfinanciera_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'entidadfinanciera_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Entidadfinanciera_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )		this.Entidadfinanciera_PK = lxVal		if this.Validar_Entidadfinanciera( lxVal, lxValOld )			This.Setear_Entidadfinanciera( lxVal )		endif		dodefault( lxVal )
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
	function escuponhuerfano( tccodigocupon as string ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccodigocupon

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Escuponhuerfano', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esdetipoanulaciondecompra( tctipo as string ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esdetipoanulaciondecompra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esdetipoanulaciondedevolucion( tctipo as string ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esdetipoanulaciondedevolucion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esdetipocompra( tctipo as string ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esdetipocompra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esdetipoconsignonegativo( tctipo as string ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esdetipoconsignonegativo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esdetipoconsignopositivo( tctipo as string ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esdetipoconsignopositivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esdetipodevolucion( tctipo as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esdetipodevolucion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esedicion() as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esedicion', lcParametros )
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
	function esretiroefectivo_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'esretiroefectivo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'esretiroefectivo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Esretiroefectivo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Esretiroefectivo( lxVal )				this.Setear_Esretiroefectivo( lxVal )			EndIf		Else			This.Setear_Esretiroefectivo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaanulado() as boolean                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estaanulado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estadotransferencia_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estadotransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estadotransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Estadotransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Estadotransferencia( lxVal )				this.Setear_Estadotransferencia( lxVal )			EndIf		Else			This.Setear_Estadotransferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaenproceso() as boolean                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estaenproceso', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estaenproceso', lcParametros )			endif		endif		local lRetorno as Boolean		with this			lRetorno = ( .lProcesando or .lCargando or .lLimpiando or .lDestroy )		endwith		return lRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estainicializado() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estainicializado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaintegrado() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estaintegrado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estavalidado() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estavalidado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function evaluarenviodemailenprocesoprevio() as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Evaluarenviodemailenprocesoprevio', lcParametros )
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
	function existearchivoclase( tcfile as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcfilelcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ExisteArchivoClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ExisteArchivoClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.				if _VFP.StartMode = 5 and !_screen.zoo.EsBuildAutomatico &&and "FOXEXTENDER" $ upper( sys( 16 ) )			try				do ( tcFile )				llRetorno = .t.			catch			endtry		else			llRetorno = file( tcFile )		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function externalidclover_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'externalidclover_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'externalidclover_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Externalidclover		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Externalidclover( lxVal )				this.Setear_Externalidclover( lxVal )			EndIf		Else			This.Setear_Externalidclover( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_access', lcParametros )			endif		endif		if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.FechaAltaFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaaltafw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaaltafw( lxVal )			EndIf		Else			This.Setear_Fechaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechabaja_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechabaja_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechabaja_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechabaja		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechabaja( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechabaja( lxVal )			EndIf		Else			This.Setear_Fechabaja( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechacierredelote_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechacierredelote_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechacierredelote_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechacierredelote		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechacierredelote( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechacierredelote( lxVal )			EndIf		Else			This.Setear_Fechacierredelote( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechacomprobante_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechacomprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechacomprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechacomprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechacomprobante( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechacomprobante( lxVal )			EndIf		Else			This.Setear_Fechacomprobante( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechacupon_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechacupon_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechacupon_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechacupon		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechacupon( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechacupon( lxVal )			EndIf		Else			This.Setear_Fechacupon( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechadecuponafectado_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechadecuponafectado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechadecuponafectado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechadecuponafectado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechadecuponafectado( lxVal )				this.Setear_Fechadecuponafectado( lxVal )			EndIf		Else			This.Setear_Fechadecuponafectado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaexpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaexpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaexpo( lxVal )			EndIf		Else			This.Setear_Fechaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaimpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaimpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaimpo( lxVal )			EndIf		Else			This.Setear_Fechaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			This.FechaModificacionFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechamodificacionfw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechamodificacionfw( lxVal )			EndIf		Else			This.Setear_Fechamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechanotadecredito_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechanotadecredito_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechanotadecredito_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechanotadecredito		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechanotadecredito( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechanotadecredito( lxVal )			EndIf		Else			This.Setear_Fechanotadecredito( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechatransferencia_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechatransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechatransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechatransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechatransferencia( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechatransferencia( lxVal )			EndIf		Else			This.Setear_Fechatransferencia( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_access', lcParametros )			endif		endif				if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			this.HoraAltaFW = goLibrerias.ObtenerHora()		endif		return this.HoraAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaaltafw( lxVal )				this.Setear_Horaaltafw( lxVal )			EndIf		Else			This.Setear_Horaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horabaja_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horabaja_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horabaja_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horabaja		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horabaja( lxVal )				this.Setear_Horabaja( lxVal )			EndIf		Else			This.Setear_Horabaja( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horacierredelote_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horacierredelote_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horacierredelote_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horacierredelote		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horacierredelote( lxVal )				this.Setear_Horacierredelote( lxVal )			EndIf		Else			This.Setear_Horacierredelote( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horacupon_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horacupon_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horacupon_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horacupon		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horacupon( lxVal )				this.Setear_Horacupon( lxVal )			EndIf		Else			This.Setear_Horacupon( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaexpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaexpo( lxVal )				this.Setear_Horaexpo( lxVal )			EndIf		Else			This.Setear_Horaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaimpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaimpo( lxVal )				this.Setear_Horaimpo( lxVal )			EndIf		Else			This.Setear_Horaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_access() as string                                                                                                                                                                                                            
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			this.HoraModificacionFW = goServicios.Librerias.ObtenerHora()		endif		return this.HoraModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horamodificacionfw( lxVal )				this.Setear_Horamodificacionfw( lxVal )			EndIf		Else			This.Setear_Horamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idcaja_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idcaja_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idcaja_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Idcaja ) = 'O' or isnull( this.Idcaja ) )					this.Idcaja = _Screen.zoo.instanciarentidad( 'Cajaestado' )					this.Idcaja.lEsSubEntidad = .t.					this.enlazar( 'Idcaja.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Idcaja.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Idcaja.ID # this.Idcaja_PK						this.Idcaja.ID = this.Idcaja_PK					endif				endif			endif		endif		return this.Idcaja
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idcaja_pk_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idcaja_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idcaja_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idcaja_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		this.Idcaja_PK = lxVal		if this.Validar_Idcaja( lxVal, lxValOld )			This.Setear_Idcaja( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idgocuotas_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idgocuotas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idgocuotas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idgocuotas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idgocuotas( lxVal )				this.Setear_Idgocuotas( lxVal )			EndIf		Else			This.Setear_Idgocuotas( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idordenclover_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idordenclover_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idordenclover_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idordenclover		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idordenclover( lxVal )				this.Setear_Idordenclover( lxVal )			EndIf		Else			This.Setear_Idordenclover( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idpagoclover_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idpagoclover_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idpagoclover_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idpagoclover		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idpagoclover( lxVal )				this.Setear_Idpagoclover( lxVal )			EndIf		Else			This.Setear_Idpagoclover( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function idsmartlapos_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'idsmartlapos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'idsmartlapos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Idsmartlapos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Idsmartlapos( lxVal )				this.Setear_Idsmartlapos( lxVal )			EndIf		Else			This.Setear_Idsmartlapos( lxVal )		EndIf		dodefault( lxVal )
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
	function lactualizarecepcion_access() as boolean                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lactualizarecepcion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lactualizarecepcion_access', lcParametros )			endif		endif		return .t.
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lesentidadconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lesentidadconedicionrestringida_access', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = .f.		if vartype( this.oAtributosConEdicionRestringida ) = 'O' and this.oAtributosConEdicionRestringida.Count > 0			llRetorno = .t.		endif		return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function letracanje_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'letracanje_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'letracanje_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Letracanje		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Letracanje( lxVal )				this.Setear_Letracanje( lxVal )			EndIf		Else			This.Setear_Letracanje( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function letracomprobante_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'letracomprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'letracomprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Letracomprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Letracomprobante( lxVal )				this.Setear_Letracomprobante( lxVal )			EndIf		Else			This.Setear_Letracomprobante( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function letranotadecredito_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'letranotadecredito_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'letranotadecredito_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Letranotadecredito		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Letranotadecredito( lxVal )				this.Setear_Letranotadecredito( lxVal )			EndIf		Else			This.Setear_Letranotadecredito( lxVal )		EndIf		dodefault( lxVal )
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
	function lote_assign( txval as variant ) as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lote_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lote_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Lote		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Lote( lxVal )				this.Setear_Lote( lxVal )			EndIf		Else			This.Setear_Lote( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function loteafectado_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'loteafectado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'loteafectado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Loteafectado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Loteafectado( lxVal )				this.Setear_Loteafectado( lxVal )			EndIf		Else			This.Setear_Loteafectado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mailgocuotas_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mailgocuotas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mailgocuotas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mailgocuotas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mailgocuotas( lxVal )				this.Setear_Mailgocuotas( lxVal )			EndIf		Else			This.Setear_Mailgocuotas( lxVal )		EndIf		dodefault( lxVal )
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
	function monto_assign( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'monto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'monto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Monto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Monto( lxVal )				this.Setear_Monto( lxVal )			EndIf		Else			This.Setear_Monto( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nombretitular_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nombretitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nombretitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nombretitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Nombretitular( lxVal )				this.Setear_Nombretitular( lxVal )			EndIf		Else			This.Setear_Nombretitular( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nrodocumentotitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nrodocumentotitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nrodocumentotitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Nrodocumentotitular( lxVal )				this.Setear_Nrodocumentotitular( lxVal )			EndIf		Else			This.Setear_Nrodocumentotitular( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerocierredelote_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerocierredelote_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerocierredelote		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerocierredelote( lxVal )				this.Setear_Numerocierredelote( lxVal )			EndIf		Else			This.Setear_Numerocierredelote( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerocomercio_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerocomercio_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerocomercio_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerocomercio		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerocomercio( lxVal )				this.Setear_Numerocomercio( lxVal )			EndIf		Else			This.Setear_Numerocomercio( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerocomprobante_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerocomprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerocomprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerocomprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerocomprobante( lxVal )				this.Setear_Numerocomprobante( lxVal )			EndIf		Else			This.Setear_Numerocomprobante( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerocupon_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerocupon_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerocupon_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerocupon		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerocupon( lxVal )				this.Setear_Numerocupon( lxVal )			EndIf		Else			This.Setear_Numerocupon( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerodecanje_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerodecanje_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerodecanje_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerodecanje		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerodecanje( lxVal )				this.Setear_Numerodecanje( lxVal )			EndIf		Else			This.Setear_Numerodecanje( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerodecuponafectado_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerodecuponafectado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerodecuponafectado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerodecuponafectado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerodecuponafectado( lxVal )				this.Setear_Numerodecuponafectado( lxVal )			EndIf		Else			This.Setear_Numerodecuponafectado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numerointerno_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numerointerno_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numerointerno_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numerointerno		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numerointerno( lxVal )				this.Setear_Numerointerno( lxVal )			EndIf		Else			This.Setear_Numerointerno( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numeronotadecredito_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numeronotadecredito_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numeronotadecredito_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numeronotadecredito		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numeronotadecredito( lxVal )				this.Setear_Numeronotadecredito( lxVal )			EndIf		Else			This.Setear_Numeronotadecredito( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numeroreferencia_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numeroreferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numeroreferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numeroreferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numeroreferencia( lxVal )				this.Setear_Numeroreferencia( lxVal )			EndIf		Else			This.Setear_Numeroreferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function numeroreferenciaafectado_assign( txval as variant ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numeroreferenciaafectado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numeroreferenciaafectado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numeroreferenciaafectado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numeroreferenciaafectado( lxVal )				this.Setear_Numeroreferenciaafectado( lxVal )			EndIf		Else			This.Setear_Numeroreferenciaafectado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oad_access() as variant                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oad_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oad_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )			this.oAD = this.crearobjeto( 'Din_EntidadCUPONAD_' + alltrim( _screen.zoo.app.TipoDeBase ))			this.oAD.InyectarEntidad( this )			this.oAD.Inicializar()		endif		return this.oAD
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oatributosconedicionrestringida_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oatributosconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oatributosconedicionrestringida_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oAtributosConEdicionRestringida ) = 'O'			this.oAtributosConEdicionRestringida = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oAtributosConEdicionRestringida
	EndFunc

	*-----------------------------------------------------------------------------------------
	function observacion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'observacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'observacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Observacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Observacion( lxVal )				this.Setear_Observacion( lxVal )			EndIf		Else			This.Setear_Observacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoclaveprimaria() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obteneratributoclaveprimaria', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obteneratributoclaveprimaria', lcParametros )			endif		endif		return this.cAtributoPK
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
	function obtenercolecciondecupones( tnnumerocupon as integer, tnmonto as double, tncuotas as integer, tdfecha as date ) as zoocoleccion                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tnnumerocupon
		lxParam2 = tnmonto
		lxParam3 = tncuotas
		lxParam4 = tdfecha

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercolecciondecupones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercolecciondecuponesparaafectar( tnnumerocupon as integer, tnmonto as double, tncuotas as integer ) as zoocoleccion                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tnnumerocupon
		lxParam2 = tnmonto
		lxParam3 = tncuotas

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercolecciondecuponesparaafectar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercuponeshuerfanos( tnsigno as integer, tlincluiranulaciones as boolean ) as zoocoleccion of zoocoleccion.prg                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnsigno
		lxParam2 = tlincluiranulaciones

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercuponeshuerfanos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercuponeshuerfanosendispositivopos( tcpos as string ) as zoocoleccion of zoocoleccion.prg                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcpos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercuponeshuerfanosendispositivopos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercuponeshuerfanosporcaja( tncaja as integer, tlincluiranulaciones as boolean ) as zoocoleccion of zoocoleccion.prg                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tncaja
		lxParam2 = tlincluiranulaciones

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercuponeshuerfanosporcaja', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdatoscupon( tccodigo as string ) as object                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccodigo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerdatoscupon', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenerdescripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenerdescripcion', lcParametros )			endif		endif		return this.cDescripcion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdescripciondeltipo( tctipo as string ) as string                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerdescripciondeltipo', lcParametros )
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
	function obteneridporclavecandidata() as variant                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneridporclavecandidata', lcParametros )
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
	function obtenerposdefault() as string                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerposdefault', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolaboradorpos_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolaboradorpos_access', lcParametros )			endif		endif		local loFactory as object		if !this.lDestroy			loFactory = _screen.Zoo.CrearObjeto( "FactoryColaboradoresDispositivoPOS" )			if type( "this.oColaboradorPOS" ) <> "O" or isnull( this.oColaboradorPOS )				this.oColaboradorPOS = loFactory.ColaboradorSegunPrestador( this.POS.Prestador )				this.oColaboradorPOS.InyectarEntidadPos( this.POS )				this.enlazar( 'oColaboradorPOS.EventoObtenerInformacion', 'inyectarInformacion' )			else				if ( !empty( this.Pos.Prestador ) and this.POS.Prestador <> this.oColaboradorPOS.cPrestador) or ( empty( this.Pos.Prestador ) and this.oColaboradorPOS.cPrestador <> "POSNET" )					this.oColaboradorPOS.oEntidadPos = null					this.oColaboradorPOS.release()					this.oColaboradorPOS = loFactory.ColaboradorSegunPrestador( this.POS.Prestador )					this.oColaboradorPOS.InyectarEntidadPos( this.POS )					this.enlazar( 'oColaboradorPOS.EventoObtenerInformacion', 'inyectarInformacion' )				endif			endif		endif		return this.oColaboradorPOS
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocolatributosobligatoriosdefinidosporusuario_access() as object                                                                                                                                                                                  
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			endif		endif		local loRetorno as Object				loRetorno = null		if !this.lDestroy					loRetorno = goServicios.SaltosDeCampoyValoresSugeridos.ObtenerColeccionAtributosObligatorios( this.ObtenerNombre() )		endif				return loRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocomportamientocodigosugerido_access() as void                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocomportamientocodigosugerido_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocomportamientocodigosugerido_access', lcParametros )			endif		endif		local loComportamientoCodigoSugerido as Object		if !this.ldestroy and !vartype( this.oComportamientoCodigoSugerido ) = 'O'			loComportamientoCodigoSugerido = _Screen.zoo.CrearObjeto( "DecoradorDeCodigosDeEntidades" )			this.InicializarComportamientoCodigoSugerido(loComportamientoCodigoSugerido )			this.oComportamientoCodigoSugerido = loComportamientoCodigoSugerido		endif		return this.oComportamientoCodigoSugerido
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ogestordemail_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ogestordemail_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ogestordemail_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oGestorDeMail ) = 'O'			this.oGestorDeMail = _Screen.zoo.CrearObjeto( "GestorDeMail" )		endif		return this.oGestorDeMail
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oinformacion_access() as variant                                                                                                                                                                                                                 
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oinformacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oinformacion_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )				this.eventoObtenerInformacion( this )				if !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )					.oInformacion = this.CrearObjeto( "ZooInformacion" )				endif				endif		endwith		return this.oInformacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ologueo_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ologueo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ologueo_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oLogueo ) = 'O' and isnull( .oLogueo ) and vartype( goServicios ) = 'O'				this.eventoObtenerLogueo( this )				if !vartype( .oLogueo ) = 'O' and isnull( .oLogueo )					.oLogueo = goServicios.Logueos.obtenerObjetoLogueo( this )					.SetearAccion()					.lLogueoPropio = .T.				else					.lLogueoPropio = .F.								endif				endif		endwith		return this.oLogueo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function omensaje_access() as void                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'omensaje_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'omensaje_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oMensaje ) = 'O' or isnull( this.oMensaje ) )			this.oMensaje = _screen.zoo.crearobjeto( "mensajeentidad", "", this )		endif				return this.oMensaje
	EndFunc

	*-----------------------------------------------------------------------------------------
	function onumeraciones_access() as variant                                                                                                                                                                                                                
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'onumeraciones_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'onumeraciones_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oNumeraciones ) = 'O' or isnull( this.oNumeraciones ) )			this.oNumeraciones = this.CrearObjeto( 'Numeraciones' )			this.oNumeraciones.Inicializar()			this.oNumeraciones.SetearEntidad( this )		endif		return this.oNumeraciones
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oobservadoresdeimportacion_access() as variant                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oobservadoresdeimportacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oobservadoresdeimportacion_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oObservadoresDeImportacion ) = 'O' or isnull( this.oObservadoresDeImportacion ) )			this.oObservadoresDeImportacion = _Screen.zoo.crearobjeto( 'ZooColeccion' )		endif		return this.oObservadoresDeImportacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oregistrosdeactividadesalgrabar_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oregistrosdeactividadesalgrabar_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oregistrosdeactividadesalgrabar_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oRegistrosDeActividadesAlGrabar ) = 'O'			this.oRegistrosDeActividadesAlGrabar = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oRegistrosDeActividadesAlGrabar
	EndFunc

	*-----------------------------------------------------------------------------------------
	function otalle_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'otalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'otalle_access', lcParametros )			endif		endif		if this.ldestroy		else			if ( !vartype( this.oTalle ) = 'O' or isnull( this.oTalle ) )				this.oTalle = _Screen.zoo.instanciarentidad( 'Talle' )			endif		endif		return this.oTalle
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ovalidadorescomp_access() as object                                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ovalidadorescomp_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ovalidadorescomp_access', lcParametros )			endif		endif		if !this.lDestroy and !( vartype( this.oValidadoresComp ) == "O" )			this.oValidadoresComp = _screen.Zoo.Crearobjeto( "ZooColeccion" )		endif				return this.oValidadoresComp
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
	function pos_access() as variant                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'pos_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'pos_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Pos ) = 'O' or isnull( this.Pos ) )					this.Pos = _Screen.zoo.instanciarentidad( 'Pos' )					this.Pos.lEsSubEntidad = .t.					this.enlazar( 'Pos.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Pos.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Pos.CODIGO # this.Pos_PK						this.Pos.CODIGO = this.Pos_PK					endif				endif			endif		endif		return this.Pos
	EndFunc

	*-----------------------------------------------------------------------------------------
	function pos_pk_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'pos_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'pos_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Pos_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Pos_PK = lxVal		if this.Validar_Pos( lxVal, lxValOld )			This.Setear_Pos( lxVal )		endif		dodefault( lxVal )
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
	function procesarenviodeemailalimportarporbuffer() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Procesarenviodeemailalimportarporbuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function puntodeventa_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'puntodeventa_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'puntodeventa_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Puntodeventa		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Puntodeventa( lxVal )				this.Setear_Puntodeventa( lxVal )				if !empty( lxVal ) and this.esNuevo()					if this.VerificarContexto( 'CB' )					else						this.lCargando = .t.						local loError as exception						try							this.NUMEROINTERNO = this.oNumeraciones.ObtenerNumero('NUMEROINTERNO')						catch to loError							local loEx as Object							loEx = Newobject( 'ZooException', 'ZooException.prg' )							With loEx								.Grabar( loError )								.Throw()							endwith						finally							this.lCargando = .f.						endtry					endif				endif			EndIf		Else			This.Setear_Puntodeventa( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function puntodeventacanje_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'puntodeventacanje_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'puntodeventacanje_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Puntodeventacanje		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Puntodeventacanje( lxVal )				this.Setear_Puntodeventacanje( lxVal )			EndIf		Else			This.Setear_Puntodeventacanje( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function puntodeventacomprobante_assign( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'puntodeventacomprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'puntodeventacomprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Puntodeventacomprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Puntodeventacomprobante( lxVal )				this.Setear_Puntodeventacomprobante( lxVal )			EndIf		Else			This.Setear_Puntodeventacomprobante( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function puntodeventanotadecredito_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'puntodeventanotadecredito_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'puntodeventanotadecredito_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Puntodeventanotadecredito		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Puntodeventanotadecredito( lxVal )				this.Setear_Puntodeventanotadecredito( lxVal )			EndIf		Else			This.Setear_Puntodeventanotadecredito( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function qrtranfdebinidposnet_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'qrtranfdebinidposnet_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'qrtranfdebinidposnet_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Qrtranfdebinidposnet		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Qrtranfdebinidposnet( lxVal )				if ( this.lHabilitarQrtranfdebinidposnet or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Qrtranfdebinidposnet( lxVal )				else					this.Qrtranfdebinidposnet = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Cupones - Atributo: Qrtranfdebinidposnet)" )				endif			EndIf		Else			This.Setear_Qrtranfdebinidposnet( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function qrtransactionidposnet_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'qrtransactionidposnet_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'qrtransactionidposnet_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Qrtransactionidposnet		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Qrtransactionidposnet( lxVal )				if ( this.lHabilitarQrtransactionidposnet or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Qrtransactionidposnet( lxVal )				else					this.Qrtransactionidposnet = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Cupones - Atributo: Qrtransactionidposnet)" )				endif			EndIf		Else			This.Setear_Qrtransactionidposnet( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function reasignarpk_con_cc() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Reasignarpk_con_cc', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function reasignarvalorsugeridoencasodeconcurrencia() as string                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Reasignarvalorsugeridoencasodeconcurrencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function recargomonto_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'recargomonto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'recargomonto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Recargomonto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Recargomonto( lxVal )				this.Setear_Recargomonto( lxVal )			EndIf		Else			This.Setear_Recargomonto( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function recargoporcentaje_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'recargoporcentaje_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'recargoporcentaje_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Recargoporcentaje		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Recargoporcentaje( lxVal )				this.Setear_Recargoporcentaje( lxVal )			EndIf		Else			This.Setear_Recargoporcentaje( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'referenciaexterna_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'referenciaexterna_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Referenciaexterna		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Referenciaexterna( lxVal )				this.Setear_Referenciaexterna( lxVal )			EndIf		Else			This.Setear_Referenciaexterna( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurargenhabilitar() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurargenhabilitar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function secambiomontooriginal() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Secambiomontooriginal', lcParametros )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'serial_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'serial_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Serial		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Serial( lxVal )				this.Setear_Serial( lxVal )			EndIf		Else			This.Setear_Serial( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.SerieAltaFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriealtafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriealtafw( lxVal )				this.Setear_Seriealtafw( lxVal )			EndIf		Else			This.Setear_Seriealtafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriebaja_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriebaja_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriebaja_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriebaja		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriebaja( lxVal )				this.Setear_Seriebaja( lxVal )			EndIf		Else			This.Setear_Seriebaja( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.SerieModificacionFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriemodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriemodificacionfw( lxVal )				this.Setear_Seriemodificacionfw( lxVal )			EndIf		Else			This.Setear_Seriemodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function serieorigen_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'serieorigen_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'serieorigen_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Serieorigen		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Serieorigen( lxVal )				this.Setear_Serieorigen( lxVal )			EndIf		Else			This.Setear_Serieorigen( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_autorizacionpos( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_autorizacionpos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_autorizacionpos', lcParametros )			endif		endif		this.Autorizacionpos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_autorizaciontelefonica( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_autorizaciontelefonica', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_autorizaciontelefonica', lcParametros )			endif		endif		this.Autorizaciontelefonica = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_autorizaciontelefonicaoffline( txval as variant ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_autorizaciontelefonicaoffline', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_autorizaciontelefonicaoffline', lcParametros )			endif		endif		this.Autorizaciontelefonicaoffline = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatos( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatos', lcParametros )			endif		endif		this.Basededatos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosaltafw( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosaltafw', lcParametros )			endif		endif		this.Basededatosaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosbaja( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosbaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosbaja', lcParametros )			endif		endif		this.Basededatosbaja = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosmodificacionfw( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosmodificacionfw', lcParametros )			endif		endif		this.Basededatosmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_clasedetarjeta( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_clasedetarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_clasedetarjeta', lcParametros )			endif		endif		this.Clasedetarjeta.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cliente( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_cliente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_cliente', lcParametros )			endif		endif		this.Cliente.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_codigocierredelote( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_codigocierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_codigocierredelote', lcParametros )			endif		endif		this.Codigocierredelote = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_codigoplan( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_codigoplan', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_codigoplan', lcParametros )			endif		endif		this.Codigoplan = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_comprobante( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_comprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_comprobante', lcParametros )			endif		endif		this.Comprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cotizacion( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_cotizacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_cotizacion', lcParametros )			endif		endif		this.Cotizacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cuotas( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_cuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_cuotas', lcParametros )			endif		endif		this.Cuotas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descuentomonto( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descuentomonto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descuentomonto', lcParametros )			endif		endif		this.Descuentomonto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descuentoporcentaje( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descuentoporcentaje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descuentoporcentaje', lcParametros )			endif		endif		this.Descuentoporcentaje = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_dispositivomovil( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_dispositivomovil', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_dispositivomovil', lcParametros )			endif		endif		this.Dispositivomovil = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_entidadfinanciera( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_entidadfinanciera', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_entidadfinanciera', lcParametros )			endif		endif		this.Entidadfinanciera.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_esretiroefectivo( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_esretiroefectivo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_esretiroefectivo', lcParametros )			endif		endif		this.Esretiroefectivo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_estadotransferencia( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_estadotransferencia', lcParametros )			endif		endif		this.Estadotransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_externalidclover( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_externalidclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_externalidclover', lcParametros )			endif		endif		this.Externalidclover = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaaltafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaaltafw', lcParametros )			endif		endif		this.Fechaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechabaja( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechabaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechabaja', lcParametros )			endif		endif		this.Fechabaja = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechacierredelote( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechacierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechacierredelote', lcParametros )			endif		endif		this.Fechacierredelote = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechacomprobante( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechacomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechacomprobante', lcParametros )			endif		endif		this.Fechacomprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechacupon( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechacupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechacupon', lcParametros )			endif		endif		this.Fechacupon = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechadecuponafectado( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechadecuponafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechadecuponafectado', lcParametros )			endif		endif		this.Fechadecuponafectado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaexpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaexpo', lcParametros )			endif		endif		this.Fechaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaimpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaimpo', lcParametros )			endif		endif		this.Fechaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechamodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechamodificacionfw', lcParametros )			endif		endif		this.Fechamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechanotadecredito( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechanotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechanotadecredito', lcParametros )			endif		endif		this.Fechanotadecredito = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechatransferencia( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechatransferencia', lcParametros )			endif		endif		this.Fechatransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaaltafw( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaaltafw', lcParametros )			endif		endif		this.Horaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horabaja( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horabaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horabaja', lcParametros )			endif		endif		this.Horabaja = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horacierredelote( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horacierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horacierredelote', lcParametros )			endif		endif		this.Horacierredelote = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horacupon( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horacupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horacupon', lcParametros )			endif		endif		this.Horacupon = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaexpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaexpo', lcParametros )			endif		endif		this.Horaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaimpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaimpo', lcParametros )			endif		endif		this.Horaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horamodificacionfw( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horamodificacionfw', lcParametros )			endif		endif		this.Horamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idcaja( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idcaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idcaja', lcParametros )			endif		endif		this.Idcaja.ID = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idgocuotas( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idgocuotas', lcParametros )			endif		endif		this.Idgocuotas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idordenclover( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idordenclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idordenclover', lcParametros )			endif		endif		this.Idordenclover = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idpagoclover( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idpagoclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idpagoclover', lcParametros )			endif		endif		this.Idpagoclover = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_idsmartlapos( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_idsmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_idsmartlapos', lcParametros )			endif		endif		this.Idsmartlapos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_letracanje( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_letracanje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_letracanje', lcParametros )			endif		endif		this.Letracanje = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_letracomprobante( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_letracomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_letracomprobante', lcParametros )			endif		endif		this.Letracomprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_letranotadecredito( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_letranotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_letranotadecredito', lcParametros )			endif		endif		this.Letranotadecredito = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_lote( txval as variant ) as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_lote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_lote', lcParametros )			endif		endif		this.Lote = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_loteafectado( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_loteafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_loteafectado', lcParametros )			endif		endif		this.Loteafectado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mailgocuotas( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mailgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mailgocuotas', lcParametros )			endif		endif		this.Mailgocuotas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_monto( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_monto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_monto', lcParametros )			endif		endif		this.Monto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nombretitular( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nombretitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nombretitular', lcParametros )			endif		endif		this.Nombretitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nrodocumentotitular( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nrodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nrodocumentotitular', lcParametros )			endif		endif		this.Nrodocumentotitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerocierredelote( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerocierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerocierredelote', lcParametros )			endif		endif		this.Numerocierredelote = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerocomercio( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerocomercio', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerocomercio', lcParametros )			endif		endif		this.Numerocomercio = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerocomprobante( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerocomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerocomprobante', lcParametros )			endif		endif		this.Numerocomprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerocupon( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerocupon', lcParametros )			endif		endif		this.Numerocupon = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerodecanje( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerodecanje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerodecanje', lcParametros )			endif		endif		this.Numerodecanje = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerodecuponafectado( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerodecuponafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerodecuponafectado', lcParametros )			endif		endif		this.Numerodecuponafectado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numerointerno( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numerointerno', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numerointerno', lcParametros )			endif		endif		this.Numerointerno = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numeronotadecredito( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numeronotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numeronotadecredito', lcParametros )			endif		endif		this.Numeronotadecredito = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numeroreferencia( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numeroreferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numeroreferencia', lcParametros )			endif		endif		this.Numeroreferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numeroreferenciaafectado( txval as variant ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numeroreferenciaafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numeroreferenciaafectado', lcParametros )			endif		endif		this.Numeroreferenciaafectado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_observacion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_observacion', lcParametros )			endif		endif		this.Observacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_pos( txval as variant ) as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_pos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_pos', lcParametros )			endif		endif		this.Pos.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_puntodeventa( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_puntodeventa', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_puntodeventa', lcParametros )			endif		endif		this.Puntodeventa = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_puntodeventacanje( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_puntodeventacanje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_puntodeventacanje', lcParametros )			endif		endif		this.Puntodeventacanje = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_puntodeventacomprobante( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_puntodeventacomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_puntodeventacomprobante', lcParametros )			endif		endif		this.Puntodeventacomprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_puntodeventanotadecredito( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_puntodeventanotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_puntodeventanotadecredito', lcParametros )			endif		endif		this.Puntodeventanotadecredito = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_qrtranfdebinidposnet( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_qrtranfdebinidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_qrtranfdebinidposnet', lcParametros )			endif		endif		this.Qrtranfdebinidposnet = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_qrtransactionidposnet( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_qrtransactionidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_qrtransactionidposnet', lcParametros )			endif		endif		this.Qrtransactionidposnet = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_recargomonto( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_recargomonto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_recargomonto', lcParametros )			endif		endif		this.Recargomonto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_recargoporcentaje( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_recargoporcentaje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_recargoporcentaje', lcParametros )			endif		endif		this.Recargoporcentaje = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_referenciaexterna( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_referenciaexterna', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_referenciaexterna', lcParametros )			endif		endif		this.Referenciaexterna = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_serial( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_serial', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_serial', lcParametros )			endif		endif		this.Serial = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriealtafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriealtafw', lcParametros )			endif		endif		this.Seriealtafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriebaja( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriebaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriebaja', lcParametros )			endif		endif		this.Seriebaja = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriemodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriemodificacionfw', lcParametros )			endif		endif		this.Seriemodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_serieorigen( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_serieorigen', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_serieorigen', lcParametros )			endif		endif		this.Serieorigen = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_simbolomonetario( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_simbolomonetario', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_simbolomonetario', lcParametros )			endif		endif		this.Simbolomonetario.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_telefonotitular( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_telefonotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_telefonotitular', lcParametros )			endif		endif		this.Telefonotitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ticketicard( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ticketicard', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ticketicard', lcParametros )			endif		endif		this.Ticketicard = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ticketicardcl( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ticketicardcl', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ticketicardcl', lcParametros )			endif		endif		this.Ticketicardcl = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipocomprobante( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipocomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipocomprobante', lcParametros )			endif		endif		this.Tipocomprobante = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipocupon( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipocupon', lcParametros )			endif		endif		this.Tipocupon = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipodocumentotitular( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipodocumentotitular', lcParametros )			endif		endif		this.Tipodocumentotitular = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tiponotadecredito( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tiponotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tiponotadecredito', lcParametros )			endif		endif		this.Tiponotadecredito = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipotarjeta( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipotarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipotarjeta', lcParametros )			endif		endif		this.Tipotarjeta = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ultimosdigitos( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ultimosdigitos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ultimosdigitos', lcParametros )			endif		endif		this.Ultimosdigitos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuarioaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuarioaltafw', lcParametros )			endif		endif		this.Usuarioaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuariomodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuariomodificacionfw', lcParametros )			endif		endif		this.Usuariomodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_validacion( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_validacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_validacion', lcParametros )			endif		endif		this.Validacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_valor( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_valor', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_valor', lcParametros )			endif		endif		dodefault( txVal )		this.EstablecerTipoTarjeta()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionaltafw', lcParametros )			endif		endif		this.Versionaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionmodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionmodificacionfw', lcParametros )			endif		endif		this.Versionmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_zadsfw( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_zadsfw', lcParametros )			endif		endif		this.Zadsfw = txVal		dodefault( txVal )
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
	function simbolomonetario_access() as variant                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'simbolomonetario_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'simbolomonetario_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Simbolomonetario ) = 'O' or isnull( this.Simbolomonetario ) )					this.Simbolomonetario = _Screen.zoo.instanciarentidad( 'Moneda' )					this.Simbolomonetario.lEsSubEntidad = .t.					this.enlazar( 'Simbolomonetario.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Simbolomonetario.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Simbolomonetario.CODIGO # this.Simbolomonetario_PK						this.Simbolomonetario.CODIGO = this.Simbolomonetario_PK					endif				endif			endif		endif		return this.Simbolomonetario
	EndFunc

	*-----------------------------------------------------------------------------------------
	function simbolomonetario_pk_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'simbolomonetario_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'simbolomonetario_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Simbolomonetario_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Simbolomonetario_PK = lxVal		if this.Validar_Simbolomonetario( lxVal, lxValOld )			This.Setear_Simbolomonetario( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function soportabusquedaextendida( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'soportabusquedaextendida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'soportabusquedaextendida', lcParametros )			endif		endif		return This.oComportamientoCodigoSugerido.SoportaBusquedaExtendida()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function telefonotitular_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'telefonotitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'telefonotitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Telefonotitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Telefonotitular( lxVal )				this.Setear_Telefonotitular( lxVal )			EndIf		Else			This.Setear_Telefonotitular( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ticketicard_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ticketicard_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ticketicard_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ticketicard		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ticketicard( lxVal )				this.Setear_Ticketicard( lxVal )			EndIf		Else			This.Setear_Ticketicard( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ticketicardcl_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ticketicardcl_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ticketicardcl_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ticketicardcl		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ticketicardcl( lxVal )				this.Setear_Ticketicardcl( lxVal )			EndIf		Else			This.Setear_Ticketicardcl( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienecanjedecupon() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienecanjedecupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienecierredelote() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienecierredelote', lcParametros )
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
	function tipocomprobante_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipocomprobante_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipocomprobante_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipocomprobante		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipocomprobante( lxVal )				this.Setear_Tipocomprobante( lxVal )			EndIf		Else			This.Setear_Tipocomprobante( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipocupon_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipocupon_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipocupon_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipocupon		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipocupon( lxVal )				this.Setear_Tipocupon( lxVal )			EndIf		Else			This.Setear_Tipocupon( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipodocumentotitular_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipodocumentotitular_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipodocumentotitular_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipodocumentotitular		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipodocumentotitular( lxVal )				this.Setear_Tipodocumentotitular( lxVal )			EndIf		Else			This.Setear_Tipodocumentotitular( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tiponotadecredito_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tiponotadecredito_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tiponotadecredito_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tiponotadecredito		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tiponotadecredito( lxVal )				this.Setear_Tiponotadecredito( lxVal )			EndIf		Else			This.Setear_Tiponotadecredito( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipotarjeta_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipotarjeta_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipotarjeta_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipotarjeta		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipotarjeta( lxVal )				this.Setear_Tipotarjeta( lxVal )			EndIf		Else			This.Setear_Tipotarjeta( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ultimosdigitos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ultimosdigitos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ultimosdigitos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ultimosdigitos( lxVal )				this.Setear_Ultimosdigitos( lxVal )			EndIf		Else			This.Setear_Ultimosdigitos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_access() as date                                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.UsuarioAltaFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() ) + this.UsuarioAutorizante()		endif		return This.UsuarioAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuarioaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuarioaltafw( lxVal )				this.Setear_Usuarioaltafw( lxVal )			EndIf		Else			This.Setear_Usuarioaltafw( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.UsuarioModificacionFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() )  + this.UsuarioAutorizante()		endif		return This.UsuarioModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuariomodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuariomodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuariomodificacionfw( lxVal )				this.Setear_Usuariomodificacionfw( lxVal )			EndIf		Else			This.Setear_Usuariomodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validacion_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Validacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Validacion( lxVal )				this.Setear_Validacion( lxVal )			EndIf		Else			This.Setear_Validacion( lxVal )		EndIf		dodefault( lxVal )
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
	function validar_autorizacionpos( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_autorizacionpos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_autorizacionpos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_autorizaciontelefonica( txval as variant ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_autorizaciontelefonica', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_autorizaciontelefonica', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_autorizaciontelefonicaoffline( txval as variant ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_autorizaciontelefonicaoffline', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_autorizaciontelefonicaoffline', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatos( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosaltafw( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosbaja( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosbaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosbaja', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_clasedetarjeta( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_clasedetarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_clasedetarjeta', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cliente( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_cliente', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_cliente', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_codigocierredelote( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_codigocierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_codigocierredelote', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_codigoplan( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_codigoplan', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_codigoplan', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_comprobante( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_comprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_comprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cotizacion( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_cotizacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_cotizacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cuotas( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_cuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_cuotas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descuentomonto( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descuentomonto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descuentomonto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descuentoporcentaje( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descuentoporcentaje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descuentoporcentaje', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_dispositivomovil( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_dispositivomovil', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_dispositivomovil', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_entidadfinanciera( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_entidadfinanciera', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_entidadfinanciera', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_esretiroefectivo( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_esretiroefectivo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_esretiroefectivo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_estadotransferencia( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_estadotransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_externalidclover( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_externalidclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_externalidclover', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaaltafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechabaja( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechabaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechabaja', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechacierredelote( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechacierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechacierredelote', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechacomprobante( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechacomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechacomprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechacupon( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechacupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechacupon', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechadecuponafectado( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechadecuponafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechadecuponafectado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaexpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaimpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechanotadecredito( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechanotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechanotadecredito', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechatransferencia( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechatransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaaltafw( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horabaja( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horabaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horabaja', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horacierredelote( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horacierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horacierredelote', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horacupon( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horacupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horacupon', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaexpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaimpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idcaja( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idcaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idcaja', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idgocuotas( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idgocuotas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idordenclover( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idordenclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idordenclover', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idpagoclover( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idpagoclover', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idpagoclover', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_idsmartlapos( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_idsmartlapos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_idsmartlapos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_letracanje( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_letracanje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_letracanje', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_letracomprobante( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_letracomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_letracomprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_letranotadecredito( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_letranotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_letranotadecredito', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_lote( txval as variant ) as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_lote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_lote', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_loteafectado( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_loteafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_loteafectado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mailgocuotas( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mailgocuotas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mailgocuotas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_monto( txval as variant ) as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_monto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_monto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nombretitular( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nombretitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nombretitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nrodocumentotitular( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nrodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nrodocumentotitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerocierredelote( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerocierredelote', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerocierredelote', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerocomercio( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerocomercio', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerocomercio', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerocomprobante( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerocomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerocomprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerocupon( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerocupon', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerodecanje( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerodecanje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerodecanje', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerodecuponafectado( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerodecuponafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerodecuponafectado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numerointerno( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numerointerno', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numerointerno', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numeronotadecredito( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numeronotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numeronotadecredito', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numeroreferencia( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numeroreferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numeroreferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numeroreferenciaafectado( txval as variant ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numeroreferenciaafectado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numeroreferenciaafectado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_observacion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_observacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_pos( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_pos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_pos', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_puntodeventa( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_puntodeventa', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_puntodeventa', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_puntodeventacanje( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_puntodeventacanje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_puntodeventacanje', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_puntodeventacomprobante( txval as variant ) as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_puntodeventacomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_puntodeventacomprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_puntodeventanotadecredito( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_puntodeventanotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_puntodeventanotadecredito', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_qrtranfdebinidposnet( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_qrtranfdebinidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_qrtranfdebinidposnet', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_qrtransactionidposnet( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_qrtransactionidposnet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_qrtransactionidposnet', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_recargomonto( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_recargomonto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_recargomonto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_recargoporcentaje( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_recargoporcentaje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_recargoporcentaje', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_referenciaexterna( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_referenciaexterna', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_referenciaexterna', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_serial( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_serial', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_serial', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriealtafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriealtafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriebaja( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriebaja', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriebaja', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriemodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriemodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_serieorigen( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_serieorigen', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_serieorigen', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_simbolomonetario( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_simbolomonetario', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_simbolomonetario', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_telefonotitular( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_telefonotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_telefonotitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ticketicard( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ticketicard', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ticketicard', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ticketicardcl( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ticketicardcl', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ticketicardcl', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipocomprobante( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipocomprobante', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipocomprobante', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipocupon( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipocupon', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipocupon', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipodocumentotitular( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipodocumentotitular', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipodocumentotitular', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tiponotadecredito( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tiponotadecredito', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tiponotadecredito', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipotarjeta( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipotarjeta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipotarjeta', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ultimosdigitos( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ultimosdigitos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ultimosdigitos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuarioaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuarioaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuariomodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuariomodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_validacion( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_validacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_validacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_valor( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_valor', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_valor', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_zadsfw( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_zadsfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaranulacion() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaranulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarbasededatos() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarbasededatos', lcParametros )
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
	function validarclasedetarjeta() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarclasedetarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcliente() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcliente', lcParametros )
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
	function validaridcaja() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaridcaja', lcParametros )
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
	function validarnumerodecupon() as boolean                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarnumerodecupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarpagopoint() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarpagopoint', lcParametros )
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
	function validarserieorigen() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarserieorigen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarsimbolomonetario() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarsimbolomonetario', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validartipocupon() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validartipocupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validartipodecupon() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validartipodecupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarvalor() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarvalor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valor_access() as variant                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'valor_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'valor_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Valor ) = 'O' or isnull( this.Valor ) )					this.Valor = _Screen.zoo.instanciarentidad( 'Valor' )					this.Valor.lEsSubEntidad = .t.					this.enlazar( 'Valor.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Valor.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Valor.CODIGO # this.Valor_PK						this.Valor.CODIGO = this.Valor_PK					endif				endif			endif		endif		return this.Valor
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valor_pk_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'valor_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'valor_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Valor_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )		this.Valor_PK = lxVal		if this.Validar_Valor( lxVal, lxValOld )			This.Setear_Valor( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridobasededatos() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridobasededatos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoesretiroefectivo() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoesretiroefectivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofechabaja() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofechabaja', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofechacierredelote() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofechacierredelote', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofechacupon() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofechacupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwbasededatos() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwbasededatos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwesretiroefectivo() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwesretiroefectivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwpos() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwpos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwpuntodeventa() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwpuntodeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwserieorigen() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwserieorigen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridohorabaja() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridohorabaja', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridohoracierredelote() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridohoracierredelote', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridohoracupon() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridohoracupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonumerocierredelote() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonumerocierredelote', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonumerocupon() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonumerocupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonumerodecanje() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonumerodecanje', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopos() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopuntodeventa() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopuntodeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoqrtranfdebinidposnet() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoqrtranfdebinidposnet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoqrtransactionidposnet() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoqrtransactionidposnet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoserieorigen() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoserieorigen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotipocupon() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotipocupon', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarcontexto( tctipos as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tctiposlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'verificarcontexto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'verificarcontexto', lcParametros )			endif		endif		local llRetorno as boolean, i as Integer, lcLetra as string				if empty( tcTipos )			llRetorno = empty( this.cContexto )		else			tcTipos = upper( alltrim( tcTipos ) )			llRetorno = .f.			for i = 1 to len( tcTipos )				lcLetra = substr( tcTipos, i, 1 )				llRetorno = ( lcLetra $ this.cContexto ) or llRetorno				if llRetorno					exit				endif			endfor		endif				return llRetorno
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
	function verificarsielcuponsiguehuerfano( tccodigocupon as string ) as boolean                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccodigocupon

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificarsielcuponsiguehuerfano', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionaltafw_access() as string                                                                                                                                                                                                                 
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.VersionAltaFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionaltafw( lxVal )				this.Setear_Versionaltafw( lxVal )			EndIf		Else			This.Setear_Versionaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_access() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.VersionModificacionFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionmodificacionfw( lxVal )				this.Setear_Versionmodificacionfw( lxVal )			EndIf		Else			This.Setear_Versionmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'zadsfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'zadsfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Zadsfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Zadsfw( lxVal )				this.Setear_Zadsfw( lxVal )			EndIf		Else			This.Setear_Zadsfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'esclasenet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'esclasenet', lcParametros )			endif		endif		return "." $ tcClase
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenernombreclase( tcclase ) as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenernombreclase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenernombreclase', lcParametros )			endif		endif		Local lcRetorno as String, lcNombreApp as String		if upper( substr( alltrim( tcClase ), len( alltrim( tcClase ) ) - 1 ) ) = "UO"			if !this.lEsExe and this.BuscarClase( alltrim( tcClase ) + "UO.prg" )				lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			else				lcRetorno = tcClase			endif		else			if type( "_screen.zoo.app.cProyecto" ) = "C"				lcNombreApp = upper( _screen.zoo.app.cProyecto )			else				lcNombreApp = ""			endif							do case				case upper( left( tcClase, 4 ) ) = "ENT_"					lcRetorno = strtran( upper( tcClase ), "ENT_","" ,1 ,1 )				case upper( left( tcClase, 4 + len( lcNombreApp ) ) ) = "ENT" + lcNombreApp + "_"					lcRetorno = strtran( upper( tcClase ), "ENT" + lcNombreApp + "_", "", 1 ,1 )				case upper( left( tcClase, 11 ) ) = "DIN_ENTIDAD"					lcRetorno = strtran( tcClase, "Din_Entidad","" ,1 ,1 )				otherwise					lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			endcase		endif		return lcRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenersentenciacondesgloseparametros( tccomando as string, tcclase as string, tclibreria as string, tcapp as string, tnparametros as integer )                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5lnParametros = pcount()lxParam1 = tccomandolxParam2 = tcclaselxParam3 = tclibrerialxParam4 = tcapplxParam5 = tnparametroslcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenersentenciaCondesgloseparametros', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenersentenciaCondesgloseparametros', lcParametros )			endif		endif		local lcRetorno as string, lni as integer, lcLibreria as string, lcApp as string				if empty( tcLibreria )			lcLibreria = ""		else			lcLibreria = alltrim( tcLibreria )		endif				if empty( tcApp )			lcApp = ""		else			lcApp = alltrim( tcApp )		endif		if inlist( upper( tcComando ), "CLRCREATEOBJECT", "CLRINVOKESTATICMETHOD" )			lcRetorno = tcComando + "( '" + tcClase + "'"		else			if empty( tnParametros ) and empty( tcApp )				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "'"			else				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "', '" + tcApp + "'"			endif		endif				for lni = 1 to tnParametros			lcRetorno = lcRetorno + ", tvPar" + transform( lni )		endfor		lcRetorno = lcRetorno + " )"		return lcRetorno
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
	protected function agregarclaseacoleccion( tcclase as string ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'AgregarClaseAColeccion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'AgregarClaseAColeccion', lcParametros )			endif		endif		if !alltrim( upper( "mock" ) )$alltrim( upper( tcClase ) )			_screen.oClases.Add( tcClase, sys(2007, alltrim( lower( tcClase )),0,1))		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function consultarporclaveprimariasugerida() as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Consultarporclaveprimariasugerida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function creardatostarjetacustom() as object                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Creardatostarjetacustom', lcParametros )
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
	protected function establecertipotarjeta() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Establecertipotarjeta', lcParametros )
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
	protected function obtenercolecciondecuponeshuerfanos( tcfiltro as string ) as zoocoleccion of zoocoleccion.prg                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcfiltro

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercolecciondecuponeshuerfanos', lcParametros )
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
	protected function transformaralasignar( txval as variant ) as variant                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'CUPON' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Transformaralasignar', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Transformaralasignar', lcParametros )			endif		endif		return txVal
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