
define class Mock_GENERADORSENTENCIACOMBINACION_COMBINADO as MockBase of MockBase.prg

	cClase = 'GENERADORSENTENCIACOMBINACION_COMBINADO'

	
	cFormatoFechaNet = ""                                                                                                                                                                                                                                     
	lDesarrollo = .f.                                                                                                                                                                                                                                         
	lDestroy = .f.                                                                                                                                                                                                                                            
	lEsExe = .f.                                                                                                                                                                                                                                              
	lLoguear = .T.                                                                                                                                                                                                                                            
	lLogueoPropio = .T.                                                                                                                                                                                                                                       
	lNoCheckSessionOpen = .f. && para omitir el objeto del analisis de sessiones abiertas de test de foxunit                                                                                                                                                  
	lNoLoguearRestAPI = .F.                                                                                                                                                                                                                                   
	oConsultaStock = null                                                                                                                                                                                                                                     
	oConsultaprecios = null                                                                                                                                                                                                                                   
	oInformacion = null                                                                                                                                                                                                                                       
	oLogueo = null                                                                                                                                                                                                                                            
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

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
	function hayinformacion() as boolean                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hayinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function init() as boolean                                                                                                                                                                                                                                
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
	function inyectarentidad( toentidad as entidad of entidad.prg ) as void                                                                                                                                                                                   
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
	function obtenerinformacion() as zooinformacion of zooinformacion.prg                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerinformacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentencia() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenersentencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenertablasconsultacombinaciones() as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertablasconsultacombinaciones', lcParametros )
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
	function oconsultaprecios_access() as variant                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Oconsultaprecios_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oconsultastock_access() as variant                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Oconsultastock_access', lcParametros )
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
	function sedebeloguear() as boolean                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Sedebeloguear', lcParametros )
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


enddefine