
define class Mock_articulo as MockBase of MockBase.prg

	lNuevo = .f. 
	lEdicion = .f. 
	lDestroy = .f. 
	cContexto = '' 

	cClase = 'articulo'

	
	AgruPubliDetalle = null                                                                                                                                                                                                                                   
	Alto = 0                                                                                                                                                                                                                                                  
	Ancho = 0                                                                                                                                                                                                                                                 
	Ano = 0                                                                                                                                                                                                                                                   
	BASEDEDATOSALTAFW = ""                                                                                                                                                                                                                                    
	BASEDEDATOSMODIFICACIONFW = ""                                                                                                                                                                                                                            
	BLOQUEARREGISTRO = .F.                                                                                                                                                                                                                                    
	CamposEquivalenciaLince = ""                                                                                                                                                                                                                              
	CategoriaDeArticulo = null                                                                                                                                                                                                                                
	CategoriaDeArticulo_PK = ""                                                                                                                                                                                                                               
	Clasificacion = null                                                                                                                                                                                                                                      
	Clasificacion_PK = ""                                                                                                                                                                                                                                     
	Codigo = ""                                                                                                                                                                                                                                               
	Comportamiento = 0                                                                                                                                                                                                                                        
	CondicionIvaCompras = 0                                                                                                                                                                                                                                   
	CondicionIvaVentas = 0                                                                                                                                                                                                                                    
	Curvadetalles = null                                                                                                                                                                                                                                      
	Curvadetalles_PK = ""                                                                                                                                                                                                                                     
	DescEcommerce = ""                                                                                                                                                                                                                                        
	DescEcommerceHTML = ""                                                                                                                                                                                                                                    
	Descripcion = ""                                                                                                                                                                                                                                          
	DescripcionAdicional = ""                                                                                                                                                                                                                                 
	DescripcionFW = ""                                                                                                                                                                                                                                        
	ESTADOTRANSFERENCIA = ""                                                                                                                                                                                                                                  
	FECHAALTAFW = ctod( '  /  /    ' )                                                                                                                                                                                                                        
	FECHAEXPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAIMPO = ctod( '  /  /    ' )                                                                                                                                                                                                                          
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )                                                                                                                                                                                                                
	FECHATRANSFERENCIA = ctod( '  /  /    ' )                                                                                                                                                                                                                 
	Familia = null                                                                                                                                                                                                                                            
	Familia_PK = ""                                                                                                                                                                                                                                           
	FechaAltaFW = {}                                                                                                                                                                                                                                          
	FechaModificacionFW = {}                                                                                                                                                                                                                                  
	Grupo = null                                                                                                                                                                                                                                              
	Grupo_PK = ""                                                                                                                                                                                                                                             
	HORAALTAFW = ""                                                                                                                                                                                                                                           
	HORAEXPO = ""                                                                                                                                                                                                                                             
	HORAIMPO = ""                                                                                                                                                                                                                                             
	HORAMODIFICACIONFW = ""                                                                                                                                                                                                                                   
	Imagen = ""                                                                                                                                                                                                                                               
	Importado = .F.                                                                                                                                                                                                                                           
	ImprimeDespacho = .F.                                                                                                                                                                                                                                     
	Largo = 0                                                                                                                                                                                                                                                 
	Linea = null                                                                                                                                                                                                                                              
	Linea_PK = ""                                                                                                                                                                                                                                             
	Marca = null                                                                                                                                                                                                                                              
	Marca_PK = ""                                                                                                                                                                                                                                             
	Material = null                                                                                                                                                                                                                                           
	Material_PK = ""                                                                                                                                                                                                                                          
	NoComercializable = ctod( '  /  /    ' )                                                                                                                                                                                                                  
	NoPermiteDevoluciones  = .f.                                                                                                                                                                                                                              
	NoPermiteDevoluciones = .F.                                                                                                                                                                                                                               
	NoPublicarEnEcommerce = .F.                                                                                                                                                                                                                               
	Nomenclador = null                                                                                                                                                                                                                                        
	Nomenclador_PK = ""                                                                                                                                                                                                                                       
	Observacion = ""                                                                                                                                                                                                                                          
	Paletadecolores = null                                                                                                                                                                                                                                    
	Paletadecolores_PK = ""                                                                                                                                                                                                                                   
	ParticipantesDetalle = null                                                                                                                                                                                                                               
	PercepcionIvaRG5329 = 0                                                                                                                                                                                                                                   
	Peso = 0                                                                                                                                                                                                                                                  
	PorcentajeImpuestoInterno = 0                                                                                                                                                                                                                             
	PorcentajeIvaCompras = 0                                                                                                                                                                                                                                  
	PorcentajeIvaVentas = 0                                                                                                                                                                                                                                   
	Proveedor = null                                                                                                                                                                                                                                          
	Proveedor_PK = ""                                                                                                                                                                                                                                         
	RequiereCCosto = 0                                                                                                                                                                                                                                        
	RestringirArticulo = ctod( '  /  /    ' )                                                                                                                                                                                                                 
	RestringirDescuentos = .F.                                                                                                                                                                                                                                
	RetornoExtension = .t.                                                                                                                                                                                                                                    
	SERIEALTAFW = ""                                                                                                                                                                                                                                          
	SERIEMODIFICACIONFW = ""                                                                                                                                                                                                                                  
	SoloPromoYKit = .F.                                                                                                                                                                                                                                       
	TIMESTAMP = 0                                                                                                                                                                                                                                             
	Temporada = null                                                                                                                                                                                                                                          
	Temporada_PK = ""                                                                                                                                                                                                                                         
	TipodeArticulo = null                                                                                                                                                                                                                                     
	TipodeArticulo_PK = ""                                                                                                                                                                                                                                    
	USUARIOALTAFW = ""                                                                                                                                                                                                                                        
	USUARIOMODIFICACIONFW = ""                                                                                                                                                                                                                                
	UnidadDeMedida = null                                                                                                                                                                                                                                     
	UnidadDeMedida_PK = ""                                                                                                                                                                                                                                    
	VERSIONALTAFW = ""                                                                                                                                                                                                                                        
	VERSIONMODIFICACIONFW = ""                                                                                                                                                                                                                                
	ZADSFW = ""                                                                                                                                                                                                                                               
	cAtributoAAuditar = ""                                                                                                                                                                                                                                    
	cAtributoPK = ""                                                                                                                                                                                                                                          
	cAtributoVendedor = ''                                                                                                                                                                                                                                    
	cCaracteres = ""                                                                                                                                                                                                                                          
	cCodigoPrevioGuardarComo = ""                                                                                                                                                                                                                             
	cContexto = ""                                                                                                                                                                                                                                            
	cDescripcion =  "Artículos"                                                                                                                                                                                                                               
	cDescripcionSingular = ""                                                                                                                                                                                                                                 
	cEvento = ""                                                                                                                                                                                                                                              
	cFormatoFechaNet = ""                                                                                                                                                                                                                                     
	cIdentificadorConexion = ""                                                                                                                                                                                                                               
	cNombre = ""                                                                                                                                                                                                                                              
	cNombre = 'ARTICULO'                                                                                                                                                                                                                                      
	cPrefijoImportar = ""                                                                                                                                                                                                                                     
	cPrefijoRecibir = ""                                                                                                                                                                                                                                      
	cUsuarioQueAutorizoSeguridad = ""                                                                                                                                                                                                                         
	cValorComboToolbar = ''                                                                                                                                                                                                                                   
	cValorComboToolbarAnterior = 'Todas'                                                                                                                                                                                                                      
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
	lEsGuardarComo = .F.                                                                                                                                                                                                                                      
	lEsSubEntidad = .f.                                                                                                                                                                                                                                       
	lEstaSeteandoValorSugerido = .f.                                                                                                                                                                                                                          
	lHabilitaEnviarAlGrabar = .f.                                                                                                                                                                                                                             
	lHabilitaTotalizadores = .f.                                                                                                                                                                                                                              
	lHabilitarComportamiento = .T.                                                                                                                                                                                                                            
	lHabilitarCondicionIvaCompras = .T.                                                                                                                                                                                                                       
	lHabilitarCondicionIvaVentas = .T.                                                                                                                                                                                                                        
	lHabilitarCurvadetalles_PK = .T.                                                                                                                                                                                                                          
	lHabilitarImportado = .T.                                                                                                                                                                                                                                 
	lHabilitarImprimeDespacho = .T.                                                                                                                                                                                                                           
	lHabilitarPaletadecolores_PK = .T.                                                                                                                                                                                                                        
	lHabilitarParticipantesDetalle = .T.                                                                                                                                                                                                                      
	lHabilitarPorcentajeImpuestoInterno = .T.                                                                                                                                                                                                                 
	lHabilitarPorcentajeIvaCompras = .T.                                                                                                                                                                                                                      
	lHabilitarPorcentajeIvaVentas = .T.                                                                                                                                                                                                                       
	lHabilitarRequiereCCosto = .T.                                                                                                                                                                                                                            
	lHabilitarSoloPromoYKit = .T.                                                                                                                                                                                                                             
	lIgnorarCamposObligatoriosDefinidosPorUsuario = .F.                                                                                                                                                                                                       
	lIgnorarClaveprimariaEnRecepcionBD = .f.                                                                                                                                                                                                                  
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
	lPreguntarSiDebeEliminar = .f.                                                                                                                                                                                                                            
	lProcesando = .F.                                                                                                                                                                                                                                         
	lReAsignarPk_Con_CC = .F.                                                                                                                                                                                                                                 
	lTieneAccionesAutomaticas = .f.                                                                                                                                                                                                                           
	lTieneDiseñosParaEnviarMail = .t.                                                                                                                                                                                                                         
	lTieneVendedorComoClaveForanea = .f.                                                                                                                                                                                                                      
	lUsaAgrupamientoPublicaciones = .T.                                                                                                                                                                                                                       
	lWHEliminar = .f.                                                                                                                                                                                                                                         
	lWHIngresar = .f.                                                                                                                                                                                                                                         
	lWHModificar = .f.                                                                                                                                                                                                                                        
	oAD = null                                                                                                                                                                                                                                                
	oArticuloParticipante = null                                                                                                                                                                                                                              
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
	tipoagrupamientopublicaciones = 0                                                                                                                                                                                                                         
	
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
	function agrupublidetalle_access() as variant                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'agrupublidetalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'agrupublidetalle_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Agrupublidetalle ) = 'O' or isnull( this.Agrupublidetalle ) )			this.Agrupublidetalle = this.crearobjeto( 'Din_DetalleArticuloAgrupublidetalle' )			this.Agrupublidetalle.inicializar()			this.enlazar( 'Agrupublidetalle.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Agrupublidetalle.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Agrupublidetalle, 'CambioSumarizado', this, 'CambiosDetalleAgrupublidetalle', 1)			this.enlazar( 'Agrupublidetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Agrupublidetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')		endif		return this.Agrupublidetalle
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
	function alto_assign( txval as variant ) as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'alto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'alto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Alto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Alto( lxVal )				this.Setear_Alto( lxVal )			EndIf		Else			This.Setear_Alto( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ancho_assign( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ancho_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ancho_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ancho		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ancho( lxVal )				this.Setear_Ancho( lxVal )			EndIf		Else			This.Setear_Ancho( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ano_assign( txval as variant ) as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ano_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ano_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Ano		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Ano( lxVal )				this.Setear_Ano( lxVal )			EndIf		Else			This.Setear_Ano( lxVal )		EndIf		dodefault( lxVal )
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
	function articulonopermitedevoluciones() as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Articulonopermitedevoluciones', lcParametros )
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
	function basededatosaltafw_access() as date                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosAltaFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosaltafw_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosaltafw( lxVal )				this.Setear_Basededatosaltafw( lxVal )			EndIf		Else			This.Setear_Basededatosaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_access() as date                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.BaseDeDatosModificacionFW = alltrim( _screen.Zoo.App.cSucursalActiva )		endif		return This.BaseDeDatosModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function basededatosmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'basededatosmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'basededatosmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Basededatosmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Basededatosmodificacionfw( lxVal )				this.Setear_Basededatosmodificacionfw( lxVal )			EndIf		Else			This.Setear_Basededatosmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'bloquearregistro_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'bloquearregistro_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Bloquearregistro		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Bloquearregistro( lxVal )				this.Setear_Bloquearregistro( lxVal )			EndIf		Else			This.Setear_Bloquearregistro( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'BuscarClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'BuscarClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.		this.Crear_oClases()				if _screen.oClases.GetKey( sys(2007, alltrim( lower( tcClase )),0,1)) > 0			llRetorno = .t.		else			if this.ExisteArchivoClase( tcClase )				this.AgregarClaseAColeccion( tcClase )				llRetorno = .t.			endif		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function buscarkitendetalle( toparticipantes as object, tccodigo as string ) as boolean                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = toparticipantes
		lxParam2 = tccodigo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Buscarkitendetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetalleagrupublidetalle() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetalleagrupublidetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosdetalleparticipantesdetalle() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosdetalleparticipantesdetalle', lcParametros )
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
	function cargarcadenaagrupamientosparacombotoolbar( tnopcion as integer ) as string                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnopcion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cargarcadenaagrupamientosparacombotoolbar', lcParametros )
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
	function categoriadearticulo_access() as variant                                                                                                                                                                                                          
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'categoriadearticulo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'categoriadearticulo_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Categoriadearticulo ) = 'O' or isnull( this.Categoriadearticulo ) )					this.Categoriadearticulo = _Screen.zoo.instanciarentidad( 'Categoriadearticulo' )					this.Categoriadearticulo.lEsSubEntidad = .t.					this.enlazar( 'Categoriadearticulo.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Categoriadearticulo.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Categoriadearticulo.CODIGO # this.Categoriadearticulo_PK						this.Categoriadearticulo.CODIGO = this.Categoriadearticulo_PK					endif				endif			endif		endif		return this.Categoriadearticulo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function categoriadearticulo_pk_assign( txval as variant ) as void                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'categoriadearticulo_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'categoriadearticulo_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Categoriadearticulo_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Categoriadearticulo.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Categoriadearticulo )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Categoriadearticulo_PK = lxVal		if this.Validar_Categoriadearticulo( lxVal, lxValOld )			This.Setear_Categoriadearticulo( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function clasificacion_access() as variant                                                                                                                                                                                                                
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'clasificacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'clasificacion_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Clasificacion ) = 'O' or isnull( this.Clasificacion ) )					this.Clasificacion = _Screen.zoo.instanciarentidad( 'Clasificacionarticulo' )					this.Clasificacion.lEsSubEntidad = .t.					this.enlazar( 'Clasificacion.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Clasificacion.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Clasificacion.CODIGO # this.Clasificacion_PK						this.Clasificacion.CODIGO = this.Clasificacion_PK					endif				endif			endif		endif		return this.Clasificacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function clasificacion_pk_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'clasificacion_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'clasificacion_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Clasificacion_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Clasificacion.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Clasificacion )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Clasificacion_PK = lxVal		if this.Validar_Clasificacion( lxVal, lxValOld )			This.Setear_Clasificacion( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function codigo_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'codigo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'codigo_assign', lcParametros )			endif		endif		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean		with this			llEdicion = .EsEdicion()			if !this.lPermiteMinusculasPK				try					txVal = upper( txVal )				Catch				Endtry			endif			if .lLimpiando or .lCargando				.Codigo = .TransformarAlAsignar( txVal )			else				if llEdicion				else					llNuevo = .EsNuevo()					.Codigo = .TransformarAlAsignar( txVal )					if empty( txVal ) and !llNuevo						.Limpiar()					else						if llNuevo							if .ValidarIngreso( txVal, llNuevo )							else								goServicios.Errores.LevantarExcepcion( 'Caracter inválido en el código.' )							endif						endif						llConsulta = .oAD.ConsultarPorClavePrimaria()						if !llConsulta							if !this.lEsSubEntidad and !llNuevo and this.SoportaBusquedaExtendida()								llConsulta = .ConsultarPorClavePrimariaSugerida()							endif						endif						do case							case !llNuevo and llConsulta								.Cargar()							case !llNuevo and !llConsulta								.Limpiar()								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )							case llNuevo and llConsulta								.Codigo = []								goServicios.Errores.LevantarExcepcion( 'El código ' + alltrim( transform( txVal ) ) + ' ya existe.' )						endcase					endif				endif			endif		endwith
	EndFunc

	*-----------------------------------------------------------------------------------------
	function comportamiento_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'comportamiento_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'comportamiento_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Comportamiento		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Comportamiento( lxVal )				if ( this.lHabilitarComportamiento or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Comportamiento( lxVal )				else					this.Comportamiento = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Comportamiento)" )				endif			EndIf		Else			This.Setear_Comportamiento( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function condicionesparaelenviodeemailalimportar() as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Condicionesparaelenviodeemailalimportar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function condicionivacompras_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'condicionivacompras_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'condicionivacompras_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Condicionivacompras		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Condicionivacompras( lxVal )				if ( this.lHabilitarCondicionivacompras or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Condicionivacompras( lxVal )				else					this.Condicionivacompras = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Condicionivacompras)" )				endif			EndIf		Else			This.Setear_Condicionivacompras( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function condicionivaventas_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'condicionivaventas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'condicionivaventas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Condicionivaventas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Condicionivaventas( lxVal )				if ( this.lHabilitarCondicionivaventas or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Condicionivaventas( lxVal )				else					this.Condicionivaventas = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Condicionivaventas)" )				endif			EndIf		Else			This.Setear_Condicionivaventas( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Crear_oClases', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Crear_oClases', lcParametros )			endif		endif		if !pemstatus( _screen, "oClases", 5 )				_screen.AddObject( "oClases", "Collection" )		endif				if !vartype( _screen.oClases ) = 'O' and isnull( _screen.oClases )			_screen.oClases = newobject( "Collection" )		endif
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crearobjeto( tcclase as string, tclibreria as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant )                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9, lxParam10lnParametros = pcount()lxParam1 = tcclaselxParam2 = tclibrerialxParam3 = tvpar1lxParam4 = tvpar2lxParam5 = tvpar3lxParam6 = tvpar4lxParam7 = tvpar5lxParam8 = tvpar6lxParam9 = tvpar7lxParam10 = tvpar8lcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'crearobjeto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'crearobjeto', lcParametros )			endif		endif		Local loReturn As Object, lnParametrosReales As Integer, lcClase as String, lcConstructor as string, lcComando as String, ;			lnParamAux as Integer, lcClase as String, lcLibreria as String , lcSetProcedure as String,;			loErrorBase as Exception, loEx as Exception, loRetorno as object, lcConstructor as String, lcProcedure as String,;			lcSetClassLib as String, lcSet as String, loMock as Object, lcClaseProxy as String					loReturn = Null		lcLibreria = tcLibreria		lcClaseProxy = ""				*-------------------------------------------------------------------		if pemstatus(_screen, "Mocks", 5 ) and vartype( _Screen.Mocks ) = "O"				*Instanciación de Mocks			*Objeto solo instanciado en DESARROLLO.			if _screen.Mocks.lUtilizarMockV2 and this.buscarClase( forceext( "MockV2_" + tcClase, "prg" ) )				lcClase = "MockV2_" + tcClase			else				if _screen.Mocks.lUtilizarMockV1					local lnItem as Integer					lcClase = this.ObtenerNombreClase( tcClase )					lnItem = _Screen.Mocks.BuscarMock( lcClase )										if !empty( lnItem )						loMock = _Screen.Mocks.Item[lnItem]						loMock.lUsado = .t.						lcClase = loMock.cNombreClaseMock												if empty( loMock.cNombrePrgMock )							lcLibreria = iif( empty( lcLibreria ), "", "Mock_" + justfname( lcLibreria ) )						else							lcLibreria = loMock.cNombrePrgMock						endif					else						lcClase = tcClase					endif				else					lcClase = tcClase				endif			endif		else			lcClase = tcClase		endif		*-------------------------------------------------------------------		If empty( lcLibreria )			lcLibreria = forceext( lcClase, "prg" )		endif				If Pcount() > 1			lnParamAux = 2		Else			lnParamAux = 1		EndIf		lnParametrosReales = Pcount() - lnParamAux			loRetorno = null				try			if this.EsClaseNet( lcClase )				if !pemstatus( _screen, "NetExtender", 5 )					goServicios.Errores.LevantarExcepcion( "Para instanciar un objeto net debe haber iniciado la aplicación." )				endif				lcComando = this.ObtenerSentenciaConDesgloseParametros( "ClrCreateObject", lcClase, "", "", lnParametrosReales )				loRetorno = this.CrearObjetoNet( lcComando, tvPar1, tvPar2, tvPar3, tvPar4, tvPar5, tvPar6, tvPar7, tvPar8 )			else				lcClase = justfname( lcClase )								if lnParametrosReales = 0 and vartype( _Screen.Zoo ) = "O" and !isnull( _Screen.Zoo ) and !isnull( _screen.Zoo.oConstructor )					lcClaseProxy = _screen.Zoo.oConstructor.ObtenerNombreClaseProxy( lcClase, lcLibreria )				endif				if !empty( lcClaseProxy )					loRetorno = _screen.Zoo.oConstructor.CrearObjeto( lcClaseProxy, set( "Datasession" ) )				else					lcSetProcedure = set('Procedure')					lcSetClassLib = set("Classlib")												if upper( justext( lcLibreria )) = "VCX"						lcSet  = "SET CLASSLIB TO "					else						lcSet = "SET PROCEDURE TO "					endif													if this.lEsExe and upper( justext( lcLibreria ) ) == "PRG"						&& En el Exe solo se pueden instanciar los archivos FXP, si no se fuerza la extensión recorre todo el path buscando el PRG.						lcLibreria = forceext( lcLibreria, "fxp" )						lcProcedure = lcLibreria					else						lcProcedure = forceext( lcLibreria, "" )					endif												lcSet = lcSet + "'" + lcProcedure + "'"										if this.BuscarClase( lcLibreria )						&lcSet					endif																			if lnParametrosReales > 0						lcComando = this.ObtenerSentenciaConDesgloseParametros( "NewObject", lcClase, lcLibreria , "", lnParametrosReales )						loRetorno = &lcComando					else						loRetorno = newobject( lcClase, lcLibreria )					endif									if !(lower(lcSetClassLib) == lower(set("Classlib")))						set classlib to &lcSetClassLib					endif						set procedure to &lcSetProcedure				endif			endif		Catch To loErrorBase				local lnError as Integer			lnError = 0						if loErrorBase.ErrorNo = 1 and left( lower( lcLibreria ), 4 ) == "din_"				do case					case !this.BuscarClase( strtran( lower( lcLibreria ), ".prg", ".fxp" ) )						lnError = 10					case !this.BuscarClase( lcLibreria )						lnError	= 20				endcase			endif			loEx = Newobject( "ZooException", "ZooException.prg" )			With loEx				.Grabar( loErrorBase )				.nZooErrorNo = lnError				.Throw()			EndWith		EndTry		return loRetorno
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
	function curvadetalles_access() as variant                                                                                                                                                                                                                
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'curvadetalles_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'curvadetalles_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Curvadetalles ) = 'O' or isnull( this.Curvadetalles ) )					this.Curvadetalles = _Screen.zoo.instanciarentidad( 'Curvadetalles' )					this.Curvadetalles.lEsSubEntidad = .t.					this.enlazar( 'Curvadetalles.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Curvadetalles.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Curvadetalles.CODIGO # this.Curvadetalles_PK						this.Curvadetalles.CODIGO = this.Curvadetalles_PK					endif				endif			endif		endif		return this.Curvadetalles
	EndFunc

	*-----------------------------------------------------------------------------------------
	function curvadetalles_pk_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'curvadetalles_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'curvadetalles_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Curvadetalles_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Curvadetalles_PK = lxVal		if this.Validar_Curvadetalles( lxVal, lxValOld )			if ( this.lHabilitarCurvadetalles_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )				This.Setear_Curvadetalles( lxVal )			else				this.Curvadetalles_PK = lxValOld				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Curvadetalles)" )			endif		endif		dodefault( lxVal )
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
	function debevalidaratributo( tcatributo as string ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Debevalidaratributo', lcParametros )
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
	function descecommerce_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descecommerce_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descecommerce_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descecommerce		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descecommerce( lxVal )				this.Setear_Descecommerce( lxVal )			EndIf		Else			This.Setear_Descecommerce( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function descecommercehtml_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descecommercehtml_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descecommercehtml_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descecommercehtml		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descecommercehtml( lxVal )				this.Setear_Descecommercehtml( lxVal )			EndIf		Else			This.Setear_Descecommercehtml( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function descripcion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descripcion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descripcion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descripcion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descripcion( lxVal )				this.Setear_Descripcion( lxVal )			EndIf		Else			This.Setear_Descripcion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function descripcionadicional_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descripcionadicional_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descripcionadicional_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descripcionadicional		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descripcionadicional( lxVal )				this.Setear_Descripcionadicional( lxVal )			EndIf		Else			This.Setear_Descripcionadicional( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function descripcionfw_access() as variant                                                                                                                                                                                                                
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descripcionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descripcionfw_access', lcParametros )			endif		endif		If This.lDestroy		Else			this.DescripcionFW = alltrim( transform( this.ObtenerDescripcion() + " " + this.codigo ) )		Endif		return this.DescripcionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function descripcionfw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'descripcionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'descripcionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Descripcionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Descripcionfw( lxVal )				this.Setear_Descripcionfw( lxVal )			EndIf		Else			This.Setear_Descripcionfw( lxVal )		EndIf		dodefault( lxVal )
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
	function esarticulotipoconjunto() as boolean                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esarticulotipoconjunto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esarticulotipokit() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esarticulotipokit', lcParametros )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estadotransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estadotransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Estadotransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Estadotransferencia( lxVal )				this.Setear_Estadotransferencia( lxVal )			EndIf		Else			This.Setear_Estadotransferencia( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaenproceso() as boolean                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'estaenproceso', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'estaenproceso', lcParametros )			endif		endif		local lRetorno as Boolean		with this			lRetorno = ( .lProcesando or .lCargando or .lLimpiando or .lDestroy )		endwith		return lRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esvalidoatributoobligatorio( tcatributo, tcdescatributo, tcdetalle ) as void                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = tcdescatributo
		lxParam3 = tcdetalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esvalidoatributoobligatorio', lcParametros )
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
	function eventopreguntarsieliminaporstockopreciomayoracero( tnmensaje as integer ) as void                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnmensaje

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventopreguntarsieliminaporstockopreciomayoracero', lcParametros )
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
	function eventosetearcaptionsolapakits( tlesconjunto ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlesconjunto

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventosetearcaptionsolapakits', lcParametros )
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
	function eventosetearvalorcombopordefecto() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventosetearvalorcombopordefecto', lcParametros )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcfilelcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ExisteArchivoClase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ExisteArchivoClase', lcParametros )			endif		endif		local llRetorno as Boolean				llRetorno = .f.				if _VFP.StartMode = 5 and !_screen.zoo.EsBuildAutomatico &&and "FOXEXTENDER" $ upper( sys( 16 ) )			try				do ( tcFile )				llRetorno = .t.			catch			endtry		else			llRetorno = file( tcFile )		endif				return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function existecombinacionconprecio() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Existecombinacionconprecio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function existecombinacionconstock() as boolean                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Existecombinacionconstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function familia_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'familia_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'familia_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Familia ) = 'O' or isnull( this.Familia ) )					this.Familia = _Screen.zoo.instanciarentidad( 'Familia' )					this.Familia.lEsSubEntidad = .t.					this.enlazar( 'Familia.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Familia.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Familia.CODIGO # this.Familia_PK						this.Familia.CODIGO = this.Familia_PK					endif				endif			endif		endif		return this.Familia
	EndFunc

	*-----------------------------------------------------------------------------------------
	function familia_pk_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'familia_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'familia_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Familia_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Familia.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Familia )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Familia_PK = lxVal		if this.Validar_Familia( lxVal, lxValOld )			This.Setear_Familia( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_access() as date                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_access', lcParametros )			endif		endif		if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.FechaAltaFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaaltafw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaaltafw( lxVal )			EndIf		Else			This.Setear_Fechaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaexpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaexpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaexpo( lxVal )			EndIf		Else			This.Setear_Fechaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechaimpo_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechaimpo( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechaimpo( lxVal )			EndIf		Else			This.Setear_Fechaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			This.FechaModificacionFW = goServicios.Librerias.ObtenerFecha()		endif		return This.FechaModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechamodificacionfw( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechamodificacionfw( lxVal )			EndIf		Else			This.Setear_Fechamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function fechatransferencia_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'fechatransferencia_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'fechatransferencia_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Fechatransferencia		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Fechatransferencia( lxVal )				this.ValidarDominio_Fecha( lxVal )				this.Setear_Fechatransferencia( lxVal )			EndIf		Else			This.Setear_Fechatransferencia( lxVal )		EndIf		dodefault( lxVal )
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
	function grupo_access() as variant                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'grupo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'grupo_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Grupo ) = 'O' or isnull( this.Grupo ) )					this.Grupo = _Screen.zoo.instanciarentidad( 'Grupo' )					this.Grupo.lEsSubEntidad = .t.					this.enlazar( 'Grupo.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Grupo.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Grupo.CODIGO # this.Grupo_PK						this.Grupo.CODIGO = this.Grupo_PK					endif				endif			endif		endif		return this.Grupo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function grupo_pk_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'grupo_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'grupo_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Grupo_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Grupo.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Grupo )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Grupo_PK = lxVal		if this.Validar_Grupo( lxVal, lxValOld )			This.Setear_Grupo( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function guardarcomo() as void                                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Guardarcomo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitardeshabilitaratributossegunkit( tleskit as boolean ) as void                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tleskit

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Habilitardeshabilitaratributossegunkit', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitarporcentajeivacomprasseguncondicion( txvalor as variant ) as void                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txvalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Habilitarporcentajeivacomprasseguncondicion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function habilitarporcentajeivaventasseguncondicion( txvalor as variant ) as void                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txvalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Habilitarporcentajeivaventasseguncondicion', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_access', lcParametros )			endif		endif				if !this.ldestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			this.HoraAltaFW = goLibrerias.ObtenerHora()		endif		return this.HoraAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaaltafw_assign( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaaltafw( lxVal )				this.Setear_Horaaltafw( lxVal )			EndIf		Else			This.Setear_Horaaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaexpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaexpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaexpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaexpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaexpo( lxVal )				this.Setear_Horaexpo( lxVal )			EndIf		Else			This.Setear_Horaexpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horaimpo_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horaimpo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horaimpo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horaimpo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horaimpo( lxVal )				this.Setear_Horaimpo( lxVal )			EndIf		Else			This.Setear_Horaimpo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_access() as string                                                                                                                                                                                                            
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_access', lcParametros )			endif		endif		if !this.ldestroy and ( This.EsNuevo() or This.EsEdicion() or this.lAnular ) and this.DebeCrearValoresParaAtributos()			this.HoraModificacionFW = goServicios.Librerias.ObtenerHora()		endif		return this.HoraModificacionFW
	EndFunc

	*-----------------------------------------------------------------------------------------
	function horamodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'horamodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'horamodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Horamodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Horamodificacionfw( lxVal )				this.Setear_Horamodificacionfw( lxVal )			EndIf		Else			This.Setear_Horamodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function imagen_assign( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imagen_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imagen_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imagen		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imagen( lxVal )				this.Setear_Imagen( lxVal )			EndIf		Else			This.Setear_Imagen( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function importado_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'importado_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'importado_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Importado		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Importado( lxVal )				if ( this.lHabilitarImportado or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Importado( lxVal )				else					this.Importado = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Importado)" )				endif			EndIf		Else			This.Setear_Importado( lxVal )		EndIf		dodefault( lxVal )
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
	function imprimedespacho_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'imprimedespacho_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'imprimedespacho_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Imprimedespacho		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Imprimedespacho( lxVal )				if ( this.lHabilitarImprimedespacho or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Imprimedespacho( lxVal )				else					this.Imprimedespacho = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Imprimedespacho)" )				endif			EndIf		Else			This.Setear_Imprimedespacho( lxVal )		EndIf		dodefault( lxVal )
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
	function largo_assign( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'largo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'largo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Largo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Largo( lxVal )				this.Setear_Largo( lxVal )			EndIf		Else			This.Setear_Largo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lesentidadconedicionrestringida_access() as boolean                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lesentidadconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lesentidadconedicionrestringida_access', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = .f.		if vartype( this.oAtributosConEdicionRestringida ) = 'O' and this.oAtributosConEdicionRestringida.Count > 0			llRetorno = .t.		endif		return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lhabilitarparticipantesdetalle_assign( txval as variant ) as void                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'lhabilitarparticipantesdetalle_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'lhabilitarparticipantesdetalle_assign', lcParametros )			endif		endif		this.lHabilitarParticipantesDetalle = txVal		this.ParticipantesDetalle.habilitarItems( txVal )
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
	function limpiardatosdetalleagrupamientopublicaciones() as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Limpiardatosdetalleagrupamientopublicaciones', lcParametros )
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
	function linea_access() as variant                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'linea_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'linea_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Linea ) = 'O' or isnull( this.Linea ) )					this.Linea = _Screen.zoo.instanciarentidad( 'Linea' )					this.Linea.lEsSubEntidad = .t.					this.enlazar( 'Linea.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Linea.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Linea.CODIGO # this.Linea_PK						this.Linea.CODIGO = this.Linea_PK					endif				endif			endif		endif		return this.Linea
	EndFunc

	*-----------------------------------------------------------------------------------------
	function linea_pk_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'linea_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'linea_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Linea_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Linea.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Linea )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Linea_PK = lxVal		if this.Validar_Linea( lxVal, lxValOld )			This.Setear_Linea( lxVal )		endif		dodefault( lxVal )
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
	function marca_access() as variant                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'marca_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'marca_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Marca ) = 'O' or isnull( this.Marca ) )					this.Marca = _Screen.zoo.instanciarentidad( 'Marca' )					this.Marca.lEsSubEntidad = .t.					this.enlazar( 'Marca.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Marca.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Marca.CODIGO # this.Marca_PK						this.Marca.CODIGO = this.Marca_PK					endif				endif			endif		endif		return this.Marca
	EndFunc

	*-----------------------------------------------------------------------------------------
	function marca_pk_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'marca_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'marca_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Marca_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Marca.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Marca )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )		this.Marca_PK = lxVal		if this.Validar_Marca( lxVal, lxValOld )			This.Setear_Marca( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function material_access() as variant                                                                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'material_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'material_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Material ) = 'O' or isnull( this.Material ) )					this.Material = _Screen.zoo.instanciarentidad( 'Material' )					this.Material.lEsSubEntidad = .t.					this.enlazar( 'Material.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Material.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Material.CODIGO # this.Material_PK						this.Material.CODIGO = this.Material_PK					endif				endif			endif		endif		return this.Material
	EndFunc

	*-----------------------------------------------------------------------------------------
	function material_pk_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'material_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'material_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Material_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Material.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Material )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Material_PK = lxVal		if this.Validar_Material( lxVal, lxValOld )			This.Setear_Material( lxVal )		endif		dodefault( lxVal )
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
	function nocomercializable_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nocomercializable_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nocomercializable_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nocomercializable		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Nocomercializable( lxVal )				this.ValidarDominio_Fechacalendario( lxVal )				this.Setear_Nocomercializable( lxVal )			EndIf		Else			This.Setear_Nocomercializable( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nomenclador_access() as variant                                                                                                                                                                                                                  
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nomenclador_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nomenclador_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Nomenclador ) = 'O' or isnull( this.Nomenclador ) )					this.Nomenclador = _Screen.zoo.instanciarentidad( 'Nomencladorarba' )					this.Nomenclador.lEsSubEntidad = .t.					this.enlazar( 'Nomenclador.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Nomenclador.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Nomenclador.CODIGO # this.Nomenclador_PK						this.Nomenclador.CODIGO = this.Nomenclador_PK					endif				endif			endif		endif		return this.Nomenclador
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nomenclador_pk_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nomenclador_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nomenclador_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nomenclador_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )		this.Nomenclador_PK = lxVal		if this.Validar_Nomenclador( lxVal, lxValOld )			This.Setear_Nomenclador( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nopermitedevoluciones_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nopermitedevoluciones_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nopermitedevoluciones_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nopermitedevoluciones		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Nopermitedevoluciones( lxVal )				this.Setear_Nopermitedevoluciones( lxVal )			EndIf		Else			This.Setear_Nopermitedevoluciones( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nopublicarenecommerce_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'nopublicarenecommerce_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'nopublicarenecommerce_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Nopublicarenecommerce		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Nopublicarenecommerce( lxVal )				this.Setear_Nopublicarenecommerce( lxVal )			EndIf		Else			This.Setear_Nopublicarenecommerce( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oad_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oad_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )			this.oAD = this.crearobjeto( "ent_ARTICULOAD_SQLSERVER" )			this.oAD.InyectarEntidad( this )			this.oAD.Inicializar()		endif		return this.oAD
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oarticuloparticipante_access() as void                                                                                                                                                                                                           
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oarticuloparticipante_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oarticuloparticipante_access', lcParametros )			endif		endif		if !this.lDestroy and !vartype( this.oArticuloParticipante ) == "O"			this.oArticuloParticipante = _Screen.Zoo.InstanciarEntidad( "ARTICULO" )		endif				return this.oArticuloParticipante
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oatributosconedicionrestringida_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oatributosconedicionrestringida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oatributosconedicionrestringida_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oAtributosConEdicionRestringida ) = 'O'			this.oAtributosConEdicionRestringida = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oAtributosConEdicionRestringida
	EndFunc

	*-----------------------------------------------------------------------------------------
	function observacion_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'observacion_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'observacion_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Observacion		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Observacion( lxVal )				this.Setear_Observacion( lxVal )			EndIf		Else			This.Setear_Observacion( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoclaveprimaria() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obteneratributoclaveprimaria', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obteneratributoclaveprimaria', lcParametros )			endif		endif		return this.cAtributoPK
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
	function obtenercampossegunequivalencia( taest ) as integer                                                                                                                                                                                               
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
	function obtenercomportamiento( tccodigo as string ) as number                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccodigo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercomportamiento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercomportamientodearticulo( tcarticulo ) as integer                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcarticulo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercomportamientodearticulo', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenerdescripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenerdescripcion', lcParametros )			endif		endif		return this.cDescripcion
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
	function obtenerkitenqueparticipa( tckit as string ) as object                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tckit

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerkitenqueparticipa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerkitsparticipantes( tckit as string ) as object                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tckit

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerkitsparticipantes', lcParametros )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocolatributosobligatoriosdefinidosporusuario_access', lcParametros )			endif		endif		local loRetorno as Object				loRetorno = null		if !this.lDestroy					loRetorno = goServicios.SaltosDeCampoyValoresSugeridos.ObtenerColeccionAtributosObligatorios( this.ObtenerNombre() )		endif				return loRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocomportamientocodigosugerido_access() as void                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ocomportamientocodigosugerido_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ocomportamientocodigosugerido_access', lcParametros )			endif		endif		local loComportamientoCodigoSugerido as Object		if !this.ldestroy and !vartype( this.oComportamientoCodigoSugerido ) = 'O'			loComportamientoCodigoSugerido = _Screen.zoo.CrearObjeto( "DecoradorDeCodigosDeEntidades" )			this.InicializarComportamientoCodigoSugerido(loComportamientoCodigoSugerido )			this.oComportamientoCodigoSugerido = loComportamientoCodigoSugerido		endif		return this.oComportamientoCodigoSugerido
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ogestordemail_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ogestordemail_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ogestordemail_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oGestorDeMail ) = 'O'			this.oGestorDeMail = _Screen.zoo.CrearObjeto( "GestorDeMail" )		endif		return this.oGestorDeMail
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oinformacion_access() as variant                                                                                                                                                                                                                 
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oinformacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oinformacion_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )				this.eventoObtenerInformacion( this )				if !vartype( .oInformacion ) = 'O' and isnull( .oInformacion )					.oInformacion = this.CrearObjeto( "ZooInformacion" )				endif				endif		endwith		return this.oInformacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ologueo_access() as variant                                                                                                                                                                                                                      
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ologueo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ologueo_access', lcParametros )			endif		endif		with this			if !.ldestroy and !vartype( .oLogueo ) = 'O' and isnull( .oLogueo ) and vartype( goServicios ) = 'O'				this.eventoObtenerLogueo( this )				if !vartype( .oLogueo ) = 'O' and isnull( .oLogueo )					.oLogueo = goServicios.Logueos.obtenerObjetoLogueo( this )					.SetearAccion()					.lLogueoPropio = .T.				else					.lLogueoPropio = .F.								endif				endif		endwith		return this.oLogueo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function omensaje_access() as void                                                                                                                                                                                                                        
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'omensaje_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'omensaje_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oMensaje ) = 'O' or isnull( this.oMensaje ) )			this.oMensaje = _screen.zoo.crearobjeto( "mensajeentidad", "", this )		endif				return this.oMensaje
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oobservadoresdeimportacion_access() as variant                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oobservadoresdeimportacion_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oobservadoresdeimportacion_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.oObservadoresDeImportacion ) = 'O' or isnull( this.oObservadoresDeImportacion ) )			this.oObservadoresDeImportacion = _Screen.zoo.crearobjeto( 'ZooColeccion' )		endif		return this.oObservadoresDeImportacion
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oregistrosdeactividadesalgrabar_access() as zoocoleccion of zoocoleccion.prg                                                                                                                                                                     
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'oregistrosdeactividadesalgrabar_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'oregistrosdeactividadesalgrabar_access', lcParametros )			endif		endif		if !this.ldestroy and !vartype( this.oRegistrosDeActividadesAlGrabar ) = 'O'			this.oRegistrosDeActividadesAlGrabar = _Screen.zoo.CrearObjeto( "ZooColeccion" )		endif		return this.oRegistrosDeActividadesAlGrabar
	EndFunc

	*-----------------------------------------------------------------------------------------
	function otalle_access() as variant                                                                                                                                                                                                                       
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'otalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'otalle_access', lcParametros )			endif		endif		if this.ldestroy		else			if ( !vartype( this.oTalle ) = 'O' or isnull( this.oTalle ) )				this.oTalle = _Screen.zoo.instanciarentidad( 'Talle' )			endif		endif		return this.oTalle
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ovalidadorescomp_access() as object                                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'ovalidadorescomp_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'ovalidadorescomp_access', lcParametros )			endif		endif		if !this.lDestroy and !( vartype( this.oValidadoresComp ) == "O" )			this.oValidadoresComp = _screen.Zoo.Crearobjeto( "ZooColeccion" )		endif				return this.oValidadoresComp
	EndFunc

	*-----------------------------------------------------------------------------------------
	function paletadecolores_access() as variant                                                                                                                                                                                                              
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'paletadecolores_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'paletadecolores_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Paletadecolores ) = 'O' or isnull( this.Paletadecolores ) )					this.Paletadecolores = _Screen.zoo.instanciarentidad( 'Paletadecolores' )					this.Paletadecolores.lEsSubEntidad = .t.					this.enlazar( 'Paletadecolores.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Paletadecolores.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Paletadecolores.CODIGO # this.Paletadecolores_PK						this.Paletadecolores.CODIGO = this.Paletadecolores_PK					endif				endif			endif		endif		return this.Paletadecolores
	EndFunc

	*-----------------------------------------------------------------------------------------
	function paletadecolores_pk_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'paletadecolores_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'paletadecolores_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Paletadecolores_PK		local lxVal as Variant		local loSugerido as Object				lxVal = txVal		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Paletadecolores_PK = lxVal		if this.Validar_Paletadecolores( lxVal, lxValOld )			if ( this.lHabilitarPaletadecolores_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )				This.Setear_Paletadecolores( lxVal )			else				this.Paletadecolores_PK = lxValOld				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Paletadecolores)" )			endif		endif		dodefault( lxVal )
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
	function participantesdetalle_access() as variant                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'participantesdetalle_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'participantesdetalle_access', lcParametros )			endif		endif		if !this.ldestroy and ( !vartype( this.Participantesdetalle ) = 'O' or isnull( this.Participantesdetalle ) )			this.Participantesdetalle = this.crearobjeto( 'Din_DetalleArticuloParticipantesdetalle' )			this.Participantesdetalle.inicializar()			this.enlazar( 'Participantesdetalle.EventoObtenerLogueo', 'inyectarLogueo' )			this.enlazar( 'Participantesdetalle.EventoObtenerInformacion', 'inyectarInformacion' )			bindevent( this.Participantesdetalle, 'CambioSumarizado', this, 'CambiosDetalleParticipantesdetalle', 1)			this.enlazar( 'Participantesdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno')			this.enlazar( 'Participantesdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno')			this.Participantesdetalle.lVerificarLimitesEnDisenoImpresion = .t.		endif		return this.Participantesdetalle
	EndFunc

	*-----------------------------------------------------------------------------------------
	function percepcionivarg5329_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'percepcionivarg5329_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'percepcionivarg5329_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Percepcionivarg5329		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Percepcionivarg5329( lxVal )				this.Setear_Percepcionivarg5329( lxVal )			EndIf		Else			This.Setear_Percepcionivarg5329( lxVal )		EndIf		dodefault( lxVal )
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
	function peso_assign( txval as variant ) as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'peso_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'peso_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Peso		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Peso( lxVal )				this.Setear_Peso( lxVal )			EndIf		Else			This.Setear_Peso( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function porcentajeimpuestointerno_assign( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'porcentajeimpuestointerno_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'porcentajeimpuestointerno_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Porcentajeimpuestointerno		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Porcentajeimpuestointerno( lxVal )				if ( this.lHabilitarPorcentajeimpuestointerno or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.ValidarDominio_Impuestointerno( lxVal )					this.Setear_Porcentajeimpuestointerno( lxVal )				else					this.Porcentajeimpuestointerno = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Porcentajeimpuestointerno)" )				endif			EndIf		Else			This.Setear_Porcentajeimpuestointerno( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function porcentajeivacompras_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'porcentajeivacompras_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'porcentajeivacompras_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Porcentajeivacompras		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Porcentajeivacompras( lxVal )				if ( this.lHabilitarPorcentajeivacompras or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.ValidarDominio_Numericononegativo( lxVal )					this.Setear_Porcentajeivacompras( lxVal )				else					this.Porcentajeivacompras = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Porcentajeivacompras)" )				endif			EndIf		Else			This.Setear_Porcentajeivacompras( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function porcentajeivaventas_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'porcentajeivaventas_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'porcentajeivaventas_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Porcentajeivaventas		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Porcentajeivaventas( lxVal )				if ( this.lHabilitarPorcentajeivaventas or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.ValidarDominio_Numericononegativo( lxVal )					this.Setear_Porcentajeivaventas( lxVal )				else					this.Porcentajeivaventas = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Porcentajeivaventas)" )				endif			EndIf		Else			This.Setear_Porcentajeivaventas( lxVal )		EndIf		dodefault( lxVal )
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
	function preprocesarcursorparaimportacionenbloque( tccursor as string ) as void                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccursor

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
	function proveedor_access() as variant                                                                                                                                                                                                                    
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'proveedor_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'proveedor_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Proveedor ) = 'O' or isnull( this.Proveedor ) )					this.Proveedor = _Screen.zoo.instanciarentidad( 'Proveedor' )					this.Proveedor.lEsSubEntidad = .t.					this.enlazar( 'Proveedor.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Proveedor.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Proveedor.CODIGO # this.Proveedor_PK						this.Proveedor.CODIGO = this.Proveedor_PK					endif				endif			endif		endif		return this.Proveedor
	EndFunc

	*-----------------------------------------------------------------------------------------
	function proveedor_pk_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'proveedor_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'proveedor_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Proveedor_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Proveedor.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Proveedor )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Proveedor_PK = lxVal		if this.Validar_Proveedor( lxVal, lxValOld )			This.Setear_Proveedor( lxVal )		endif		dodefault( lxVal )
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
	function requiereccosto_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'requiereccosto_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'requiereccosto_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Requiereccosto		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Requiereccosto( lxVal )				if ( this.lHabilitarRequiereccosto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Requiereccosto( lxVal )				else					this.Requiereccosto = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Requiereccosto)" )				endif			EndIf		Else			This.Setear_Requiereccosto( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurargenhabilitar() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurargenhabilitar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restringirarticulo_assign( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'restringirarticulo_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'restringirarticulo_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Restringirarticulo		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Restringirarticulo( lxVal )				this.ValidarDominio_Fechacalendario( lxVal )				this.Setear_Restringirarticulo( lxVal )			EndIf		Else			This.Setear_Restringirarticulo( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restringirdescuentos_assign( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'restringirdescuentos_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'restringirdescuentos_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Restringirdescuentos		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Restringirdescuentos( lxVal )				this.Setear_Restringirdescuentos( lxVal )			EndIf		Else			This.Setear_Restringirdescuentos( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.SerieAltaFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriealtafw_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriealtafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriealtafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriealtafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriealtafw( lxVal )				this.Setear_Seriealtafw( lxVal )			EndIf		Else			This.Setear_Seriealtafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_access() as date                                                                                                                                                                                                             
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.SerieModificacionFW = alltrim( _screen.Zoo.App.cSerie )		endif		return This.SerieModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seriemodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'seriemodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'seriemodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Seriemodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Seriemodificacionfw( lxVal )				this.Setear_Seriemodificacionfw( lxVal )			EndIf		Else			This.Setear_Seriemodificacionfw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_alto( txval as variant ) as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_alto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_alto', lcParametros )			endif		endif		this.Alto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ancho( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ancho', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ancho', lcParametros )			endif		endif		this.Ancho = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_ano( txval as variant ) as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_ano', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_ano', lcParametros )			endif		endif		this.Ano = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosaltafw( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosaltafw', lcParametros )			endif		endif		this.Basededatosaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_basededatosmodificacionfw( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_basededatosmodificacionfw', lcParametros )			endif		endif		this.Basededatosmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_bloquearregistro( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_bloquearregistro', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_bloquearregistro', lcParametros )			endif		endif		this.Bloquearregistro = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_categoriadearticulo( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_categoriadearticulo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_categoriadearticulo', lcParametros )			endif		endif		this.Categoriadearticulo.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_clasificacion( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_clasificacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_clasificacion', lcParametros )			endif		endif		this.Clasificacion.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_comportamiento( txvalor as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_comportamiento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_comportamiento', lcParametros )			endif		endif		local llEsKit as Boolean, lnResultado as Integer, llSetear as Boolean		llEsKit = ( txValor = 4 ) or (txValor = 5 )		if !llEsKit and this.TieneItemsParticipantes() and !this.lCargando and !this.lLimpiando			goServicios.Errores.LevantarExcepcion( "Para cambiar el tipo de comportamiento debe eliminar los participantes agregados." )		endif		dodefault( txValor )			this.HabilitarDeshabilitarAtributosSegunKit( llEsKit )		this.eventoSetearCaptionSolapaKits( txValor = 5 )		this.partICIPANTESDETALLE.oitem.tipocomportamiento = txvalor				
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_condicionivacompras( txvalor as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_condicionivacompras', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_condicionivacompras', lcParametros )			endif		endif		dodefault( txValor )		this.HabilitarPorcentajeIvaComprasSegunCondicion( txValor )			
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_condicionivaventas( txvalor as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_condicionivaventas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_condicionivaventas', lcParametros )			endif		endif		dodefault( txValor )		this.HabilitarPorcentajeIvaVentasSegunCondicion( txValor )		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_curvadetalles( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_curvadetalles', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_curvadetalles', lcParametros )			endif		endif		this.Curvadetalles.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descecommerce( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descecommerce', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descecommerce', lcParametros )			endif		endif		this.Descecommerce = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descecommercehtml( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descecommercehtml', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descecommercehtml', lcParametros )			endif		endif		this.Descecommercehtml = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descripcion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descripcion', lcParametros )			endif		endif		this.Descripcion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descripcionadicional( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descripcionadicional', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descripcionadicional', lcParametros )			endif		endif		this.Descripcionadicional = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_descripcionfw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_descripcionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_descripcionfw', lcParametros )			endif		endif		this.Descripcionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_estadotransferencia( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_estadotransferencia', lcParametros )			endif		endif		this.Estadotransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_familia( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_familia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_familia', lcParametros )			endif		endif		this.Familia.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaaltafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaaltafw', lcParametros )			endif		endif		this.Fechaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaexpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaexpo', lcParametros )			endif		endif		this.Fechaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechaimpo( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechaimpo', lcParametros )			endif		endif		this.Fechaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechamodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechamodificacionfw', lcParametros )			endif		endif		this.Fechamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_fechatransferencia( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_fechatransferencia', lcParametros )			endif		endif		this.Fechatransferencia = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_grupo( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_grupo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_grupo', lcParametros )			endif		endif		this.Grupo.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaaltafw( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaaltafw', lcParametros )			endif		endif		this.Horaaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaexpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaexpo', lcParametros )			endif		endif		this.Horaexpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horaimpo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horaimpo', lcParametros )			endif		endif		this.Horaimpo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_horamodificacionfw( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_horamodificacionfw', lcParametros )			endif		endif		this.Horamodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imagen( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imagen', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imagen', lcParametros )			endif		endif		this.Imagen = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_importado( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_importado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_importado', lcParametros )			endif		endif		this.Importado = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_imprimedespacho( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_imprimedespacho', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_imprimedespacho', lcParametros )			endif		endif		this.Imprimedespacho = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_largo( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_largo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_largo', lcParametros )			endif		endif		this.Largo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_linea( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_linea', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_linea', lcParametros )			endif		endif		this.Linea.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_marca( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_marca', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_marca', lcParametros )			endif		endif		this.Marca.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_material( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_material', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_material', lcParametros )			endif		endif		this.Material.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nocomercializable( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nocomercializable', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nocomercializable', lcParametros )			endif		endif		this.Nocomercializable = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nomenclador( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nomenclador', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nomenclador', lcParametros )			endif		endif		this.Nomenclador.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nopermitedevoluciones( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nopermitedevoluciones', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nopermitedevoluciones', lcParametros )			endif		endif		this.Nopermitedevoluciones = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nopublicarenecommerce( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_nopublicarenecommerce', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_nopublicarenecommerce', lcParametros )			endif		endif		this.Nopublicarenecommerce = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_observacion( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_observacion', lcParametros )			endif		endif		this.Observacion = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_paletadecolores( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_paletadecolores', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_paletadecolores', lcParametros )			endif		endif		this.Paletadecolores.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_percepcionivarg5329( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_percepcionivarg5329', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_percepcionivarg5329', lcParametros )			endif		endif		this.Percepcionivarg5329 = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_peso( txval as variant ) as void                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_peso', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_peso', lcParametros )			endif		endif		this.Peso = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_porcentajeimpuestointerno( txval as variant ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_porcentajeimpuestointerno', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_porcentajeimpuestointerno', lcParametros )			endif		endif		this.Porcentajeimpuestointerno = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_porcentajeivacompras( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_porcentajeivacompras', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_porcentajeivacompras', lcParametros )			endif		endif		this.Porcentajeivacompras = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_porcentajeivaventas( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_porcentajeivaventas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_porcentajeivaventas', lcParametros )			endif		endif		this.Porcentajeivaventas = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_proveedor( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_proveedor', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_proveedor', lcParametros )			endif		endif		this.Proveedor.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_requiereccosto( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_requiereccosto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_requiereccosto', lcParametros )			endif		endif		this.Requiereccosto = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_restringirarticulo( txval as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_restringirarticulo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_restringirarticulo', lcParametros )			endif		endif		this.Restringirarticulo = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_restringirdescuentos( txval as variant ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_restringirdescuentos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_restringirdescuentos', lcParametros )			endif		endif		this.Restringirdescuentos = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriealtafw( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriealtafw', lcParametros )			endif		endif		this.Seriealtafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_seriemodificacionfw( txval as variant ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_seriemodificacionfw', lcParametros )			endif		endif		this.Seriemodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_solopromoykit( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_solopromoykit', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_solopromoykit', lcParametros )			endif		endif		this.Solopromoykit = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_temporada( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_temporada', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_temporada', lcParametros )			endif		endif		this.Temporada.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_timestamp( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_timestamp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_timestamp', lcParametros )			endif		endif		this.Timestamp = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipoagrupamientopublicaciones( txval as variant ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipoagrupamientopublicaciones', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipoagrupamientopublicaciones', lcParametros )			endif		endif		this.Tipoagrupamientopublicaciones = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_tipodearticulo( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_tipodearticulo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_tipodearticulo', lcParametros )			endif		endif		this.Tipodearticulo.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_unidaddemedida( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_unidaddemedida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_unidaddemedida', lcParametros )			endif		endif		this.Unidaddemedida.CODIGO = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuarioaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuarioaltafw', lcParametros )			endif		endif		this.Usuarioaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_usuariomodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_usuariomodificacionfw', lcParametros )			endif		endif		this.Usuariomodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionaltafw( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionaltafw', lcParametros )			endif		endif		this.Versionaltafw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_versionmodificacionfw( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_versionmodificacionfw', lcParametros )			endif		endif		this.Versionmodificacionfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_zadsfw( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'setear_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'setear_zadsfw', lcParametros )			endif		endif		this.Zadsfw = txVal		dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearaccion() as string                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearaccion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearcodigosugerido() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearcodigosugerido', lcParametros )
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
	function setearporcentajedeivaalpack() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearporcentajedeivaalpack', lcParametros )
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
	function solopromoykit_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'solopromoykit_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'solopromoykit_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Solopromoykit		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Solopromoykit( lxVal )				if ( this.lHabilitarSolopromoykit or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)					this.Setear_Solopromoykit( lxVal )				else					this.Solopromoykit = lxValOld					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Artículos - Atributo: Solopromoykit)" )				endif			EndIf		Else			This.Setear_Solopromoykit( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function soportabusquedaextendida( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'soportabusquedaextendida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'soportabusquedaextendida', lcParametros )			endif		endif		return This.oComportamientoCodigoSugerido.SoportaBusquedaExtendida()
	EndFunc

	*-----------------------------------------------------------------------------------------
	function temporada_access() as variant                                                                                                                                                                                                                    
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'temporada_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'temporada_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Temporada ) = 'O' or isnull( this.Temporada ) )					this.Temporada = _Screen.zoo.instanciarentidad( 'Temporada' )					this.Temporada.lEsSubEntidad = .t.					this.enlazar( 'Temporada.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Temporada.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Temporada.CODIGO # this.Temporada_PK						this.Temporada.CODIGO = this.Temporada_PK					endif				endif			endif		endif		return this.Temporada
	EndFunc

	*-----------------------------------------------------------------------------------------
	function temporada_pk_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'temporada_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'temporada_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Temporada_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Temporada.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Temporada )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )		this.Temporada_PK = lxVal		if this.Validar_Temporada( lxVal, lxValOld )			This.Setear_Temporada( lxVal )		endif		dodefault( lxVal )
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
	function tieneitemsparticipantes() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tieneitemsparticipantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienemodulohabilitado() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienemodulohabilitado', lcParametros )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'timestamp_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'timestamp_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Timestamp		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Timestamp( lxVal )				this.Setear_Timestamp( lxVal )			EndIf		Else			This.Setear_Timestamp( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipoagrupamientopublicaciones_assign( txval as variant ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipoagrupamientopublicaciones_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipoagrupamientopublicaciones_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipoagrupamientopublicaciones		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Tipoagrupamientopublicaciones( lxVal )				this.Setear_Tipoagrupamientopublicaciones( lxVal )			EndIf		Else			This.Setear_Tipoagrupamientopublicaciones( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipodearticulo_access() as variant                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipodearticulo_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipodearticulo_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Tipodearticulo ) = 'O' or isnull( this.Tipodearticulo ) )					this.Tipodearticulo = _Screen.zoo.instanciarentidad( 'Tipodearticulo' )					this.Tipodearticulo.lEsSubEntidad = .t.					this.enlazar( 'Tipodearticulo.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Tipodearticulo.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Tipodearticulo.CODIGO # this.Tipodearticulo_PK						this.Tipodearticulo.CODIGO = this.Tipodearticulo_PK					endif				endif			endif		endif		return this.Tipodearticulo
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tipodearticulo_pk_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'tipodearticulo_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'tipodearticulo_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Tipodearticulo_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Tipodearticulo.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Tipodearticulo )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )		this.Tipodearticulo_PK = lxVal		if this.Validar_Tipodearticulo( lxVal, lxValOld )			This.Setear_Tipodearticulo( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ultimo () as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ultimo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function unidaddemedida_access() as variant                                                                                                                                                                                                               
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'unidaddemedida_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'unidaddemedida_access', lcParametros )			endif		endif		if this.ldestroy		else			if This.lInstanciarSubEntidadaDemanda				if ( !vartype( this.Unidaddemedida ) = 'O' or isnull( this.Unidaddemedida ) )					this.Unidaddemedida = _Screen.zoo.instanciarentidad( 'Unidaddemedida' )					this.Unidaddemedida.lEsSubEntidad = .t.					this.enlazar( 'Unidaddemedida.EventoObtenerLogueo', 'inyectarLogueo' )					this.enlazar( 'Unidaddemedida.EventoObtenerInformacion', 'inyectarInformacion' )				endif				if !this.lBuscandoCodigo					if this.Unidaddemedida.CODIGO # this.Unidaddemedida_PK						this.Unidaddemedida.CODIGO = this.Unidaddemedida_PK					endif				endif			endif		endif		return this.Unidaddemedida
	EndFunc

	*-----------------------------------------------------------------------------------------
	function unidaddemedida_pk_assign( txval as variant ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'unidaddemedida_pk_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'unidaddemedida_pk_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Unidaddemedida_PK		local lxVal as Variant		local loSugerido as Object				if txVal = lxValOld or empty( txVal )			lxVal = txVal		else			this.lBuscandoCodigo = .t.			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )				lxVal = This.Unidaddemedida.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Unidaddemedida )			else				lxVal = txVal			endif			this.lBuscandoCodigo = .f.		endif		lxVal = iif( len( lxVal ) < 3, padr( lxVal, 3 ), lxVal )		this.Unidaddemedida_PK = lxVal		if this.Validar_Unidaddemedida( lxVal, lxValOld )			This.Setear_Unidaddemedida( lxVal )		endif		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_access() as date                                                                                                                                                                                                                   
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.UsuarioAltaFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() ) + this.UsuarioAutorizante()		endif		return This.UsuarioAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuarioaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuarioaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuarioaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuarioaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuarioaltafw( lxVal )				this.Setear_Usuarioaltafw( lxVal )			EndIf		Else			This.Setear_Usuarioaltafw( lxVal )		EndIf		dodefault( lxVal )
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.UsuarioModificacionFW = alltrim( goServicios.Seguridad.ObtenerUltimoUsuarioLogueado() )  + this.UsuarioAutorizante()		endif		return This.UsuarioModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function usuariomodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'usuariomodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'usuariomodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Usuariomodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Usuariomodificacionfw( lxVal )				this.Setear_Usuariomodificacionfw( lxVal )			EndIf		Else			This.Setear_Usuariomodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
	function validar_alto( txval as variant ) as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_alto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_alto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ancho( txval as variant ) as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ancho', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ancho', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_ano( txval as variant ) as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_ano', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_ano', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosaltafw( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_basededatosmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_basededatosmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_basededatosmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_bloquearregistro( txval as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_bloquearregistro', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_bloquearregistro', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_categoriadearticulo( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_categoriadearticulo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_categoriadearticulo', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_clasificacion( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_clasificacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_clasificacion', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_comportamiento( txvalor as variant ) as boolean                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_comportamiento', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_comportamiento', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = dodefault( txValor )		if llRetorno			if !between( txValor, 0, 5 )				local loEx as Exception				loEx = Newobject(  "ZooException", "ZooException.prg" )				With loEx					.Message = "La característica está fuera de rango."					.Details = .Message					.Grabar()					.Throw()				endwith			endif		endif		return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_condicionivacompras(  txvalor as integer ) as boolean                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_condicionivacompras', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_condicionivacompras', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = dodefault( txValor )		if llRetorno			if !between( txValor, 0, 4 )				local loEx as Exception				loEx = Newobject(  "ZooException", "ZooException.prg" )				With loEx					.Message = "La condición de IVA Compras esta fuera de rango."					.Details = .Message					.Grabar()					.Throw()				endwith			endif		endif		return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_condicionivaventas( txvalor as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvalorlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_condicionivaventas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_condicionivaventas', lcParametros )			endif		endif		local llRetorno as Boolean		llRetorno = dodefault( txValor )		if llRetorno			if !between( txValor, 0, 4 )				local loEx as Exception				loEx = Newobject(  "ZooException", "ZooException.prg" )				With loEx					.Message = "La condición de IVA Ventas esta fuera de rango."					.Details = .Message					.Grabar()					.Throw()				endwith			endif		endif		return llRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_curvadetalles( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_curvadetalles', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_curvadetalles', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descecommerce( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descecommerce', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descecommerce', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descecommercehtml( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descecommercehtml', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descecommercehtml', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descripcion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descripcion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descripcion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descripcionadicional( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descripcionadicional', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descripcionadicional', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_descripcionfw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_descripcionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_descripcionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_estadotransferencia( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_estadotransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_estadotransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_familia( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_familia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_familia', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaaltafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaexpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechaimpo( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_fechatransferencia( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_fechatransferencia', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_fechatransferencia', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_grupo( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_grupo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_grupo', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaaltafw( txval as variant ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaexpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaexpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaexpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horaimpo( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horaimpo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horaimpo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_horamodificacionfw( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_horamodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_horamodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imagen( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imagen', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imagen', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_importado( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_importado', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_importado', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_imprimedespacho( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_imprimedespacho', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_imprimedespacho', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_largo( txval as variant ) as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_largo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_largo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_linea( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_linea', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_linea', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_marca( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_marca', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_marca', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_material( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_material', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_material', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nocomercializable( txval as variant ) as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nocomercializable', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nocomercializable', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nomenclador( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nomenclador', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nomenclador', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nopermitedevoluciones( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nopermitedevoluciones', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nopermitedevoluciones', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nopublicarenecommerce( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_nopublicarenecommerce', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_nopublicarenecommerce', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_observacion( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_observacion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_observacion', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_paletadecolores( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_paletadecolores', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_paletadecolores', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_percepcionivarg5329( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_percepcionivarg5329', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_percepcionivarg5329', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_peso( txval as variant ) as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_peso', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_peso', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_porcentajeimpuestointerno( txval as variant ) as boolean                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_porcentajeimpuestointerno', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_porcentajeimpuestointerno', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_porcentajeivacompras( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_porcentajeivacompras', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_porcentajeivacompras', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_porcentajeivaventas( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_porcentajeivaventas', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_porcentajeivaventas', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_proveedor( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_proveedor', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_proveedor', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Proveedor.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion)
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_requiereccosto( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_requiereccosto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_requiereccosto', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_restringirarticulo( txval as variant ) as boolean                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_restringirarticulo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_restringirarticulo', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_restringirdescuentos( txval as variant ) as boolean                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_restringirdescuentos', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_restringirdescuentos', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriealtafw( txval as variant ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriealtafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriealtafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_seriemodificacionfw( txval as variant ) as boolean                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_seriemodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_seriemodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_solopromoykit( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_solopromoykit', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_solopromoykit', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_temporada( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_temporada', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_temporada', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_timestamp( txval as variant ) as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_timestamp', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_timestamp', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipoagrupamientopublicaciones( txval as variant ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipoagrupamientopublicaciones', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipoagrupamientopublicaciones', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_tipodearticulo( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_tipodearticulo', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_tipodearticulo', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_unidaddemedida( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2lnParametros = pcount()lxParam1 = txvallxParam2 = txvaloldlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_unidaddemedida', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_unidaddemedida', lcParametros )			endif		endif		Return This.CargaManual() and dodefault( txVal, txValOld )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuarioaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuarioaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuarioaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_usuariomodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_usuariomodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_usuariomodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionaltafw( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionaltafw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionaltafw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_versionmodificacionfw( txval as variant ) as boolean                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_versionmodificacionfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_versionmodificacionfw', lcParametros )			endif		endif		Return dodefault( txVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_zadsfw( txval as variant ) as boolean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'validar_zadsfw', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'validar_zadsfw', lcParametros )			endif		endif		Return dodefault( txVal )
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
	function validarcategoriadearticulo() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcategoriadearticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarclasificacion() as boolean                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarclasificacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarconjuntosinparticipantes() as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarconjuntosinparticipantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarcurvadetalles() as boolean                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcurvadetalles', lcParametros )
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
	function validardominio_fechacalendario( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validardominio_fechacalendario', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validardominio_impuestointerno( txval as variant ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validardominio_impuestointerno', lcParametros )
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
	function validarextension() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarextension', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarfamilia() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarfamilia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validargrupo() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validargrupo', lcParametros )
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
	function validaringresopack(tcart) as void                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcart

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validaringresopack', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarkitsinparticipantes() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarkitsinparticipantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarlinea() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarlinea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarmarca() as boolean                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarmarca', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarmaterial() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarmaterial', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarnivelesdekits() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarnivelesdekits', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarnivelesdekitshaciaarriba( tckits as string, tnniveles as integer ) as void                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tckits
		lxParam2 = tnniveles

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarnivelesdekitshaciaarriba', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarnomenclador() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarnomenclador', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarnotipokitniconjuntoyparticipantes() as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarnotipokitniconjuntoyparticipantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarpaletadecolores() as boolean                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarpaletadecolores', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarpk() as boolean                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarpk', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarproveedor() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarproveedor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarrecursividad( tnpasadas as integer, toparticipantes as object ) as boolean                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnpasadas
		lxParam2 = toparticipantes

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarrecursividad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarrecursividaddekits() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarrecursividaddekits', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarrestricciondedescuentosyparticipante() as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarrestricciondedescuentosyparticipante', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validartemporada() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validartemporada', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validartipodearticulo() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validartipodearticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarunidaddemedida() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarunidaddemedida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoalto() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoalto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoancho() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoancho', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoano() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoano', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocategoriadearticulo() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocategoriadearticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoclasificacion() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoclasificacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocomportamiento() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocomportamiento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocondicionivacompras() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocondicionivacompras', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocondicionivaventas() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocondicionivaventas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocurvadetalles() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocurvadetalles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodescecommerce() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodescecommerce', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodescecommercehtml() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodescecommercehtml', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodescripcion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodescripcion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridodescripcionadicional() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridodescripcionadicional', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridofamilia() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridofamilia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridogrupo() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridogrupo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoimagen() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoimagen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoimportado() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoimportado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoimprimedespacho() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoimprimedespacho', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridolargo() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridolargo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridolinea() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridolinea', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomarca() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomarca', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridomaterial() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridomaterial', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonocomercializable() as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonocomercializable', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonomenclador() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonomenclador', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonopermitedevoluciones() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonopermitedevoluciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridonopublicarenecommerce() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridonopublicarenecommerce', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoobservacion() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoobservacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopaletadecolores() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopaletadecolores', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopercepcionivarg5329() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopercepcionivarg5329', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopeso() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopeso', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoporcentajeimpuestointerno() as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoporcentajeimpuestointerno', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoporcentajeivacompras() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoporcentajeivacompras', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoporcentajeivaventas() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoporcentajeivaventas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoproveedor() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoproveedor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridorequiereccosto() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridorequiereccosto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridorestringirarticulo() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridorestringirarticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridorestringirdescuentos() as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridorestringirdescuentos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridosolopromoykit() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridosolopromoykit', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotemporada() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotemporada', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotipodearticulo() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotipodearticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridounidaddemedida() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridounidaddemedida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarcontexto( tctipos as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tctiposlcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'verificarcontexto', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'verificarcontexto', lcParametros )			endif		endif		local llRetorno as boolean, i as Integer, lcLetra as string				if empty( tcTipos )			llRetorno = empty( this.cContexto )		else			tcTipos = upper( alltrim( tcTipos ) )			llRetorno = .f.			for i = 1 to len( tcTipos )				lcLetra = substr( tcTipos, i, 1 )				llRetorno = ( lcLetra $ this.cContexto ) or llRetorno				if llRetorno					exit				endif			endfor		endif				return llRetorno
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
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_access', lcParametros )			endif		endif		if !this.lDestroy and this.EsNuevo() and this.DebeCrearValoresParaAtributos()			This.VersionAltaFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionAltaFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionaltafw_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionaltafw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionaltafw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionaltafw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionaltafw( lxVal )				this.Setear_Versionaltafw( lxVal )			EndIf		Else			This.Setear_Versionaltafw( lxVal )		EndIf		dodefault( lxVal )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_access() as string                                                                                                                                                                                                         
		lnParametros = pcount()lcParametros = ''		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_access', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_access', lcParametros )			endif		endif		if !this.lDestroy and ( This.EsNuevo() or This.EsEdicion() ) and this.DebeCrearValoresParaAtributos()			This.VersionModificacionFW = _screen.zoo.app.ObtenerVersion()		endif		return This.VersionModificacionFW		
	EndFunc

	*-----------------------------------------------------------------------------------------
	function versionmodificacionfw_assign( txval as variant ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'versionmodificacionfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'versionmodificacionfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Versionmodificacionfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Versionmodificacionfw( lxVal )				this.Setear_Versionmodificacionfw( lxVal )			EndIf		Else			This.Setear_Versionmodificacionfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'zadsfw_assign', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'zadsfw_assign', lcParametros )			endif		endif		Local lxValOld As Variant		lxValOld = this.Zadsfw		local lxVal as Variant		lxVal = txVal		if This.CargaManual()			if this.Validar_Zadsfw( lxVal )				this.Setear_Zadsfw( lxVal )			EndIf		Else			This.Setear_Zadsfw( lxVal )		EndIf		dodefault( lxVal )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'esclasenet', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'esclasenet', lcParametros )			endif		endif		return "." $ tcClase
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenernombreclase( tcclase ) as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenernombreclase', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenernombreclase', lcParametros )			endif		endif		Local lcRetorno as String, lcNombreApp as String		if upper( substr( alltrim( tcClase ), len( alltrim( tcClase ) ) - 1 ) ) = "UO"			if !this.lEsExe and this.BuscarClase( alltrim( tcClase ) + "UO.prg" )				lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			else				lcRetorno = tcClase			endif		else			if type( "_screen.zoo.app.cProyecto" ) = "C"				lcNombreApp = upper( _screen.zoo.app.cProyecto )			else				lcNombreApp = ""			endif							do case				case upper( left( tcClase, 4 ) ) = "ENT_"					lcRetorno = strtran( upper( tcClase ), "ENT_","" ,1 ,1 )				case upper( left( tcClase, 4 + len( lcNombreApp ) ) ) = "ENT" + lcNombreApp + "_"					lcRetorno = strtran( upper( tcClase ), "ENT" + lcNombreApp + "_", "", 1 ,1 )				case upper( left( tcClase, 11 ) ) = "DIN_ENTIDAD"					lcRetorno = strtran( tcClase, "Din_Entidad","" ,1 ,1 )				otherwise					lcRetorno = strtran( tcClase, "Din_","" ,1 ,1 )			endcase		endif		return lcRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenersentenciacondesgloseparametros( tccomando as string, tcclase as string, tclibreria as string, tcapp as string, tnparametros as integer )                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1, lxParam2, lxParam3, lxParam4, lxParam5lnParametros = pcount()lxParam1 = tccomandolxParam2 = tcclaselxParam3 = tclibrerialxParam4 = tcapplxParam5 = tnparametroslcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'obtenersentenciaCondesgloseparametros', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'obtenersentenciaCondesgloseparametros', lcParametros )			endif		endif		local lcRetorno as string, lni as integer, lcLibreria as string, lcApp as string				if empty( tcLibreria )			lcLibreria = ""		else			lcLibreria = alltrim( tcLibreria )		endif				if empty( tcApp )			lcApp = ""		else			lcApp = alltrim( tcApp )		endif		if inlist( upper( tcComando ), "CLRCREATEOBJECT", "CLRINVOKESTATICMETHOD" )			lcRetorno = tcComando + "( '" + tcClase + "'"		else			if empty( tnParametros ) and empty( tcApp )				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "'"			else				lcRetorno = tcComando + "( '" + tcClase + "', '" + lcLibreria + "', '" + tcApp + "'"			endif		endif				for lni = 1 to tnParametros			lcRetorno = lcRetorno + ", tvPar" + transform( lni )		endfor		lcRetorno = lcRetorno + " )"		return lcRetorno
	EndFunc

	*-----------------------------------------------------------------------------------------
	protect function informarwebhook()                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Informarwebhook', lcParametros )
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
	protected function agregarclaseacoleccion( tcclase as string ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = tcclaselcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'AgregarClaseAColeccion', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'AgregarClaseAColeccion', lcParametros )			endif		endif		if !alltrim( upper( "mock" ) )$alltrim( upper( tcClase ) )			_screen.oClases.Add( tcClase, sys(2007, alltrim( lower( tcClase )),0,1))		endif
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
	protected function eliminarparticipantes() as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminarparticipantes', lcParametros )
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
	protected function habilitarcentrodecostoseguncondicion() as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Habilitarcentrodecostoseguncondicion', lcParametros )
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
	protected function obtenerparticipantes( tcarticulo as string ) as object                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcarticulo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerparticipantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function setearvalorcombopordefecto() as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearvalorcombopordefecto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function tienemodulocontabilidad() as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienemodulocontabilidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function transformaralasignar( txval as variant ) as variant                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer, ;		lnIdMetodo as Integer, lnIdClase as Integer, lxParam1lnParametros = pcount()lxParam1 = txvallcParametros = ''		for lni = 1 to lnParametros			lcParam = 'lxParam' + alltrim(str(lni))			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )		endfor		lnIdClase = _screen.Mocks.BuscarMock( 'ARTICULO' )		if lnIdClase > 0			lnIdMetodo =  _screen.Mocks.BuscarMetodo( lnIdClase, 'Transformaralasignar', lcParametros )			if lnIdMetodo > 0				return this.ObtenerResultado( 'Transformaralasignar', lcParametros )			endif		endif		return txVal
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
	protected function validarporcentajesiva() as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarporcentajesiva', lcParametros )
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