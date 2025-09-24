
define class Mock_listadospersonalizados as MockBase of MockBase.prg

	lNuevo = .f. 
	lEdicion = .f. 
	lDestroy = .f. 
	cContexto = '' 

	cClase = 'listadospersonalizados'

	
	Anulado = .F.                                                                                                                                                                                                                                             
	BASEDEDATOSALTAFW = ""                                                                                                                                                                                                                                    
	BASEDEDATOSMODIFICACIONFW = ""                                                                                                                                                                                                                            
	BLOQUEARREGISTRO = .F.                                                                                                                                                                                                                                    
	BaseDeDatos = ""                                                                                                                                                                                                                                          
	BaseDeDatosDetallada = .F.                                                                                                                                                                                                                                
	CamposDetalle = null                                                                                                                                                                                                                                      
	CamposEquivalenciaLince = ""                                                                                                                                                                                                                              
	Codigo = ""                                                                                                                                                                                                                                               
	ColorParaElSombreado = 0                                                                                                                                                                                                                                  
	Descripcion = ""                                                                                                                                                                                                                                          
	DestinoArchivo = ""                                                                                                                                                                                                                                       
	DestinoFechaHora = .F.                                                                                                                                                                                                                                    
	DestinoRuta = ""                                                                                                                                                                                                                                          
	DestinoTipo = 0                                                                                                                                                                                                                                           
	DiferenciarDetalle = .F.                                                                                                                                                                                                                                  
	ESTADOTRANSFERENCIA = ""                                                                                                                                                                                                                                  
	EsDefault = .F.                                                                                                                                                                                                                                           
	Estilo = null                                                                                                                                                                                                                                             
	Estilo_PK = ""                                                                                                                                                                                                                                            
	FECHAALTAFW = ctod( '  /  /    ' )                                                                                                                                                                                                                        
	FECHAEXPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAIMPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )                                                                                                                                                                                                                
	FECHATRANSFERENCIA = ctod( '  /  /    ' )                                                                                                                                                                                                                 
	FechaAltaFW = {}                                                                                                                                                                                                                                          
	FechaModificacionFW = {}                                                                                                                                                                                                                                  
	FiltrosDetalle = null                                                                                                                                                                                                                                     
	HORAALTAFW = ""                                                                                                                                                                                                                                           
	HORAEXPO = ""                                                                                                                                                                                                                                             
	HORAIMPO = ""                                                                                                                                                                                                                                             
	HORAMODIFICACIONFW = ""                                                                                                                                                                                                                                   
	IdentificadorOrdenamiento = ""                                                                                                                                                                                                                            
	ImagenListado = ""                                                                                                                                                                                                                                        
	ImprimeEncabezadoDeDetalle = .F.                                                                                                                                                                                                                          
	ImprimeEncabezadoDePagina = .F.                                                                                                                                                                                                                           
	ImprimeEncabezadoDeReporte = .F.                                                                                                                                                                                                                          
	ImprimeFechaDeImpresion = .F.                                                                                                                                                                                                                             
	ImprimeHoraDeImpresion = .F.                                                                                                                                                                                                                              
	ImprimeInformacionDeContexto = .F.                                                                                                                                                                                                                        
	ImprimeInformacionDeCorrida = .F.                                                                                                                                                                                                                         
	ImprimeResumenDeReporte = .F.                                                                                                                                                                                                                             
	MailAsunto = ""                                                                                                                                                                                                                                           
	MailConCopia = ""                                                                                                                                                                                                                                         
	MailConCopiaOculta = ""                                                                                                                                                                                                                                   
	MailMensaje = ""                                                                                                                                                                                                                                          
	MailPara = ""                                                                                                                                                                                                                                             
	MantenerGruposUnidos = .F.                                                                                                                                                                                                                                
	MargenCabecera = 0                                                                                                                                                                                                                                        
	MargenDerecho = 0                                                                                                                                                                                                                                         
	MargenIzquierdo = 0                                                                                                                                                                                                                                       
	MargenPie = 0                                                                                                                                                                                                                                             
	NumeracionDePaginaSimple = .F.                                                                                                                                                                                                                            
	Observacion = ""                                                                                                                                                                                                                                          
	OrdenadoPor = 0                                                                                                                                                                                                                                           
	OrdenamientosDetalle = null                                                                                                                                                                                                                               
	Orientacion = 0                                                                                                                                                                                                                                           
	RepetirCabecerasDeGrupos = .F.                                                                                                                                                                                                                            
	RetornoExtension = .t.                                                                                                                                                                                                                                    
	SERIEALTAFW = ""                                                                                                                                                                                                                                          
	SERIEMODIFICACIONFW = ""                                                                                                                                                                                                                                  
	SalidasDetalle = null                                                                                                                                                                                                                                     
	SubtotalDetallado = .F.                                                                                                                                                                                                                                   
	SubtotalDetalle = null                                                                                                                                                                                                                                    
	TipoOrdenamiento = 0                                                                                                                                                                                                                                      
	TituloListado = ""                                                                                                                                                                                                                                        
	TitulosDeColumnasDeGrupoEnCP = .F.                                                                                                                                                                                                                        
	TitulosDeColumnasDeSubreporteEnCP = .F.                                                                                                                                                                                                                   
	USUARIOALTAFW = ""                                                                                                                                                                                                                                        
	USUARIOMODIFICACIONFW = ""                                                                                                                                                                                                                                
	UsaTransporteEntrePaginas = .F.                                                                                                                                                                                                                           
	VERSIONALTAFW = ""                                                                                                                                                                                                                                        
	VERSIONMODIFICACIONFW = ""                                                                                                                                                                                                                                
	ZADSFW = ""                                                                                                                                                                                                                                               
	cAtributoAAuditar = ""                                                                                                                                                                                                                                    
	cAtributoPK = ""                                                                                                                                                                                                                                          
	cAtributoVendedor = ''                                                                                                                                                                                                                                    
	cCaracteres = ""                                                                                                                                                                                                                                          
	cContexto = ""                                                                                                                                                                                                                                            
	cDescripcion =  "Listados personalizados"                                                                                                                                                                                                                 
	cDescripcionSingular = ""                                                                                                                                                                                                                                 
	cEvento = ""                                                                                                                                                                                                                                              
	cFormatoFechaNet = ""                                                                                                                                                                                                                                     
	cIdentificadorConexion = ""                                                                                                                                                                                                                               
	cListado = ""                                                                                                                                                                                                                                             
	cNombre = ""                                                                                                                                                                                                                                              
	cNombre = 'LISTADOSPERSONALIZADOS'                                                                                                                                                                                                                        
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
	lIgnorarCamposObligatoriosDefinidosPorUsuario = .F.                                                                                                                                                                                                       
	lIgnorarClaveprimariaEnRecepcionBD = .f.                                                                                                                                                                                                                  
	lInicializarCodigoSugeridoHabilitado = .f.                                                                                                                                                                                                                
	lInstanciarSubEntidadaDemanda = .t.                                                                                                                                                                                                                       
	lLimpiando = .f.                                                                                                                                                                                                                                          
	lLoguear = .T.                                                                                                                                                                                                                                            
	lLoguear = .f.                                                                                                                                                                                                                                            
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
	oAD = null                                                                                                                                                                                                                                                
	oAtributosAnulacion = null                                                                                                                                                                                                                                
	oAtributosAuditoria = null                                                                                                                                                                                                                                
	oAtributosConEdicionRestringida= null                                                                                                                                                                                                                     
	oColAtributosObligatoriosDefinidosPorUsuario = null                                                                                                                                                                                                       
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
	function anulado_assign( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'anulado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'anulado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Anulado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Anulado( lxVal )				this.Setear_Anulado( lxVal )			EndIf		Else			This.Setear_Anulado( lxVal )		EndIf		dodefault( lxVal )
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
	function basededatos_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatos( lxVal )				this.Setear_Basededatos( lxVal )			EndIf		Else			This.Setear_Basededatos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_access() as date                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosAltaFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosaltafw( lxVal )				this.Setear_Basededatosaltafw( lxVal )			EndIf		Else			This.Setear_Basededatosaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosdetallada_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosdetallada_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosdetallada_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosdetallada		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosdetallada( lxVal )				this.Setear_Basededatosdetallada( lxVal )			EndIf		Else			This.Setear_Basededatosdetallada( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_access() as date                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosModificacionFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosmodificacionfw( lxVal )				this.Setear_Basededatosmodificacionfw( lxVal )			EndIf		Else			This.Setear_Basededatosmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'bloquearregistro_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'bloquearregistro_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Bloquearregistro		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Bloquearregistro( lxVal )				this.Setear_Bloquearregistro( lxVal )			EndIf		Else			This.Setear_Bloquearregistro( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'BuscarClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'BuscarClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.		this.Crear_oClases()				if _screen.oClases.GetKey( sys(2007, alltrim( lower( tcClase )),0,1)) > 0			llRetorno = .t.		else			if this.ExisteArchivoClase( tcClase )				this.AgregarClaseAColeccion( tcClase )				llRetorno = .t.			endif		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetallecamposdetalle() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetallecamposdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetallefiltrosdetalle() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetallefiltrosdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetalleordenamientosdetalle() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetalleordenamientosdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetallesalidasdetalle() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetallesalidasdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetallesubtotaldetalle() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetallesubtotaldetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosumarizado() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosumarizado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function camposdetalle_access() as variant                                                                                                                                                                                                                
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'camposdetalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'camposdetalle_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Camposdetalle ) = 'O' or isnull( this.Camposdetalle ) )			this.Camposdetalle = this.crearobjeto( 'Din_DetalleListadospersonalizadosCamposdetalle' )			this.Camposdetalle.inicializar()			this.enlazar( 'Camposdetalle.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Camposdetalle.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Camposdetalle, 'CambioSumarizado', this, 'CambiosDetalleCamposdetalle', 1)			this.enlazar( 'Camposdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Camposdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Camposdetalle
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
	function clistado_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'clistado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'clistado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Clistado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Clistado( lxVal )				this.Setear_Clistado( lxVal )			EndIf		Else			This.Setear_Clistado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigo_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigo_assign', lcParametros )			endif		endif		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean		with this			llEdicion = .EsEdicion()			if !this.lPermiteMinusculasPK				try					txVal = upper( txVal )				Catch				Endtry			endif			if .lLimpiando or .lCargando				.Codigo = .TransformarAlAsignar( txVal )			else				if llEdicion				else					llNuevo = .EsNuevo()					.Codigo = .TransformarAlAsignar( txVal )					if empty( txVal ) and !llNuevo						.Limpiar()					else						if llNuevo							if .ValidarIngreso( txVal, llNuevo )							else								goServicios.Errores.LevantarExcepcion( 'Caracter inválido en el código.' )							endif						endif						llConsulta = .oAD.ConsultarPorClavePrimaria()						do case							case !llNuevo and llConsulta								.Cargar()							case !llNuevo and !llConsulta								.Limpiar()								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )							case llNuevo and llConsulta								.Codigo = []								goServicios.Errores.LevantarExcepcion( 'El código ' + alltrim( transform( txVal ) ) + ' ya existe.' )						endcase					endif				endif			endif		endwith
	EndFunc

	*-----------------------------------------------------------------------------------------
	function colorparaelsombreado_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'colorparaelsombreado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'colorparaelsombreado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Colorparaelsombreado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Colorparaelsombreado( lxVal )				this.Setear_Colorparaelsombreado( lxVal )			EndIf		Else			This.Setear_Colorparaelsombreado( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Crear_oClases', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Crear_oClases', lcParametros )			endif		endif		if !pemstatus( _screen, "oClases", 5 )				_screen.AddObject( "oClases", "Collection" )		endif				if !vartype( _screen.oClases ) = 'O' and isnull( _screen.oClases )			_screen.oClases = newobject( "Collection" )		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crearobjeto( tcclase as string, tclibreria as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant )                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9, lxParam10lnParametros = pcount()lxParam1 = tcclaselxParam2 = tclibrerialxParam3 = tvpar1lxParam4 = tvpar2lxParam5 = tvpar3lxParam6 = tvpar4lxParam7 = tvpar5lxParam8 = tvpar6lxParam9 = tvpar7lxParam10 = tvpar8lcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'crearobjeto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'crearobjeto', lcParametros )			endif		endif		Local loReturn As Object, lnParametrosReales As Integer, lcClase as String, lcConstructor as string, lcComando as String, ;			lnParamAux as Integer, lcClase as String, lcLibreria as String , lcSetProcedure as String,;			loErrorBase as Exception, loEx as Exception, loRetorno as object, lcConstructor as String, lcProcedure as String,;			lcSetClassLib as String, lcSet as String, loMock as Object, lcClaseProxy as String					loReturn = Null		lcLibreria = tcLibreria		lcClaseProxy = ""				*-------------------------------------------------------------------		if pemstatus(_screen, "Mocks", 5 ) and vartype( _Screen.Mocks ) = "O"				*Instanciación de Mocks			*Objeto solo instanciado en DESARROLLO.			if _screen.Mocks.lUtilizarMockV2 and this.buscarClase( forceext( "MockV2_" + tcClase, "prg" ) )				lcClase = "MockV2_" + tcClase			else				if _screen.Mocks.lUtilizarMockV1					local lnItem as Integer					lcClase = this.ObtenerNombreClase( tcClase )					lnItem = _Screen.Mocks.BuscarMock( lcClase )										if !empty( lnItem )						loMock = _Screen.Mocks.Item[lnItem]						loMock.lUsado = .t.						lcClase = loMock.cNombreClaseMock												if empty( loMock.cNombrePrgMock )							lcLibreria = iif( empty( lcLibreria ), "", "Mock_" + justfname( lcLibreria ) )						else							lcLibreria = loMock.cNombrePrgMock						endif					else						lcClase = tcClase					endif				else					lcClase = tcClase				endif			endif		else			lcClase = tcClase		endif		*-------------------------------------------------------------------		If empty( lcLibreria )			lcLibreria = forceext( lcClase, "prg" )		endif				If Pcount() > 1			lnParamAux = 2		Else			lnParamAux = 1		EndIf		lnParametrosReales = Pcount() - lnParamAux			loRetorno = null				try			if this.EsClaseNet( lcClase )				if !pemstatus( _screen, "NetExtender", 5 )					goServicios.Errores.LevantarExcepcion( "Para instanciar un objeto net debe haber iniciado la aplicación." )				endif				lcComando = this.ObtenerSentenciaConDesgloseParametros( "ClrCreateObject", lcClase, "", "", lnParametrosReales )				loRetorno = this.CrearObjetoNet( lcComando, tvPar1, tvPar2, tvPar3, tvPar4, tvPar5, tvPar6, tvPar7, tvPar8 )			else				lcClase = justfname( lcClase )								if lnParametrosReales = 0 and vartype( _Screen.Zoo ) = "O" and !isnull( _Screen.Zoo ) and !isnull( _screen.Zoo.oConstructor )					lcClaseProxy = _screen.Zoo.oConstructor.ObtenerNombreClaseProxy( lcClase, lcLibreria )				endif				if !empty( lcClaseProxy )					loRetorno = _screen.Zoo.oConstructor.CrearObjeto( lcClaseProxy, set( "Datasession" ) )				else					lcSetProcedure = set('Procedure')					lcSetClassLib = set("Classlib")												if upper( justext( lcLibreria )) = "VCX"						lcSet  = "SET CLASSLIB TO "					else						lcSet = "SET PROCEDURE TO "					endif													if this.lEsExe and upper( justext( lcLibreria ) ) == "PRG"						&& En el Exe solo se pueden instanciar los archivos FXP, si no se fuerza la extensión recorre todo el path buscando el PRG.						lcLibreria = forceext( lcLibreria, "fxp" )						lcProcedure = lcLibreria					else						lcProcedure = forceext( lcLibreria, "" )					endif												lcSet = lcSet + "'" + lcProcedure + "'"										if this.BuscarClase( lcLibreria )						&lcSet					endif																			if lnParametrosReales > 0						lcComando = this.ObtenerSentenciaConDesgloseParametros( "NewObject", lcClase, lcLibreria , "", lnParametrosReales )						loRetorno = &lcComando					else						loRetorno = newobject( lcClase, lcLibreria )					endif									if !(lower(lcSetClassLib) == lower(set("Classlib")))						set classlib to &lcSetClassLib					endif						set procedure to &lcSetProcedure				endif			endif		Catch To loErrorBase				local lnError as Integer			lnError = 0						if loErrorBase.ErrorNo = 1 and left( lower( lcLibreria ), 4 ) == "din_"				do case					case !this.BuscarClase( strtran( lower( lcLibreria ), ".prg", ".fxp" ) )						lnError = 10					case !this.BuscarClase( lcLibreria )						lnError	= 20				endcase			endif			loEx = Newobject( "ZooException", "ZooException.prg" )			With loEx				.Grabar( loErrorBase )				.nZooErrorNo = lnError				.Throw()			EndWith		EndTry		return loRetorno
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
	function descripcion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descripcion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descripcion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descripcion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descripcion( lxVal )				this.Setear_Descripcion( lxVal )			EndIf		Else			This.Setear_Descripcion( lxVal )		EndIf		dodefault( lxVal )
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
	function destinoarchivo_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'destinoarchivo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'destinoarchivo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Destinoarchivo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Destinoarchivo( lxVal )				this.Setear_Destinoarchivo( lxVal )			EndIf		Else			This.Setear_Destinoarchivo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function destinofechahora_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'destinofechahora_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'destinofechahora_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Destinofechahora		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Destinofechahora( lxVal )				this.Setear_Destinofechahora( lxVal )			EndIf		Else			This.Setear_Destinofechahora( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function destinoruta_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'destinoruta_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'destinoruta_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Destinoruta		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Destinoruta( lxVal )				this.Setear_Destinoruta( lxVal )			EndIf		Else			This.Setear_Destinoruta( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function destinotipo_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'destinotipo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'destinotipo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Destinotipo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Destinotipo( lxVal )				this.Setear_Destinotipo( lxVal )			EndIf		Else			This.Setear_Destinotipo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function diferenciardetalle_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'diferenciardetalle_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'diferenciardetalle_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Diferenciardetalle		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Diferenciardetalle( lxVal )				this.Setear_Diferenciardetalle( lxVal )			EndIf		Else			This.Setear_Diferenciardetalle( lxVal )		EndIf		dodefault( lxVal )
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
	function esdefault_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'esdefault_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'esdefault_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Esdefault		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Esdefault( lxVal )				this.Setear_Esdefault( lxVal )			EndIf		Else			This.Setear_Esdefault( lxVal )		EndIf		dodefault( lxVal )
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
	function estaanulado() as boolean                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estaanulado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estadotransferencia_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estadotransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estadotransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Estadotransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Estadotransferencia( lxVal )				this.Setear_Estadotransferencia( lxVal )			EndIf		Else			This.Setear_Estadotransferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaenproceso() as boolean                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estaenproceso', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estaenproceso', lcParametros )			endif		endif		local lRetorno as Boolean		with this			lRetorno = ( .lProcesando or .lCargando or .lLimpiando or .lDestroy )		endwith		return lRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estilo_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estilo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estilo_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Estilo ) = 'O' or isnull( this.Estilo ) )					this.Estilo = _Screen.zoo.instanciarentidad( 'Estiloimpresion' )					this.Estilo.lEsSubEntidad = .t.					this.enlazar( 'Estilo.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Estilo.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Estilo.CODIGO # this.Estilo_PK						this.Estilo.CODIGO = this.Estilo_PK					endif				endif			endif		endif		return this.Estilo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estilo_pk_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estilo_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estilo_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Estilo_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Estilo_PK = lxVal		if this.Validar_Estilo( lxVal, lxValOld )			This.Setear_Estilo( lxVal )		endif		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcfilelcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ExisteArchivoClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ExisteArchivoClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.				if _VFP.StartMode = 5 and !_screen.zoo.EsBuildAutomatico &&and "FOXEXTENDER" $ upper( sys( 16 ) )			try				do ( tcFile )				llRetorno = .t.			catch			endtry		else			llRetorno = file( tcFile )		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_access', lcParametros )			endif		endif		if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.FechaAltaFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaaltafw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaaltafw( lxVal )			EndIf		Else			This.Setear_Fechaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaexpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaexpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaexpo( lxVal )			EndIf		Else			This.Setear_Fechaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaimpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaimpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaimpo( lxVal )			EndIf		Else			This.Setear_Fechaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			This.FechaModificacionFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechamodificacionfw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechamodificacionfw( lxVal )			EndIf		Else			This.Setear_Fechamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechatransferencia_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechatransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechatransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechatransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechatransferencia( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechatransferencia( lxVal )			EndIf		Else			This.Setear_Fechatransferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function filtrosdetalle_access() as variant                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'filtrosdetalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'filtrosdetalle_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Filtrosdetalle ) = 'O' or isnull( this.Filtrosdetalle ) )			this.Filtrosdetalle = this.crearobjeto( 'Din_DetalleListadospersonalizadosFiltrosdetalle' )			this.Filtrosdetalle.inicializar()			this.enlazar( 'Filtrosdetalle.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Filtrosdetalle.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Filtrosdetalle, 'CambioSumarizado', this, 'CambiosDetalleFiltrosdetalle', 1)			this.enlazar( 'Filtrosdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Filtrosdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Filtrosdetalle
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_access', lcParametros )			endif		endif				if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			this.HoraAltaFW = goLibrerias.ObtenerHora()		endif		return this.HoraAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaaltafw( lxVal )				this.Setear_Horaaltafw( lxVal )			EndIf		Else			This.Setear_Horaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaexpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaexpo( lxVal )				this.Setear_Horaexpo( lxVal )			EndIf		Else			This.Setear_Horaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaimpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaimpo( lxVal )				this.Setear_Horaimpo( lxVal )			EndIf		Else			This.Setear_Horaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_access() as string                                                                                                                                                                                                            
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			this.HoraModificacionFW = goServicios.Librerias.ObtenerHora()		endif		return this.HoraModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horamodificacionfw( lxVal )				this.Setear_Horamodificacionfw( lxVal )			EndIf		Else			This.Setear_Horamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function identificadorordenamiento_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'identificadorordenamiento_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'identificadorordenamiento_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Identificadorordenamiento		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Identificadorordenamiento( lxVal )				this.Setear_Identificadorordenamiento( lxVal )			EndIf		Else			This.Setear_Identificadorordenamiento( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imagenlistado_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imagenlistado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imagenlistado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imagenlistado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imagenlistado( lxVal )				this.Setear_Imagenlistado( lxVal )			EndIf		Else			This.Setear_Imagenlistado( lxVal )		EndIf		dodefault( lxVal )
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
	function imprimeencabezadodedetalle_assign( txval as variant ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimeencabezadodedetalle_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimeencabezadodedetalle_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimeencabezadodedetalle		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimeencabezadodedetalle( lxVal )				this.Setear_Imprimeencabezadodedetalle( lxVal )			EndIf		Else			This.Setear_Imprimeencabezadodedetalle( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimeencabezadodepagina_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimeencabezadodepagina_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimeencabezadodepagina_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimeencabezadodepagina		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimeencabezadodepagina( lxVal )				this.Setear_Imprimeencabezadodepagina( lxVal )			EndIf		Else			This.Setear_Imprimeencabezadodepagina( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimeencabezadodereporte_assign( txval as variant ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimeencabezadodereporte_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimeencabezadodereporte_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimeencabezadodereporte		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimeencabezadodereporte( lxVal )				this.Setear_Imprimeencabezadodereporte( lxVal )			EndIf		Else			This.Setear_Imprimeencabezadodereporte( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimefechadeimpresion_assign( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimefechadeimpresion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimefechadeimpresion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimefechadeimpresion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimefechadeimpresion( lxVal )				this.Setear_Imprimefechadeimpresion( lxVal )			EndIf		Else			This.Setear_Imprimefechadeimpresion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimehoradeimpresion_assign( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimehoradeimpresion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimehoradeimpresion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimehoradeimpresion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimehoradeimpresion( lxVal )				this.Setear_Imprimehoradeimpresion( lxVal )			EndIf		Else			This.Setear_Imprimehoradeimpresion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimeinformaciondecontexto_assign( txval as variant ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimeinformaciondecontexto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimeinformaciondecontexto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimeinformaciondecontexto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimeinformaciondecontexto( lxVal )				this.Setear_Imprimeinformaciondecontexto( lxVal )			EndIf		Else			This.Setear_Imprimeinformaciondecontexto( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimeinformaciondecorrida_assign( txval as variant ) as void                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimeinformaciondecorrida_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimeinformaciondecorrida_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimeinformaciondecorrida		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimeinformaciondecorrida( lxVal )				this.Setear_Imprimeinformaciondecorrida( lxVal )			EndIf		Else			This.Setear_Imprimeinformaciondecorrida( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imprimeresumendereporte_assign( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimeresumendereporte_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimeresumendereporte_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimeresumendereporte		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimeresumendereporte( lxVal )				this.Setear_Imprimeresumendereporte( lxVal )			EndIf		Else			This.Setear_Imprimeresumendereporte( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lesentidadconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lesentidadconedicionrestringida_access', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = .f.		if vartype( this.oAtributosConEdicionRestringida ) = 'O' and this.oAtributosConEdicionRestringida.Count > 0			llRetorno = .t.		endif		return llRetorno
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
	function mailasunto_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mailasunto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mailasunto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mailasunto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mailasunto( lxVal )				this.Setear_Mailasunto( lxVal )			EndIf		Else			This.Setear_Mailasunto( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mailconcopia_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mailconcopia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mailconcopia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mailconcopia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mailconcopia( lxVal )				this.ValidarDominio_Mail( lxVal )				this.Setear_Mailconcopia( lxVal )			EndIf		Else			This.Setear_Mailconcopia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mailconcopiaoculta_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mailconcopiaoculta_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mailconcopiaoculta_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mailconcopiaoculta		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mailconcopiaoculta( lxVal )				this.ValidarDominio_Mail( lxVal )				this.Setear_Mailconcopiaoculta( lxVal )			EndIf		Else			This.Setear_Mailconcopiaoculta( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mailmensaje_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mailmensaje_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mailmensaje_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mailmensaje		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mailmensaje( lxVal )				this.Setear_Mailmensaje( lxVal )			EndIf		Else			This.Setear_Mailmensaje( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mailpara_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mailpara_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mailpara_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mailpara		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mailpara( lxVal )				this.ValidarDominio_Mail( lxVal )				this.Setear_Mailpara( lxVal )			EndIf		Else			This.Setear_Mailpara( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mantenergruposunidos_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'mantenergruposunidos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'mantenergruposunidos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Mantenergruposunidos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Mantenergruposunidos( lxVal )				this.Setear_Mantenergruposunidos( lxVal )			EndIf		Else			This.Setear_Mantenergruposunidos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function margencabecera_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margencabecera_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margencabecera_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margencabecera		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margencabecera( lxVal )				this.Setear_Margencabecera( lxVal )			EndIf		Else			This.Setear_Margencabecera( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function margenderecho_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margenderecho_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margenderecho_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margenderecho		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margenderecho( lxVal )				this.Setear_Margenderecho( lxVal )			EndIf		Else			This.Setear_Margenderecho( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function margenizquierdo_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margenizquierdo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margenizquierdo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margenizquierdo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margenizquierdo( lxVal )				this.Setear_Margenizquierdo( lxVal )			EndIf		Else			This.Setear_Margenizquierdo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function margenpie_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'margenpie_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'margenpie_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Margenpie		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Margenpie( lxVal )				this.Setear_Margenpie( lxVal )			EndIf		Else			This.Setear_Margenpie( lxVal )		EndIf		dodefault( lxVal )
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
	function numeraciondepaginasimple_assign( txval as variant ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'numeraciondepaginasimple_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'numeraciondepaginasimple_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Numeraciondepaginasimple		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Numeraciondepaginasimple( lxVal )				this.Setear_Numeraciondepaginasimple( lxVal )			EndIf		Else			This.Setear_Numeraciondepaginasimple( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oad_access() as variant                                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oad_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oad_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )			this.oAD = this.crearobjeto( 'ListadosPersonalizadosAD_' + alltrim( _screen.zoo.app.TipoDeBase ))			this.oAD.InyectarEntidad( this )			this.oAD.Inicializar()		endif		return this.oAD
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oatributosconedicionrestringida_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oatributosconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oatributosconedicionrestringida_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oAtributosConEdicionRestringida ) = 'O'			this.oAtributosConEdicionRestringida = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oAtributosConEdicionRestringida
	EndFunc

	*-----------------------------------------------------------------------------------------
	function observacion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'observacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'observacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Observacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Observacion( lxVal )				this.Setear_Observacion( lxVal )			EndIf		Else			This.Setear_Observacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoclaveprimaria() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obteneratributoclaveprimaria', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obteneratributoclaveprimaria', lcParametros )			endif		endif		return this.cAtributoPK
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenerdescripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenerdescripcion', lcParametros )			endif		endif		return this.cDescripcion
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
	function ocolatributosobligatoriosdefinidosporusuario_access() as object                                                                                                                                                                                  
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			endif		endif		local loRetorno as Object				loRetorno = null		if !this.lDestroy					loRetorno = goServicios.SaltosDeCampoyValoresSugeridos.ObtenerColeccionAtributosObligatorios( this.ObtenerNombre() )		endif				return loRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocomportamientocodigosugerido_access() as void                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocomportamientocodigosugerido_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocomportamientocodigosugerido_access', lcParametros )			endif		endif		local loComportamientoCodigoSugerido as Object		if !this.ldestroy and !vartype( this.oComportamientoCodigoSugerido ) = 'O'			loComportamientoCodigoSugerido = _Screen.zoo.CrearObjeto( "DecoradorDeCodigosDeEntidades" )			this.InicializarComportamientoCodigoSugerido(loComportamientoCodigoSugerido )			this.oComportamientoCodigoSugerido = loComportamientoCodigoSugerido		endif		return this.oComportamientoCodigoSugerido
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ogestordemail_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ogestordemail_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ogestordemail_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oGestorDeMail ) = 'O'			this.oGestorDeMail = _Screen.zoo.CrearObjeto( "GestorDeMail" )		endif		return this.oGestorDeMail
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oinformacion_access() as variant                                                                                                                                                                                                                 
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oinformacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oinformacion_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )				this.eventoObtenerInformacion( this )				if !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )					.oInformacion = this.CrearObjeto( "ZooInformacion" )				endif				endif		endwith		return this.oInformacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ologueo_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ologueo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ologueo_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oLogueo ) = 'O' and isnull( .oLogueo ) and vartype( goServicios ) = 'O'				this.eventoObtenerLogueo( this )				if !vartype( .oLogueo ) = 'O' and isnull( .oLogueo )					.oLogueo = goServicios.Logueos.obtenerObjetoLogueo( this )					.SetearAccion()					.lLogueoPropio = .T.				else					.lLogueoPropio = .F.								endif				endif		endwith		return this.oLogueo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function omensaje_access() as void                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'omensaje_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'omensaje_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oMensaje ) = 'O' or isnull( this.oMensaje ) )			this.oMensaje = _screen.zoo.crearobjeto( "mensajeentidad", "", this )		endif				return this.oMensaje
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oobservadoresdeimportacion_access() as variant                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oobservadoresdeimportacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oobservadoresdeimportacion_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oObservadoresDeImportacion ) = 'O' or isnull( this.oObservadoresDeImportacion ) )			this.oObservadoresDeImportacion = _Screen.zoo.crearobjeto( 'ZooColeccion' )		endif		return this.oObservadoresDeImportacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ordenadopor_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ordenadopor_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ordenadopor_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ordenadopor		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ordenadopor( lxVal )				this.Setear_Ordenadopor( lxVal )			EndIf		Else			This.Setear_Ordenadopor( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ordenamientosdetalle_access() as variant                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ordenamientosdetalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ordenamientosdetalle_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Ordenamientosdetalle ) = 'O' or isnull( this.Ordenamientosdetalle ) )			this.Ordenamientosdetalle = this.crearobjeto( 'Din_DetalleListadospersonalizadosOrdenamientosdetalle' )			this.Ordenamientosdetalle.inicializar()			this.enlazar( 'Ordenamientosdetalle.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Ordenamientosdetalle.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Ordenamientosdetalle, 'CambioSumarizado', this, 'CambiosDetalleOrdenamientosdetalle', 1)			this.enlazar( 'Ordenamientosdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Ordenamientosdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Ordenamientosdetalle
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oregistrosdeactividadesalgrabar_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oregistrosdeactividadesalgrabar_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oregistrosdeactividadesalgrabar_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oRegistrosDeActividadesAlGrabar ) = 'O'			this.oRegistrosDeActividadesAlGrabar = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oRegistrosDeActividadesAlGrabar
	EndFunc

	*-----------------------------------------------------------------------------------------
	function orientacion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'orientacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'orientacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Orientacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Orientacion( lxVal )				this.Setear_Orientacion( lxVal )			EndIf		Else			This.Setear_Orientacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function otalle_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'otalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'otalle_access', lcParametros )			endif		endif		if this.ldestroy		else			if ( !vartype( this.oTalle ) = 'O' or isnull( this.oTalle ) )				this.oTalle = _Screen.zoo.instanciarentidad( 'Talle' )			endif		endif		return this.oTalle
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ovalidadorescomp_access() as object                                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ovalidadorescomp_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ovalidadorescomp_access', lcParametros )			endif		endif		if !this.lDestroy and !( vartype( this.oValidadoresComp ) == "O" )			this.oValidadoresComp = _screen.Zoo.Crearobjeto( "ZooColeccion" )		endif				return this.oValidadoresComp
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
	function repetircabecerasdegrupos_assign( txval as variant ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'repetircabecerasdegrupos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'repetircabecerasdegrupos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Repetircabecerasdegrupos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Repetircabecerasdegrupos( lxVal )				this.Setear_Repetircabecerasdegrupos( lxVal )			EndIf		Else			This.Setear_Repetircabecerasdegrupos( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurargenhabilitar() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurargenhabilitar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function salidasdetalle_access() as variant                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'salidasdetalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'salidasdetalle_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Salidasdetalle ) = 'O' or isnull( this.Salidasdetalle ) )			this.Salidasdetalle = this.crearobjeto( 'Din_DetalleListadospersonalizadosSalidasdetalle' )			this.Salidasdetalle.inicializar()			this.enlazar( 'Salidasdetalle.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Salidasdetalle.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Salidasdetalle, 'CambioSumarizado', this, 'CambiosDetalleSalidasdetalle', 1)			this.enlazar( 'Salidasdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Salidasdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Salidasdetalle
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
	function seriealtafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.SerieAltaFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriealtafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriealtafw( lxVal )				this.Setear_Seriealtafw( lxVal )			EndIf		Else			This.Setear_Seriealtafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.SerieModificacionFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriemodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriemodificacionfw( lxVal )				this.Setear_Seriemodificacionfw( lxVal )			EndIf		Else			This.Setear_Seriemodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_anulado( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_anulado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_anulado', lcParametros )			endif		endif		this.Anulado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatos( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatos', lcParametros )			endif		endif		this.Basededatos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosaltafw( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosaltafw', lcParametros )			endif		endif		this.Basededatosaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosdetallada( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosdetallada', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosdetallada', lcParametros )			endif		endif		this.Basededatosdetallada = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosmodificacionfw( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosmodificacionfw', lcParametros )			endif		endif		this.Basededatosmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_bloquearregistro( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_bloquearregistro', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_bloquearregistro', lcParametros )			endif		endif		this.Bloquearregistro = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_clistado( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_clistado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_clistado', lcParametros )			endif		endif		this.Clistado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_colorparaelsombreado( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_colorparaelsombreado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_colorparaelsombreado', lcParametros )			endif		endif		this.Colorparaelsombreado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descripcion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descripcion', lcParametros )			endif		endif		this.Descripcion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_destinoarchivo( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_destinoarchivo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_destinoarchivo', lcParametros )			endif		endif		this.Destinoarchivo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_destinofechahora( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_destinofechahora', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_destinofechahora', lcParametros )			endif		endif		this.Destinofechahora = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_destinoruta( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_destinoruta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_destinoruta', lcParametros )			endif		endif		this.Destinoruta = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_destinotipo( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_destinotipo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_destinotipo', lcParametros )			endif		endif		this.Destinotipo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_diferenciardetalle( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_diferenciardetalle', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_diferenciardetalle', lcParametros )			endif		endif		this.Diferenciardetalle = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_esdefault( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_esdefault', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_esdefault', lcParametros )			endif		endif		this.Esdefault = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_estadotransferencia( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_estadotransferencia', lcParametros )			endif		endif		this.Estadotransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_estilo( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_estilo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_estilo', lcParametros )			endif		endif		this.Estilo.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaaltafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaaltafw', lcParametros )			endif		endif		this.Fechaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaexpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaexpo', lcParametros )			endif		endif		this.Fechaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaimpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaimpo', lcParametros )			endif		endif		this.Fechaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechamodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechamodificacionfw', lcParametros )			endif		endif		this.Fechamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechatransferencia( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechatransferencia', lcParametros )			endif		endif		this.Fechatransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaaltafw( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaaltafw', lcParametros )			endif		endif		this.Horaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaexpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaexpo', lcParametros )			endif		endif		this.Horaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaimpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaimpo', lcParametros )			endif		endif		this.Horaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horamodificacionfw( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horamodificacionfw', lcParametros )			endif		endif		this.Horamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_identificadorordenamiento( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_identificadorordenamiento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_identificadorordenamiento', lcParametros )			endif		endif		this.Identificadorordenamiento = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imagenlistado( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imagenlistado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imagenlistado', lcParametros )			endif		endif		this.Imagenlistado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimeencabezadodedetalle( txval as variant ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimeencabezadodedetalle', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimeencabezadodedetalle', lcParametros )			endif		endif		this.Imprimeencabezadodedetalle = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimeencabezadodepagina( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimeencabezadodepagina', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimeencabezadodepagina', lcParametros )			endif		endif		this.Imprimeencabezadodepagina = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimeencabezadodereporte( txval as variant ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimeencabezadodereporte', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimeencabezadodereporte', lcParametros )			endif		endif		this.Imprimeencabezadodereporte = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimefechadeimpresion( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimefechadeimpresion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimefechadeimpresion', lcParametros )			endif		endif		this.Imprimefechadeimpresion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimehoradeimpresion( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimehoradeimpresion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimehoradeimpresion', lcParametros )			endif		endif		this.Imprimehoradeimpresion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimeinformaciondecontexto( txval as variant ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimeinformaciondecontexto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimeinformaciondecontexto', lcParametros )			endif		endif		this.Imprimeinformaciondecontexto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimeinformaciondecorrida( txval as variant ) as void                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimeinformaciondecorrida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimeinformaciondecorrida', lcParametros )			endif		endif		this.Imprimeinformaciondecorrida = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimeresumendereporte( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimeresumendereporte', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimeresumendereporte', lcParametros )			endif		endif		this.Imprimeresumendereporte = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mailasunto( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mailasunto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mailasunto', lcParametros )			endif		endif		this.Mailasunto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mailconcopia( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mailconcopia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mailconcopia', lcParametros )			endif		endif		this.Mailconcopia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mailconcopiaoculta( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mailconcopiaoculta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mailconcopiaoculta', lcParametros )			endif		endif		this.Mailconcopiaoculta = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mailmensaje( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mailmensaje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mailmensaje', lcParametros )			endif		endif		this.Mailmensaje = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mailpara( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mailpara', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mailpara', lcParametros )			endif		endif		this.Mailpara = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_mantenergruposunidos( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_mantenergruposunidos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_mantenergruposunidos', lcParametros )			endif		endif		this.Mantenergruposunidos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margencabecera( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margencabecera', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margencabecera', lcParametros )			endif		endif		this.Margencabecera = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margenderecho( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margenderecho', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margenderecho', lcParametros )			endif		endif		this.Margenderecho = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margenizquierdo( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margenizquierdo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margenizquierdo', lcParametros )			endif		endif		this.Margenizquierdo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_margenpie( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_margenpie', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_margenpie', lcParametros )			endif		endif		this.Margenpie = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_numeraciondepaginasimple( txval as variant ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_numeraciondepaginasimple', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_numeraciondepaginasimple', lcParametros )			endif		endif		this.Numeraciondepaginasimple = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_observacion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_observacion', lcParametros )			endif		endif		this.Observacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ordenadopor( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ordenadopor', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ordenadopor', lcParametros )			endif		endif		this.Ordenadopor = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_orientacion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_orientacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_orientacion', lcParametros )			endif		endif		this.Orientacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_repetircabecerasdegrupos( txval as variant ) as void                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_repetircabecerasdegrupos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_repetircabecerasdegrupos', lcParametros )			endif		endif		this.Repetircabecerasdegrupos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriealtafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriealtafw', lcParametros )			endif		endif		this.Seriealtafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriemodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriemodificacionfw', lcParametros )			endif		endif		this.Seriemodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_subtotaldetallado( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_subtotaldetallado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_subtotaldetallado', lcParametros )			endif		endif		this.Subtotaldetallado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipoordenamiento( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipoordenamiento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipoordenamiento', lcParametros )			endif		endif		this.Tipoordenamiento = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_titulolistado( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_titulolistado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_titulolistado', lcParametros )			endif		endif		this.Titulolistado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_titulosdecolumnasdegrupoencp( txval as variant ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_titulosdecolumnasdegrupoencp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_titulosdecolumnasdegrupoencp', lcParametros )			endif		endif		this.Titulosdecolumnasdegrupoencp = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_titulosdecolumnasdesubreporteencp( txval as variant ) as void                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_titulosdecolumnasdesubreporteencp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_titulosdecolumnasdesubreporteencp', lcParametros )			endif		endif		this.Titulosdecolumnasdesubreporteencp = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usatransporteentrepaginas( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usatransporteentrepaginas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usatransporteentrepaginas', lcParametros )			endif		endif		this.Usatransporteentrepaginas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuarioaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuarioaltafw', lcParametros )			endif		endif		this.Usuarioaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuariomodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuariomodificacionfw', lcParametros )			endif		endif		this.Usuariomodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionaltafw', lcParametros )			endif		endif		this.Versionaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionmodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionmodificacionfw', lcParametros )			endif		endif		this.Versionmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_zadsfw( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_zadsfw', lcParametros )			endif		endif		this.Zadsfw = txVal		dodefault( txVal )
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
	function soportabusquedaextendida( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'soportabusquedaextendida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'soportabusquedaextendida', lcParametros )			endif		endif		return This.oComportamientoCodigoSugerido.SoportaBusquedaExtendida()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function subtotaldetallado_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'subtotaldetallado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'subtotaldetallado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Subtotaldetallado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Subtotaldetallado( lxVal )				this.Setear_Subtotaldetallado( lxVal )			EndIf		Else			This.Setear_Subtotaldetallado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function subtotaldetalle_access() as variant                                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'subtotaldetalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'subtotaldetalle_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Subtotaldetalle ) = 'O' or isnull( this.Subtotaldetalle ) )			this.Subtotaldetalle = this.crearobjeto( 'Din_DetalleListadospersonalizadosSubtotaldetalle' )			this.Subtotaldetalle.inicializar()			this.enlazar( 'Subtotaldetalle.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Subtotaldetalle.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Subtotaldetalle, 'CambioSumarizado', this, 'CambiosDetalleSubtotaldetalle', 1)			this.enlazar( 'Subtotaldetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Subtotaldetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Subtotaldetalle
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
	function tipoordenamiento_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipoordenamiento_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipoordenamiento_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipoordenamiento		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipoordenamiento( lxVal )				this.Setear_Tipoordenamiento( lxVal )			EndIf		Else			This.Setear_Tipoordenamiento( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function titulolistado_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'titulolistado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'titulolistado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Titulolistado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Titulolistado( lxVal )				this.Setear_Titulolistado( lxVal )			EndIf		Else			This.Setear_Titulolistado( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function titulosdecolumnasdegrupoencp_assign( txval as variant ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'titulosdecolumnasdegrupoencp_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'titulosdecolumnasdegrupoencp_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Titulosdecolumnasdegrupoencp		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Titulosdecolumnasdegrupoencp( lxVal )				this.Setear_Titulosdecolumnasdegrupoencp( lxVal )			EndIf		Else			This.Setear_Titulosdecolumnasdegrupoencp( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function titulosdecolumnasdesubreporteencp_assign( txval as variant ) as void                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'titulosdecolumnasdesubreporteencp_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'titulosdecolumnasdesubreporteencp_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Titulosdecolumnasdesubreporteencp		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Titulosdecolumnasdesubreporteencp( lxVal )				this.Setear_Titulosdecolumnasdesubreporteencp( lxVal )			EndIf		Else			This.Setear_Titulosdecolumnasdesubreporteencp( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ultimo () as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ultimo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usatransporteentrepaginas_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usatransporteentrepaginas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usatransporteentrepaginas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usatransporteentrepaginas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usatransporteentrepaginas( lxVal )				this.Setear_Usatransporteentrepaginas( lxVal )			EndIf		Else			This.Setear_Usatransporteentrepaginas( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_access() as date                                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.UsuarioAltaFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() ) + this.UsuarioAutorizante()		endif		return This.UsuarioAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuarioaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuarioaltafw( lxVal )				this.Setear_Usuarioaltafw( lxVal )			EndIf		Else			This.Setear_Usuarioaltafw( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.UsuarioModificacionFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() )  + this.UsuarioAutorizante()		endif		return This.UsuarioModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuariomodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuariomodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuariomodificacionfw( lxVal )				this.Setear_Usuariomodificacionfw( lxVal )			EndIf		Else			This.Setear_Usuariomodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
	function validar_anulado( txval as variant ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_anulado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_anulado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatos( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosaltafw( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosdetallada( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosdetallada', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosdetallada', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_bloquearregistro( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_bloquearregistro', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_bloquearregistro', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_clistado( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_clistado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_clistado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_colorparaelsombreado( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_colorparaelsombreado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_colorparaelsombreado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descripcion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descripcion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_destinoarchivo( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_destinoarchivo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_destinoarchivo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_destinofechahora( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_destinofechahora', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_destinofechahora', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_destinoruta( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_destinoruta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_destinoruta', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_destinotipo( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_destinotipo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_destinotipo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_diferenciardetalle( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_diferenciardetalle', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_diferenciardetalle', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_esdefault( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_esdefault', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_esdefault', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_estadotransferencia( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_estadotransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_estilo( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_estilo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_estilo', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaaltafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaexpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaimpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechatransferencia( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechatransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaaltafw( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaexpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaimpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_identificadorordenamiento( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_identificadorordenamiento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_identificadorordenamiento', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imagenlistado( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imagenlistado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imagenlistado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimeencabezadodedetalle( txval as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimeencabezadodedetalle', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimeencabezadodedetalle', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimeencabezadodepagina( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimeencabezadodepagina', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimeencabezadodepagina', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimeencabezadodereporte( txval as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimeencabezadodereporte', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimeencabezadodereporte', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimefechadeimpresion( txval as variant ) as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimefechadeimpresion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimefechadeimpresion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimehoradeimpresion( txval as variant ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimehoradeimpresion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimehoradeimpresion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimeinformaciondecontexto( txval as variant ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimeinformaciondecontexto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimeinformaciondecontexto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimeinformaciondecorrida( txval as variant ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimeinformaciondecorrida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimeinformaciondecorrida', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimeresumendereporte( txval as variant ) as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimeresumendereporte', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimeresumendereporte', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mailasunto( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mailasunto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mailasunto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mailconcopia( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mailconcopia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mailconcopia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mailconcopiaoculta( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mailconcopiaoculta', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mailconcopiaoculta', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mailmensaje( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mailmensaje', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mailmensaje', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mailpara( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mailpara', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mailpara', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_mantenergruposunidos( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_mantenergruposunidos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_mantenergruposunidos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margencabecera( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margencabecera', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margencabecera', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margenderecho( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margenderecho', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margenderecho', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margenizquierdo( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margenizquierdo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margenizquierdo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_margenpie( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_margenpie', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_margenpie', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_numeraciondepaginasimple( txval as variant ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_numeraciondepaginasimple', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_numeraciondepaginasimple', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_observacion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_observacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ordenadopor( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ordenadopor', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ordenadopor', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_orientacion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_orientacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_orientacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_repetircabecerasdegrupos( txval as variant ) as boolean                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_repetircabecerasdegrupos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_repetircabecerasdegrupos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriealtafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriealtafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriemodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriemodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_subtotaldetallado( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_subtotaldetallado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_subtotaldetallado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipoordenamiento( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipoordenamiento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipoordenamiento', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_titulolistado( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_titulolistado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_titulolistado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_titulosdecolumnasdegrupoencp( txval as variant ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_titulosdecolumnasdegrupoencp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_titulosdecolumnasdegrupoencp', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_titulosdecolumnasdesubreporteencp( txval as variant ) as boolean                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_titulosdecolumnasdesubreporteencp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_titulosdecolumnasdesubreporteencp', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usatransporteentrepaginas( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usatransporteentrepaginas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usatransporteentrepaginas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuarioaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuarioaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuariomodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuariomodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_zadsfw( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_zadsfw', lcParametros )			endif		endif		Return dodefault( txVal )
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
	function validarelenviodeemailalimportarporbuffer() as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarelenviodeemailalimportarporbuffer', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarestilo() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarestilo', lcParametros )
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
	function validarpk() as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarpk', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridobasededatos() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridobasededatos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridobasededatosdetallada() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridobasededatosdetallada', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoclistado() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoclistado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocolorparaelsombreado() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocolorparaelsombreado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodescripcion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodescripcion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodestinoarchivo() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodestinoarchivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodestinofechahora() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodestinofechahora', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodestinoruta() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodestinoruta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodestinotipo() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodestinotipo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodiferenciardetalle() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodiferenciardetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoesdefault() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoesdefault', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoestilo() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoestilo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwimprimefechadeimpresion() as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwimprimefechadeimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofwimprimehoradeimpresion() as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofwimprimehoradeimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoimagenlistado() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoimagenlistado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoimprimefechadeimpresion() as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoimprimefechadeimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoimprimehoradeimpresion() as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoimprimehoradeimpresion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomailasunto() as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomailasunto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomailconcopia() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomailconcopia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomailconcopiaoculta() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomailconcopiaoculta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomailmensaje() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomailmensaje', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomailpara() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomailpara', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargencabecera() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargencabecera', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargenderecho() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargenderecho', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargenizquierdo() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargenizquierdo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomargenpie() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomargenpie', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoobservacion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoobservacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoordenadopor() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoordenadopor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoorientacion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoorientacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridosubtotaldetallado() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridosubtotaldetallado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotipoordenamiento() as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotipoordenamiento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotitulolistado() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotitulolistado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarcontexto( tctipos as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tctiposlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'verificarcontexto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'verificarcontexto', lcParametros )			endif		endif		local llRetorno as boolean, i as Integer, lcLetra as string				if empty( tcTipos )			llRetorno = empty( this.cContexto )		else			tcTipos = upper( alltrim( tcTipos ) )			llRetorno = .f.			for i = 1 to len( tcTipos )				lcLetra = substr( tcTipos, i, 1 )				llRetorno = ( lcLetra $ this.cContexto ) or llRetorno				if llRetorno					exit				endif			endfor		endif				return llRetorno
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.VersionAltaFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionaltafw( lxVal )				this.Setear_Versionaltafw( lxVal )			EndIf		Else			This.Setear_Versionaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_access() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.VersionModificacionFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionmodificacionfw( lxVal )				this.Setear_Versionmodificacionfw( lxVal )			EndIf		Else			This.Setear_Versionmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'zadsfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'zadsfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Zadsfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Zadsfw( lxVal )				this.Setear_Zadsfw( lxVal )			EndIf		Else			This.Setear_Zadsfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'esclasenet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'esclasenet', lcParametros )			endif		endif		return "." $ tcClase
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenernombreclase( tcclase ) as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenernombreclase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenernombreclase', lcParametros )			endif		endif		Local lcRetorno as String, lcNombreApp as String		if upper( substr( alltrim( tcClase ), len( alltrim( tcClase ) ) - 1 ) ) = "UO"			if !this.lEsExe and this.BuscarClase( alltrim( tcClase ) + "UO.prg" )				lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			else				lcRetorno = tcClase			endif		else			if type( "_screen.zoo.app.cProyecto" ) = "C"				lcNombreApp = upper( _screen.zoo.app.cProyecto )			else				lcNombreApp = ""			endif							do case				case upper( left( tcClase, 4 ) ) = "ENT_"					lcRetorno = strtran( upper( tcClase ), "ENT_","" ,1 ,1 )				case upper( left( tcClase, 4 + len( lcNombreApp ) ) ) = "ENT" + lcNombreApp + "_"					lcRetorno = strtran( upper( tcClase ), "ENT" + lcNombreApp + "_", "", 1 ,1 )				case upper( left( tcClase, 11 ) ) = "DIN_ENTIDAD"					lcRetorno = strtran( tcClase, "Din_Entidad","" ,1 ,1 )				otherwise					lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			endcase		endif		return lcRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenersentenciacondesgloseparametros( tccomando as string, tcclase as string, tclibreria as string, tcapp as string, tnparametros as integer )                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5lnParametros = pcount()lxParam1 = tccomandolxParam2 = tcclaselxParam3 = tclibrerialxParam4 = tcapplxParam5 = tnparametroslcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenersentenciaCondesgloseparametros', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenersentenciaCondesgloseparametros', lcParametros )			endif		endif		local lcRetorno as string, lni as integer, lcLibreria as string, lcApp as string				if empty( tcLibreria )			lcLibreria = ""		else			lcLibreria = alltrim( tcLibreria )		endif				if empty( tcApp )			lcApp = ""		else			lcApp = alltrim( tcApp )		endif		if inlist( upper( tcComando ), "CLRCREATEOBJECT", "CLRINVOKESTATICMETHOD" )			lcRetorno = tcComando + "( '" + tcClase + "'"		else			if empty( tnParametros ) and empty( tcApp )				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "'"			else				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "', '" + tcApp + "'"			endif		endif				for lni = 1 to tnParametros			lcRetorno = lcRetorno + ", tvPar" + transform( lni )		endfor		lcRetorno = lcRetorno + " )"		return lcRetorno
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'AgregarClaseAColeccion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'AgregarClaseAColeccion', lcParametros )			endif		endif		if !alltrim( upper( "mock" ) )$alltrim( upper( tcClase ) )			_screen.oClases.Add( tcClase, sys(2007, alltrim( lower( tcClase )),0,1))		endif
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'LISTADOSPERSONALIZADOS' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Transformaralasignar', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Transformaralasignar', lcParametros )			endif		endif		return txVal
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