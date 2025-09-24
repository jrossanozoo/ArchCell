
define class Mock_disenoimpresion as MockBase of MockBase.prg

	lNuevo = .f. 
	lEdicion = .f. 
	lDestroy = .f. 
	cContexto = '' 

	cClase = 'disenoimpresion'

	
	Advierte = 0                                                                                                                                                                                                                                              
	AplicaLimite = 0                                                                                                                                                                                                                                          
	Areas = null                                                                                                                                                                                                                                              
	Atributos = null                                                                                                                                                                                                                                          
	BASEDEDATOSALTAFW = ""                                                                                                                                                                                                                                    
	BASEDEDATOSMODIFICACIONFW = ""                                                                                                                                                                                                                            
	BLOQUEARREGISTRO = .F.                                                                                                                                                                                                                                    
	CamposEquivalenciaLince = ""                                                                                                                                                                                                                              
	CantidadCopias = 0                                                                                                                                                                                                                                        
	Codigo = ""                                                                                                                                                                                                                                               
	Columnas = 0                                                                                                                                                                                                                                              
	Condicion = ""                                                                                                                                                                                                                                            
	ConfirmaPdf = 0                                                                                                                                                                                                                                           
	DefaultImpresion = .F.                                                                                                                                                                                                                                    
	Descripcion = ""                                                                                                                                                                                                                                          
	ESTADOTRANSFERENCIA = ""                                                                                                                                                                                                                                  
	Entidad = ""                                                                                                                                                                                                                                              
	Entidades = null                                                                                                                                                                                                                                          
	EsPrevisualizacion = .t.                                                                                                                                                                                                                                  
	Estilo = null                                                                                                                                                                                                                                             
	Estilo_PK = ""                                                                                                                                                                                                                                            
	FECHAALTAFW = ctod( '  /  /    ' )                                                                                                                                                                                                                        
	FECHAEXPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAIMPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )                                                                                                                                                                                                                
	FECHATRANSFERENCIA = ctod( '  /  /    ' )                                                                                                                                                                                                                 
	FechaAltaFW = {}                                                                                                                                                                                                                                          
	FechaModificacionFW = {}                                                                                                                                                                                                                                  
	HORAALTAFW = ""                                                                                                                                                                                                                                           
	HORAEXPO = ""                                                                                                                                                                                                                                             
	HORAIMPO = ""                                                                                                                                                                                                                                             
	HORAMODIFICACIONFW = ""                                                                                                                                                                                                                                   
	HabilitaSalidaAImpresora = .F.                                                                                                                                                                                                                            
	HabilitaSalidaAPdf = .F.                                                                                                                                                                                                                                  
	ImpresionAutomatica = .F.                                                                                                                                                                                                                                 
	MargenDer = 0                                                                                                                                                                                                                                             
	MargenInf = 0                                                                                                                                                                                                                                             
	MargenIzq = 0                                                                                                                                                                                                                                             
	MargenSup = 0                                                                                                                                                                                                                                             
	Observacion = ""                                                                                                                                                                                                                                          
	OpcionDeSalida = 0                                                                                                                                                                                                                                        
	PdfAutomatico = .F.                                                                                                                                                                                                                                       
	Puerto = ""                                                                                                                                                                                                                                               
	RetornoExtension = .t.                                                                                                                                                                                                                                    
	RutaPdf = ""                                                                                                                                                                                                                                              
	SERIEALTAFW = ""                                                                                                                                                                                                                                          
	SERIEMODIFICACIONFW = ""                                                                                                                                                                                                                                  
	Segundos = 0                                                                                                                                                                                                                                              
	Series = ""                                                                                                                                                                                                                                               
	SolicitarConfirmacion = .F.                                                                                                                                                                                                                               
	Sugiere = 0                                                                                                                                                                                                                                               
	TIMESTAMP = 0                                                                                                                                                                                                                                             
	TwipsPorMilimetro = 0                                                                                                                                                                                                                                     
	USUARIOALTAFW = ""                                                                                                                                                                                                                                        
	USUARIOMODIFICACIONFW = ""                                                                                                                                                                                                                                
	VERSIONALTAFW = ""                                                                                                                                                                                                                                        
	VERSIONMODIFICACIONFW = ""                                                                                                                                                                                                                                
	ZADSFW = ""                                                                                                                                                                                                                                               
	cAtributoAAuditar = ""                                                                                                                                                                                                                                    
	cAtributoPK = ""                                                                                                                                                                                                                                          
	cAtributoVendedor = ''                                                                                                                                                                                                                                    
	cCaracteres = ""                                                                                                                                                                                                                                          
	cCodigoPrevioGuardarComo = ""                                                                                                                                                                                                                             
	cContexto = ""                                                                                                                                                                                                                                            
	cDescripcion =  "Diseño de salida"                                                                                                                                                                                                                        
	cDescripcionSingular = ""                                                                                                                                                                                                                                 
	cEtiqueta = ''                                                                                                                                                                                                                                            
	cEvento = ""                                                                                                                                                                                                                                              
	cFormatoFechaNet = ""                                                                                                                                                                                                                                     
	cIdentificadorConexion = ""                                                                                                                                                                                                                               
	cNombre = ""                                                                                                                                                                                                                                              
	cNombre = 'DISENOIMPRESION'                                                                                                                                                                                                                               
	cPrefijoImportar = ""                                                                                                                                                                                                                                     
	cPrefijoRecibir = ""                                                                                                                                                                                                                                      
	cUsuarioQueAutorizoSeguridad = ""                                                                                                                                                                                                                         
	lAccionAutomaticaTipoAntes = .F.                                                                                                                                                                                                                          
	lActivando = .f.                                                                                                                                                                                                                                          
	lActualizaRecepcion = .T.                                                                                                                                                                                                                                 
	lActualizarAltoEtiqueta = .f.                                                                                                                                                                                                                             
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
	lEsGuardarComo = .F.                                                                                                                                                                                                                                      
	lEsSubEntidad = .f.                                                                                                                                                                                                                                       
	lEstaSeteandoValorSugerido = .f.                                                                                                                                                                                                                          
	lHabilitaEnviarAlGrabar = .f.                                                                                                                                                                                                                             
	lHabilitarAdvierte = .T.                                                                                                                                                                                                                                  
	lHabilitarAplicaLimite = .T.                                                                                                                                                                                                                              
	lHabilitarCantidadCopias = .T.                                                                                                                                                                                                                            
	lHabilitarColumnas = .T.                                                                                                                                                                                                                                  
	lHabilitarConfirmaPdf = .T.                                                                                                                                                                                                                               
	lHabilitarImpresionAutomatica = .T.                                                                                                                                                                                                                       
	lHabilitarOpcionDeSalida = .T.                                                                                                                                                                                                                            
	lHabilitarPdfAutomatico = .T.                                                                                                                                                                                                                             
	lHabilitarPuerto = .T.                                                                                                                                                                                                                                    
	lHabilitarRutaPdf = .T.                                                                                                                                                                                                                                   
	lHabilitarSegundos = .T.                                                                                                                                                                                                                                  
	lHabilitarSugiere = .T.                                                                                                                                                                                                                                   
	lIgnorarCamposObligatoriosDefinidosPorUsuario = .F.                                                                                                                                                                                                       
	lIgnorarClaveprimariaEnRecepcionBD = .f.                                                                                                                                                                                                                  
	lImprimeContinuo = .F.                                                                                                                                                                                                                                    
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
	lPreguntarActualizarAlto = .t.                                                                                                                                                                                                                            
	lProcesando = .F.                                                                                                                                                                                                                                         
	lReAsignarPk_Con_CC = .F.                                                                                                                                                                                                                                 
	lTieneAccionesAutomaticas = .f.                                                                                                                                                                                                                           
	lTieneDiseñosParaEnviarMail = .t.                                                                                                                                                                                                                         
	lTieneVendedorComoClaveForanea = .f.                                                                                                                                                                                                                      
	lWHEliminar = .f.                                                                                                                                                                                                                                         
	lWHIngresar = .f.                                                                                                                                                                                                                                         
	lWHModificar = .f.                                                                                                                                                                                                                                        
	oAD = null                                                                                                                                                                                                                                                
	oAtributosAnulacion = null                                                                                                                                                                                                                                
	oAtributosAuditoria = null                                                                                                                                                                                                                                
	oAtributosConEdicionRestringida= null                                                                                                                                                                                                                     
	oColAtributosObligatoriosDefinidosPorUsuario = null                                                                                                                                                                                                       
	oColaboradorDeDetalles = null                                                                                                                                                                                                                             
	oColeccionVS = null                                                                                                                                                                                                                                       
	oColeccionVSFW = null                                                                                                                                                                                                                                     
	oCompDisenoImpresion = null                                                                                                                                                                                                                               
	oComportamientoCodigoSugerido = null                                                                                                                                                                                                                      
	oDibujanteImpresion = null                                                                                                                                                                                                                                
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
	function advierte_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'advierte_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'advierte_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Advierte		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Advierte( lxVal )				if ( this.lHabilitarAdvierte or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Advierte( lxVal )				else					this.Advierte = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Advierte)" )				endif			EndIf		Else			This.Setear_Advierte( lxVal )		EndIf		dodefault( lxVal )
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
	function aplicalimite_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'aplicalimite_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'aplicalimite_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Aplicalimite		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Aplicalimite( lxVal )				if ( this.lHabilitarAplicalimite or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Aplicalimite( lxVal )				else					this.Aplicalimite = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Aplicalimite)" )				endif			EndIf		Else			This.Setear_Aplicalimite( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function areas_access() as variant                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'areas_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'areas_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Areas ) = 'O' or isnull( this.Areas ) )			this.Areas = this.crearobjeto( 'DetalleDisenoimpresionAreas' )			this.Areas.inicializar()			this.enlazar( 'Areas.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Areas.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Areas, 'CambioSumarizado', this, 'CambiosDetalleAreas', 1)			this.enlazar( 'Areas.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Areas.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Areas
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
	function atributos_access() as variant                                                                                                                                                                                                                    
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'atributos_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'atributos_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Atributos ) = 'O' or isnull( this.Atributos ) )			this.Atributos = this.crearobjeto( 'DetalleDisenoimpresionAtributos' )			this.Atributos.inicializar()			this.enlazar( 'Atributos.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Atributos.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Atributos, 'CambioSumarizado', this, 'CambiosDetalleAtributos', 1)			this.enlazar( 'Atributos.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Atributos.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Atributos
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_access() as date                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosAltaFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosaltafw( lxVal )				this.Setear_Basededatosaltafw( lxVal )			EndIf		Else			This.Setear_Basededatosaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_access() as date                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosModificacionFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosmodificacionfw( lxVal )				this.Setear_Basededatosmodificacionfw( lxVal )			EndIf		Else			This.Setear_Basededatosmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
	function bloquearregistro_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'bloquearregistro_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'bloquearregistro_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Bloquearregistro		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Bloquearregistro( lxVal )				this.Setear_Bloquearregistro( lxVal )			EndIf		Else			This.Setear_Bloquearregistro( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'BuscarClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'BuscarClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.		this.Crear_oClases()				if _screen.oClases.GetKey( sys(2007, alltrim( lower( tcClase )),0,1)) > 0			llRetorno = .t.		else			if this.ExisteArchivoClase( tcClase )				this.AgregarClaseAColeccion( tcClase )				llRetorno = .t.			endif		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetalleareas() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetalleareas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetalleatributos() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetalleatributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetalleentidades() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetalleentidades', lcParametros )
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
	function cantidadcopias_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'cantidadcopias_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'cantidadcopias_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Cantidadcopias		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Cantidadcopias( lxVal )				if ( this.lHabilitarCantidadcopias or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Cantidadcopias( lxVal )				else					this.Cantidadcopias = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Cantidadcopias)" )				endif			EndIf		Else			This.Setear_Cantidadcopias( lxVal )		EndIf		dodefault( lxVal )
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
	function codigo_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigo_assign', lcParametros )			endif		endif		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean		with this			llEdicion = .EsEdicion()			if !this.lPermiteMinusculasPK				try					txVal = upper( txVal )				Catch				Endtry			endif			if .lLimpiando or .lCargando				.Codigo = .TransformarAlAsignar( txVal )			else				if llEdicion				else					llNuevo = .EsNuevo()					.Codigo = .TransformarAlAsignar( txVal )					if empty( txVal ) and !llNuevo						.Limpiar()					else						if llNuevo							if .ValidarIngreso( txVal, llNuevo )							else								goServicios.Errores.LevantarExcepcion( 'Caracter inválido en el código.' )							endif						endif						llConsulta = .oAD.ConsultarPorClavePrimaria()						do case							case !llNuevo and llConsulta								.Cargar()							case !llNuevo and !llConsulta								.Limpiar()								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )							case llNuevo and llConsulta								.Codigo = []								goServicios.Errores.LevantarExcepcion( 'El código ' + alltrim( transform( txVal ) ) + ' ya existe.' )						endcase					endif				endif			endif		endwith
	EndFunc

	*-----------------------------------------------------------------------------------------
	function columnas_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'columnas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'columnas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Columnas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Columnas( lxVal )				if ( this.lHabilitarColumnas or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Columnas( lxVal )				else					this.Columnas = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Columnas)" )				endif			EndIf		Else			This.Setear_Columnas( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function condicion_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'condicion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'condicion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Condicion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Condicion( lxVal )				this.Setear_Condicion( lxVal )			EndIf		Else			This.Setear_Condicion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function condicionesparaelenviodeemailalimportar() as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Condicionesparaelenviodeemailalimportar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function confirmapdf_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'confirmapdf_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'confirmapdf_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Confirmapdf		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Confirmapdf( lxVal )				if ( this.lHabilitarConfirmapdf or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Confirmapdf( lxVal )				else					this.Confirmapdf = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Confirmapdf)" )				endif			EndIf		Else			This.Setear_Confirmapdf( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Crear_oClases', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Crear_oClases', lcParametros )			endif		endif		if !pemstatus( _screen, "oClases", 5 )				_screen.AddObject( "oClases", "Collection" )		endif				if !vartype( _screen.oClases ) = 'O' and isnull( _screen.oClases )			_screen.oClases = newobject( "Collection" )		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crearobjeto( tcclase as string, tclibreria as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant )                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9, lxParam10lnParametros = pcount()lxParam1 = tcclaselxParam2 = tclibrerialxParam3 = tvpar1lxParam4 = tvpar2lxParam5 = tvpar3lxParam6 = tvpar4lxParam7 = tvpar5lxParam8 = tvpar6lxParam9 = tvpar7lxParam10 = tvpar8lcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'crearobjeto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'crearobjeto', lcParametros )			endif		endif		Local loReturn As Object, lnParametrosReales As Integer, lcClase as String, lcConstructor as string, lcComando as String, ;			lnParamAux as Integer, lcClase as String, lcLibreria as String , lcSetProcedure as String,;			loErrorBase as Exception, loEx as Exception, loRetorno as object, lcConstructor as String, lcProcedure as String,;			lcSetClassLib as String, lcSet as String, loMock as Object, lcClaseProxy as String					loReturn = Null		lcLibreria = tcLibreria		lcClaseProxy = ""				*-------------------------------------------------------------------		if pemstatus(_screen, "Mocks", 5 ) and vartype( _Screen.Mocks ) = "O"				*Instanciación de Mocks			*Objeto solo instanciado en DESARROLLO.			if _screen.Mocks.lUtilizarMockV2 and this.buscarClase( forceext( "MockV2_" + tcClase, "prg" ) )				lcClase = "MockV2_" + tcClase			else				if _screen.Mocks.lUtilizarMockV1					local lnItem as Integer					lcClase = this.ObtenerNombreClase( tcClase )					lnItem = _Screen.Mocks.BuscarMock( lcClase )										if !empty( lnItem )						loMock = _Screen.Mocks.Item[lnItem]						loMock.lUsado = .t.						lcClase = loMock.cNombreClaseMock												if empty( loMock.cNombrePrgMock )							lcLibreria = iif( empty( lcLibreria ), "", "Mock_" + justfname( lcLibreria ) )						else							lcLibreria = loMock.cNombrePrgMock						endif					else						lcClase = tcClase					endif				else					lcClase = tcClase				endif			endif		else			lcClase = tcClase		endif		*-------------------------------------------------------------------		If empty( lcLibreria )			lcLibreria = forceext( lcClase, "prg" )		endif				If Pcount() > 1			lnParamAux = 2		Else			lnParamAux = 1		EndIf		lnParametrosReales = Pcount() - lnParamAux			loRetorno = null				try			if this.EsClaseNet( lcClase )				if !pemstatus( _screen, "NetExtender", 5 )					goServicios.Errores.LevantarExcepcion( "Para instanciar un objeto net debe haber iniciado la aplicación." )				endif				lcComando = this.ObtenerSentenciaConDesgloseParametros( "ClrCreateObject", lcClase, "", "", lnParametrosReales )				loRetorno = this.CrearObjetoNet( lcComando, tvPar1, tvPar2, tvPar3, tvPar4, tvPar5, tvPar6, tvPar7, tvPar8 )			else				lcClase = justfname( lcClase )								if lnParametrosReales = 0 and vartype( _Screen.Zoo ) = "O" and !isnull( _Screen.Zoo ) and !isnull( _screen.Zoo.oConstructor )					lcClaseProxy = _screen.Zoo.oConstructor.ObtenerNombreClaseProxy( lcClase, lcLibreria )				endif				if !empty( lcClaseProxy )					loRetorno = _screen.Zoo.oConstructor.CrearObjeto( lcClaseProxy, set( "Datasession" ) )				else					lcSetProcedure = set('Procedure')					lcSetClassLib = set("Classlib")												if upper( justext( lcLibreria )) = "VCX"						lcSet  = "SET CLASSLIB TO "					else						lcSet = "SET PROCEDURE TO "					endif													if this.lEsExe and upper( justext( lcLibreria ) ) == "PRG"						&& En el Exe solo se pueden instanciar los archivos FXP, si no se fuerza la extensión recorre todo el path buscando el PRG.						lcLibreria = forceext( lcLibreria, "fxp" )						lcProcedure = lcLibreria					else						lcProcedure = forceext( lcLibreria, "" )					endif												lcSet = lcSet + "'" + lcProcedure + "'"										if this.BuscarClase( lcLibreria )						&lcSet					endif																			if lnParametrosReales > 0						lcComando = this.ObtenerSentenciaConDesgloseParametros( "NewObject", lcClase, lcLibreria , "", lnParametrosReales )						loRetorno = &lcComando					else						loRetorno = newobject( lcClase, lcLibreria )					endif									if !(lower(lcSetClassLib) == lower(set("Classlib")))						set classlib to &lcSetClassLib					endif						set procedure to &lcSetProcedure				endif			endif		Catch To loErrorBase				local lnError as Integer			lnError = 0						if loErrorBase.ErrorNo = 1 and left( lower( lcLibreria ), 4 ) == "din_"				do case					case !this.BuscarClase( strtran( lower( lcLibreria ), ".prg", ".fxp" ) )						lnError = 10					case !this.BuscarClase( lcLibreria )						lnError	= 20				endcase			endif			loEx = Newobject( "ZooException", "ZooException.prg" )			With loEx				.Grabar( loErrorBase )				.nZooErrorNo = lnError				.Throw()			EndWith		EndTry		return loRetorno
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
	function defaultimpresion_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'defaultimpresion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'defaultimpresion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Defaultimpresion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Defaultimpresion( lxVal )				this.Setear_Defaultimpresion( lxVal )			EndIf		Else			This.Setear_Defaultimpresion( lxVal )		EndIf		dodefault( lxVal )
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
	function descripcion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descripcion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descripcion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descripcion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descripcion( lxVal )				this.Setear_Descripcion( lxVal )			EndIf		Else			This.Setear_Descripcion( lxVal )		EndIf		dodefault( lxVal )
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
	function elminararchivosdatos() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Elminararchivosdatos', lcParametros )
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
	function entidad_assign( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'entidad_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'entidad_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Entidad		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Entidad( lxVal )				this.Setear_Entidad( lxVal )			EndIf		Else			This.Setear_Entidad( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function entidades_access() as variant                                                                                                                                                                                                                    
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'entidades_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'entidades_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Entidades ) = 'O' or isnull( this.Entidades ) )			this.Entidades = this.crearobjeto( 'Din_DetalleDisenoimpresionEntidades' )			this.Entidades.inicializar()			this.Entidades.lPermitirDetalleVacio = .F.			this.enlazar( 'Entidades.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Entidades.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Entidades, 'CambioSumarizado', this, 'CambiosDetalleEntidades', 1)			this.enlazar( 'Entidades.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Entidades.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Entidades
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
	function esatributo( tctipo as string ) as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esatributo', lcParametros )
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
	function esatributototalizadordecolumna( tctipo as string ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esatributototalizadordecolumna', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esatributotransportable( tctipo as string ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esatributotransportable', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function escdp( tctipo as string ) as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Escdp', lcParametros )
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
	function escodigodebarra( toitem as object ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Escodigodebarra', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esedicion() as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esedicion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esetiqueta( tctipo as string ) as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esetiqueta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esfuncionalidad( tctipo as string ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esfuncionalidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esgrafico( tctipo as string ) as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esgrafico', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esimagen( tctipo as string ) as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esimagen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eslinea( tctipo as string ) as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eslinea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eslineahorizontal( tctipo as string ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eslineahorizontal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eslineavertical( tctipo as string ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eslineavertical', lcParametros )
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
	function estadotransferencia_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estadotransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estadotransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Estadotransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Estadotransferencia( lxVal )				this.Setear_Estadotransferencia( lxVal )			EndIf		Else			This.Setear_Estadotransferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaenproceso() as boolean                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estaenproceso', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estaenproceso', lcParametros )			endif		endif		local lRetorno as Boolean		with this			lRetorno = ( .lProcesando or .lCargando or .lLimpiando or .lDestroy )		endwith		return lRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estilo_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estilo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estilo_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Estilo ) = 'O' or isnull( this.Estilo ) )					this.Estilo = _Screen.zoo.instanciarentidad( 'Estiloimpresion' )					this.Estilo.lEsSubEntidad = .t.					this.enlazar( 'Estilo.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Estilo.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Estilo.CODIGO # this.Estilo_PK						this.Estilo.CODIGO = this.Estilo_PK					endif				endif			endif		endif		return this.Estilo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estilo_pk_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estilo_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estilo_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Estilo_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Estilo_PK = lxVal		if this.Validar_Estilo( lxVal, lxValOld )			This.Setear_Estilo( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esunreportedeetiqueta() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esunreportedeetiqueta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esvariablereporte( tctipo as string ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esvariablereporte', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function evaluarenviodemailenprocesoprevio() as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Evaluarenviodemailenprocesoprevio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizargrilladetalleareas() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizargrilladetalleareas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoactualizargrilladetalleatributos() as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoactualizargrilladetalleatributos', lcParametros )
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
	function eventocabecera() as void                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventocabecera', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventocambiarlabel() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventocambiarlabel', lcParametros )
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
	function eventoetiqueta() as void                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoetiqueta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoetiquetacantidad() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoetiquetacantidad', lcParametros )
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
	function eventopreguntaractualizaraltoetiqueta() as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventopreguntaractualizaraltoetiqueta', lcParametros )
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
	function eventosetearlabel() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventosetearlabel', lcParametros )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcfilelcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ExisteArchivoClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ExisteArchivoClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.				if _VFP.StartMode = 5 and !_screen.zoo.EsBuildAutomatico &&and "FOXEXTENDER" $ upper( sys( 16 ) )			try				do ( tcFile )				llRetorno = .t.			catch			endtry		else			llRetorno = file( tcFile )		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_access', lcParametros )			endif		endif		if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.FechaAltaFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaaltafw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaaltafw( lxVal )			EndIf		Else			This.Setear_Fechaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaexpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaexpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaexpo( lxVal )			EndIf		Else			This.Setear_Fechaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaimpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaimpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaimpo( lxVal )			EndIf		Else			This.Setear_Fechaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			This.FechaModificacionFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechamodificacionfw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechamodificacionfw( lxVal )			EndIf		Else			This.Setear_Fechamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechatransferencia_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechatransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechatransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechatransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechatransferencia( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechatransferencia( lxVal )			EndIf		Else			This.Setear_Fechatransferencia( lxVal )		EndIf		dodefault( lxVal )
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
	function generarimpresion() as string                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generarimpresion', lcParametros )
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
	function guardarcomo() as void                                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Guardarcomo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitasalidaaimpresora_assign( txval as variant ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'habilitasalidaaimpresora_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'habilitasalidaaimpresora_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Habilitasalidaaimpresora		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Habilitasalidaaimpresora( lxVal )				this.Setear_Habilitasalidaaimpresora( lxVal )			EndIf		Else			This.Setear_Habilitasalidaaimpresora( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitasalidaapdf_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'habilitasalidaapdf_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'habilitasalidaapdf_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Habilitasalidaapdf		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Habilitasalidaapdf( lxVal )				this.Setear_Habilitasalidaapdf( lxVal )			EndIf		Else			This.Setear_Habilitasalidaapdf( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_access', lcParametros )			endif		endif				if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			this.HoraAltaFW = goLibrerias.ObtenerHora()		endif		return this.HoraAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaaltafw( lxVal )				this.Setear_Horaaltafw( lxVal )			EndIf		Else			This.Setear_Horaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaexpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaexpo( lxVal )				this.Setear_Horaexpo( lxVal )			EndIf		Else			This.Setear_Horaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaimpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaimpo( lxVal )				this.Setear_Horaimpo( lxVal )			EndIf		Else			This.Setear_Horaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_access() as string                                                                                                                                                                                                            
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			this.HoraModificacionFW = goServicios.Librerias.ObtenerHora()		endif		return this.HoraModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horamodificacionfw( lxVal )				this.Setear_Horamodificacionfw( lxVal )			EndIf		Else			This.Setear_Horamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
	function impresionautomatica_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'impresionautomatica_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'impresionautomatica_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Impresionautomatica		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Impresionautomatica( lxVal )				if ( this.lHabilitarImpresionautomatica or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Impresionautomatica( lxVal )				else					this.Impresionautomatica = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Impresionautomatica)" )				endif			EndIf		Else			This.Setear_Impresionautomatica( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimecontinuo() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Imprimecontinuo', lcParametros )
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
	function lanzareventopreguntaranular() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Lanzareventopreguntaranular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lesentidadconedicionrestringida_access() as boolean                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lesentidadconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lesentidadconedicionrestringida_access', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = .f.		if vartype( this.oAtributosConEdicionRestringida ) = 'O' and this.oAtributosConEdicionRestringida.Count > 0			llRetorno = .t.		endif		return llRetorno
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
	function margender_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margender_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margender_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margender		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margender( lxVal )				this.Setear_Margender( lxVal )			EndIf		Else			This.Setear_Margender( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function margeninf_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margeninf_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margeninf_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margeninf		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margeninf( lxVal )				this.Setear_Margeninf( lxVal )			EndIf		Else			This.Setear_Margeninf( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function margenizq_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margenizq_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margenizq_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margenizq		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margenizq( lxVal )				this.Setear_Margenizq( lxVal )			EndIf		Else			This.Setear_Margenizq( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function margensup_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margensup_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margensup_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margensup		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margensup( lxVal )				this.Setear_Margensup( lxVal )			EndIf		Else			This.Setear_Margensup( lxVal )		EndIf		dodefault( lxVal )
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
	function novalidardetalleporoperatoriaenbasea() as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Novalidardetalleporoperatoriaenbasea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nuevo() as boolean                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Nuevo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oad_access() as variant                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oad_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oad_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )			this.oAD = this.crearobjeto( 'Din_EntidadDISENOIMPRESIONAD_' + alltrim( _screen.zoo.app.TipoDeBase ))			this.oAD.InyectarEntidad( this )			this.oAD.Inicializar()		endif		return this.oAD
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oatributosconedicionrestringida_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oatributosconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oatributosconedicionrestringida_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oAtributosConEdicionRestringida ) = 'O'			this.oAtributosConEdicionRestringida = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oAtributosConEdicionRestringida
	EndFunc

	*-----------------------------------------------------------------------------------------
	function observacion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'observacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'observacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Observacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Observacion( lxVal )				this.Setear_Observacion( lxVal )			EndIf		Else			This.Setear_Observacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoclaveprimaria() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obteneratributoclaveprimaria', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obteneratributoclaveprimaria', lcParametros )			endif		endif		return this.cAtributoPK
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
	function obteneratributostotalizadores() as object                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributostotalizadores', lcParametros )
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
	function obtenercantidadatributos() as integer                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercantidadatributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercantidadcolumnas() as integer                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercantidadcolumnas', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenerdescripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenerdescripcion', lcParametros )			endif		endif		return this.cDescripcion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdescripcionimpresoreaparatooltip() as string                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdescripcionimpresoreaparatooltip', lcParametros )
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
	function obtenerdisenospredeterminados() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdisenospredeterminados', lcParametros )
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
	function ocolaboradordedetalles_access() as variant                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolaboradordedetalles_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolaboradordedetalles_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oColaboradorDeDetalles ) = 'O' or isnull( this.oColaboradorDeDetalles ) )			this.oColaboradorDeDetalles = _Screen.zoo.crearobjeto( 'ColaboradorDeDetalles' )			This.oColaboradorDeDetalles.InyectarAccesoADatos( This.oAd )		endif		return this.oColaboradorDeDetalles
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocolatributosobligatoriosdefinidosporusuario_access() as object                                                                                                                                                                                  
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			endif		endif		local loRetorno as Object				loRetorno = null		if !this.lDestroy					loRetorno = goServicios.SaltosDeCampoyValoresSugeridos.ObtenerColeccionAtributosObligatorios( this.ObtenerNombre() )		endif				return loRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocompdisenoimpresion_access() as variant                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocompdisenoimpresion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocompdisenoimpresion_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oCompDisenoimpresion ) = 'O' or isnull( this.oCompDisenoimpresion ) )			this.oCompDisenoimpresion = _Screen.zoo.InstanciarComponente( 'ComponenteDisenoimpresion' )		this.oCompDisenoimpresion.Inicializar()		this.enlazar( 'oCompDisenoimpresion.EventoObtenerLogueo', 'inyectarLogueo' )		this.enlazar( 'oCompDisenoimpresion.EventoObtenerInformacion', 'inyectarInformacion' )		endif		return this.oCompDisenoimpresion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocomportamientocodigosugerido_access() as void                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocomportamientocodigosugerido_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocomportamientocodigosugerido_access', lcParametros )			endif		endif		local loComportamientoCodigoSugerido as Object		if !this.ldestroy and !vartype( this.oComportamientoCodigoSugerido ) = 'O'			loComportamientoCodigoSugerido = _Screen.zoo.CrearObjeto( "DecoradorDeCodigosDeEntidades" )			this.InicializarComportamientoCodigoSugerido(loComportamientoCodigoSugerido )			this.oComportamientoCodigoSugerido = loComportamientoCodigoSugerido		endif		return this.oComportamientoCodigoSugerido
	EndFunc

	*-----------------------------------------------------------------------------------------
	function odibujanteimpresion_access() as object                                                                                                                                                                                                           
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'odibujanteimpresion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'odibujanteimpresion_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oDibujanteImpresion ) = 'O'			this.oDibujanteImpresion = this.crearobjeto( 'DibujanteImpresion' )			this.oDibujanteImpresion.Inicializar()		endif		return this.oDibujanteImpresion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ogestordemail_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ogestordemail_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ogestordemail_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oGestorDeMail ) = 'O'			this.oGestorDeMail = _Screen.zoo.CrearObjeto( "GestorDeMail" )		endif		return this.oGestorDeMail
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oinformacion_access() as variant                                                                                                                                                                                                                 
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oinformacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oinformacion_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )				this.eventoObtenerInformacion( this )				if !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )					.oInformacion = this.CrearObjeto( "ZooInformacion" )				endif				endif		endwith		return this.oInformacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ologueo_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ologueo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ologueo_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oLogueo ) = 'O' and isnull( .oLogueo ) and vartype( goServicios ) = 'O'				this.eventoObtenerLogueo( this )				if !vartype( .oLogueo ) = 'O' and isnull( .oLogueo )					.oLogueo = goServicios.Logueos.obtenerObjetoLogueo( this )					.SetearAccion()					.lLogueoPropio = .T.				else					.lLogueoPropio = .F.								endif				endif		endwith		return this.oLogueo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function omensaje_access() as void                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'omensaje_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'omensaje_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oMensaje ) = 'O' or isnull( this.oMensaje ) )			this.oMensaje = _screen.zoo.crearobjeto( "mensajeentidad", "", this )		endif				return this.oMensaje
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oobservadoresdeimportacion_access() as variant                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oobservadoresdeimportacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oobservadoresdeimportacion_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oObservadoresDeImportacion ) = 'O' or isnull( this.oObservadoresDeImportacion ) )			this.oObservadoresDeImportacion = _Screen.zoo.crearobjeto( 'ZooColeccion' )		endif		return this.oObservadoresDeImportacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function opciondesalida_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'opciondesalida_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'opciondesalida_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Opciondesalida		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Opciondesalida( lxVal )				if ( this.lHabilitarOpciondesalida or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Opciondesalida( lxVal )					 This.Opciondesalida_DespuesDeAsignar()				else					this.Opciondesalida = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Opciondesalida)" )				endif			EndIf		Else			This.Setear_Opciondesalida( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function opciondesalida_despuesdeasignar() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Opciondesalida_despuesdeasignar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oregistrosdeactividadesalgrabar_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oregistrosdeactividadesalgrabar_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oregistrosdeactividadesalgrabar_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oRegistrosDeActividadesAlGrabar ) = 'O'			this.oRegistrosDeActividadesAlGrabar = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oRegistrosDeActividadesAlGrabar
	EndFunc

	*-----------------------------------------------------------------------------------------
	function otalle_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'otalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'otalle_access', lcParametros )			endif		endif		if this.ldestroy		else			if ( !vartype( this.oTalle ) = 'O' or isnull( this.oTalle ) )				this.oTalle = _Screen.zoo.instanciarentidad( 'Talle' )			endif		endif		return this.oTalle
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ovalidadordisenospredeterminados_access() as object                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ovalidadordisenospredeterminados_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ovalidadordisenospredeterminados_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oValidadorDisenosPredeterminados ) = 'O'			this.oValidadorDisenosPredeterminados = _screen.zoo.crearobjeto( 'validadordisenoimpresion' )			this.oValidadorDisenosPredeterminados.InyectarEntidad( this )			this.enlazar( 'oValidadorDisenosPredeterminados.EventoObtenerInformacion', 'inyectarInformacion' )		endif		return this.oValidadorDisenosPredeterminados
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ovalidadorescomp_access() as object                                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ovalidadorescomp_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ovalidadorescomp_access', lcParametros )			endif		endif		if !this.lDestroy and !( vartype( this.oValidadoresComp ) == "O" )			this.oValidadoresComp = _screen.Zoo.Crearobjeto( "ZooColeccion" )		endif				return this.oValidadoresComp
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
	function pdfautomatico_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'pdfautomatico_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'pdfautomatico_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Pdfautomatico		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Pdfautomatico( lxVal )				if ( this.lHabilitarPdfautomatico or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Pdfautomatico( lxVal )				else					this.Pdfautomatico = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Pdfautomatico)" )				endif			EndIf		Else			This.Setear_Pdfautomatico( lxVal )		EndIf		dodefault( lxVal )
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
	function puerto_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'puerto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'puerto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Puerto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Puerto( lxVal )				if ( this.lHabilitarPuerto or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Puerto( lxVal )				else					this.Puerto = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Puerto)" )				endif			EndIf		Else			This.Setear_Puerto( lxVal )		EndIf		dodefault( lxVal )
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
	function reordenardetalles() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Reordenardetalles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurargenhabilitar() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurargenhabilitar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function rutapdf_assign( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'rutapdf_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'rutapdf_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Rutapdf		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Rutapdf( lxVal )				if ( this.lHabilitarRutapdf or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))					this.Setear_Rutapdf( lxVal )				else					this.Rutapdf = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Rutapdf)" )				endif			EndIf		Else			This.Setear_Rutapdf( lxVal )		EndIf		dodefault( lxVal )
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
	function segundos_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'segundos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'segundos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Segundos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Segundos( lxVal )				if ( this.lHabilitarSegundos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Segundos( lxVal )				else					this.Segundos = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Segundos)" )				endif			EndIf		Else			This.Setear_Segundos( lxVal )		EndIf		dodefault( lxVal )
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
	function seimprimeporcontroladorfiscal() as integer                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Seimprimeporcontroladorfiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.SerieAltaFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriealtafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriealtafw( lxVal )				this.Setear_Seriealtafw( lxVal )			EndIf		Else			This.Setear_Seriealtafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.SerieModificacionFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriemodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriemodificacionfw( lxVal )				this.Setear_Seriemodificacionfw( lxVal )			EndIf		Else			This.Setear_Seriemodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function series_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'series_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'series_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Series		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Series( lxVal )				this.Setear_Series( lxVal )			EndIf		Else			This.Setear_Series( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_advierte( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_advierte', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_advierte', lcParametros )			endif		endif		this.Advierte = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_aplicalimite( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_aplicalimite', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_aplicalimite', lcParametros )			endif		endif		local llHabilitarAdvierte as Boolean		dodefault( txVal )		llHabilitarAdvierte = ( val( transform( txVal) ) = 0 )		this.SetearHabilitarAdvierteSegunAtributoAplicaLimite( llHabilitarAdvierte )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosaltafw( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosaltafw', lcParametros )			endif		endif		this.Basededatosaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosmodificacionfw( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosmodificacionfw', lcParametros )			endif		endif		this.Basededatosmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_bloquearregistro( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_bloquearregistro', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_bloquearregistro', lcParametros )			endif		endif		this.Bloquearregistro = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cantidadcopias( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_cantidadcopias', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_cantidadcopias', lcParametros )			endif		endif		this.Cantidadcopias = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_columnas( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_columnas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_columnas', lcParametros )			endif		endif		this.Columnas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_condicion( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_condicion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_condicion', lcParametros )			endif		endif		this.Condicion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_confirmapdf( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_confirmapdf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_confirmapdf', lcParametros )			endif		endif		this.Confirmapdf = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_defaultimpresion( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_defaultimpresion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_defaultimpresion', lcParametros )			endif		endif		this.Defaultimpresion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descripcion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descripcion', lcParametros )			endif		endif		this.Descripcion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_entidad( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_entidad', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_entidad', lcParametros )			endif		endif		this.Entidad = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_estadotransferencia( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_estadotransferencia', lcParametros )			endif		endif		this.Estadotransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_estilo( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_estilo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_estilo', lcParametros )			endif		endif		this.Estilo.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaaltafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaaltafw', lcParametros )			endif		endif		this.Fechaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaexpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaexpo', lcParametros )			endif		endif		this.Fechaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaimpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaimpo', lcParametros )			endif		endif		this.Fechaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechamodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechamodificacionfw', lcParametros )			endif		endif		this.Fechamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechatransferencia( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechatransferencia', lcParametros )			endif		endif		this.Fechatransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_habilitasalidaaimpresora( txvalor as variant ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_habilitasalidaaimpresora', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_habilitasalidaaimpresora', lcParametros )			endif		endif		dodefault( txValor )		with this			this.HabilitarAtributosSalidaAImpresora( txValor )		endWith
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_habilitasalidaapdf( txvalor as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_habilitasalidaapdf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_habilitasalidaapdf', lcParametros )			endif		endif		dodefault( txValor )		with this			this.HabilitarAtributosSalidaAPdf( txValor )		endWith
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaaltafw( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaaltafw', lcParametros )			endif		endif		this.Horaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaexpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaexpo', lcParametros )			endif		endif		this.Horaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaimpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaimpo', lcParametros )			endif		endif		this.Horaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horamodificacionfw( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horamodificacionfw', lcParametros )			endif		endif		this.Horamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_impresionautomatica( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_impresionautomatica', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_impresionautomatica', lcParametros )			endif		endif		this.Impresionautomatica = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margender( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margender', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margender', lcParametros )			endif		endif		this.Margender = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margeninf( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margeninf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margeninf', lcParametros )			endif		endif		this.Margeninf = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margenizq( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margenizq', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margenizq', lcParametros )			endif		endif		this.Margenizq = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margensup( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margensup', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margensup', lcParametros )			endif		endif		this.Margensup = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_observacion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_observacion', lcParametros )			endif		endif		this.Observacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_opciondesalida( txvalor as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_opciondesalida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_opciondesalida', lcParametros )			endif		endif		dodefault( txValor )		this.SetearEstadoPuerto()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_pdfautomatico( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_pdfautomatico', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_pdfautomatico', lcParametros )			endif		endif		this.Pdfautomatico = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_puerto( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_puerto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_puerto', lcParametros )			endif		endif		this.Puerto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_rutapdf( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_rutapdf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_rutapdf', lcParametros )			endif		endif		this.Rutapdf = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_segundos( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_segundos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_segundos', lcParametros )			endif		endif		this.Segundos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriealtafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriealtafw', lcParametros )			endif		endif		this.Seriealtafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriemodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriemodificacionfw', lcParametros )			endif		endif		this.Seriemodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_series( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_series', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_series', lcParametros )			endif		endif		this.Series = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_solicitarconfirmacion( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_solicitarconfirmacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_solicitarconfirmacion', lcParametros )			endif		endif		this.Solicitarconfirmacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_sugiere( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_sugiere', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_sugiere', lcParametros )			endif		endif		this.Sugiere = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_timestamp( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_timestamp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_timestamp', lcParametros )			endif		endif		this.Timestamp = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuarioaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuarioaltafw', lcParametros )			endif		endif		this.Usuarioaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuariomodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuariomodificacionfw', lcParametros )			endif		endif		this.Usuariomodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionaltafw', lcParametros )			endif		endif		this.Versionaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionmodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionmodificacionfw', lcParametros )			endif		endif		this.Versionmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_zadsfw( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_zadsfw', lcParametros )			endif		endif		this.Zadsfw = txVal		dodefault( txVal )
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
	function setearestadopuerto() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearestadopuerto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearimpresionpredeterminada() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearimpresionpredeterminada', lcParametros )
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
	function solicitarconfirmacion_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'solicitarconfirmacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'solicitarconfirmacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Solicitarconfirmacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Solicitarconfirmacion( lxVal )				this.Setear_Solicitarconfirmacion( lxVal )			EndIf		Else			This.Setear_Solicitarconfirmacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function soportabusquedaextendida( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'soportabusquedaextendida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'soportabusquedaextendida', lcParametros )			endif		endif		return This.oComportamientoCodigoSugerido.SoportaBusquedaExtendida()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function sugiere_assign( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'sugiere_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'sugiere_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Sugiere		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Sugiere( lxVal )				if ( this.lHabilitarSugiere or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Sugiere( lxVal )				else					this.Sugiere = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Diseño de salida - Atributo: Sugiere)" )				endif			EndIf		Else			This.Setear_Sugiere( lxVal )		EndIf		dodefault( lxVal )
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
	function timestamp_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'timestamp_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'timestamp_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Timestamp		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Timestamp( lxVal )				this.Setear_Timestamp( lxVal )			EndIf		Else			This.Setear_Timestamp( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function twipspormilimetro_access() as variant                                                                                                                                                                                                            
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'twipspormilimetro_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'twipspormilimetro_access', lcParametros )			endif		endif		if !this.ldestroy and empty( this.TwipsPorMilimetro )			This.TwipsPorMilimetro = goServicios.Registry.Dibujante.Reportes.TwipsPorMilimetro		endif		return this.TwipsPorMilimetro
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ultimo () as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ultimo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_access() as date                                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.UsuarioAltaFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() ) + this.UsuarioAutorizante()		endif		return This.UsuarioAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuarioaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuarioaltafw( lxVal )				this.Setear_Usuarioaltafw( lxVal )			EndIf		Else			This.Setear_Usuarioaltafw( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.UsuarioModificacionFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() )  + this.UsuarioAutorizante()		endif		return This.UsuarioModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuariomodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuariomodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuariomodificacionfw( lxVal )				this.Setear_Usuariomodificacionfw( lxVal )			EndIf		Else			This.Setear_Usuariomodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
	function validar_advierte( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_advierte', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_advierte', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_aplicalimite( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_aplicalimite', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_aplicalimite', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosaltafw( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_bloquearregistro( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_bloquearregistro', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_bloquearregistro', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cantidadcopias( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_cantidadcopias', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_cantidadcopias', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_columnas( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_columnas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_columnas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_condicion( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_condicion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_condicion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_confirmapdf( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_confirmapdf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_confirmapdf', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_defaultimpresion( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_defaultimpresion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_defaultimpresion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descripcion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descripcion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_entidad( txval as variant ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_entidad', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_entidad', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_estadotransferencia( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_estadotransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_estilo( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_estilo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_estilo', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaaltafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaexpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaimpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechatransferencia( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechatransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_habilitasalidaaimpresora( txval as variant ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_habilitasalidaaimpresora', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_habilitasalidaaimpresora', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_habilitasalidaapdf( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_habilitasalidaapdf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_habilitasalidaapdf', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaaltafw( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaexpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaimpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_impresionautomatica( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_impresionautomatica', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_impresionautomatica', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margender( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margender', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margender', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margeninf( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margeninf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margeninf', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margenizq( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margenizq', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margenizq', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margensup( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margensup', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margensup', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_observacion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_observacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_opciondesalida( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_opciondesalida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_opciondesalida', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_pdfautomatico( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_pdfautomatico', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_pdfautomatico', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_puerto( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_puerto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_puerto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_rutapdf( txval as variant ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_rutapdf', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_rutapdf', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_segundos( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_segundos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_segundos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriealtafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriealtafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriemodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriemodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_series( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_series', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_series', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_solicitarconfirmacion( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_solicitarconfirmacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_solicitarconfirmacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_sugiere( txval as variant ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_sugiere', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_sugiere', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_timestamp( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_timestamp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_timestamp', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuarioaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuarioaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuariomodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuariomodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_zadsfw( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_zadsfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaranulacion() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaranulacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarareascontinuas() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarareascontinuas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarareascontransporte() as boolean                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarareascontransporte', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaratributoscontransporte( tcareacabecera, tcareadetalle, tcareapie ) as boolean                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcareacabecera
		lxParam2 = tcareadetalle
		lxParam3 = tcareapie

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validaratributoscontransporte', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaratributosendisenosconconsecuencial() as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaratributosendisenosconconsecuencial', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaratributosexistentesenentidaddeldiseno() as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaratributosexistentesenentidaddeldiseno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcamposobligatoriosdefinidosporusuario() as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcamposobligatoriosdefinidosporusuario', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcantidadcolumnas() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcantidadcolumnas', lcParametros )
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
	function validarcondicionendetalles() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcondicionendetalles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validardescripcion() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validardescripcion', lcParametros )
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
	function validarorientacionendetalles() as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarorientacionendetalles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarpk() as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarpk', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarsalidadirectaapuerto() as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarsalidadirectaapuerto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoadvierte() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoadvierte', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoaplicalimite() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoaplicalimite', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocantidadcopias() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocantidadcopias', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocolumnas() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocolumnas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocondicion() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocondicion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoconfirmapdf() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoconfirmapdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodescripcion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodescripcion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoestilo() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoestilo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwadvierte() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwadvierte', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwaplicalimite() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwaplicalimite', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwcantidadcopias() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwcantidadcopias', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwcolumnas() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwcolumnas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwhabilitasalidaaimpresora() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwhabilitasalidaaimpresora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwhabilitasalidaapdf() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwhabilitasalidaapdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwrutapdf() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwrutapdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwsegundos() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwsegundos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridohabilitasalidaaimpresora() as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridohabilitasalidaaimpresora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridohabilitasalidaapdf() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridohabilitasalidaapdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoimpresionautomatica() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoimpresionautomatica', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargender() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargender', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargeninf() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargeninf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargenizq() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargenizq', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargensup() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargensup', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoobservacion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoobservacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoopciondesalida() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoopciondesalida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopdfautomatico() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopdfautomatico', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopuerto() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopuerto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridorutapdf() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridorutapdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridosegundos() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridosegundos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoseries() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoseries', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridosugiere() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridosugiere', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificaratributosenarea( tcatributo as string, tcarea as string ) as boolean                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = tcarea

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificaratributosenarea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarcontexto( tctipos as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tctiposlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'verificarcontexto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'verificarcontexto', lcParametros )			endif		endif		local llRetorno as boolean, i as Integer, lcLetra as string				if empty( tcTipos )			llRetorno = empty( this.cContexto )		else			tcTipos = upper( alltrim( tcTipos ) )			llRetorno = .f.			for i = 1 to len( tcTipos )				lcLetra = substr( tcTipos, i, 1 )				llRetorno = ( lcLetra $ this.cContexto ) or llRetorno				if llRetorno					exit				endif			endfor		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarentidadcontransporte() as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificarentidadcontransporte', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.VersionAltaFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionaltafw( lxVal )				this.Setear_Versionaltafw( lxVal )			EndIf		Else			This.Setear_Versionaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_access() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.VersionModificacionFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionmodificacionfw( lxVal )				this.Setear_Versionmodificacionfw( lxVal )			EndIf		Else			This.Setear_Versionmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
	function votacioncambioestadocancelar( tcestado as string ) as boolean                                                                                                                                                                                    
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
	function votacioncambioestadoeliminar( tcestado as string ) as boolean                                                                                                                                                                                    
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
	function votacioncambioestadograbar( tcestado as string ) as boolean                                                                                                                                                                                      
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
	function votacioncambioestadomodificar( tcestado as string ) as boolean                                                                                                                                                                                   
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
	function votacioncambioestadonuevo( tcestado as string ) as boolean                                                                                                                                                                                       
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'zadsfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'zadsfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Zadsfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Zadsfw( lxVal )				this.Setear_Zadsfw( lxVal )			EndIf		Else			This.Setear_Zadsfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'esclasenet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'esclasenet', lcParametros )			endif		endif		return "." $ tcClase
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenernombreclase( tcclase ) as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenernombreclase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenernombreclase', lcParametros )			endif		endif		Local lcRetorno as String, lcNombreApp as String		if upper( substr( alltrim( tcClase ), len( alltrim( tcClase ) ) - 1 ) ) = "UO"			if !this.lEsExe and this.BuscarClase( alltrim( tcClase ) + "UO.prg" )				lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			else				lcRetorno = tcClase			endif		else			if type( "_screen.zoo.app.cProyecto" ) = "C"				lcNombreApp = upper( _screen.zoo.app.cProyecto )			else				lcNombreApp = ""			endif							do case				case upper( left( tcClase, 4 ) ) = "ENT_"					lcRetorno = strtran( upper( tcClase ), "ENT_","" ,1 ,1 )				case upper( left( tcClase, 4 + len( lcNombreApp ) ) ) = "ENT" + lcNombreApp + "_"					lcRetorno = strtran( upper( tcClase ), "ENT" + lcNombreApp + "_", "", 1 ,1 )				case upper( left( tcClase, 11 ) ) = "DIN_ENTIDAD"					lcRetorno = strtran( tcClase, "Din_Entidad","" ,1 ,1 )				otherwise					lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			endcase		endif		return lcRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenersentenciacondesgloseparametros( tccomando as string, tcclase as string, tclibreria as string, tcapp as string, tnparametros as integer )                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5lnParametros = pcount()lxParam1 = tccomandolxParam2 = tcclaselxParam3 = tclibrerialxParam4 = tcapplxParam5 = tnparametroslcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenersentenciaCondesgloseparametros', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenersentenciaCondesgloseparametros', lcParametros )			endif		endif		local lcRetorno as string, lni as integer, lcLibreria as string, lcApp as string				if empty( tcLibreria )			lcLibreria = ""		else			lcLibreria = alltrim( tcLibreria )		endif				if empty( tcApp )			lcApp = ""		else			lcApp = alltrim( tcApp )		endif		if inlist( upper( tcComando ), "CLRCREATEOBJECT", "CLRINVOKESTATICMETHOD" )			lcRetorno = tcComando + "( '" + tcClase + "'"		else			if empty( tnParametros ) and empty( tcApp )				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "'"			else				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "', '" + tcApp + "'"			endif		endif				for lni = 1 to tnParametros			lcRetorno = lcRetorno + ", tvPar" + transform( lni )		endfor		lcRetorno = lcRetorno + " )"		return lcRetorno
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
	protected function _esregistroguardablecomo() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( '_esregistroguardablecomo', lcParametros )
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
	protected function agregar_oitem( tcatributo as string ) as string                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregar_oitem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function agregarclaseacoleccion( tcclase as string ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'AgregarClaseAColeccion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'AgregarClaseAColeccion', lcParametros )			endif		endif		if !alltrim( upper( "mock" ) )$alltrim( upper( tcClase ) )			_screen.oClases.Add( tcClase, sys(2007, alltrim( lower( tcClase )),0,1))		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function cargarcolecciondeatributosconedicionrestringida() as void                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargarcolecciondeatributosconedicionrestringida', lcParametros )
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
	protected function existeelementoencolecciondeareas( tcvalorcampo as string ) as boolean                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcvalorcampo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Existeelementoencolecciondeareas', lcParametros )
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
	protected function habilitaratributossalidaaimpresora( tlhabilita as boolean ) as void                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlhabilita

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Habilitaratributossalidaaimpresora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function habilitaratributossalidaapdf( tlhabilita as boolean ) as void                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlhabilita

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Habilitaratributossalidaapdf', lcParametros )
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
	protected function instanciarentidad( toentidad as object ) as object                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = toentidadlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'instanciarentidad', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'instanciarentidad', lcParametros )			endif		endif		local loEntidad as Entidad of Entidad.Prg		if type( "toEntidad" ) = "O"			loEntidad = toEntidad		else			Try				loEntidad = _Screen.zoo.instanciarEntidad( This.Entidad )			catch			Endtry			endif		return loEntidad
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
	protected function releasearentidad( toentidad as object ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toentidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Releasearentidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function setearhabilitaradviertesegunatributoaplicalimite( tlhabilitar as boolean ) as void                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlhabilitar

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearhabilitaradviertesegunatributoaplicalimite', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function transformaralasignar( txval as variant ) as variant                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'DISENOIMPRESION' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Transformaralasignar', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Transformaralasignar', lcParametros )			endif		endif		return txVal
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function transformaramilimietros( tntwips as integer ) as string                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tntwips

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Transformaramilimietros', lcParametros )
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
	protected function validaraltoreporte() as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaraltoreporte', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validaranchoatributosinancho() as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaranchoatributosinancho', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validaranchocontrol( tcarea as string, toitem as object ) as boolean                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcarea
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validaranchocontrol', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarantesdeanular() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarantesdeanular', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarareadetalle( tcarea as string ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcarea

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarareadetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validaratributo( toitem as object, toentidad as object ) as boolean                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = toitem
		lxParam2 = toentidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validaratributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validaratributotransporte( ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaratributotransporte', lcParametros )
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
	protected function validarcontenidodeatributos() as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcontenidodeatributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validardisenospredeterminados() as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validardisenospredeterminados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarestilo() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarestilo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarexistencia() as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarexistencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarexistenciaatributos() as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarexistenciaatributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarexistenciadeareaenatributo( toitem as object ) as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarexistenciadeareaenatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarfuncionagrupar() as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarfuncionagrupar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarfuncionagrupararea() as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarfuncionagrupararea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarfuncionagruparatributos() as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarfuncionagruparatributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarordenamientosrepetidos() as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarordenamientosrepetidos', lcParametros )
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