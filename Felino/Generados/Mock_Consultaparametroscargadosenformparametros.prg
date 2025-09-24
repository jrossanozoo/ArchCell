
define class Mock_CONSULTAPARAMETROSCARGADOSENFORMPARAMETROS as MockBase of MockBase.prg

	cClase = 'CONSULTAPARAMETROSCARGADOSENFORMPARAMETROS'

	
	oFormParametros = null                                                                                                                                                                                                                                    
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init( toformparametros as formularioparametrosprincipal of formularioparametrosprincipal.prg ) as void                                                                                                                                           
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenervalorparametro( tcproyecto as string, tnidnodo as integer, tnid as integer ) as object                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tcproyecto
		lxParam2 = tnidnodo
		lxParam3 = tnid

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenervalorparametro', lcParametros )
	EndFunc


enddefine