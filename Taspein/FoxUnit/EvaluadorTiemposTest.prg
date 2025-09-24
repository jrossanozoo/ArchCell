define class EvaluadorTiemposTest as custom

	#if .f.
		Local this as EvaluadorTiemposTest of EvaluadorTiemposTest.prg
	#endif

	nSegundosLimite = 1
	oTestExcluidos = null
	 
	*-----------------------------------------------------------------------------------------
	function Init() as Void
		dodefault()
		if vartype(this.oTestExcluidos) != "O"
			this.oTestExcluidos =  newobject( "collection" )
			*this.CargarTest()
			this.SetearSegundosLimiteDeTest()
		endif

	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function CargarTest() as Void
		local lnConexion as Integer, lcSql as String, lcCursor as String

		lnConexion = this.ConectarSql()
		if lnConexion > -1
			lcCursor = "c_" + sys( 2015 )
			lcSql = "SELECT NombreClase + '_' + NombreTest as Test " + ;
					"FROM [Desarrollo].[Autobuild].[TestExcluidos] " + ;
					"where excluido = 1 and Proyecto = '" + alltrim( upper( _Screen.Zoo.App.cProyecto ) ) + "'"
			
			try
				sqlexec( lnConexion, lcSql, lcCursor )
				select &lcCursor
				scan
					this.oTestExcluidos.Add( upper(alltrim( &lcCursor..Test )), upper(alltrim( &lcCursor..Test )) )
				endscan
			catch
				if !_screen.zoo.EsBuildAutomatico
					goServicios.Mensajes.Enviar( "Hubo problemas al realizar la consulta SQL para cargar los Test que se deben excluir de la medición de tiempos." )
				endif
			endtry
			use in select( lcCursor )
        	sqldisconnect( lnConexion )
		endif
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function SetearSegundosLimiteDeTest() as Void
		local lnSegundos as Integer
		
		lnSegundos = This.ObtenerSegundosDesdeElServidor()
		This.nSegundosLimite = lnSegundos
		
	endfunc

	*-----------------------------------------------------------------------------------------
	protected function ObtenerSegundosDesdeElServidor() as integer
		local lnSegundosLocal as Integer, lcSql as String, lcCursor as String, lcNombreEquipo as string
		lnSegundosLocal = 1

		lnConexion = this.ConectarSql()
		
		if lnConexion > -1
			lcCursor = "c_" + sys( 2015 )
			lcSql = "SELECT SegundosTest as seg, coeficienteTest as coe, nombre FROM [Desarrollo].[Autobuild].[Servidores]"

			try
				sqlexec( lnConexion, lcSql, lcCursor )
				lcNombreEquipo = This.ObtenerNombreEquipo()
				locate for alltrim( upper( &lcCursor..nombre ) ) == lcNombreEquipo
				if found()
					*-- Ya tengo los segundos
					lnSegundosLocal = &lcCursor..seg
				else
					
					locate for &lcCursor..coe>0
					if found()
						*-- Obtener Diferencia de segundos
						lnSegundosLocal = ( &lcCursor..coe / This.CalcularCoeficienteActual() ) * &lcCursor..seg
					endif
				endif
			catch
			finally
				use in select( lcCursor )
		    	sqldisconnect( lnConexion )
			endtry
		endif

		return lnSegundosLocal
	endfunc 	

	*-----------------------------------------------------------------------------------------
	protected function CalcularCoeficienteActual() as decimal
		local lnTiempo as Decimal, lnFin as Decimal, lnCont as Integer
		lnTiempo = SECONDS()
		
		FOR lnCont=1 TO 10000000
		endfor
		
		lnFin = SECONDS()
		return lnFin - lnTiempo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerNombreEquipo() as String
		local lcRetorno as String
		lcRetorno = alltrim( left( sys(0), at( "#", sys(0) ) -1 ) )
		return lcRetorno
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ConectarSql() as Integer
		return -1
		*sqlstringconnect( "Driver={Sql Server Native Client 10.0};Server=ZLLOPSFSI02;Database=Desarrollo;Trusted_Connection=yes" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EvaluarTiemposTest( toTestResult as FxuTestResult of FxuTestResult.prg ) as Boolean
		local lnDuracionTest as Integer, llRetorno as Boolean
		llRetorno = .F.
******************** OJO SACAR ESTO PARA ACTIVAR LA FUNCIONALIDAD *******************
** SAQUE EL STRTOFILE POR QUE ME PARECIA UNA LOKURA --> PALAT
return llRetorno
*************************************************************************************
		with toTestResult
			if this.EvaluarSiDebeValidatTestPorTiempos( toTestResult )
			.ilCurrentResult = .F.
			
			lcMensaje = "Exedio el tiempo permitido para un test unitario. El permitido es " + transform( this.ObtenerLimiteDeSegundos() ) + " segundos."
			.icFailureErrorDetails = lcMensaje
			.icMessages = lcMensaje
			llRetorno = .T.
			endif
		endwith 		
		return llRetorno
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function EvaluarSiDebeValidatTestPorTiempos( toTestResult as FxuTestResult of FxuTestResult.prg ) as Void
		local llRetorno as Boolean
		llRetorno = .F.

		if !( "NOCTURNO" $ upper( alltrim( toTestResult.icCurrentTestClass ) ) ) and (_Screen.Zoo.App.cProyecto != "ADNIMPLANT")
			if toTestResult.ilCurrentResult
				lcKey = upper( alltrim( .icCurrentTestClass ) ) + "_" + upper( alltrim( .icCurrentTestName ) )
				if this.oTestExcluidos.GetKey(lcKey)=0
					llRetorno = this.CalculateElapsed( toTestResult.inCurrentStartSeconds, toTestResult.inCurrentEndSeconds ) > this.ObtenerLimiteDeSegundos()
				endif
			endif
		endif
		
		return llRetorno
	endfunc 
		
	*-----------------------------------------------------------------------------------------
	protected function CalculateElapsed(tnStartSeconds, tnEndSeconds) as Integer
	
		IF tnEndSeconds <tnStartSeconds
			tnEndSeconds = tnEndSeconds + 126000
		ENDIF
		
		lnElapsedSeconds = tnEndSeconds - tnStartSeconds
		
		RETURN lnElapsedSeconds
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerLimiteDeSegundos() as integer
		return int( this.nSegundosLimite )
	endfunc 
	
enddefine
