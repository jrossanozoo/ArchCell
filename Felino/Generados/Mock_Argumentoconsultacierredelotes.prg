
define class Mock_ARGUMENTOCONSULTACIERREDELOTES as MockBase of MockBase.prg

	cClase = 'ARGUMENTOCONSULTACIERREDELOTES'

	
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function obteneratributos() as string                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerfiltro( tcpos as string, tdfechacierredelote as date, tchoracierredelote as string ) as string                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcpos
		lxParam2 = tdfechacierredelote
		lxParam3 = tchoracierredelote

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenerfiltro', lcParametros )
	EndFunc


enddefine