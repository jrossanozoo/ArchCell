
define class Mock_Itemmovimientostockdesdeproduccmovimientodetalle as MockBase of MockBase.prg

	cClase = 'Itemmovimientostockdesdeproduccmovimientodetalle'

	
	Articulo = null                                                                                                                                                                                                                                           
	ArticuloDetalle = ""                                                                                                                                                                                                                                      
	Articulo_PK = ""                                                                                                                                                                                                                                          
	Cantidad = 0                                                                                                                                                                                                                                              
	CantidadStockDF = 0                                                                                                                                                                                                                                       
	Codigo = ""                                                                                                                                                                                                                                               
	CodigoDeBarras = ""                                                                                                                                                                                                                                       
	Color = null                                                                                                                                                                                                                                              
	ColorArt = null                                                                                                                                                                                                                                           
	ColorArtDetalle = ""                                                                                                                                                                                                                                      
	ColorArt_PK = ""                                                                                                                                                                                                                                          
	ColorDetalle = ""                                                                                                                                                                                                                                         
	Color_PK = ""                                                                                                                                                                                                                                             
	Comportamiento = 0                                                                                                                                                                                                                                        
	Equivalencia = null                                                                                                                                                                                                                                       
	Equivalencia_PK = ""                                                                                                                                                                                                                                      
	IdKit = ""                                                                                                                                                                                                                                                
	Insumo = null                                                                                                                                                                                                                                             
	InsumoDetalle = ""                                                                                                                                                                                                                                        
	Insumo_PK = ""                                                                                                                                                                                                                                            
	Inventario = null                                                                                                                                                                                                                                         
	Inventario_PK = ""                                                                                                                                                                                                                                        
	NROITEM = 0                                                                                                                                                                                                                                               
	NoProcesarStock = .F.                                                                                                                                                                                                                                     
	Partida = ""                                                                                                                                                                                                                                              
	Rinde = 0                                                                                                                                                                                                                                                 
	Talle = null                                                                                                                                                                                                                                              
	TalleArt = null                                                                                                                                                                                                                                           
	TalleArtDetalle = ""                                                                                                                                                                                                                                      
	TalleArt_PK = ""                                                                                                                                                                                                                                          
	TalleDetalle = ""                                                                                                                                                                                                                                         
	Talle_PK = ""                                                                                                                                                                                                                                             
	Unidad = null                                                                                                                                                                                                                                             
	UnidadStockDF = null                                                                                                                                                                                                                                      
	UnidadStockDF_PK = ""                                                                                                                                                                                                                                     
	Unidad_PK = ""                                                                                                                                                                                                                                            
	cAtributoPK = ""                                                                                                                                                                                                                                          
	cFormatoFechaNet = ""                                                                                                                                                                                                                                     
	cNombre = 'MOVIMIENTOSTOCKDESDEPRODUCC'                                                                                                                                                                                                                   
	datasession = 1                                                                                                                                                                                                                                           
	lAdvertirMinimoReposicion = .T.                                                                                                                                                                                                                           
	lAfectadoPorUnaPromocion = .f.                                                                                                                                                                                                                            
	lBuscandoCodigo = .f.                                                                                                                                                                                                                                     
	lCalcularImpuestosInternos = .f.                                                                                                                                                                                                                          
	lCargando = .f.                                                                                                                                                                                                                                           
	lControlaStock = .T.                                                                                                                                                                                                                                      
	lDesarrollo = .f.                                                                                                                                                                                                                                         
	lDestroy = .f.                                                                                                                                                                                                                                            
	lEdicion = .f.                                                                                                                                                                                                                                            
	lEsExe = .f.                                                                                                                                                                                                                                              
	lEsSubEntidad = .f.                                                                                                                                                                                                                                       
	lEstaImportando = .f.                                                                                                                                                                                                                                     
	lEstaSeteandoValorSugerido = .f.                                                                                                                                                                                                                          
	lInstanciarSubEntidadaDemanda = .t.                                                                                                                                                                                                                       
	lInvertirSigno = .f.                                                                                                                                                                                                                                      
	lKitPermiteColorYTalle = .f.                                                                                                                                                                                                                              
	lLimpiando = .f.                                                                                                                                                                                                                                          
	lLoguear = .T.                                                                                                                                                                                                                                            
	lLogueoPropio = .T.                                                                                                                                                                                                                                       
	lNoCheckSessionOpen = .f. && para omitir el objeto del analisis de sessiones abiertas de test de foxunit                                                                                                                                                  
	lNoLoguearRestAPI = .F.                                                                                                                                                                                                                                   
	lNuevo = .f.                                                                                                                                                                                                                                              
	lPermiteCantidadesNegativas = .T.                                                                                                                                                                                                                         
	lSeteandoAtributoAcumulado = .f.                                                                                                                                                                                                                          
	lSeteandoCantidad = .F.                                                                                                                                                                                                                                   
	lSoportaKits = .f.                                                                                                                                                                                                                                        
	lTieneAtributosSumarizados = .f.                                                                                                                                                                                                                          
	lTieneStockDisponible = .T.                                                                                                                                                                                                                               
	nCantidadAnterior = 0                                                                                                                                                                                                                                     
	nMontoAnterior = 0                                                                                                                                                                                                                                        
	oColeccionVS = null                                                                                                                                                                                                                                       
	oColeccionVSFW = null                                                                                                                                                                                                                                     
	oCombinacion = null                                                                                                                                                                                                                                       
	oCompStockProduccion = null                                                                                                                                                                                                                               
	oComportamientoCodigoSugerido = null                                                                                                                                                                                                                      
	oDetalle = null                                                                                                                                                                                                                                           
	oEntidad = null                                                                                                                                                                                                                                           
	oInformacion = null                                                                                                                                                                                                                                       
	oItemAnterior = null                                                                                                                                                                                                                                      
	oLogueo = null                                                                                                                                                                                                                                            
	oMensaje = null                                                                                                                                                                                                                                           
	oValidacionDominios= null                                                                                                                                                                                                                                 
	
	*-----------------------------------------------------------------------------------------
	function Inicializar() as boolean
	endfunc

	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function actualizarcoleccionparticipantes() as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizarcoleccionparticipantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function acumularsumarizado( tlforzar as boolean, tcatributo as string, tnvalor as decimal, tnvalorant as decimal ) as void                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tlforzar
		lxParam2 = tcatributo
		lxParam3 = tnvalor
		lxParam4 = tnvalorant

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Acumularsumarizado', lcParametros )
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
	function articulo_access() as variant                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Articulo_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function articulo_pk_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Articulo_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function articulodetalle_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Articulodetalle_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function bindearcomponentes() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Bindearcomponentes', lcParametros )
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
	function buscarclase( tcclase as string ) as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcclase

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Buscarclase', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiocombinacion() as void                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiocombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiosumarizado() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cambiosumarizado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cantidad_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cantidad_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cantidadstockdf_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cantidadstockdf_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cargamanual() as boolean                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Cargamanual', lcParametros )
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
	function codigodebarras_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Codigodebarras_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function color_access() as variant                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Color_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function color_pk_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Color_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function colorart_access() as variant                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Colorart_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function colorart_pk_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Colorart_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function colorartdetalle_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Colorartdetalle_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function colordetalle_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Colordetalle_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function comportamiento_assign( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Comportamiento_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crear_oclases() as void                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Crear_oclases', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function crearobjeto( tcclase as string, tclibreria as string, tvpar1 as variant, tvpar2 as variant, tvpar3 as variant, tvpar4 as variant, tvpar5 as variant , tvpar6 as variant, tvpar7 as variant, tvpar8 as variant )                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7, lxParam8, lxParam9, lxParam10

		lnParametros = pcount()
		lxParam1 = tcclase
		lxParam2 = tclibreria
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

		return this.ObtenerResultado( 'Crearobjeto', lcParametros )
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
	function debesugerircodigo() as boolean                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Debesugerircodigo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function desbindearcomponentes() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Desbindearcomponentes', lcParametros )
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
	function descripcionfw_access() as variant                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Descripcionfw_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function elementoanterior( tcatributo) as object                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Elementoanterior', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eliminarstockinicial()                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminarstockinicial', lcParametros )
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
	function equivalencia_access() as variant                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Equivalencia_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function equivalencia_pk_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Equivalencia_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esatributodecombinacion( tcatributo as string ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esatributodecombinacion', lcParametros )
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
	function esitemretiroenefectivo() as boolean                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esitemretiroenefectivo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esmodoedicion() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esmodoedicion', lcParametros )
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
	function eventoalcanzominimodereposicion( toinformacion ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toinformacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoalcanzominimodereposicion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoantesdesetear( toobject as object, tcatributo as string, txvalold as variant, txval as variant ) as void                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = toobject
		lxParam2 = tcatributo
		lxParam3 = txvalold
		lxParam4 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoantesdesetear', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoantesdeverificardisponibilidaddestockalsetearcantidad() as void                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventoantesdeverificardisponibilidaddestockalsetearcantidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventocambioatributodecombinacion( tcatributo as string, toitem as object ) as void                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventocambioatributodecombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventocomponentekitdearticulos( tcatributo as string, toitem as object ) as void                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventocomponentekitdearticulos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventocomponentestock( tcatributo as string, toitem as object ) as void                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventocomponentestock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventodespuesdesetear( toobject as object, tcatributo as string, txvalold as variant, txval as variant ) as void                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = toobject
		lxParam2 = tcatributo
		lxParam3 = txvalold
		lxParam4 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventodespuesdesetear', lcParametros )
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
	function eventohacambiadocantidad( toitem as object, tncantidadanterior as number, tnmontoanterior as number ) as void                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = toitem
		lxParam2 = tncantidadanterior
		lxParam3 = tnmontoanterior

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventohacambiadocantidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventohacambiadomonto( toitem as object, tncantidadanterior as number, tnmontoanterior as number ) as void                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = toitem
		lxParam2 = tncantidadanterior
		lxParam3 = tnmontoanterior

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventohacambiadomonto', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventoinformararticuloconcolorotallefueradepaletaocurva( toinformacion as object ) as void                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toinformacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventoinformararticuloconcolorotallefueradepaletaocurva', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventonohaystock( toinformacion ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toinformacion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventonohaystock', lcParametros )
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
	function eventosetearitemdespuesdeexcepcionfueradepaletaocurva() as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eventosetearitemdespuesdeexcepcionfueradepaletaocurva', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function existearchivoclase( tcfile as string ) as boolean                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcfile

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Existearchivoclase', lcParametros )
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
	function habilitar( tlhabilitar as boolean ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlhabilitar

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Habilitar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hacambiado( tcatributo as string, toitem as object ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Hacambiado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hayinformacion() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hayinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function init()                                                                                                                                                                                                                                           
	EndFunc

	*-----------------------------------------------------------------------------------------
	function insumo_access() as variant                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Insumo_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function insumo_pk_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Insumo_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function insumodetalle_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Insumodetalle_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inventario_access() as variant                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Inventario_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inventario_pk_assign( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inventario_pk_assign', lcParametros )
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
	function inyectardetalle( todetalle as detalle of detalle.prg ) as void                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = todetalle

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectardetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inyectarentidad( toentidad as object ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toentidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectarentidad', lcParametros )
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
	function mensagelogueoinicial() as string                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Mensagelogueoinicial', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function noprocesarstock_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Noprocesarstock_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nroitem_assign( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Nroitem_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoscombinacion() as object                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributoscombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercomponente( tccomponente as string ) as object                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccomponente

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercomponente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerinformacion() as zooinformacion of zooinformacion.prg                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenernombre() as string                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombre', lcParametros )
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
	function ocomportamientocodigosugerido_access() as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ocomportamientocodigosugerido_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ocompstockproduccion_access() as variant                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ocompstockproduccion_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oinformacion_access() as variant                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Oinformacion_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ologueo_access() as variant                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ologueo_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function omensaje_access() as void                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Omensaje_access', lcParametros )
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
	function partida_assign( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Partida_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function puedeejecutarcambiosumarizado() as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Puedeejecutarcambiosumarizado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function puedeejecutarhacambiado() as boolean                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Puedeejecutarhacambiado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function restaurargenhabilitar() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Restaurargenhabilitar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function rinde_assign( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Rinde_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function sedebeloguear() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Sedebeloguear', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_articulo( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_articulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_articulodetalle( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_articulodetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cantidad( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_cantidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_cantidadstockdf( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_cantidadstockdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_codigodebarras( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_codigodebarras', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_color( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_color', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_colorart( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_colorart', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_colorartdetalle( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_colorartdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_colordetalle( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_colordetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_comportamiento( txval as variant ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_comportamiento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_equivalencia( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_equivalencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_insumo( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_insumo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_insumodetalle( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_insumodetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_inventario( txval as variant ) as void                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_inventario', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_noprocesarstock( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_noprocesarstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_nroitem( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_nroitem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_partida( txval as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_partida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_rinde( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_rinde', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_talle( txval as variant ) as void                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_talle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_talleart( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_talleart', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_talleartdetalle( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_talleartdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_talledetalle( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_talledetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_unidad( txval as variant ) as void                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_unidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setear_unidadstockdf( txval as variant ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setear_unidadstockdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearaccion() as string                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearaccion', lcParametros )
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
	function setearstockinicial()                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Setearstockinicial', lcParametros )
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
	function talle_access() as variant                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Talle_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function talle_pk_assign( txval as variant ) as void                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Talle_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function talleart_access() as variant                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Talleart_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function talleart_pk_assign( txval as variant ) as void                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Talleart_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function talleartdetalle_assign( txval as variant ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Talleartdetalle_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function talledetalle_assign( txval as variant ) as void                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Talledetalle_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienearticulocargado() as boolean                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienearticulocargado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienedisponible() as boolean                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienedisponible', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienedisponibledeparticipantes() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienedisponibledeparticipantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function totalizarsumarizado( ttoitem as object ) as void                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = ttoitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Totalizarsumarizado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function unidad_access() as variant                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Unidad_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function unidad_pk_assign( txval as variant ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Unidad_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function unidadstockdf_access() as variant                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Unidadstockdf_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function unidadstockdf_pk_assign( txval as variant ) as void                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Unidadstockdf_pk_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaarticulotipokit() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validaarticulotipokit', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_articulo( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_articulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_articulodetalle( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_articulodetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cantidad( txval as variant ) as boolean                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_cantidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_cantidadstockdf( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_cantidadstockdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_codigodebarras( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_codigodebarras', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_color( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_color', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_colorart( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_colorart', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_colorartdetalle( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_colorartdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_colordetalle( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_colordetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_comportamiento( txval as variant ) as boolean                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_comportamiento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_equivalencia( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_equivalencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_insumo( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_insumo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_insumodetalle( txval as variant ) as boolean                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_insumodetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_inventario( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_inventario', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_noprocesarstock( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_noprocesarstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_nroitem( txval as variant ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_nroitem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_partida( txval as variant ) as boolean                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_partida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_rinde( txval as variant ) as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_rinde', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_talle( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_talle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_talleart( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_talleart', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_talleartdetalle( txval as variant ) as boolean                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_talleartdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_talledetalle( txval as variant ) as boolean                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_talledetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_unidad( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_unidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar_unidadstockdf( txval as variant, txvalold as variant ) as boolean                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = txvalold

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validar_unidadstockdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validaratributocomponente( txval as variant, tcatributo as string ) as boolean                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = txval
		lxParam2 = tcatributo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validaratributocomponente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarexistenciacamposfijos() as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarexistenciacamposfijos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarexistenciacamposfijositemplano() as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarexistenciacamposfijositemplano', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarsicambioelvalordelatributo( tcatributo as string, txvalold as variant, txval as variant ) as boolean                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcatributo
		lxParam2 = txvalold
		lxParam3 = txval

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Validarsicambioelvalordelatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoarticulo() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoarticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoarticulodetalle() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoarticulodetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocantidad() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocantidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocantidadstockdf() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocantidadstockdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocolor() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocolor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocolorart() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocolorart', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocolorartdetalle() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocolorartdetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridocolordetalle() as void                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridocolordetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoinsumo() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoinsumo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridoinsumodetalle() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridoinsumodetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridopartida() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridopartida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridorinde() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridorinde', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotalle() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridotalleart() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridotalleart', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridounidad() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridounidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valorsugeridounidadstockdf() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valorsugeridounidadstockdf', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificarvalidezarticulo( toarticulo as entidad of entidad.prg ) as void                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toarticulo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Verificarvalidezarticulo', lcParametros )
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
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcclase

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Esclasenet', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenernombreclase( tcclase ) as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcclase

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenernombreclase', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	hidden function obtenersentenciacondesgloseparametros( tccomando as string, tcclase as string, tclibreria as string, tcapp as string, tnparametros as integer )                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tccomando
		lxParam2 = tcclase
		lxParam3 = tclibreria
		lxParam4 = tcapp
		lxParam5 = tnparametros

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciacondesgloseparametros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function agregarclaseacoleccion( tcclase as string ) as void                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcclase

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agregarclaseacoleccion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function escomponentestock() as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Escomponentestock', lcParametros )
	EndFunc


enddefine