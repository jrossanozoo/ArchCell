
define class Mock_MENSAJEENTIDAD as MockBase of MockBase.prg

	cClase = 'MENSAJEENTIDAD'

	
	_nRespuesta = 0                                                                                                                                                                                                                                           
	oObjeto = null                                                                                                                                                                                                                                            
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init( toobjeto as object ) as void                                                                                                                                                                                                               
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearrespuesta( tnrespuesta as integer ) as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnrespuesta

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearrespuesta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerrespuesta() as void                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerrespuesta', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function alertar( tcmensaje as string, tnbotones as integer , tnbotondefault as integer, tctitulo as string, tntiempoespera as integer ) as integer                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tnbotones
		lxParam3 = tnbotondefault
		lxParam4 = tctitulo
		lxParam5 = tntiempoespera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Alertar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function advertir( tcmensaje as string, tnbotones as integer , tnbotondefault as integer, tctitulo as string, tntiempoespera as integer ) as integer                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tnbotones
		lxParam3 = tnbotondefault
		lxParam4 = tctitulo
		lxParam5 = tntiempoespera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Advertir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function preguntar( tcmensaje as string, tnbotones as integer , tnbotondefault as integer, tctitulo as string, tntiempoespera as integer ) as integer                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tnbotones
		lxParam3 = tnbotondefault
		lxParam4 = tctitulo
		lxParam5 = tntiempoespera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Preguntar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function informar( tcmensaje as string, tnbotones as integer , tnbotondefault as integer, tctitulo as string, tntiempoespera as integer ) as integer                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5

		lnParametros = pcount()
		lxParam1 = tcmensaje
		lxParam2 = tnbotones
		lxParam3 = tnbotondefault
		lxParam4 = tctitulo
		lxParam5 = tntiempoespera

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Informar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eventomensaje( tctipomensaje as string, toobjeto as object, tcmensaje as string, tnbotones as integer, tnbotondefault as integer, tctitulo as string, tntiempo as integer ) as integer                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6, lxParam7

		lnParametros = pcount()
		lxParam1 = tctipomensaje
		lxParam2 = toobjeto
		lxParam3 = tcmensaje
		lxParam4 = tnbotones
		lxParam5 = tnbotondefault
		lxParam6 = tctitulo
		lxParam7 = tntiempo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Eventomensaje', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function enviar( tctipomensaje as string, tcmensaje as string, tnbotones as integer, tnbotondefault as integer, tctitulo as string, tntiempo as integer ) as integer                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4, lxParam5, lxParam6

		lnParametros = pcount()
		lxParam1 = tctipomensaje
		lxParam2 = tcmensaje
		lxParam3 = tnbotones
		lxParam4 = tnbotondefault
		lxParam5 = tctitulo
		lxParam6 = tntiempo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Enviar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function defaultrespuestamensaje( tnbotones as integer, tnbotondefault as integer ) as void                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tnbotones
		lxParam2 = tnbotondefault

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Defaultrespuestamensaje', lcParametros )
	EndFunc


enddefine