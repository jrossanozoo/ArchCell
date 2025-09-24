***********************************************************************
*	FoxUnit is Copyright (c) 2004, Vision Data Solutions Inc.
*	All rights reserved.
*
*	Redistribution and use in source and binary forms, with or 
*	without modification, are permitted provided that the following 
*	conditions are met:
*
*		*	Redistributions of source code must retain the above
*			copyright notice, this list of conditions and the 
*			following disclaimer.
*
*		*	Redistributions in binary form must reproduce the above 
*			copyright notice, this list of conditions and the 
*			following disclaimer in the documentation and/or other 
*			materials provided with the distribution. 
*			
*		*	Neither the name of Vision Data Solutions Inc nor the
*			names of the FoxUnit contributors may be used to endorse
*			or promote products derived from this software without
*			specific prior written permission. 
*
*	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
*	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
*	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
*	FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
*	COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
*	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
*	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
*	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
*	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
*	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
*	ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
*	POSSIBILITY OF SUCH DAMAGE.     
***********************************************************************
LPARAMETERS toTestResult as FxuTestResult of FxuTestResult.prg

RETURN CREATEOBJECT("FxuTestCase",toTestResult)

**********************************************************************
DEFINE CLASS FxuTestCase As FxuTest OF FxuTest.Prg
**********************************************************************

	#IF .f.
		LOCAL this as FxuTestCase OF FxuTestCase.prg
	#ENDIF


	protected oServicioMocks as serviciomocks of serviciomocks.prg, cSucursalActivaAnterior as String, _ControlDeObjetosInstanciados as Object 
	
	_ControlDeObjetosInstanciados = null
	icCurrentTest = ""
	ioTestResult = .NULL.
	ilAllowDebug = .f.
	ilQueryTests = .f.
	ilSuccess = .t.
	inReturnCode = 0
	ioAssert = .f.
	icTestPrefix = "ZTEST"
	
	oColServiciosAntesDeIniciar = null
	cServicios = ""
	cTipoDeBase = ""
	cBaseAnt = ""
	cSucursalActivaAnterior = ""
	
	nMinutosVencimientoParametrosPuesto = 0
	nMinutosVencimientoParametrosSucursal = 0
	nMinutosVencimientoParametrosOrganizacion = 0
	nMinutosVencimientoRegistryPuesto = 0
	nMinutosVencimientoRegistrySucursal = 0
	nMinutosVencimientoRegistryOrganizacion = 0

	oColTablasAbiertas = null
	oServicioMocks = null
	
	_MemberData = [<VFPData><memberdata ] ;
	 + [name="AssertEquals" display="AssertEquals" type="method" ] ;
	 + [name="AssertTrue" display="AssertTrue" type="method" ] ;
	 + [name="AssertNotNull" display="AssertNotNull" type="method" ] ;
	 + [/></VFPData>]
	 
	
	lVerificarObjetosInstanciados = .F. 	&& Indica si debe controlar TODOS los objetos que quedan abiertos despues del TearDown.
	lVerificarSesiones = .t. 		&& Indica si debe controlar sesion despues del TearDown.
	lVerificarSesionesV2 = .T.		&& La V2 Indica el nombre sesion queda abierta luego de ejecutar el TearDown.
	nSesionesIniciales = 0	
	oSesiones = null
	nSesionesIniciales = 0
	Dimension laSesiones(1)

	lMockearParametros = .T.
	lLoguearCantidadDeMemoriaVFP = .T. 
	
	
	********************************************************************
	FUNCTION INIT(toTestResult)
	********************************************************************
		IF VERSION(5) < 900
			LOCAL laStackInfo[1]
			IF ASTACKINFO(laStackInfo) > 0
				IF ASCAN(laStackInfo,"FXUInheritsFromFXUTestCase",1,-1,3,15)>0
				*
				*  don't proceed with this method if this 
				*  object is being instantiated from 
				*  FXUInheritsFromFXUTestCase.PRG, to test
				*  its inheritance
				*
				*  MODIFY COMMAND FXUInheritsFromFXUTestCase
				*
				RETURN .t.
				ENDIF
				RELEASE laStackInfo
			ENDIF
		ENDIF

		
		IF VARTYPE(toTestResult) != "O"
			this.ilQueryTests = .t.
		ELSE
			IF UPPER(toTestResult.Class) == "FXUTESTRESULT"
				this.ioTestResult = toTestResult
			ELSE
				RETURN .f.
			ENDIF
		ENDIF
		
		this.icCurrentTest = this.ioTestResult.icCurrentTestName
			
		RETURN .t.
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION Run()
	********************************************************************
		LOCAL loExTest as Exception, loZooEx as exception
	
		this.ioAssert = .f.
		this.ioAssert = FxuNewObject("FxuAssertions")
		this.ioAssert.ioTestResult = this.ioTestResult
		
		this.ioTestResult.inCurrentStartSeconds = SECONDS()
		this.ioTestResult.inCurrentStartTime = datetime()

		this.InicializarServicioDatos()
		this.InicializarRegistroDeActividad()		
		
		if this.ValidarEjecucionTest()
			this.EjecutarTest()
		else
			this.ioTestResult.lCorrioTest = .F.
		endif
				
		this.ioTestResult.inCurrentEndSeconds = SECONDS()
		this.ioTestResult.inCurrentEndTime = datetime()
	
		this.ioTestResult.LogResult()
	
	********************************************************************
	ENDFUNC
	********************************************************************

	*-----------------------------------------------------------------------------------------
	protected function EjecutarTest() as Void
		local lnCantDbf
		local array laCantDbf[1]
		
		IF this.ilAllowDebug
			this.RunWithSetupTeardownDebugging()
		else
			try
				if type( "_screen.zoo" ) = "O"
					if pemstatus( _Screen.zoo.app, "TipoDeBase", 5 )
						this.cTipoDeBase = _Screen.zoo.app.TipoDeBase
					endif
					this.AumentarBufferDeParametrosyRegistros()
					this.MatarServicios()
					this.AntesDelSetup()
					this.ControlarTablasAbiertas( 1, .t. )
					
					if pemstatus( _Screen.zoo.app, "cSucursalActiva", 5 )
						this.cSucursalActivaAnterior = _screen.Zoo.App.cSucursalActiva
					else
						this.cSucursalActivaAnterior = ""
					endif
				endif
				set talk off
				this.SetUp()
				this.RunTest()
			CATCH TO loExTest						
				this.asserttrue( DesglosarError( loExTest ) , .f. )
			FINALLY
				try
					try
						this.TearDown()
					finally
						if type( "_screen.zoo" ) = "O"
							this.MatarServicios()
							if !inlist(_screen.zoo.app.cProyecto,"NUCLEO","GENERADORES","DIBUJANTE")
								this.CerrarSubEntidadesDeCajas()
							endif
							this.DesconectarConexionesAdicionales()
							this.ControlarTablasAbiertas( 1 )
						endif
						this.DespuesDelTearDown()
					endtry
				CATCH TO loExTest
					LOCAL ARRAY laStackInfo[1,1]
					=ASTACKINFO(laStackInfo)
					this.HandleException(loExTest,@laStackInfo,.t.)
				finally
					if type( "_screen.zoo" ) = "O"
						_Screen.zoo.app.TipoDeBase = this.cTipoDeBase
					endif
				ENDTRY 
			ENDTRY
		ENDIF
	endfunc 

	*-----------------------------------------------------------------------------------------
	function CerrarSubEntidadesDeCajas() as Void
		if type( "goCaja" ) == "O" and !isnull( goCaja )
			try
				goCaja.ldestroy = .t.
				if type( "goCaja.oCajaEstado" ) == "O" and !isnull( goCaja.oCajaEstado )
					goCaja.oCajaEstado.Release()
				endif
				if type( "goCaja.oCajaSaldos" ) == "O" and !isnull( goCaja.oCajaSaldos )
					goCaja.oCajaSaldos.Release()
				endif
				if type( "goCaja.oCajaAuditoria" ) == "O" and !isnull( goCaja.oCajaAuditoria )
					goCaja.oCajaAuditoria.Release()
				endif						
			finally
				goCaja.ldestroy = .f.
			endtry
		endif
	endfunc 


	*-----------------------------------------------------------------------------------------
	function AumentarBufferDeParametrosyRegistros() as Void
		goParametros.oDatos.SetearMinutosVencimiento( 3*60 )
		goRegistry.oDatos.SetearMinutosVencimiento( 3*60 )			
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ControlarTablasAbiertas( tnSesion as integer, tlGuardar as Boolean ) as Void
		if empty( tnSesion ) 
			tnSesion = 0
		endif

		if tlGuardar
			this.CargarTablasAbiertas( tnSesion )
		else
			this.ChequearTablasAbiertas( tnSesion )		
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function CargarTablasAbiertas( tnSession ) as Void
		local i as Integer, lnSesiones as Integer
		local array aSessiones[1]
		
		with this as fxutestcase of fxutestcase.prg
			if vartype( .oColTablasAbiertas ) != "O"
				.oColTablasAbiertas = newobject( "Collection" )
			endif
			
			if empty( tnSession )
				lnSesiones = asessions( aSesiones )
				for i = 1 to lnSesiones
					.CargarTablasAbiertasSegunSesion( aSesiones[ i ] )
				endfor
			else
				.CargarTablasAbiertasSegunSesion( tnSession )			
			endif
		endwith		
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function CargarTablasAbiertasSegunSesion( tnSesion as Integer ) as Void
		local lnCant as Integer, i as Integer, lcClave as String
		local array laTablas[1]
		
		lnCant = aused( laTablas, tnSesion )
		lcClave = alltrim( transform( tnSesion ))
		
		if this.oColTablasAbiertas.GetKey( lcClave ) > 0
			this.oColTablasAbiertas.Remove( lcClave )
		endif
		
		this.oColTablasAbiertas.Add( newobject( "Collection" ), lcClave )
		
		for i = 1 to lnCant
			this.oColTablasAbiertas.Item[ lcClave ].Add( laTablas[i, 1], alltrim( upper( laTablas[i, 1] ) ) )
		endfor
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ChequearTablasAbiertas( tnSesion as integer ) as Void
		local i as Integer, lnSesiones as Integer
		local array aSessiones[1]
		
		with this as fxutestcase of fxutestcase.prg
			if empty( tnSesion )
				lnSesiones = asessions( aSesiones )
				for i = 1 to lnSesiones
					this.ChequearTablasAbiertasSegunSesion( aSesiones[ i ])
				endfor
			else
				this.ChequearTablasAbiertasSegunSesion( tnSesion )			
			endif
		endwith		
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ChequearTablasAbiertasSegunSesion( tnSesion as Integer ) as Void
		local lnCant as Integer, i as Integer, lcClave as String, llExiste as Boolean, lnSesion as Integer
		local array laTablas[1]
		
		lnCant = aused( laTablas, tnSesion )
		lcClave = alltrim( transform( tnSesion ))
		lnSesion = set( "Datasession" )
		
		if this.oColTablasAbiertas.GetKey( lcClave ) > 0
			for i = 1 to lnCant
				llExiste = this.oColTablasAbiertas.Item[ lcClave ].GetKey( alltrim( upper( laTablas[i, 1] ))) > 0
				this.Asserttrue( "La tabla/cursor " + alltrim( upper( laTablas[i, 1] )) + " de la sesion " + lcClave + " está abierta al final del test", llExiste )
				
				if !llExiste
					set datasession to tnSesion
					use in select( laTablas[i, 1] )
					set datasession to lnSesion
				endif
			endfor
		endif
		this.oColTablasAbiertas.remove(-1)
		this.oColTablasAbiertas = null
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ValidarEjecucionTest() as Void
		local llRetorno as Boolean
		
		llRetorno = .t.
		if type( "_screen.zoo" ) = "O"
			do case
				case goServicios.Datos.EsNativa()
					if left( upper( alltrim( this.iCcurrentTest ) ), 14 ) == "ZTESTSQLSERVER"
						llRetorno = .f.
					endif
				case goServicios.Datos.EsSqlServer()
					if left( upper( alltrim( this.iCcurrentTest ) ), 11 ) == "ZTESTNATIVA"
						llRetorno = .f.
					endif
			endcase
		endif
				
		return llRetorno
	endfunc 

	********************************************************************
	PROTECTED FUNCTION RunWithSetupTeardownDebugging
	********************************************************************
	
		LOCAL loExTest as Exception
	
		this.AntesDelSetup()
		this.Setup()
	
		TRY

			this.RunTest()	
		
		CATCH TO loExTest
		
			LOCAL ARRAY laStackInfo[1,1]
			=ASTACKINFO(laStackInfo)
			this.HandleException(loExTest,@laStackInfo)
		
		ENDTRY
		
		this.TearDown()
		this.DespuesDelTearDown()
		
		RETURN 
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION SetUp() && Abstract Method
	********************************************************************
	
	
	
	********************************************************************
	ENDFUNC
	********************************************************************
	*-----------------------------------------------------------------------------------------
	protected function MatarServicios() as Void
		local i as Integer, lnCant as Integer
		
		if vartype( goServicios ) == "O"
			lnCant = goServicios.oColServiciosActivos.Count
				
			if goServicios.oColServiciosActivos.GetKey( "MANAGERTRANSFERENCIAS" ) > 0
				goServicios.oColServiciosActivos[ "MANAGERTRANSFERENCIAS" ].Detener()
				this.AssertEquals( "No se mató correctamente el servicio de Transferencias (fxuTestCase)", lnCant - 1, goServicios.oColServiciosActivos.Count )
			endif

			lnCant = goServicios.oColServiciosActivos.Count
			if goServicios.oColServiciosActivos.GetKey( "SERVICIOESTRUCTURA" + _screen.zoo.app.TipoDeBase ) > 0
				goServicios.oColServiciosActivos[ "SERVICIOESTRUCTURA" + _screen.zoo.app.TipoDeBase ].Detener()
				this.AssertEquals( "No se mató correctamente el servicio de Transferencias (fxuTestCase)", lnCant - 1, goServicios.oColServiciosActivos.Count )
			endif

			lnCant = goServicios.oColServiciosActivos.Count
			if goServicios.oColServiciosActivos.GetKey( "MANAGERACCIONESAUTOMATICAS" ) > 0
				goServicios.oColServiciosActivos[ "MANAGERACCIONESAUTOMATICAS" ].Detener()
				this.AssertEquals( "No se mató correctamente el servicio de Acciones automaticas (fxuTestCase)", lnCant - 1, goServicios.oColServiciosActivos.Count )
			endif

			lnCant = goServicios.oColServiciosActivos.Count
			if goServicios.oColServiciosActivos.GetKey( "TERMINAL" ) > 0
				goServicios.oColServiciosActivos[ "TERMINAL" ].Detener()
				this.AssertEquals( "No se mató correctamente el servicio de Terminal (fxuTestCase)", lnCant - 1, goServicios.oColServiciosActivos.Count )
			endif

			lnCant = goServicios.oColServiciosActivos.Count
			if goServicios.oColServiciosActivos.GetKey( "MANAGEREJECUCION" ) > 0
				goServicios.oColServiciosActivos[ "MANAGEREJECUCION" ].Detener()
				this.AssertEquals( "No se mató correctamente el servicio de Ejecucion (fxuTestCase)", lnCant - 1, goServicios.oColServiciosActivos.Count )
			endif			
			
			lnCant = goServicios.oColServiciosActivos.Count
			if goServicios.oColServiciosActivos.GetKey( "SEGURIDAD" ) > 0
				goServicios.oColServiciosActivos[ "SEGURIDAD" ].Detener()
				this.AssertEquals( "No se mató correctamente el servicio de Ejecucion (fxuTestCase)", lnCant - 1, goServicios.oColServiciosActivos.Count )
			endif			
			
		endif		
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function DesconectarConexionesAdicionales() as Void
		if type( "_screen.zoo" ) = "O"
			if type( "_screen.zoo.app" ) = "O"
				if type( "_screen.zoo.app.oPoolConexiones" ) = "O"
					_screen.zoo.app.oPoolConexiones = null
				endif
			endif
		endif
	endfunc 


	*-----------------------------------------------------------------------------------------
	protected function InicializarServicioDatos() as Void
		if type( "_screen.zoo" ) = "O"
			if vartype( goDatos ) != 'O'
				public goDatos
				goDatos = _screen.zoo.Crearobjeto( "ServicioDatos" )
				_screen.zoo.app.oDatos = goDatos
			endif
			
			goServicios.Datos = goDatos
		endif
	endfunc 
	*-----------------------------------------------------------------------------------------
	protected function InicializarRegistroDeActividad() as Void
		try
			local pp
			pp = Goservicios.RegistroDeActividad
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ObtenerSesiones() as Collection
		local loSesionesAbiertas as Collection, lnI as Integer, lcId as String, lcNombre as string, ;
			leItem as Variant, llExiste as Boolean, lcNombreExistente AS String, loObjetoVFP as Object
		local llOmitir as Boolean 
		loSesionesAbiertas = newobject("Collection")
		
		for lnI = 1 to _vfp.Objects.Count
			try
				loObjetoVFP = _vfp.Objects.Item[lnI]
			catch
				&& Que entre acá es raro, no?, pero esta pasando en los bancos de prueba y autobuild :S
				&& esta pasando en el zTestListadobase.prg -> ztestu_ObtenerNombreFuncionsql
				loObjetoVFP = null
			endtry

			if !isnull( loObjetoVFP ) and pemstatus( loObjetoVFP, "DataSessionId", 5 )				
				lcId = transform( loObjetoVFP.DataSessionId ) 
				lcNombre = upper( alltrim( loObjetoVFP.Name ) )

				llOmitir = pemstatus(loObjetoVFP,"lNoCheckSessionOpen",5) and loObjetoVFP.lNoCheckSessionOpen

				try
					llExiste = .F.
					leItem = loSesionesAbiertas.Item[ lcId ]
					llExiste = .T.
				Catch
				Endtry
				
				if !llOmitir
					if llExiste 
						lcNombreExistente = loSesionesAbiertas.Item[ lcId ]
						loSesionesAbiertas.Remove( lcId )
						loSesionesAbiertas.Add( lcNombreExistente + ", " + lcNombre, lcId )
					else
						loSesionesAbiertas.Add( lcNombre, lcId )
					endif
				endif
			endif
			llOmitir = .f.
		endfor
								
		return loSesionesAbiertas
	endfunc 


	********************************************************************
	FUNCTION AntesDelSetup() && Solo para medir sesiones
		if vartype( goTimer ) == "O"
			goTimer.MatarTodosLosTimers()
		endif
		
		&& El Verificar Sesiones V2 contiene mucho detalle, se utiliza para obtener el nombre de la clase que te deja la sesion abierta
		*this.lVerificarSesionesV2 = !_screen.Zoo.EsBuildAutomatico
		
		if this.lVerificarSesiones
			if this.lVerificarSesionesV2
				this.oSesiones = this.ObtenerSesiones()
				this.nSesionesIniciales = this.oSesiones.Count
			else			
				this.nSesionesIniciales = asessions( this.laSesiones )
			endif
		endif		
		
		this.oColServiciosAntesDeIniciar = newobject( "Collection" )
		if vartype( goServicios ) = "O"
			local loServicio as Object
			for each loServicio in goServicios.oColServiciosActivos foxobject
				this.oColServiciosAntesDeIniciar.add( loServicio.Class, alltrim( upper( loServicio.Class )) )
			endfor
			goServicios.RegistroDeActividad.lEstaHabilitado = .f.
		endif
		
		
		if this.lVerificarObjetosInstanciados
			local lcClaseMock as String 
			&&Lazyloading de serviciomocks
			lcClaseMock = this.oServicioMocks.class
			
			this._ControlDeObjetosInstanciados = newobject( "_ControlDeObjetosInstanciados", "_ControlDeObjetosInstanciados.prg" )
			this._ControlDeObjetosInstanciados.IniciarControl( .F. ) && tlControlAvanzado 
		endif		

		if This.lMockearParametros
			_Screen.Mocks.agregarmockparametrosyregistros()
		Endif			

	ENDFUNC

	*-----------------------------------------------------------------------------------------
	FUNCTION RunTest()
		LOCAL lcCurrentTest, loError
		
		lcCurrentTest = "this." + this.icCurrentTest + "()"
		
		try
			&lcCurrentTest
		catch to loError
			throw loError
		endtry
	ENDFUNC
	
	*-----------------------------------------------------------------------------------------
	FUNCTION TearDown() && Abstract Method
	ENDFUNC

	*-----------------------------------------------------------------------------------------
	hidden FUNCTION DespuesDelTearDown() && Para medir cantidad se sesiones
		local lcMensajeServicios as String
		
		if pemstatus(_screen, "Mocks", 5 ) and vartype( _Screen.Mocks ) = "O"
			_screen.mocks.vaciar()
		endif

		if vartype( goServicios ) = "O"
			if goServicios.oColServiciosActivos.count != this.oColServiciosAntesDeIniciar.count
				lcMensajeServicios = this.ObtenerServiciosFaltantes( this.oColServiciosAntesDeIniciar, goServicios.oColServiciosActivos )
				if !empty( lcMensajeServicios )
					this.assertequals( "La cantidad de servicios instanciados al final es distinta a la inicial", ;
						this.oColServiciosAntesDeIniciar.count, goServicios.oColServiciosActivos.count )
					this.asserttrue( lcMensajeServicios, .f. )
				endif
			endif
		endif
		
		this.EliminarArchivosMcokV2()
		
		if this.lVerificarSesionesV2
			this.ControlarSesionesAbiertasV2()
		else
			this.ControlarSesionesAbiertasV1()
		endif
		if this.lLoguearCantidadDeMemoriaVFP
			this.LoguearCantidadDeMemoriaVFP()
		endif

		&&Se limpia en todos los test esta coleccion de información para que no acumule.
		local loInformacion as zooinformacion of zooInformacion.prg
		loInformacion = _screen.zoo.app.ObtenerInformacion()
		loInformacion.Remove(-1)
		loInformacion.release()
		loInformacion = null
		
		if this.lVerificarObjetosInstanciados
			this.AssertEquals( "Problemas en el control de objetos instanciados.", "", this._ControlDeObjetosInstanciados.FinalizarControl() )
		endif
		This.VerificarGOs_y_ScreenZoos()
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ControlarSesionesAbiertasV1() as Void
		local lnSesionesFinales as integer, loSesionesFinales as Collection, lcMsgErrSess as string, ;
			  loError as Exception, i as Integer, lnDataSs as Integer
		local array laSesionesFinales(1)
		
		
		if type( "_screen.zoo" ) == "O" and ( this.lVerificarSesiones or _screen.Zoo.EsBuildAutomatico )

			lnSesionesFinales = asessions( laSesionesFinales )
			if this.nSesionesIniciales # lnSesionesFinales			
				
				try
					create cursor SessStart ( id n(10)  )
					for i = 1 to alen( this.lasesiones, 1 )
						lnDataSs = this.lasesiones[i]
						insert into SessStart (id) values ( lnDataSs )
					endfor

					create cursor SessFinish ( id n(10) )
					for i = 1 to lnSesionesFinales
						lnDataSs = laSesionesFinales[i]
						insert into SessFinish (id) values (lnDataSs)
					endfor

					lcMsgErrSess = "La cantidad de sesiones abiertas cambio despues de ejecutar el TearDown, Antes: " + transform( this.nSesionesIniciales )
					if lnSesionesFinales > this.nSesionesIniciales
						lcMsgErrSess = lcMsgErrSess + " Ahora: " + transform( lnSesionesFinales )
						lcMsgErrSess = lcMsgErrSess + " Los id datassession que quedaron abiertos son: "	
						
						select distinct sf.id from SessFinish as sf where not sf.id in ( select distinct id from SessStart ) into cursor SessDiff
					else
						lcMsgErrSess = lcMsgErrSess + " Ahora: " + transform( lnSesionesFinales )
						lcMsgErrSess = lcMsgErrSess + " Los id datassession que se cerraron: "					

						select distinct ss.id from SessStart as ss where not ss.id in ( select distinct id from SessFinish ) into cursor SessDiff
					endif								

					select SessDiff
					scan
						lcMsgErrSess = lcMsgErrSess + transform( SessDiff.id ) + ", "
					endscan					
				catch to loError
					lcMsgErrSess = lcMsgErrSess + " Error al verificacar ID de sesiones: " + transform( loError.Message ) + " "
				finally
					use in select( "SessStart" )
					use in select( "SessFinish" )
					use in select( "SessDiff" )
				endtry
				
				this.asserttrue( substr( alltrim( lcMsgErrSess ),1, len( alltrim( lcMsgErrSess ))-1), .f.)
			endif
			
		endif
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ControlarSesionesAbiertasV2() as Void
		if this.lVerificarSesiones and type( "_screen.zoo" ) == "O"
			local lnSesionesFinales as integer, loSesionesFinales as Collection, lcMsgErrSess as string, loError as Exception
			loSesionesFinales = this.ObtenerSesiones()
			lnSesionesFinales = loSesionesFinales.Count
				
			if this.nSesionesIniciales # lnSesionesFinales
				try
					local i as Integer, lnDataSs as Integer
					
					create cursor SessStart ( id n(10), nombre C(200) )
					
					for i = 1 to this.oSesiones.Count
						lnDataSs = this.oSesiones.GetKey( i )
						insert into SessStart ( id, nombre ) values ( val(lnDataSs), upper( this.oSesiones.Item[lnDataSs] ) )
					endfor

					create cursor SessFinish ( id n(10), nombre C(200) )
					
					for i = 1 to lnSesionesFinales
						lnDataSs = loSesionesFinales.GetKey( i ) 
						insert into SessFinish ( id, nombre ) values ( val(lnDataSs), upper( loSesionesFinales.Item[lnDataSs] ) )
					endfor
					
					lcMsgErrSess = "La cantidad de sesiones abiertas cambio despues de ejecutar el TearDown, Antes: " + transform( this.nSesionesIniciales )
					if lnSesionesFinales > this.nSesionesIniciales
						lcMsgErrSess = lcMsgErrSess + " Ahora: " + transform( lnSesionesFinales )
						lcMsgErrSess = lcMsgErrSess + " Los id datassession que quedaron abiertos son: "	
						
						select distinct sf.id, sf.nombre from SessFinish as sf where not sf.id in ( select distinct id from SessStart ) into cursor SessDiff
					else
						lcMsgErrSess = lcMsgErrSess + " Ahora: " + transform( lnSesionesFinales )
						lcMsgErrSess = lcMsgErrSess + " Los id datassession que se cerraron: "					

						select distinct ss.id, ss.nombre from SessStart as ss where not ss.id in ( select distinct id from SessFinish ) into cursor SessDiff
					endif								

					select SessDiff
					scan
						lcMsgErrSess = lcMsgErrSess + transform( SessDiff.id ) + " (" + alltrim( SessDiff.nombre ) + "), "
					endscan					
				catch to loError
					lcMsgErrSess = lcMsgErrSess + " Error al verificacar ID de sesiones: " + transform( loError.Message ) + " "
				finally
					use in select( "SessStart" )
					use in select( "SessFinish" )
					use in select( "SessDiff" )
				endtry
				
				this.AssertTrue( substr( alltrim( lcMsgErrSess ), 1, len( alltrim( lcMsgErrSess ) ) - 1 ), .f. )
			endif
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	function LoguearCantidadDeMemoriaVFP() as Void
		
			
		local loProc as Object, lcMegasRealesActuales as String, lcMegasVirtualesActuales as String ,  lcMensajeMemoria AS String
		lcMegasRealesActuales = "nil"
		lcMegasVirtualesActuales = "nil"
		try
			loProc = _screen.zoo.InvocarMetodoEstatico( "System.Diagnostics.Process", "GetCurrentProcess" )
			lcMegasRealesActuales = transform( loProc.WorkingSet/1024/1024 ) 		   && Memoria real (Espacio de trabajo, memoria usada en el actual proceso)
			lcMegasVirtualesActuales = transform( loProc.PrivateMemorySize/1024/1024 ) && Memoria Virtual (Tamaño de asignación)
		catch
		finally
			loProc = null
		endtry
		lcMensajeMemoria = "Memoria al finalizar el TEST: WorkingSet:" + lcMegasRealesActuales + " MB - PrivateMemorySize:" + lcMegasVirtualesActuales 
		
		
		local lcPathLog as String

		lcPathLog = addbs( _Screen.zoo.cRutaInicial ) + "log\"
		if !directory( lcPathLog )
			try
				md ( lcPathLog )
			catch 
			endtry
		endif

		if directory( lcPathLog )
			local lcTest as String
			lcTest = this.Class + "." + this.icCurrentTest + "()" 
			strtofile( transform( datetime() ) + " TEST: " + lcMensajeMemoria + " VFPObj:" + transform( _vfp.Objects.count ) ;
				+ " VFPForm: " + transform( _screen.FormCount ) + " - " + lcTest + chr(13)+ chr(10), lcPathLog + "ControlObjetosMemoriaTEST.txt", 1 )
		endif
					
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VerificarVariable( tcVariableGlobal as string ) as bool
		local llRetorno as Boolean
		
		if empty( tcVariableGlobal )
			llRetorno = .F.
		else
			llRetorno = ( type( tcVariableGlobal ) = "O" )
			if llRetorno
				llRetorno = !isnull( &tcVariableGlobal )
			endif
		endif
		
		return llRetorno
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VerificarGoCaja() as Void
		if this.VerificarVariable( "_screen.zoo.app.oCaja" )
			this.asserttrue( "La variable goCaja no existe.", this.VerificarVariable( "goCaja" ) )
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	function VerificarServicio( tcVariableGlobal as string, tcVariableScreen as string, tcVariableGlobalNueva as string, tcNomClaseServicio as String ) as Void
		local loError as Exception, lcServ as object, llExisteVariableGlobal as Boolean, llExisteVariableScreen as Boolean, ;
			llExisteVariableGlobalNueva as Boolean, llEsDiferenteVariableGlobal as Boolean, llEsDiferenteVariableScren  as Boolean, ;
				llEsDiferenteVariableGlobalNueva as Boolean, loServicio as Variant
		
		tcNomClaseServicio = upper( tcNomClaseServicio)
		lcServ = ""
		llExisteVariableGlobal = this.VerificarVariable( tcVariableGlobal )
		llExisteVariableScreen = this.VerificarVariable( tcVariableScreen )
		llExisteVariableGlobalNueva = this.VerificarVariable( tcVariableGlobalNueva )
		
		if llExisteVariableGlobal or llExisteVariableScreen or llExisteVariableGlobalNueva 

			if llExisteVariableGlobal
				llEsDiferenteVariableGlobal = tcNomClaseServicio != upper( &tcVariableGlobal..Class )
				This.AssertEquals( "La Variable global " + tcVariableGlobal + " no esta seteada correctamente", tcNomClaseServicio, upper( &tcVariableGlobal..Class ) )
				lcServ = tcVariableGlobal
			endif
			
			if llExisteVariableScreen
				llEsDiferenteVariableScren = tcNomClaseServicio != upper( &tcVariableScreen..Class )
				This.AssertEquals( "La Variable del screen " + tcVariableScreen + " no esta seteada correctamente", tcNomClaseServicio, upper( &tcVariableScreen..Class ))

				if empty( lcServ )
					lcServ = tcVariableScreen
				else
					This.AssertEquals( "Las referencias de " + lcServ + " y " + tcVariableScreen + " son distintas.", ;
						&lcServ, &tcVariableScreen )
				endif
			endif
			
			if llExisteVariableGlobalNueva 
				llEsDiferenteVariableGlobalNueva = tcNomClaseServicio != upper( &tcVariableGlobalNueva..Class )
				This.AssertEquals( "La Variable " + tcVariableGlobalNueva + " no esta seteada correctamente", tcNomClaseServicio, upper( &tcVariableGlobalNueva..Class ) )

				if empty( lcServ )
				else
					This.AssertEquals( "Las referencias de " + lcServ + " y " + tcVariableGlobalNueva + " son distintas.", ;
						&lcServ, &tcVariableGlobalNueva)
				endif
			endif
			if llEsDiferenteVariableGlobal or llEsDiferenteVariableScren or llEsDiferenteVariableGlobalNueva 
				loServicio = _screen.zoo.crearObjeto( tcNomClaseServicio )
				if llExisteVariableGlobal
					&tcVariableGlobal. = loServicio
				endif
				if llExisteVariableScreen 
					&tcVariableScreen. = loServicio
				endif
				if llExisteVariableGlobalNueva
					&tcVariableGlobalNueva. = loServicio
				endif
				loServicio = null
			endif
		endif
		
	endfunc

	*-----------------------------------------------------------------------------------------
	protected function VerificarServiciosInstanciados() as Void
		local loItem as Collection, lcservicios as String

		lcservicios = ",MANAGERLISTADOS,MEMORIA,MANAGERIMPRESION,";
			+"MULTIMEDIA,MANAGEREJECUCION,MANAGERERRORES,MANAGERLOGUEOS,";
			+"SEGURIDAD,SEGURIDAD" + alltrim( upper( _screen.zoo.app.cProyecto ) )+",";
			+"MODULOS,MODULOS" + alltrim( upper( _screen.zoo.app.cProyecto ) )+",";
			+"LIBRERIAS,MENSAJES,MENSAJESMODOSILENCIOSO,SERVICIOESTRUCTURASQLSERVER,";
			+"SERVICIOESTRUCTURANATIVA,TERMINAL,MANAGERENTIDADES,SERVICIOPOOLDEOBJETOS,";
			+"SERVICIOSALTOSDECAMPOYVALORESSUGERIDOS,SERVICIOREGISTRODEACTIVIDAD,MANAGERWEBHOOK,TIEMPOREAL,"

		lcServicioLogueoPorProyecto = alltrim( upper( _screen.zoo.app.cProyecto ) )+"_MANAGERLOGUEOS"
		if file( FORCEEXT( lcServicioLogueoPorProyecto,"PRG") )
			lcservicios = strtran(lcservicios,"MANAGERLOGUEOS",lcServicioLogueoPorProyecto )
		endif
		
		for each loItem in goServicios.oColServiciosActivos foxobject
			if !(","+alltrim( upper( loItem.Class ) )+"," $ lcservicios)
				this.asserttrue( "El servicio instanciado es incorrecto: " + loItem.Class, .f. )
			endif
		endfor
	endfunc 

	*-----------------------------------------------------------------------------------------
	function VerificarServicioEspecifico( tcServicio as String, tcClase as String ) as Void
		if this.VerificarVariable( tcServicio )
			this.assertequals( "El Servicio instanciado no es correcto. " + tcServicio + " no esta seteada correctamente", tcClase, upper( &tcServicio..Class ) )
			if tcClase != upper( &tcServicio..Class )
				loServicio = _screen.zoo.crearObjeto( tcClase )
				&tcServicio = loServicio
				loServicio = null
			endif
		else
			this.asserttrue( "El servicio " + tcServicio + "No esta correctamente instanciado.", .f. )
		endif
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VerificarGOs_y_ScreenZoos() as Void
		if this.VerificarVariable( "_screen.zoo" )		
			this.VerificarYRestaurarSucursalActiva()
			if !this.VerificarVariable( "goServicios" )		
				This.asserttrue( "La Variable goServicios no está viva", .f. )
			endif
			
			this.VerificarServicio( "GoLibrerias", "_Screen.Zoo.App.oLibrerias", "goServicios.Librerias", "LIBRERIAS" )
			this.VerificarServicio( "GoParametros", "_Screen.Zoo.App.oParametros", "goServicios.Parametros", "DIN_PARAMETROS" )
			this.VerificarServicio( "GoRegistry", "_Screen.Zoo.App.oRegistry", "goServicios.Registry", "DIN_REGISTROS" )
			this.VerificarServicio( "GoFormularios", "_Screen.Zoo.App.oFormularios", "goServicios.Formularios", "MANAGERFORMULARIOS" )		
			this.VerificarServicio( "GoControles", "_Screen.Zoo.App.oServicioControles", "goServicios.Controles", "SERVICIOCONTROLES" )		
			this.VerificarServicio( "GoDatos", "_Screen.Zoo.App.oDatos", "goServicios.Datos", "SERVICIODATOS" )		
			this.VerificarServicio( "GoMensajes", "_Screen.Zoo.App.oMensajes", "goServicios.Mensajes", "MENSAJES" )		
			this.VerificarServicio( "GoMonitor", "_Screen.Zoo.App.oMonitor", "goServicios.Monitor", "MANAGERMONITOR" )		
			this.VerificarServicio( "", "", "goServicios.Exportaciones", "MANAGEREXPORTACIONES" )		
			this.VerificarServicio( "GoTimer", "_Screen.Zoo.App.oTimerBase", "goServicios.Timer", "TIMERBASE" )		
			this.VerificarServicio( "GoEstilos", "_Screen.Zoo.App.oEstilos", "goServicios.Estilos", "ESTILOS" )
			this.VerificarServicioEspecifico( "goServicios.Seguridad", "SEGURIDAD" )
					
			this.VerificarServiciosInstanciados()
			
			this.VerificarGoCaja()	
			
			if vartype( goModulos) = "O"						
				This.AssertTrue( "La Variable goModulos no esta seteada correctamente", ;
					( "MODULOS"==upper( goModulos.Class )) OR  ( "MODULOS" + upper( _screen.zoo.app.CPROYECTO )== upper( goModulos.Class )))
					
				This.AssertTrue( "La Variable _Screen.Zoo.App.oModulos no esta seteada correctamente", ;
					"MODULOS" == upper( _Screen.Zoo.App.oModulos.Class ) Or "MODULOS" + upper( _screen.zoo.app.CPROYECTO ) == upper( _Screen.Zoo.App.oModulos.Class ) )	
					
				This.AssertTrue( "La Variable de goServicios.Modulos no esta seteada correctamente", ;
					( "MODULOS"==upper( GoServicios.Modulos.Class )) OR  ( "MODULOS" + upper( _screen.zoo.app.CPROYECTO )== upper( GoServicios.Modulos.Class )))
			endif
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ObtenerServiciosFaltantes( toColInicial as Collection, toColActual as Collection ) as String
		local loServicio as Object, lcServicio as String, lcRetorno as String, ;
			lcMensaje as String, loServicio as object, lcItem as String, loColAux as Collection

		lcRetorno = ""
		lcMensaje = ""
		if toColInicial.Count < toColActual.Count
			loColAux = newobject( "Collection" )
			for each loServicio in toColActual foxobject
				try
					lcServicio = toColInicial.Item( alltrim( upper( loServicio.Class )) )
				catch && no lo encuentra
					loColAux.Add( alltrim( upper( loServicio.Class )) )
				endtry
			endfor
			for each lcItem in loColAux foxobject
				toColActual.Item( alltrim( upper( lcItem )) ).Release()
			endfor
		else
			for each lcItem in toColInicial foxobject
				try
					loServicio = toColActual.Item( alltrim( upper( lcItem )) )					
					lcServicio = loServicio.Class
				catch && no lo encuentra
					lcRetorno = lcRetorno + ", " + lcItem
				endtry
			endfor
			lcMensaje = "Faltan los servicios: "
		endif

		return ( lcMensaje + substr( lcRetorno, 3 ) )
	endfunc 

	*-----------------------------------------------------------------------------------------
	FUNCTION ilSuccess_Assign(tlSuccess)
		this.ioTestResult.ilCurrentResult = tlSuccess
		this.ilSuccess = tlSuccess
	ENDFUNC
	
	*-----------------------------------------------------------------------------------------
	FUNCTION AssertEquals(tcMessage, tuExpectedValue, tuExpression)
		this.ioAssert.AssertEquals(tcMessage, tuExpectedValue, tuExpression)
	ENDFUNC

	*-----------------------------------------------------------------------------------------
	FUNCTION AssertTrue(tcMessage, tuExpression)
	********************************************************************
	
		this.ioAssert.AssertTrue(tcMessage, tuExpression)
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION AssertNotNull(tcMessage, tuExpression)
	********************************************************************
	
		this.ioAssert.AssertNotNull(tcMessage, tuExpression)
	
	********************************************************************
	ENDFUNC
	********************************************************************
	

	********************************************************************
	FUNCTION MessageOut(tcMessage)
	********************************************************************
		this.ioTestResult.LogMessage(tcMessage)
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION HandleException(toEx as Exception, taStackInfo, tlTearDownException)
	********************************************************************
	
		LOCAL loExceptionInfo as FxuResultExceptionInfo OF FxuResultExceptionInfo.prg
		loExceptionInfo = FxuNewObject('FxuResultExceptionInfo')
		loExceptionInfo.SetExceptionInfo(toEx,@taStackInfo)
		this.ioTestResult.LogException(loExceptionInfo, tlTearDownException)
	
	********************************************************************
	ENDFUNC
	********************************************************************
	
	*-----------------------------------------------------------------------------------------
	function AgregarMocks( tcEntidades as String, tcAccesoDatos as String, tlNo_MensajeEntidad as Boolean ) as Void
		local lcEntidad As String, i as Integer, lnTotal as Integer
		
		if empty( tcEntidades )
			return
		endif
		
		dimension laEntidades[1]
		lnTotal = alines( laEntidades, tcEntidades, 1 + 4, "," )
		for i = 1 to lnTotal
			lcEntidad = alltrim( laEntidades[i] )
			_Screen.Mocks.AgregarMock( lcEntidad )
			_screen.mocks.AgregarSeteoMetodo( lcEntidad, 'EsEdicion', .F. )
			_screen.mocks.AgregarSeteoMetodo( lcEntidad, 'EsNuevo', .F. )
			_screen.mocks.AgregarSeteoMetodo( lcEntidad, 'Limpiar', .t. )
			_screen.mocks.AgregarSeteoMetodo( lcEntidad, 'Cargar', .t. )
			_screen.mocks.AgregarSeteoMetodo( lcEntidad, 'ObtenerNombre', lcEntidad )
			_Screen.mocks.AgregarSeteoMetodo( lcEntidad, 'Cargamanual', .F. )
			_screen.mocks.AgregarSeteoMetodo( lcEntidad, 'Obtenerfuncionalidades', "" ) 
			_screen.mocks.AgregarSeteoMetodo( lcEntidad, 'Inicializarcomportamientocodigosugerido', null, "'*OBJETO'" )

			this.MockearAccesoDatos( lcEntidad )

 		endfor
 		
		if lnTotal > 0 and !tlNo_MensajeEntidad
			_screen.mocks.agregarmock( "MensajeEntidad" )
		endif 		
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MockearAccesoDatos( tcEntidad as String ) as Void
		_Screen.Mocks.AgregarMock( tcEntidad + "AD" )
		_Screen.Mocks.AgregarMock( tcEntidad + "AD_SQLSERVER" )

		_screen.mocks.AgregarSeteoMetodoAccesoADatos( tcEntidad, 'Inyectarentidad', .T., "'*OBJETO'" )
		_screen.mocks.AgregarSeteoMetodoAccesoADatos( tcEntidad, 'ConsultarPorClavePrimaria', .T. )
	endfunc		

	*-----------------------------------------------------------------------------------------
	function BorrarTabla( tcSucursal as String, tcRuta as String, tcSchema as string, tcTabla as String, tlBorrarTodas as Boolean ) as Void
		local lcBaseAnt as String
		
		tcSchema = this.ValidarSchema( tcSchema )
		
		if this.ExisteTabla( tcSucursal, tcRuta, tcSchema, tcTabla )
			if goDatos.EsNativa() &&or alltrim( upper( tcSucursal )) == 'PUESTO'
				if tlBorrarTodas
					delete file ( tcRuta + "*.dbf" )
				else
					delete file ( tcRuta + forceext( tcTabla, "dbf" ))
				endif
			else
				try
					goDatos.DesconectarMotorSql()				
					lcBaseAnt = _Screen.Zoo.App.cNombreBaseDeDatosSql 
					_Screen.Zoo.App.cNombreBaseDeDatosSql = tcSucursal
					if tlBorrarTodas
						goDatos.EjecutarSql( "funciones.drop_schema '" + alltrim( tcSchema ) + "'" )
					else
						goDatos.EjecutarSql( "drop table " + alltrim( tcSchema ) + "." + alltrim( tcTabla ))
					endif
				catch to loError
					throw loError
				finally
					goDatos.DesconectarMotorSql()
					_Screen.Zoo.App.cNombreBaseDeDatosSql = lcBaseAnt
				endtry
			endif
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	function ExisteTabla( tcSucursal as String, tcRuta as String, tcSchema as string, tcTabla as String ) as boolean
		local llRetorno as Boolean, lcCursor as String, lcBaseAnt as String
		
		lcCursor = sys( 2015 )
		tcSchema = this.ValidarSchema( tcSchema )
		
		if goDatos.EsNativa() &&or alltrim( upper( tcSucursal )) == 'PUESTO'
			llRetorno = file( addbs( tcRuta ) + forceext( tcTabla, "dbf" ))
		else
			try
				goDatos.DesconectarMotorSql()			
				lcBaseAnt = _Screen.Zoo.App.cNombreBaseDeDatosSql 
				if this.ExisteBaseDeDatos( tcSucursal )
					_Screen.Zoo.App.cNombreBaseDeDatosSql = tcSucursal
					text to lcSql textmerge noshow pretext 1+2+4
						select 1
						from sys.tables tabla inner join sys.schemas esquema on tabla.schema_id = esquema.schema_id
						where upper( esquema.name + '.' + tabla.name ) = upper( '<< tcSchema + '.' + tcTabla >>' )						
						union all
						select 1
						from sys.synonyms sin inner join sys.schemas esquema on sin.schema_id = esquema.schema_id										
						where upper( esquema.name + '.' + sin.name ) = upper( '<< tcSchema + '.' + tcTabla >>' )
					endtext

					goDatos.EjecutarSql( lcSql, lcCursor, set("Datasession") )
					
					llRetorno = reccount( lcCursor ) > 0
				endif
			catch to loError
				throw loError
			finally
				goDatos.DesconectarMotorSql()
				_Screen.Zoo.App.cNombreBaseDeDatosSql = lcBaseAnt
				use in select( lcCursor )
			endtry
		endif	
		
		return llRetorno
	endfunc 

	*-----------------------------------------------------------------------------------------
	function ExisteBaseDeDatos( tcSucursal as String ) as Void
		local loManager as object, llRetorno as Boolean
		
		llRetorno = .t.
		
		if goDatos.EsSqlServer()
			loManager = newobject( "manageradnimplant" + _screen.zoo.app.TipoDeBase, forceext( "manageradnimplant" + _screen.zoo.app.TipoDeBase, "prg" ) )
			loManager.cBaseDeDatosEnProceso = tcSucursal
			llRetorno = goLibrerias.ExisteBaseDeDatos( tcSucursal )
			loManager.Release()
		endif
				
		return llRetorno
	endfunc 

	*-----------------------------------------------------------------------------------------
	function ObtenerEstructura( tcSucursal as String, tcRuta as String, tcSchema as string, tcTabla as String ) as zoocoleccion OF zoocoleccion.prg
		local loRetorno as zoocoleccion OF zoocoleccion.prg, lnCantCampos as Integer, lcCursor as String, lcSql as String, lcBaseAnt as String, ;
			i as Integer
		local array laCampos[1]
		
		loRetorno = _screen.zoo.crearobjeto( "ZooColeccion" )
		lcCursor = "c_ObtenerEstructura" + sys(2015)
		lcSql = ""
		lnPosIncremental = 17
		tcSchema = this.ValidarSchema( tcSchema )
		
		if this.ExisteTabla( tcSucursal, tcRuta, tcSchema, tcTabla )
			try

				text to lcSql textmerge noshow pretext 1+2+4+8
					select 	a.name nombre,  
						case	when a.is_identity = 1 or a.system_type_id = 56 then 'I'
								when a.system_type_id = 104 then 'L'
								when a.system_type_id = 108 then 'N'
								when ( a.system_type_id = 167 and a.max_length >= 2000000 ) or a.system_type_id in( 35, 34 ) then 'M'
								when a.system_type_id in( 167, 175 ) then 'C'
								when a.system_type_id = 61 then 'D'
								when a.system_type_id = 36 then 'U'
						end tipoDato,
						case	when ( a.system_type_id = 167 and a.max_length >= 2000000 ) or a.system_type_id in( 35, 34 ) then 4
								when a.is_identity = 1 then 9
								when a.system_type_id = 36 then 0
								when a.system_type_id = 61 then 8
								when a.precision = 0 and a.system_type_id != 61 then a.max_length
								else a.precision
						end Tamaño,
						case a.system_type_id when 61 then 0 
								else isnull( a.scale, 0 ) 
						end decimales,
						cast( a.is_nullable as bit ) Nulo,
						cast( isnull( e.seed_value, 0 ) as integer ) ProximoValor,
						cast( isnull( e.increment_value, 0 ) as integer ) Incremento
					from sys.columns a 	inner join sys.tables c on a.object_id = c.object_id 
										inner join sys.schemas d on c.schema_id = d.schema_id
										left join sys.identity_columns e on a.column_id = e.column_id and a.object_id = e.object_id
					where upper( d.name + '.' + c.name ) = '<< alltrim( upper( tcSchema )) + '.' + alltrim( upper( tcTabla ))>>'
				endtext

				try
					goDatos.DesconectarMotorSql()					
					lcBaseAnt = _Screen.Zoo.App.cNombreBaseDeDatosSql 
					_Screen.Zoo.App.cNombreBaseDeDatosSql = tcSucursal
					goDatos.EjecutarSql( lcSql, lcCursor, set("Datasession"))
				catch to loError
					throw loError
				finally
					goDatos.DesconectarMotorSql()
					_Screen.Zoo.App.cNombreBaseDeDatosSql = lcBaseAnt
				endtry

				select * from &lcCursor into array laCampos
				lnPosIncremental = 6
				lnCantCampos = alen( laCampos, 1 )
				
				
				for i = 1 to lnCantCampos
					loItem = newobject( "Empty" )
					addproperty( loItem, "Nombre", laCampos[i, 1])
					addproperty( loItem, "TipoDato", laCampos[i, 2])
					addproperty( loItem, "Tamaño", laCampos[i, 3])
					addproperty( loItem, "Decimales", laCampos[i, 4])
					addproperty( loItem, "EsNulo", laCampos[i, 5])					
					addproperty( loItem, "ProximoValor", laCampos[i, lnPosIncremental])
					addproperty( loItem, "Incremento", laCampos[i, lnPosIncremental + 1])

					
					loRetorno.Agregar( loItem, alltrim( upper( laCampos[i, 1] )))
				endfor
			catch to loError
				throw loError
			finally
				use in select( tcTabla )
				use in select( lcCursor )				
			endtry
		endif

		return loRetorno
	endfunc 

	*-----------------------------------------------------------------------------------------
	function EjecutarComando( tcComando as String, tcSucursal as String, tcRuta as String, tcSchema as string, tcTabla as String, tlValidarExistencia as String ) as Void
		local llCambioEstructura as Boolean, lnOldDataSession as Integer, lcBaseAnt as String
	
		tcSchema = this.ValidarSchema( tcSchema )
		tcComando = this.ReemplazarTodosLosTagSegunBaseDeDatos( tcComando, tcSucursal, tcRuta, tcSchema, tcTabla )
		lnOldDataSession = set( "DataSession" )
		llCambioEstructura = ( "ALTER" $ alltrim( upper( tcComando ) ) ) 
		
		if !tlValidarExistencia or this.ExisteTabla( tcSucursal, tcRuta, tcSchema, tcTabla )
			if goDatos.EsNativa() and !empty( tcRuta )
				if llCambioEstructura
					set datasession to goDatos.oAccesoDatos.DataSessionId
					This.Abrirtabla( tcSucursal, tcRuta , tcSchema, tcTabla , .t. )
					set datasession to lnOldDataSession
				endif
						
				goDatos.Actualizar( tcComando, addbs( tcRuta ) + forceext( tcTabla, "dbf" ))
			else
				try
					goDatos.DesconectarMotorSql()		
					lcBaseAnt = _Screen.Zoo.App.cNombreBaseDeDatosSql 
					_Screen.Zoo.App.cNombreBaseDeDatosSql = tcSucursal
					goDatos.EjecutarSql( tcComando )
				catch to loError
					throw loError
				finally
					goDatos.DesconectarMotorSql()						
					_Screen.Zoo.App.cNombreBaseDeDatosSql = lcBaseAnt
				endtry
			endif
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	function AbrirTabla( tcSucursal as String, tcRuta as String, tcSchema as string, tcTabla as String, tlExclusivo as Boolean ) as Void
		local lcXml as String, lcTipoApertura as String, lcBaseAnt as String
			
		tcSchema = this.ValidarSchema( tcSchema )
		if this.ExisteTabla( tcSucursal, tcRuta, tcSchema, tcTabla )
			if goDatos.EsNativa() &&or alltrim( upper( tcSucursal )) == 'PUESTO'
				lcTipoApertura = iif( tlExclusivo, "EXCLUSIVE" , "SHARED" )
				
				use in 0 ( addbs( tcRuta ) + forceext( tcTabla, "dbf" )) alias ( tcTabla ) &lcTipoApertura
			else
				try
					goDatos.DesconectarMotorSql()					
					lcBaseAnt = _Screen.Zoo.App.cNombreBaseDeDatosSql 
					_Screen.Zoo.App.cNombreBaseDeDatosSql = tcSucursal
					goDatos.EjecutarSql( "select * from " + alltrim( upper( tcSchema )) + "." + alltrim( upper( tcTabla )), tcTabla, set("Datasession") )
				catch to loError
					throw loError
				finally
					goDatos.DesconectarMotorSql()					
					_Screen.Zoo.App.cNombreBaseDeDatosSql = lcBaseAnt
				endtry
			endif
		endif
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReemplazarTagSegunBaseDeDatos( tcComando as string, tcTag as String, tcSqlServer as String, tcNativa as String ) as Void
		local lcRetorno as String
		if goDatos.EsNativa() &&or alltrim( upper( tcSucursal )) == 'PUESTO'
			lcRetorno = strtran( tcComando, tcTag, tcNativa )
		else
			lcRetorno = strtran( tcComando, tcTag, tcSqlServer )
		endif
		
		return lcRetorno
	endfunc 

	*-----------------------------------------------------------------------------------------	
	function CrearSchemaSqlServer( tcSucursal as string, tcSchema as String ) as Void
		local lcBaseAnt as String, lcCursor as String

		lcBaseAnt = _screen.zoo.app.cNombreBaseDeDatosSql
		lcCursor = sys(2015)
		
		try
			goDatos.DesconectarMotorSql()		
			_screen.zoo.app.cNombreBaseDeDatosSql = tcSucursal
			goDatos.EjecutarSql( "select 1 from sys.schemas b where b.name = '" + alltrim( upper( tcSchema )) + "'", lcCursor, set("Datasession"))

			if reccount( lcCursor ) = 0				
				goDatos.EjecutarSQL( "CREATE SCHEMA " + tcSchema + " AUTHORIZATION [public]" )
			endif
		Catch To loError
			goServicios.Errores.LevantarExcepcion( loError )
		finally
			goDatos.DesconectarMotorSql()				
			_screen.zoo.app.cNombreBaseDeDatosSql = lcBaseAnt
			use in select( lcCursor )
		endtry 
	endfunc 

	*-----------------------------------------------------------------------------------------
	function CrearFuncionesSqlServer( tcSucursal as String ) as Void
		local loError as Exception, loEx as Exception, lcBaseAnt as String, loFunciones as Object, ;
			lcBaseAnt  as String

		lcBaseAnt = _screen.zoo.app.cNombreBaseDeDatosSql
		try
			goDatos.DesconectarMotorSql()				
			_screen.zoo.app.cNombreBaseDeDatosSql = tcSucursal
			loFunciones = _screen.zoo.crearobjeto( "funcionesSQLServer" )
			loFunciones.Crear()
			loFunciones.Release()			
		Catch To loError
			goServicios.Errores.LevantarExcepcion( loError )
		finally
			goDatos.DesconectarMotorSql()				
			_screen.zoo.app.cNombreBaseDeDatosSql = lcBaseAnt
		endtry 
	endfunc 

	*-----------------------------------------------------------------------------------------
	function EliminarSucursalTest( tcRuta as string, tcSucursal as String ) as Void
		local lcCursor as String, loError as zooexception OF zooexception.prg, lcComando as String, lnConexionBase as Integer, lcBaseAnt as String
		
		lcCursor = sys( 2015 )
	
		try
			goDatos.DesconectarMotorSql()		
			lcBaseAnt = _screen.zoo.app.cNombreBaseDeDatosSql
			_screen.zoo.app.cNombreBaseDeDatosSql = "Master"
			
			goDatos.EjecutarSql( "select 1 from sys.databases where name = '" + alltrim( upper( tcSucursal )) + "'", lcCursor, set("Datasession"))
				
			if reccount( lcCursor ) > 0	
				*goDatos.DesconectarMotorSQL()		
				goDatos.EjecutarSql( "ALTER DATABASE [" + tcSucursal + "] SET SINGLE_USER WITH ROLLBACK IMMEDIATE" )
				goDatos.EjecutarSql( "drop database " + tcSucursal )
			endif
			goDatos.EjecutarSql( "delete from "+_screen.zoo.app.obtenerprefijodb()+"ADNIMPLANT.dbo.ControlEjecucion where BaseDeDatos = '" + alltrim( upper( tcSucursal )) + "'" )
		catch to loError
			throw loError
		finally
			goDatos.DesconectarMotorSql()					
			_screen.zoo.app.cNombreBaseDeDatosSql = lcBaseAnt
			use in select( lcCursor )
		endtry
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EliminarEsquemaSql( tcBaseDeDatos as string, tcEsquema as String ) as Void
		local lcCursor as String, loError as zooexception OF zooexception.prg, lcComando as String, ;
			lcBaseAnt  as String
		
		lcCursor = sys( 2015 )
		tcEsquema = this.ValidarSchema( tcEsquema )
		
		if goDatos.EsSqlServer()
			goDatos.DesconectarMotorSql()
			lcBaseAnt = _screen.zoo.app.cNombreBaseDeDatosSql
			Try
				_screen.zoo.app.cNombreBaseDeDatosSql = tcBaseDeDatos
			
				goDatos.EjecutarSql( "select 1 from sys.schemas b where b.name = '" + alltrim( upper( tcEsquema )) + "'", lcCursor, set("Datasession"))

				if reccount( lcCursor ) > 0				
					goDatos.EjecutarSql( "funciones.sp_drop_schema '" + tcEsquema + "'" )
				endif
			catch to loError
				throw loError
			finally
				goDatos.DesconectarMotorSql()			
				tcBaseDeDatos = _screen.zoo.app.cNombreBaseDeDatosSql
				use in select( lcCursor )
			endtry
		endif
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CrearTabla( tcSucursal as string, tcRuta as String, tcSchema as string, tcTabla as String, tcCampos as String ) as Void
		local lcComando as string
		
		tcSchema = this.ValidarSchema( tcSchema )
		if this.existetabla( tcSucursal, tcRuta, tcSchema, tcTabla )
		else
			tcCampos = this.ReemplazarTodosLosTagSegunBaseDeDatos( tcCampos, tcSucursal, tcRuta, tcSchema, tcTabla )
				
			if goDatos.EsNativa()&& or alltrim( upper( tcSucursal )) == 'PUESTO'
				goServicios.Librerias.CrearDirectorio( addbs( tcRuta ))
				create table ( addbs( tcRuta ) + tcTabla ) ( &tcCampos )
				use in select( alltrim( tcTabla ))
			else
				this.CrearSchemaSqlServer( tcSucursal, tcSchema )
				lcComando = "create table <schema>" + alltrim( tcTabla ) + " (" + alltrim( upper( tcCampos )) + " )"
				this.ejecutarcomando( lcComando, tcSucursal, tcRuta, tcSchema, tcTabla )
			endif
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	function ReemplazarTodosLosTagSegunBaseDeDatos( tcCadena as String, tcSucursal as String, tcRuta as String, tcSchema as string, tcTabla as String ) as String
		local lcRetorno
		
		tcSchema = this.ValidarSchema( tcSchema )
		lcRetorno = tcCadena
		
		lcRetorno = this.ReemplazarTagSegunBaseDeDatos( lcRetorno, "<l>", "bit", "l" )		
		lcRetorno = this.ReemplazarTagSegunBaseDeDatos( lcRetorno, "<i>", "Integer", "I" )
		lcRetorno = this.ReemplazarTagSegunBaseDeDatos( lcRetorno, "<d>", "Datetime", "D" )		
		lcRetorno = this.ReemplazarTagSegunBaseDeDatos( lcRetorno, "<a>", "Integer NOT NULL IDENTITY(1, 1)", "I" )
		lcRetorno = this.ReemplazarTagSegunBaseDeDatos( lcRetorno, "<schema>", tcSchema + ".", "" )
		lcRetorno = this.ReemplazarTagSegunBaseDeDatos( lcRetorno, "<sucursal>", tcSucursal + ".", addbs( tcRuta ) )
		lcRetorno = this.ReemplazarTagSegunBaseDeDatos( lcRetorno, "<tabla>", tcTabla, tcTabla )		
		
		return lcRetorno
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValidarSchema( tcSchema as String ) as String
		local lcRetorno as String
		
		lcRetorno = tcSchema
		
		if empty( tcSchema )
			lcRetorno = _screen.zoo.app.cSchemaDefault
		endif
		
		return lcRetorno
	endfunc 

	*-----------------------------------------------------------------------------------------
	function ObtenerNombreParametroRegistro( tlEsParametro as boolean, tcNivel as char ) as String
		local lcRetorno as String
		
		if tlEsParametro
			lcRetorno = "PARAMETROS"
		else
			lcRetorno = "REGISTROS"
		endif
		
		if goDatos.EsNativa()
			if tlEsParametro
				do case
					case tcNivel = 'O'
						lcRetorno = "PARAMETROSORG"
					case tcNivel = 'S'
						lcRetorno = "PARAMETROSSUCURSAL"
					case tcNivel = 'P'
						lcRetorno = "PARAMETROSPUESTO"
				endcase
			else
				do case
					case tcNivel = 'O'
						lcRetorno = "SYS_O"
					case tcNivel = 'S'
						lcRetorno = "SYS_S"
					case tcNivel = 'P'
						lcRetorno = "SYS_P"
				endcase
			endif
		else
			do case
				case tcNivel = 'O'
					lcRetorno = "ORGANIZACION"
				case tcNivel = 'S'
					lcRetorno = "SUCURSAL"
				case tcNivel = 'P'
					lcRetorno = "PUESTO"
			endcase
		endif
		
		return lcRetorno 
	endfunc 

	*-----------------------------------------------------------------------------------------
	function EjecutarSentencias( tcSentencia as String, tcTablas as string, tcRuta as String, tcCursor as String, tnSesion as Integer ) as Void
		local lcNuevaCadenaSql as String, lcRutaTablas as String, lnSesionGoDatos as integer, lnSesion as Integer 


		if !empty( tnSesion )
			lnSesion = set("Datasession")
			lnSesionGodatos = godatos.DataSessionId 
			goDatos.DataSessionId = tnSesion
			godatos.oAccesoDatos.DataSessionId = tnSesion
		endif
			

		goDatos.EjecutarSentencias( tcSentencia , tcTablas , tcRuta , tcCursor , tnSesion )
		
		if !empty( tnSesion )
			goDatos.DataSessionId = lnSesionGodatos
			godatos.oAccesoDatos.DataSessionId = lnSesiongoDatos
			set datasession to &lnSesion
		endif			

	endfunc 

	*-----------------------------------------------------------------------------------------
	function Datofecha( tcFecha as String ) as Variant
		local lxRetorno as variant
		
		do case
			
			case goDatos.EsNativa()
				lxRetorno = "ctod('" + tcFecha + "')" 

			case goDatos.EsSqlServer()
				lxRetorno = "'" + dtos( ctod( tcFecha ) ) + "'" 
			otherwise 
				return "'" + tcFecha + "'" 
		endcase	
	
		return lxRetorno
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function oServicioMocks_access() as Void
		local lcRutaClasesFWMock as String

		if isnull( this.oServicioMocks )
			lcRutaClasesFWMock = this.ObtenerRutaDeClasesMock()
			this.AgregarRutaClasesMockAlPath( lcRutaClasesFWMock )
			this.IntanciarServicioMocks()
		endif
		return this.oServicioMocks
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ObtenerNombreClaseAccesoADatosEntidad( tcEntidad as String ) as String
		local lcRetorno as String
		lcRetorno = "din_entidad" + tcEntidad + "ad_" + goServicios.Datos.cTipoDeBase
		return strtran( lcRetorno, "_nativa", "", 1, -1, 1 )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function EliminarArchivosMcokV2() as Void
		local array laArchivos[1]
		local lnCantidad as Integer, i as Integer
		
		lnCantidad = adir( laArchivos, addbs( this.oServicioMocks.cRuta ) + "MockV2_*.*" )
		for i = 1 to lnCantidad
			clear class ( juststem( laArchivos[ i, 1 ] ) )
			delete file ( addbs( this.oServicioMocks.cRuta ) + laArchivos[ i, 1 ] )
		endfor
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ObtenerNombreDeClaseEntidad( tcEntidad as String ) as String
		local lcRetorno as string, lcArchivo as string
		
		lcArchivo = "Ent" + _screen.zoo.app.cProyecto + "_" + tcEntidad 
		lcRetorno = ""
		
		if file( lcArchivo + ".prg" ) or file( lcArchivo  + ".FXP" )
			lcRetorno = Alltrim( Upper( lcArchivo ) )
		else
			lcArchivo = "Ent_" + tcEntidad 

			if file( lcArchivo + ".prg" ) or file( lcArchivo  + ".FXP" )
				lcRetorno = Alltrim( Upper( lcArchivo ) )
			else
				lcRetorno = "Din_Entidad" + Alltrim( Upper( tcEntidad ) )
			endif
		endif

		return lcRetorno 
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	hidden function IntanciarServicioMocks() as Void
		local lcRuta as String
	
		this.oServicioMocks = newobject( "ServicioMocks", "ServicioMocks.prg", null, ;
			newobject( "GeneradorMock", "GeneradorMock.prg" ) )
		lcRuta = addbs( _Screen.Zoo.cRutaInicial ) + "ClasesDePrueba"
		this.oServicioMocks.cRuta = lcRuta
		goServicios.Librerias.CrearDirectorio( addbs( lcRuta ))
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	hidden function AgregarRutaClasesMockAlPath( tcRutaClasesFWMock as String ) as Void
		if atc( tcRutaClasesFWMock, set("Path") ) = 0 and directory( tcRutaClasesFWMock )
			set path to ( tcRutaClasesFWMock ) additive
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	hidden function ObtenerRutaDeClasesMock() as String
		local lcRetorno as String
		
		if right( _Screen.Zoo.cRutaInicial, 1 ) = "\"
			lcRetorno = substr( _Screen.Zoo.cRutaInicial, 1, len( _Screen.Zoo.cRutaInicial ) - 1 )
		else
			lcRetorno = _Screen.Zoo.cRutaInicial
		endif
		
		lcRetorno = addbs( justpath( lcretorno ) ) + "Taspein\Mocks"
		
		return addbs( lcRetorno )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	hidden function VerificarYRestaurarSucursalActiva() as Void
		if pemstatus( _Screen.zoo.app, "cSucursalActiva", 5 )
			if upper( _screen.Zoo.App.cSucursalActiva ) # upper( this.cSucursalActivaAnterior )
				this.Assertequals( "Se cambio la sucursal activa.", this.cSucursalActivaAnterior, _screen.Zoo.App.cSucursalActiva )
				_screen.Zoo.App.cSucursalActiva = this.cSucursalActivaAnterior
			endif
		else
			if !empty( this.cSucursalActivaAnterior )
				this.assertTrue( "Se Mato el Objeto _Screen.zoo.app y no se puede determinar si se cambio la sucursal activa.", .f. )
			endif
		endif	
	endfunc 
	
**********************************************************************
ENDDEFINE && CLASS
**********************************************************************

*-----------------------------------------------------------------------------------------
function DesglosarError( toError as Exception )
	local loAux as Exception, lcError as String, llDesglosar as boolean, loError as exception, ;
		loItem as Object

	lcError = ""
	loAux = toError

	do while vartype( loAux ) = "O"
		if 2071 != loAux.ErrorNo or type( "loAux.UserValue" ) != "O"
			if !empty( lcError )
				lcError = lcError + chr(13) + "---------------------------------" + chr(13)
			endif

			if vartype( loAux.oInformacion ) = "O"
				for each loItem in loAux.oInformacion
					lcError = lcError + "Error: " + loItem.cMensaje + chr( 13 ) + chr( 10 )
				endfor
			endif
			lcError = lcError + "Error: " + loAux.Message + chr( 13) + ;
					"Nro. Error: " + transform( loAux.ErrorNo ) + chr( 13 ) + ;
					"Detalle: " + loAux.Details + chr( 13) + ;
					"Procedimiento: " + loAux.Procedure + chr( 13) + ;
					"Linea: " + loAux.LineContents + chr( 13 ) + ;
					"Nro. Linea: " + transform( loAux.LineNo )
		endif
						
		loAux = loAux.UserValue
	enddo
	
	return lcError
	
endfunc

*-----------------------------------------------------------------------------------------
function MockConvertirMoneda( tcValor as String, tnCotizacion as Decimal, tcMoneda1 as String, tcMoneda2 as String, tcFecha as String ) as Void
	local lcMoneda1 as String, lcMoneda2 as String, lcFecha as String, lnCotizacion as Decimal, lnValor as Decimal
	lcMoneda1 = iif(vartype(tcMoneda1)="C",tcMoneda1,"[*COMODIN]")
	lcMoneda2 = iif(vartype(tcMoneda2)="C",tcMoneda2,"[*COMODIN]")
	lcFecha = iif(vartype(tcFecha)="C",tcFecha,"[*COMODIN]")
	lnCotizacion = iif(vartype(tnCotizacion)="N",tnCotizacion,1)
	lnValor = round(val(tcValor)*lnCotizacion,2)
	_screen.mocks.AgregarSeteoMetodo( 'Moneda', 'ConvertirImporte', lnValor, tcValor + ","+lcMoneda1+","+lcMoneda2+","+lcFecha+"" )
*!*		_screen.mocks.AgregarSeteoMetodo( 'Moneda', 'ConvertirimporteConRedondeo', val(tcValor)*lnCotizacion, tcValor + ","+lcMoneda1+","+lcMoneda2+","+lcFecha+",[*COMODIN]" )
endfunc

*-----------------------------------------------------------------------------------------
function MockConvertirMonedaConRedondeo( tcValor as String, tnRedondeo as Integer, tnCotizacion as Decimal, tcMoneda1 as String, tcMoneda2 as String, tcFecha as String ) as Void
	local lcMoneda1 as String, lcMoneda2 as String, lcFecha as String, lnCotizacion as Decimal, lnValor as Decimal, lnRedondeo as Integer
	lcMoneda1 = iif(vartype(tcMoneda1)="C",tcMoneda1,"[*COMODIN]")
	lcMoneda2 = iif(vartype(tcMoneda2)="C",tcMoneda2,"[*COMODIN]")
	lnRedondeo = iif(vartype(tnRedondeo)="N",tnRedondeo,8)
	lcFecha = iif(vartype(tcFecha)="C",tcFecha,"[*COMODIN]")
	lnCotizacion = iif(vartype(tnCotizacion)="N",tnCotizacion,1)
	lnValor = round(val(tcValor)*lnCotizacion, lnRedondeo)
	_screen.mocks.AgregarSeteoMetodo( 'Moneda', 'ConvertirimporteConRedondeo', lnValor, tcValor + ","+lcMoneda1+","+lcMoneda2+","+lcFecha+",[*COMODIN]" )
endfunc
