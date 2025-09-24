
define class Mock_COLABORADORDEDETALLESIMPOEXPO as MockBase of MockBase.prg

	cClase = 'COLABORADORDEDETALLESIMPOEXPO'

	
	oAd = null                                                                                                                                                                                                                                                
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function aplicarordenamiento() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Aplicarordenamiento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inyectaraccesoadatos( toaccesoadatos as object ) as void                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toaccesoadatos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectaraccesoadatos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function ejecutarsentenciaordenamiento() as void                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ejecutarsentenciaordenamiento', lcParametros )
	EndFunc


enddefine