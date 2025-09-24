
define class Mock_ETMU220AF as MockBase of MockBase.prg

	cClase = 'ETMU220AF'

	
	CodigoCliente = ''                                                                                                                                                                                                                                        
	CodigoVendedor = ''                                                                                                                                                                                                                                       
	ComprobanteOrigen = ''                                                                                                                                                                                                                                    
	DireccionCliente = ''                                                                                                                                                                                                                                     
	FechaComprobanteOrigen = ''                                                                                                                                                                                                                               
	Iva1 = 0.00                                                                                                                                                                                                                                               
	Iva2 = 0.00                                                                                                                                                                                                                                               
	IvaContenido = 0                                                                                                                                                                                                                                          
	LetraComprobante = ''                                                                                                                                                                                                                                     
	Ley27743 = ""                                                                                                                                                                                                                                             
	LocalidadCliente = ''                                                                                                                                                                                                                                     
	MotivoDatosAdicionales = ''                                                                                                                                                                                                                               
	NombreCliente = ''                                                                                                                                                                                                                                        
	NombreVendedor = ''                                                                                                                                                                                                                                       
	NroDocumento = ''                                                                                                                                                                                                                                         
	Observaciones = ''                                                                                                                                                                                                                                        
	OtrosImpuestos = 0                                                                                                                                                                                                                                        
	ProcesosAdicionalesDev = .F.                                                                                                                                                                                                                              
	ResponsabilidadCliente = 0                                                                                                                                                                                                                                
	ResponsabilidadEmisor = 0                                                                                                                                                                                                                                 
	TelefonoCliente = ''                                                                                                                                                                                                                                      
	TipoComprobante = ''                                                                                                                                                                                                                                      
	TipoDocumento = ''                                                                                                                                                                                                                                        
	TotalComprob = 0                                                                                                                                                                                                                                          
	TotalUnidades = 0                                                                                                                                                                                                                                         
	cArchivoIni = ""                                                                                                                                                                                                                                          
	cArchivoSemaforo = "" &&addbs( _screen.zoo.cRutaInicial ) + "SemaforoCF.Zoo"       && ARREGLAR!!!                                                                                                                                                         
	cArticuloSenia = ""                                                                                                                                                                                                                                       
	cCaracterEspecial = ''                                                                                                                                                                                                                                    
	cCaracterEspecial=chr(47)                                                                                                                                                                                                                                 
	cCaracterImprimibleVacio = chr(127)                                                                                                                                                                                                                       
	cDetallePromo = ""                                                                                                                                                                                                                                        
	cDireccionIP = "127.0.0.1"                                                                                                                                                                                                                                
	cLeyendaFacturaAMonotributistas = "Receptor - Resp. Monotributo"                                                                                                                                                                                          
	cMensajeSinPapel = "Controlador Fiscal sin papel. Reemplace el papel"                                                                                                                                                                                     
	cMensajeSinPapelNoFiscal = "Controlador Fiscal sin papel. No se puede imprimir el comprobante no fiscal. Reemplace el papel"                                                                                                                              
	cTextoAjuste = "Ajustes por redondeo"                                                                                                                                                                                                                     
	cTituloItemExtraDespachos = "DESP. IMPORTACION:"                                                                                                                                                                                                          
	cTituloItemExtraDespachos = "DESPACHOS DE IMPORTACION:"                                                                                                                                                                                                   
	cVersion = ''                                                                                                                                                                                                                                             
	lBloqueoOk = .f.                                                                                                                                                                                                                                          
	lComprobanteParaCambios = .f.                                                                                                                                                                                                                             
	lComprobanteTestigo = .f.                                                                                                                                                                                                                                 
	lControlBucle = .T.                                                                                                                                                                                                                                       
	lControladorOK = .T.                                                                                                                                                                                                                                      
	lEnviarMensajesDeErrorGenericos = .t.                                                                                                                                                                                                                     
	lEsComprobanteFiscal = .t.                                                                                                                                                                                                                                
	lEsFacturacionAMonotributoConLetraA = .F.                                                                                                                                                                                                                 
	lEstoyImprimiendo = .F.                                                                                                                                                                                                                                   
	lFaltaCierreZ = .F.                                                                                                                                                                                                                                       
	lHayReferenciasEnPieDePagina = .F.                                                                                                                                                                                                                        
	lHaySenia = .f.                                                                                                                                                                                                                                           
	lImprimeCheque = .F.                                                                                                                                                                                                                                      
	lImprimirItemExtraParaDespachos = .f.                                                                                                                                                                                                                     
	lImprimirNombredelEmpleado = .F.                                                                                                                                                                                                                          
	lLeeDatosCheque = .F.                                                                                                                                                                                                                                     
	lMantenerBloqueo = .f.                                                                                                                                                                                                                                    
	lPagosAcumuladosPorTipo = .F.                                                                                                                                                                                                                             
	lPocoPapel = .f.                                                                                                                                                                                                                                          
	lSeguirIntentandoBloquear = .t.                                                                                                                                                                                                                           
	lSinPapel = .f.                                                                                                                                                                                                                                           
	lTieneDescuentoRecargoFinanciero = .f.                                                                                                                                                                                                                    
	nAcumuladoDevoluciones = 0                                                                                                                                                                                                                                
	nAcumuladoSenia = 0                                                                                                                                                                                                                                       
	nAnchoEncabezado = 40                                                                                                                                                                                                                                     
	nAnchoImpresion = 0                                                                                                                                                                                                                                       
	nAnchoPagina = 80                                                                                                                                                                                                                                         
	nAnchoTicket = 20                                                                                                                                                                                                                                         
	nAnchoTicket = 25                                                                                                                                                                                                                                         
	nAnchoTicket = 40                                                                                                                                                                                                                                         
	nAnchoTicketNoFiscal = 40                                                                                                                                                                                                                                 
	nCantidadLineasEncabezado = 0                                                                                                                                                                                                                             
	nCantidadLineasEncabezado = 8                                                                                                                                                                                                                             
	nCodigoAnterior = 0                                                                                                                                                                                                                                       
	nContadorBloqueos = 0                                                                                                                                                                                                                                     
	nHandle = 0                                                                                                                                                                                                                                               
	nHandlerTimer = 0                                                                                                                                                                                                                                         
	nIvaParametro = 0                                                                                                                                                                                                                                         
	nNivelesDeBloqueo = 0                                                                                                                                                                                                                                     
	nNivelesDeBloqueoPendientePorBloquearCF = 0                                                                                                                                                                                                               
	nNumeroSocket = 80                                                                                                                                                                                                                                        
	nPuerto = 0                                                                                                                                                                                                                                               
	nTamañoDeLaHoja = "10"                                                                                                                                                                                                                                    
	nVelocidadTransmision = 9600                                                                                                                                                                                                                              
	oAccesoDatos = Null                                                                                                                                                                                                                                       
	oCaracteristicas = Null                                                                                                                                                                                                                                   
	oComprobante = null                                                                                                                                                                                                                                       
	oDescuentos = Null                                                                                                                                                                                                                                        
	oDescuentosFin = Null                                                                                                                                                                                                                                     
	oError = Null                                                                                                                                                                                                                                             
	oFiscal = Null                                                                                                                                                                                                                                            
	oItemAuxiliarVacio = null                                                                                                                                                                                                                                 
	oPercepciones = Null                                                                                                                                                                                                                                      
	oPromociones = null                                                                                                                                                                                                                                       
	oPromocionesArticulosDetalle = null                                                                                                                                                                                                                       
	oRecargos = Null                                                                                                                                                                                                                                          
	oRecargosFin = Null                                                                                                                                                                                                                                       
	oZoo = null                                                                                                                                                                                                                                               
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	    function agregardescuentorecargogeneral( todatoscabecera as object ) as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregardescuentorecargogeneral', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function _configurarlogo( tcarchivologo as string ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcarchivologo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_configurarlogo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function _descifrarreporteselectronicos( tvdesde as variant, tvhasta as variant, tcrutaexportacion as string ) as boolean                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tvdesde
		lxParam2 = tvhasta
		lxParam3 = tcrutaexportacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_descifrarreporteselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function _realizardescargareporteselectronicos( tvdesde as variant, tvhasta as variant, tcrutaexportacion as string ) as boolean                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tvdesde
		lxParam2 = tvhasta
		lxParam3 = tcrutaexportacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_realizardescargareporteselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function abrircomprobantefiscal(todatoscabecera as object) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Abrircomprobantefiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function abrircomprobantenofiscal() as boolean                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Abrircomprobantenofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function abrirsemaforo() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Abrirsemaforo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function acumularpagoportipo( tocoleccion as object ) as zoocoleccion of zoocoleccion.prg                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocoleccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Acumularpagoportipo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarajustegeneral( todatoscabecera as object, tnmonto as float ) as boolean                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = todatoscabecera
		lxParam2 = tnmonto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarajustegeneral', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarcomentarios(todatoscabecera as object) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarcomentarios', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregardescuentorecargofinanciero( todatoscabecera as object ) as boolean                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregardescuentorecargofinanciero', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregardescuentorecargofinancierodll( todatoscabecera as object ) as boolean                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregardescuentorecargofinancierodll', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregardescuentorecargogeneral2( todatoscabecera as object ) as boolean                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregardescuentorecargogeneral2', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregardetallesdescripciondelpago( topago as object ) as string                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = topago

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregardetallesdescripciondelpago', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarinformacionpapelsinrepetir( tcmensaje as string, tnnumero as integer ) as boolean                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tnnumero

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarinformacionpapelsinrepetir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregaritem( tocoleccion as collection, tocoleccionadicional as collection, tocoleccionitemseniados as collection, tocoleccionadicionalitemseniados as collection, todatoscabecera as collection ) as boolean                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tocoleccionadicional
		lxParam3 = tocoleccionitemseniados
		lxParam4 = tocoleccionadicionalitemseniados
		lxParam5 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregaritem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarpago( tocoleccion as collection, tntotal as float ) as boolean                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tntotal

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarpago', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregarpercepciones() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Agregarpercepciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregartextofiscal( tocoleccion as collection ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocoleccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregartextofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agregartextonofiscal( tocoleccion as collection, tnanchoimpresionticket as integer ) as void                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tnanchoimpresionticket

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregartextonofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function armarstringcomprobanteorigen( todatoscabecera ) as string                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Armarstringcomprobanteorigen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function bloqueararchivosemaforo() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Bloqueararchivosemaforo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiarestadocontroladorfiscal( tnpuntodeventa as integer, tntipocomprobante as integer, tnnumerocomprobante as integer, tcguidcomprobante as string, tltieneerror as boolean ) as void                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tnpuntodeventa
		lxParam2 = tntipocomprobante
		lxParam3 = tnnumerocomprobante
		lxParam4 = tcguidcomprobante
		lxParam5 = tltieneerror

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cambiarestadocontroladorfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cancelarcf() as void                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cancelarcf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function capturarcontroladorfiscal() as boolean                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Capturarcontroladorfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargararraydeerrores()                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargararraydeerrores', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargarpropiedadescabecera( todatoscabecera as object ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargarpropiedadescabecera', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargarpropiedadesdescuento( todatoscabecera as object ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargarpropiedadesdescuento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargarpropiedadesdescuentofinanciero( todatoscabecera as object ) as void                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargarpropiedadesdescuentofinanciero', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargarpropiedadesrecargo( todatoscabecera as object ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargarpropiedadesrecargo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargarpropiedadesrecargofinanciero( todatoscabecera as object ) as void                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargarpropiedadesrecargofinanciero', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function carticulosenia_access() as variant                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Carticulosenia_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cerrarcomprobantefiscal() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cerrarcomprobantefiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cerrarcomprobantenofiscal() as boolean                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cerrarcomprobantenofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cerrarcomprobantenofiscalhomologado() as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cerrarcomprobantenofiscalhomologado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigodecomprobante() as character                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Codigodecomprobante', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigodedocumento() as string                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Codigodedocumento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigodeinicializacion( tcresponsabilidad as character ) as integer                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcresponsabilidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Codigodeinicializacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigoderesponsabilidad( tnresponsabilidad as integer ) as character                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnresponsabilidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Codigoderesponsabilidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function comandotextonofiscal(tctexto as string) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Comandotextonofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function compararencabezados() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Compararencabezados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function compararencabezados_y_pies() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Compararencabezados_y_pies', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function compararpiesdepagina() as boolean                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Compararpiesdepagina', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function comprobarestadocontroladorfiscal() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Comprobarestadocontroladorfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function comprobaryllenarparametros() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Comprobaryllenarparametros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function configurarentorno( ) as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Configurarentorno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function configurarlogo() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Configurarlogo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function configurarvelocidadtransmision() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Configurarvelocidadtransmision', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function consultarestadocontroladorfiscal( tnpuntodeventa as integer, tntipocomprobante as integer ) as boolean                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnpuntodeventa
		lxParam2 = tntipocomprobante

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Consultarestadocontroladorfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function controladorpreparado() as boolean                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Controladorpreparado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cortarpapelycerrarpuerto( todatoscabecera as object ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cortarpapelycerrarpuerto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function debevalidarequivalenciadevaloresafip() as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debevalidarequivalenciadevaloresafip', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function definirresponsabilidadcliente( tcsituacioncliente as string, tcsituacionmonotributo as string, tcsituacioninscriptos as string ) as string                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcsituacioncliente
		lxParam2 = tcsituacionmonotributo
		lxParam3 = tcsituacioninscriptos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Definirresponsabilidadcliente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function descifrarreporteselectronicos( tvdesde as variant, tvhasta as variant, tcrutaexportacion as string ) as boolean                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tvdesde
		lxParam2 = tvhasta
		lxParam3 = tcrutaexportacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Descifrarreporteselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function desplazarpies() as void                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Desplazarpies', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function despuesdecapturarsemaforo() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Despuesdecapturarsemaforo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function despuesdesoltarsemaforo() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Despuesdesoltarsemaforo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function emitiranulado( todatosimpresion as object ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatosimpresion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Emitiranulado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function errordedescargadereporteselectronicos() as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Errordedescargadereporteselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esbiendeuso() as string                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esbiendeuso', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eserrorconexion( tcmensaje as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcmensaje

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eserrorconexion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esfacturacionamonotributoconletraa( tcsituacioncliente as string, tcsituacionmonotributo  as string, tcletra as string ) as boolean                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcsituacioncliente
		lxParam2 = tcsituacionmonotributo
		lxParam3 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esfacturacionamonotributoconletraa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function evaluarreferencia( tcparametro as string ) as string                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcparametro

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Evaluarreferencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventopreguntarseguirintentandobloquear() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventopreguntarseguirintentandobloquear', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoquitarpreguntaseguirintentandobloquear() as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoquitarpreguntaseguirintentandobloquear', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function faltacierrez() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Faltacierrez', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaatexto(tdfecha as date) as string                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tdfecha

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Fechaatexto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function filtrarcaracteresespeciales( tctexto ) as string                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Filtrarcaracteresespeciales', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function finalizar() as void                                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Finalizar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function formarcodigodeautorizacion( tccomunicacion as character, tccodigoautorizacion as string ) as string                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tccomunicacion
		lxParam2 = tccodigoautorizacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Formarcodigodeautorizacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function franqueocheque( toitem as object, tocliente as object ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = toitem
		lxParam2 = tocliente

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Franqueocheque', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function guardarbuffer( tctipo as string, tcletra as string, tnnumero as integer ) as void                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tctipo
		lxParam2 = tcletra
		lxParam3 = tnnumero

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Guardarbuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitardescargareporteselectronicos() as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Habilitardescargareporteselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitarparametrosdeencabezadossegunjornadafiscal() as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Habilitarparametrosdeencabezadossegunjornadafiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hacercierrex() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hacercierrex', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hacercierrez() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hacercierrez', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hacerreportedeauditoria( tvdesde as variant, tvhasta as variant, tlglobal as boolean ) as boolean                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tvdesde
		lxParam2 = tvhasta
		lxParam3 = tlglobal

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Hacerreportedeauditoria', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimircomprobantefiscal( todatoscabecera as object, tocoleccionitems as collection, tocoleccionpagos as collection, tocoleccionadicional as collection, toimpresion as object ) as boolean                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = todatoscabecera
		lxParam2 = tocoleccionitems
		lxParam3 = tocoleccionpagos
		lxParam4 = tocoleccionadicional
		lxParam5 = toimpresion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimircomprobantefiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimircomprobantenofiscal( tocontenido as collection ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocontenido

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimircomprobantenofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimircomprobanteparacambios( tocontenido as collection ) as boolean                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocontenido

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimircomprobanteparacambios', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimircomprobantetestigo( tocontenido as collection ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocontenido

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimircomprobantetestigo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimirlineasadicionales( tocoleccionadicional as collection, toitem as object ) as void                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocoleccionadicional
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimirlineasadicionales', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimirordendecompra( tocontenido as collection) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocontenido

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimirordendecompra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimirtextofiscal(tctexto as string) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimirtextofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimirticketadicional( tocontenido as collection) as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocontenido

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimirticketadicional', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimirvoucher( todatos as object ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimirvoucher', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimirvoucherdeprueba() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Imprimirvoucherdeprueba', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function informarerroresporpapel() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Informarerroresporpapel', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function informarerrorestablecercomunicacioncf() as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Informarerrorestablecercomunicacioncf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inicializar() as boolean                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Inicializar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function iniciarformularioofiscal()                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Iniciarformularioofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inittardio() as void                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Inittardio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function intentarbloquearcontroladorcanceladoporusuario() as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Intentarbloquearcontroladorcanceladoporusuario', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function limprimecheque_access() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limprimecheque_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lleedatoscheque_access() as boolean                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Lleedatoscheque_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function loguearerror( toerror as object ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toerror

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Loguearerror', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mantenerbloqueo() as void                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Mantenerbloqueo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nohayerrores( tlllamohacercierrez as boolean ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlllamohacercierrez

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Nohayerrores', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerbuffer( tctipo as string, tcletra as string ) as integer                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tctipo
		lxParam2 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerbuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercantidadmaximadepercepciones() as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercantidadmaximadepercepciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercodigoderetorno() as integer                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercodigoderetorno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdatosinicializacion() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdatosinicializacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdescripcionderetorno() as string                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdescripcionderetorno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdescripciongenericatipovaloragrupado( tntipo as integer, tncantidad as integer) as string                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tntipo
		lxParam2 = tncantidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerdescripciongenericatipovaloragrupado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerencabezado(tnlinea as integer) as string                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnlinea

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerencabezado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerencabezados() as object                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerencabezados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenererrorescf( tnpuntodeventa as integer , tlsolodeldia as boolean ) as zoocoleccion of zoocoleccion.prg                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnpuntodeventa
		lxParam2 = tlsolodeldia

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenererrorescf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerfecha() as date                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerfecha', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerfechahora() as datetime                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerfechahora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerguiddecomprobanteconerrorcf( tnpuntodeventa as integer, tntipocomprobante as integer ) as integer                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnpuntodeventa
		lxParam2 = tntipocomprobante

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerguiddecomprobanteconerrorcf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerinformacioncheque() as string                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerinformacioncheque', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerlineasadicionalesaimprimir( tocoleccionadicional as collection , toitem as object) as void                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocoleccionadicional
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerlineasadicionalesaimprimir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenermensajesugerenciaerrordeconexion( tcmensaje as string ) as string                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcmensaje

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenermensajesugerenciaerrordeconexion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenernombreeventosadisparar() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombreeventosadisparar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenernumerodecomprobanteconerrorcf( tnpuntodeventa as integer, tntipocomprobante as integer ) as integer                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnpuntodeventa
		lxParam2 = tntipocomprobante

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenernumerodecomprobanteconerrorcf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerpie(tnlinea as integer) as string                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnlinea

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerpie', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerpies() as object                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerpies', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerproximovaloraagrupar( tntipovaloractual as integer ) as integer                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tntipovaloractual

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerproximovaloraagrupar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumcai() as string                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerultimonumcai', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumcierrez() as string                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerultimonumcierrez', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumfactura( tcletra as string ) as integer                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerultimonumfactura', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumfacturabuffer( tcletra as string ) as integer                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerultimonumfacturabuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumnotacredito( tcletra as string ) as integer                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerultimonumnotacredito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumnotacreditobuffer( tcletra as string ) as integer                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerultimonumnotacreditobuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumnotadebito( tcletra as string ) as integer                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerultimonumnotadebito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerultimonumnotadebitobuffer( tcletra as string ) as integer                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerultimonumnotadebitobuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenervectorestadoerrorcf( tchexaerror, tctipo, laerror ) as void                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tchexaerror
		lxParam2 = tctipo
		lxParam3 = laerror

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenervectorestadoerrorcf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocaracteristicas_access() as variant                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ocaracteristicas_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocomprobante_access() as object                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ocomprobante_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ofiscal_access() as object                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ofiscal_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function parsearnumerocomprobanteorigen( tccomprobanteorigen ) as string                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccomprobanteorigen

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Parsearnumerocomprobanteorigen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function pedirstatus() as void                                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Pedirstatus', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function permitemodificartickets() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Permitemodificartickets', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function permitereimpresiondecomprobantes() as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Permitereimpresiondecomprobantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function realizardescargareporteselectronicos( tvdesde as variant, tvhasta as variant, tcrutaexportacion as string ) as boolean                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tvdesde
		lxParam2 = tvhasta
		lxParam3 = tcrutaexportacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Realizardescargareporteselectronicos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function reemplazarcaracterñ( tctexto as string, tccaracter as string ) as string                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tctexto
		lxParam2 = tccaracter

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Reemplazarcaracterñ', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function reimprimiruncomprobantefiscal( tctipocomprobante as string, tcletra as character, tnnumero as integer ) as boolean                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tctipocomprobante
		lxParam2 = tcletra
		lxParam3 = tnnumero

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Reimprimiruncomprobantefiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restariva( tnprecio as float, tniva as float ) as float                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnprecio
		lxParam2 = tniva

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Restariva', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restarvaledecambionegativo( topago as object, tocoleccion as collection ) as boolean                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = topago
		lxParam2 = tocoleccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Restarvaledecambionegativo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurarencabezados_y_pies() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurarencabezados_y_pies', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurarencabezadosporfacturaamonotributista() as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurarencabezadosporfacturaamonotributista', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function semaforobloqueado() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Semaforobloqueado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function sequedosinpapel() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Sequedosinpapel', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function sesuperacantidaddepercepcionespermitidas( tncantidad as integer ) as boolean                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tncantidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Sesuperacantidaddepercepcionespermitidas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearanchoimpresion( tnanchoimpresionticket as integer ) as integer                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnanchoimpresionticket

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearanchoimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearconfiguracionindividual() as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearconfiguracionindividual', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteardatoscliente() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Seteardatoscliente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteardomiciliocomercial( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Seteardomiciliocomercial', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteardomiciliofiscal( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Seteardomiciliofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearencabezado( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearencabezado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearencabezados() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearencabezados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearencabezadosypiesdepagina() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearencabezadosypiesdepagina', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearencabezadosypiesespecificos( tccomprobante as string ) as void                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccomprobante

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearencabezadosypiesespecificos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearfechahora( tdfecha as date, tchora as string ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tdfecha
		lxParam2 = tchora

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearfechahora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearingresosbrutos( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearingresosbrutos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearinicioactividades(tctexto as string) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearinicioactividades', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearleyendaporfacturacionamonotributo() as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearleyendaporfacturacionamonotributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearleyendascomerciales( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearleyendascomerciales', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearlineasfantasia( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearlineasfantasia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearpie( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearpie', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearpies( tlreferencia as boolean, tlblanquear as boolean ) as boolean                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tlreferencia
		lxParam2 = tlblanquear

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearpies', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function soltarcontroladorfiscal() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Soltarcontroladorfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienedescuentosrecargosfinancieros( todatoscabecera as object ) as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Tienedescuentosrecargosfinancieros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipodeoperacion( tctipooperacion as string ) as string                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipooperacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Tipodeoperacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validartotalcontracontrolador( todatoscabecera as object ) as boolean                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatoscabecera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validartotalcontracontrolador', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificadatosdeconfiguracion() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificadatosdeconfiguracion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificaraplicarrecargoporcambio() as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificaraplicarrecargoporcambio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarbloqueo() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificarbloqueo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarcuitobligatorio() as boolean                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificarcuitobligatorio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarestado() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificarestado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarexistenciapromociones( topromociones as object ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = topromociones

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificarexistenciapromociones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarpercepcionesenmodelosantiguos() as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificarpercepcionesenmodelosantiguos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarstatus ( tchexaerror as string, tctipo as string, tlllamohacercierrez as boolean ) as boolean                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tchexaerror
		lxParam2 = tctipo
		lxParam3 = tlllamohacercierrez

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificarstatus', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function veriricarsicontroladorfiscaltuvoproblemas( tntipocomprobante as integer ) as boolean                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tntipocomprobante

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Veriricarsicontroladorfiscaltuvoproblemas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _agregaritem( tocoleccion as collection, tocoleccionadicional as collection, todatoscabecera as collection, tlseniados as boolean  ) as boolean                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tocoleccionadicional
		lxParam3 = todatoscabecera
		lxParam4 = tlseniados

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_agregaritem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _agregaritems( tocoleccion as collection, tocoleccionadicional as collection, todatoscabecera as collection, tlseniados as boolean, tlpositivos as boolean ) as boolean                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tocoleccionadicional
		lxParam3 = todatoscabecera
		lxParam4 = tlseniados
		lxParam5 = tlpositivos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_agregaritems', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _agregaritemsajustes( tocoleccion as collection, tlpositivos as boolean ) as boolean                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tlpositivos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_agregaritemsajustes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _agregartextofiscal(tocoleccion as collection) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocoleccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_agregartextofiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _controladorpreparado() as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_controladorpreparado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _enviaritemsextra( toitemextra as object ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toitemextra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_enviaritemsextra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _hacercierrex() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_hacercierrex', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _hacercierrez() as boolan                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_hacercierrez', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _hacerreportedeauditoria( tvdesde as variant, tvhasta as variant, tlglobal as boolean ) as boolean                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tvdesde
		lxParam2 = tvhasta
		lxParam3 = tlglobal

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_hacerreportedeauditoria', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _imprimiritem( toitem as object, tccodigoitem as string, tnprecio as float, tndescuento as float, tocoleccionadicional as collection ) as boolean                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = toitem
		lxParam2 = tccodigoitem
		lxParam3 = tnprecio
		lxParam4 = tndescuento
		lxParam5 = tocoleccionadicional

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_imprimiritem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _imprimirvoucher( todatos as object ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_imprimirvoucher', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _imprimirvoucherdeprueba() as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_imprimirvoucherdeprueba', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _obtenerfecha() as date                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_obtenerfecha', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _obtenerfechahora() as datetime                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_obtenerfechahora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _obtenerultimonumcierrez() as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_obtenerultimonumcierrez', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _obtenerultimonumfactura( tcletra as string ) as integer                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_obtenerultimonumfactura', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _obtenerultimonumnotacredito( tcletra as string ) as integer                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_obtenerultimonumnotacredito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _obtenerultimonumnotadebito( tcletra as string ) as integer                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcletra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_obtenerultimonumnotadebito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _pedirstatus() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_pedirstatus', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function _setearfechahora( tdfecha as date, tchora as string ) as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tdfecha
		lxParam2 = tchora

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( '_setearfechahora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function acumularajustes( tocoleccionajustes as zoocoleccion of zoocoleccion.prg ) as zoocoleccion of zoocoleccion.prg                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocoleccionajustes

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Acumularajustes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function acumularmontovalor( tocoleccion as object, tntipovalor as integer) as void                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tntipovalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Acumularmontovalor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function agregaritemsextra( todatoscabecera as object, tocoleccion as object ) as boolean                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = todatoscabecera
		lxParam2 = tocoleccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregaritemsextra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function agregarseteospreviosaimpresionfiscal() as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Agregarseteospreviosaimpresionfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function armarcolecciontextosdespacho( tctituloitemextra as string, tctextoitemextra as string ) as object                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tctituloitemextra
		lxParam2 = tctextoitemextra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Armarcolecciontextosdespacho', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function asignardatosaparametros() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Asignardatosaparametros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function cargarcaracteristicas() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargarcaracteristicas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function completardescripciondelpagocontarjeta( topago as object ) as string                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = topago

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Completardescripciondelpagocontarjeta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function crearexcepcion( txerror as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txerror

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Crearexcepcion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function deshacerbindeo( tlbloqueook as boolean ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlbloqueook

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Deshacerbindeo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function destruirobjetosglobales as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Destruirobjetosglobales As Void', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function espalabrareservada( tcpalabra as string ) as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcpalabra

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Espalabrareservada', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function esreferencia( tcparametro as string ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcparametro

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esreferencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function evaluarimpresionitemsextra( todatoscabecera as collection, tocoleccion as collection ) as boolean                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = todatoscabecera
		lxParam2 = tocoleccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Evaluarimpresionitemsextra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function evaluarsiprecioincluyeimpuestos() as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Evaluarsiprecioincluyeimpuestos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function existepuntodeventacomprobanteenentidad( tnpuntodeventa as integer, tntipocomprobante as integer, toestadocf as object) as boolean                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tnpuntodeventa
		lxParam2 = tntipocomprobante
		lxParam3 = toestadocf

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Existepuntodeventacomprobanteenentidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function formatearmensajeerrorconexion( tcmensaje as string ) as void                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcmensaje

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Formatearmensajeerrorconexion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function generararchivosemaforo() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generararchivosemaforo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function hacercierre( tctipodecierre as string ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipodecierre

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Hacercierre', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function imprimircomprobantenofiscalespecifico( tocontenido as collection, tccomprobante as string ) as boolean                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocontenido
		lxParam2 = tccomprobante

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimircomprobantenofiscalespecifico', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function imprimirdatosadicionalesdevolucion( tocoleccion as collection, tocoleccionadicional as collection, todatoscabecera as collection, tlseniados as boolean, tlpositivos as boolean ) as boolean                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tocoleccion
		lxParam2 = tocoleccionadicional
		lxParam3 = todatoscabecera
		lxParam4 = tlseniados
		lxParam5 = tlpositivos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimirdatosadicionalesdevolucion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function imprimirtextoextra4( tctexto as string, toitem as object ) as boolean                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tctexto
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Imprimirtextoextra4', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercaberavacia( todatosimpresion as object ) as object                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todatosimpresion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercaberavacia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercodigoitem( toitem as object ) as string                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercodigoitem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercomprobanteorigen1() as string                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercomprobanteorigen1', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercomprobanteorigen2() as string                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercomprobanteorigen2', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerdescripciondelpagoconmonedaextranjera( topago as object, tcdescripcion as string ) as string                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = topago
		lxParam2 = tcdescripcion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerdescripciondelpagoconmonedaextranjera', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerdescuentoitem( toitem as object, tlseniados as boolean ) as float                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = toitem
		lxParam2 = tlseniados

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerdescuentoitem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerentidadestadocontroladorfiscal() as object                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerentidadestadocontroladorfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenernumerodecomprobantedesdeini( tcbuffer as string ) as void                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcbuffer

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenernumerodecomprobantedesdeini', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerporcentajebaseimponiblecomprobantea( tntasaefectiva as float ) as float                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tntasaefectiva

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerporcentajebaseimponiblecomprobantea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerporcentajebaseimponiblecomprobanteb( tnporcentajeiva as float, tntasaefectiva as floar) as float                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnporcentajeiva
		lxParam2 = tntasaefectiva

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerporcentajebaseimponiblecomprobanteb', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerprecioitem( toitem as object, tlseniados as boolean ) as float                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = toitem
		lxParam2 = tlseniados

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerprecioitem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenersubtotal() as string                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenersubtotal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertextocoleccionadicional( tocoleccionadicional as collection, tnposicion as integer, loitem as object ) as string                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tocoleccionadicional
		lxParam2 = tnposicion
		lxParam3 = loitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenertextocoleccionadicional', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertextoextra4( tlesitemventa, toitem as object ) as string                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tlesitemventa
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenertextoextra4', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertotaldescuentos() as number                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertotaldescuentos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertotaldescuentosfinancieros() as number                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertotaldescuentosfinancieros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertotalimpuestos() as number                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertotalimpuestos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertotalrecargos() as number                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertotalrecargos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertotalrecargosfinancieros() as number                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertotalrecargosfinancieros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function parametrosvacios() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Parametrosvacios', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function porcentajebaseimponiblecomprobantea( tnneto as float, tnimpuestointerno as float ) as float                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnneto
		lxParam2 = tnimpuestointerno

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Porcentajebaseimponiblecomprobantea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function porcentajebaseimponiblecomprobanteb( tnneto as float, tnmontoiva as float, tnimpuestointerno as float ) as float                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tnneto
		lxParam2 = tnmontoiva
		lxParam3 = tnimpuestointerno

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Porcentajebaseimponiblecomprobanteb', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function procesosadicionales( tocoleccionadicional ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocoleccionadicional

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Procesosadicionales', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function reacomodartextosextra( tctexto1 as string, tctexto2 as string, tctexto3 as string, tctexto4 as string ) as void                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tctexto1
		lxParam2 = tctexto2
		lxParam3 = tctexto3
		lxParam4 = tctexto4

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Reacomodartextosextra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function seteardomiciliocomercialinterno( tnlinea as integer, tctexto as string ) as boolean                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnlinea
		lxParam2 = tctexto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Seteardomiciliocomercialinterno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function seteosparticulares() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Seteosparticulares', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function trasnformarnumeroastringvalidoparaepson( tnvalor as float, tnentero as integer, tndecimal as integer )  as string                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tnvalor
		lxParam2 = tnentero
		lxParam3 = tndecimal

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Trasnformarnumeroastringvalidoparaepson', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function vericarreferenciasenpiedepagina() as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Vericarreferenciasenpiedepagina', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function verificarerroresdeimpresiondeitem( tlprocesoexitoso as boolean ) as void                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlprocesoexitoso

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificarerroresdeimpresiondeitem', lcParametros )
	EndFunc


enddefine