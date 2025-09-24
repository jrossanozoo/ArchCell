
define class Mock_GENERADORPASAJEDESTOCK as MockBase of MockBase.prg

	cClase = 'GENERADORPASAJEDESTOCK'

	
	lPermitirGenerarStockNegativoEnTomaDeInventario = .f.                                                                                                                                                                                                     
	lPermitirPasarSinStock = .f.                                                                                                                                                                                                                              
	oCopiador = null                                                                                                                                                                                                                                          
	oItemAux = null                                                                                                                                                                                                                                           
	oPasajeDeStock = null                                                                                                                                                                                                                                     
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init( topasajedestock as object )                                                                                                                                                                                                                
	EndFunc

	*-----------------------------------------------------------------------------------------
	function destroy() as void                                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Destroy', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function generar() as boolean                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercursoresentradaysalida( ) as void                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercursoresentradaysalida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasentradaysalida( tcsentencia1 as string, tcsentencia2 as string, tcsentencia3 as string, tcsentencia4 as string  ) as void                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tcsentencia1
		lxParam2 = tcsentencia2
		lxParam3 = tcsentencia3
		lxParam4 = tcsentencia4

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasentradaysalida', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function verificardatosparamovimientodestock() as boolean                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificardatosparamovimientodestock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function generarmovimientosenorigen() as boolean                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generarmovimientosenorigen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function generarmovimientosdestockenorigen() as boolean                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generarmovimientosdestockenorigen', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function crearmovimientodestock( tcalias as string, tntipo as integer ) as void                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcalias
		lxParam2 = tntipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Crearmovimientodestock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function advertirerroresencoloresytalles(toex as collection, tomovstock as object ) as void                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = toex
		lxParam2 = tomovstock

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Advertirerroresencoloresytalles', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function actualizarentidadconmovstock( tomovstock ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tomovstock

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Actualizarentidadconmovstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function guardarrangomovimientosgenerados( tomovstock as object ) as void                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tomovstock

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Guardarrangomovimientosgenerados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function crearcabeceramovimientodestock( tomovstock as object, tntipo as integer ) as void                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tomovstock
		lxParam2 = tntipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Crearcabeceramovimientodestock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function aplicardatoscombinacion( tcalias as string, toitem as object ) as void                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcalias
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Aplicardatoscombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function completardatoscombinacion( tcalias as string, toitem as object ) as void                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcalias
		lxParam2 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Completardatoscombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function registraraccionesdelsistema( tomovstock as object, tntipo as integer ) as void                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tomovstock
		lxParam2 = tntipo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Registraraccionesdelsistema', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function transferir() as boolean                                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Transferir', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function verificarstockennegativoantesdeprocesar() as boolean                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Verificarstockennegativoantesdeprocesar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function permitirnegativosendestinoforzandolosparametros( ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Permitirnegativosendestinoforzandolosparametros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function crearitem() as object                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Crearitem', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function cambiarsucursalyparametrosdestino( tcdestino as string, llrestaura as boolean ) as void                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tcdestino
		lxParam2 = llrestaura

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Cambiarsucursalyparametrosdestino', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function eliminarmovimientosgenerados() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Eliminarmovimientosgenerados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneritemaux() as object                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneritemaux', lcParametros )
	EndFunc


enddefine