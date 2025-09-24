
define class Din_EntidadDATOSFISCALESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DATOSFISCALES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_DFIPK'
	cTablaPrincipal = 'DATOSFISCALES'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
			.ColSentencias = _screen.zoo.crearobjeto('zooColeccion')
				.cUbicacionDB = ''
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ZooLogic'
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Destroy() as boolean

		with this
		endwith

		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Insertar() as boolean

		local loError as Exception, loEx as Exception, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxDatosfiscalesFmodifw, lxDatosfiscalesFectrans, lxDatosfiscalesFecimpo, lxDatosfiscalesFaltafw, lxDatosfiscalesFecexpo, lxDatosfiscalesTimestamp, lxDatosfiscalesBloqreg, lxDatosfiscalesSmodifw, lxDatosfiscalesSaltafw, lxDatosfiscalesVmodifw, lxDatosfiscalesHmodifw, lxDatosfiscalesZadsfw, lxDatosfiscalesValtafw, lxDatosfiscalesUaltafw, lxDatosfiscalesUmodifw, lxDatosfiscalesEsttrans, lxDatosfiscalesHoraimpo, lxDatosfiscalesBdaltafw, lxDatosfiscalesBdmodifw, lxDatosfiscalesHoraexpo, lxDatosfiscalesHaltafw, lxDatosfiscalesCodigo, lxDatosfiscalesObs, lxDatosfiscalesDescripcio, lxDatosfiscalesExpoenop, lxDatosfiscalesNroiibbobl, lxDatosfiscalesAfip366814, lxDatosfiscalesAutojur, lxDatosfiscalesAutoperr, lxDatosfiscalesReintegro, lxDatosfiscalesDasiprib, lxDatosfiscalesMontomin, lxDatosfiscalesJurisdsiem, lxDatosfiscalesRetsiprib, lxDatosfiscalesSeparaiibb, lxDatosfiscalesPersiprib
				lxDatosfiscalesFmodifw =  .Fechamodificacionfw			lxDatosfiscalesFectrans =  .Fechatransferencia			lxDatosfiscalesFecimpo =  .Fechaimpo			lxDatosfiscalesFaltafw =  .Fechaaltafw			lxDatosfiscalesFecexpo =  .Fechaexpo			lxDatosfiscalesTimestamp = goLibrerias.ObtenerTimestamp()			lxDatosfiscalesBloqreg =  .Bloquearregistro			lxDatosfiscalesSmodifw =  .Seriemodificacionfw			lxDatosfiscalesSaltafw =  .Seriealtafw			lxDatosfiscalesVmodifw =  .Versionmodificacionfw			lxDatosfiscalesHmodifw =  .Horamodificacionfw			lxDatosfiscalesZadsfw =  .Zadsfw			lxDatosfiscalesValtafw =  .Versionaltafw			lxDatosfiscalesUaltafw =  .Usuarioaltafw			lxDatosfiscalesUmodifw =  .Usuariomodificacionfw			lxDatosfiscalesEsttrans =  .Estadotransferencia			lxDatosfiscalesHoraimpo =  .Horaimpo			lxDatosfiscalesBdaltafw =  .Basededatosaltafw			lxDatosfiscalesBdmodifw =  .Basededatosmodificacionfw			lxDatosfiscalesHoraexpo =  .Horaexpo			lxDatosfiscalesHaltafw =  .Horaaltafw			lxDatosfiscalesCodigo =  .Codigo			lxDatosfiscalesObs =  .Obser			lxDatosfiscalesDescripcio =  .Descripcion			lxDatosfiscalesExpoenop =  .Exportacionesautomaticasenop			lxDatosfiscalesNroiibbobl =  .Nroobligatorio			lxDatosfiscalesAfip366814 =  .Datosadicionalescomprobantesa			lxDatosfiscalesAutojur =  .Autocompletarjurisdic			lxDatosfiscalesAutoperr =  .Autocompletarpercriesgo			lxDatosfiscalesReintegro =  .Reintegro			lxDatosfiscalesDasiprib =  .Datosadicionalessiprib			lxDatosfiscalesMontomin =  .Montominimo			lxDatosfiscalesJurisdsiem =  upper( .RetPercSiempreSegunJurisdiccion_PK ) 			lxDatosfiscalesRetsiprib =  .Artincisoretiene			lxDatosfiscalesSeparaiibb =  .Generacompiibbseparados			lxDatosfiscalesPersiprib =  .Artincisopercibe
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDatosfiscalesCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.DATOSFISCALES ( "Fmodifw","Fectrans","Fecimpo","Faltafw","Fecexpo","Timestamp","Bloqreg","Smodifw","Saltafw","Vmodifw","Hmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Esttrans","Horaimpo","Bdaltafw","Bdmodifw","Horaexpo","Haltafw","Codigo","Obs","Descripcio","Expoenop","Nroiibbobl","Afip366814","Autojur","Autoperr","Reintegro","Dasiprib","Montomin","Jurisdsiem","Retsiprib","Separaiibb","Persiprib" ) values ( <<"'" + this.ConvertirDateSql( lxDatosfiscalesFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecexpo ) + "'" >>, <<lxDatosfiscalesTimestamp >>, <<iif( lxDatosfiscalesBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesDescripcio ) + "'" >>, <<iif( lxDatosfiscalesExpoenop, 1, 0 ) >>, <<iif( lxDatosfiscalesNroiibbobl, 1, 0 ) >>, <<iif( lxDatosfiscalesAfip366814, 1, 0 ) >>, <<iif( lxDatosfiscalesAutojur, 1, 0 ) >>, <<iif( lxDatosfiscalesAutoperr, 1, 0 ) >>, <<iif( lxDatosfiscalesReintegro, 1, 0 ) >>, <<iif( lxDatosfiscalesDasiprib, 1, 0 ) >>, <<lxDatosfiscalesMontomin >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesJurisdsiem ) + "'" >>, <<lxDatosfiscalesRetsiprib >>, <<iif( lxDatosfiscalesSeparaiibb, 1, 0 ) >>, <<lxDatosfiscalesPersiprib >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PerceIIBB
				if this.oEntidad.PerceIIBB.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxImpuesto_PK = loItem.Impuesto_PK
					lxCodigointerno = loItem.Codigointerno
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DatosFiscalDet("NROITEM","BLOQREG","CodRela","Impuesto","codunico" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			this.AntesEndTransaction()
			this.VerificarInsercionUnicidadAntesDelCommit( lxValorClavePrimaria )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			this.FinalDeTransaction()
		
			lnI = this.nReintentos
		
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar grabar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar grabar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar grabar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
		this.oEntidad.Timestamp = lxDatosfiscalesTimestamp
		endwith

		endfor
		
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarUnicidad() as void
		local lcError as string
		lcError = ''
		If this.ConsultarPorClavePrimaria()
			lcError = this.oEntidad.ReasignarValorSugeridoEnCasoDeConcurrencia()
		else
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			this.GenerarSentenciasComponentes()
			local  lxDatosfiscalesFmodifw, lxDatosfiscalesFectrans, lxDatosfiscalesFecimpo, lxDatosfiscalesFaltafw, lxDatosfiscalesFecexpo, lxDatosfiscalesTimestamp, lxDatosfiscalesBloqreg, lxDatosfiscalesSmodifw, lxDatosfiscalesSaltafw, lxDatosfiscalesVmodifw, lxDatosfiscalesHmodifw, lxDatosfiscalesZadsfw, lxDatosfiscalesValtafw, lxDatosfiscalesUaltafw, lxDatosfiscalesUmodifw, lxDatosfiscalesEsttrans, lxDatosfiscalesHoraimpo, lxDatosfiscalesBdaltafw, lxDatosfiscalesBdmodifw, lxDatosfiscalesHoraexpo, lxDatosfiscalesHaltafw, lxDatosfiscalesCodigo, lxDatosfiscalesObs, lxDatosfiscalesDescripcio, lxDatosfiscalesExpoenop, lxDatosfiscalesNroiibbobl, lxDatosfiscalesAfip366814, lxDatosfiscalesAutojur, lxDatosfiscalesAutoperr, lxDatosfiscalesReintegro, lxDatosfiscalesDasiprib, lxDatosfiscalesMontomin, lxDatosfiscalesJurisdsiem, lxDatosfiscalesRetsiprib, lxDatosfiscalesSeparaiibb, lxDatosfiscalesPersiprib
				lxDatosfiscalesFmodifw =  .Fechamodificacionfw			lxDatosfiscalesFectrans =  .Fechatransferencia			lxDatosfiscalesFecimpo =  .Fechaimpo			lxDatosfiscalesFaltafw =  .Fechaaltafw			lxDatosfiscalesFecexpo =  .Fechaexpo			lxDatosfiscalesTimestamp = goLibrerias.ObtenerTimestamp()			lxDatosfiscalesBloqreg =  .Bloquearregistro			lxDatosfiscalesSmodifw =  .Seriemodificacionfw			lxDatosfiscalesSaltafw =  .Seriealtafw			lxDatosfiscalesVmodifw =  .Versionmodificacionfw			lxDatosfiscalesHmodifw =  .Horamodificacionfw			lxDatosfiscalesZadsfw =  .Zadsfw			lxDatosfiscalesValtafw =  .Versionaltafw			lxDatosfiscalesUaltafw =  .Usuarioaltafw			lxDatosfiscalesUmodifw =  .Usuariomodificacionfw			lxDatosfiscalesEsttrans =  .Estadotransferencia			lxDatosfiscalesHoraimpo =  .Horaimpo			lxDatosfiscalesBdaltafw =  .Basededatosaltafw			lxDatosfiscalesBdmodifw =  .Basededatosmodificacionfw			lxDatosfiscalesHoraexpo =  .Horaexpo			lxDatosfiscalesHaltafw =  .Horaaltafw			lxDatosfiscalesCodigo =  .Codigo			lxDatosfiscalesObs =  .Obser			lxDatosfiscalesDescripcio =  .Descripcion			lxDatosfiscalesExpoenop =  .Exportacionesautomaticasenop			lxDatosfiscalesNroiibbobl =  .Nroobligatorio			lxDatosfiscalesAfip366814 =  .Datosadicionalescomprobantesa			lxDatosfiscalesAutojur =  .Autocompletarjurisdic			lxDatosfiscalesAutoperr =  .Autocompletarpercriesgo			lxDatosfiscalesReintegro =  .Reintegro			lxDatosfiscalesDasiprib =  .Datosadicionalessiprib			lxDatosfiscalesMontomin =  .Montominimo			lxDatosfiscalesJurisdsiem =  upper( .RetPercSiempreSegunJurisdiccion_PK ) 			lxDatosfiscalesRetsiprib =  .Artincisoretiene			lxDatosfiscalesSeparaiibb =  .Generacompiibbseparados			lxDatosfiscalesPersiprib =  .Artincisopercibe
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.DATOSFISCALES set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecexpo ) + "'">>,"Timestamp" = <<lxDatosfiscalesTimestamp>>,"Bloqreg" = <<iif( lxDatosfiscalesBloqreg, 1, 0 )>>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesVmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesUmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesObs ) + "'">>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesDescripcio ) + "'">>,"Expoenop" = <<iif( lxDatosfiscalesExpoenop, 1, 0 )>>,"Nroiibbobl" = <<iif( lxDatosfiscalesNroiibbobl, 1, 0 )>>,"Afip366814" = <<iif( lxDatosfiscalesAfip366814, 1, 0 )>>,"Autojur" = <<iif( lxDatosfiscalesAutojur, 1, 0 )>>,"Autoperr" = <<iif( lxDatosfiscalesAutoperr, 1, 0 )>>,"Reintegro" = <<iif( lxDatosfiscalesReintegro, 1, 0 )>>,"Dasiprib" = <<iif( lxDatosfiscalesDasiprib, 1, 0 )>>,"Montomin" = <<lxDatosfiscalesMontomin>>,"Jurisdsiem" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesJurisdsiem ) + "'">>,"Retsiprib" = <<lxDatosfiscalesRetsiprib>>,"Separaiibb" = <<iif( lxDatosfiscalesSeparaiibb, 1, 0 )>>,"Persiprib" = <<lxDatosfiscalesPersiprib>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesCodigo ) + "'">> and  DATOSFISCALES.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DatosFiscalDet where "CodRela" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PerceIIBB
				if this.oEntidad.PerceIIBB.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxImpuesto_PK = loItem.Impuesto_PK
					lxCodigointerno = loItem.Codigointerno
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DatosFiscalDet("NROITEM","BLOQREG","CodRela","Impuesto","codunico" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			this.AntesEndTransaction()
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			lnI = this.nReintentos
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar actualizar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar actualizar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar actualizar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Modificacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Modificacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
		this.oEntidad.Timestamp = lxDatosfiscalesTimestamp
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValidarTimestamp() as void
		Local lnTimestamp as integer
		if !this.oEntidad.lEsSubentidad
			lnTimestamp = this.ObtenerTimestampActual()
			if this.oEntidad.Timestamp = lnTimestamp 
			else 
				local loEx as Object
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Message = 'Error al intentar Grabar'
					.Details = 'No se puede grabar, el registro ha cambiado'
					.Grabar()
					.Throw()
				endwith
			endif
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.DATOSFISCALES where " + this.ConvertirFuncionesSql( " DATOSFISCALES.CODIGO != ''" ) )
			this.xmlacursor( lcXml, 'c_HayDatos' )
			llHayDatos = reccount( 'c_HayDatos' ) > 0 
			use in select('c_HayDatos')
		return llHayDatos
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClavePrimaria( tlLlenarAtributos as Boolean ) as Boolean
		local llRetorno as boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxDatosfiscalesCodigo
			lxDatosfiscalesCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Obs" as "Obser", "Descripcio" as "Descripcion", "Expoenop" as "Exportacionesautomaticasenop", "Nroiibbobl" as "Nroobligatorio", "Afip366814" as "Datosadicionalescomprobantesa", "Autojur" as "Autocompletarjurisdic", "Autoperr" as "Autocompletarpercriesgo", "Reintegro" as "Reintegro", "Dasiprib" as "Datosadicionalessiprib", "Montomin" as "Montominimo", "Jurisdsiem" as "Retpercsiempresegunjurisdiccion", "Retsiprib" as "Artincisoretiene", "Separaiibb" as "Generacompiibbseparados", "Persiprib" as "Artincisopercibe" from ZooLogic.DATOSFISCALES where "Codigo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesCodigo ) + "'">> and  DATOSFISCALES.CODIGO != ''
			endtext
			use in select('c_DATOSFISCALES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSFISCALES', set( 'Datasession' ) )

			if reccount( 'c_DATOSFISCALES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codrela" as "Codigo", "Impuesto" as "Impuesto", "Codunico" as "Codigointerno" from ZooLogic.DatosFiscalDet where CodRela = <<"'" + this.FormatearTextoSql( c_DATOSFISCALES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PerceIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PerceIIBB', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PerceIIBB
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxDatosfiscalesCodigo as Variant
		llRetorno = .t.
		lxDatosfiscalesCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.DATOSFISCALES where "Codigo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesCodigo ) + "'">> and  DATOSFISCALES.CODIGO != ''
			endtext
			use in select('c_VerificarExistencia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VerificarExistencia', set( 'Datasession' ) )

			if c_VerificarExistencia.CantidadDeRegistros = 0
				llRetorno = .f.
			endif
			use in select( 'c_VerificarExistencia' )
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Primero() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Obs" as "Obser", "Descripcio" as "Descripcion", "Expoenop" as "Exportacionesautomaticasenop", "Nroiibbobl" as "Nroobligatorio", "Afip366814" as "Datosadicionalescomprobantesa", "Autojur" as "Autocompletarjurisdic", "Autoperr" as "Autocompletarpercriesgo", "Reintegro" as "Reintegro", "Dasiprib" as "Datosadicionalessiprib", "Montomin" as "Montominimo", "Jurisdsiem" as "Retpercsiempresegunjurisdiccion", "Retsiprib" as "Artincisoretiene", "Separaiibb" as "Generacompiibbseparados", "Persiprib" as "Artincisopercibe" from ZooLogic.DATOSFISCALES where  DATOSFISCALES.CODIGO != '' order by Codigo
			endtext
			use in select('c_DATOSFISCALES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSFISCALES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codrela" as "Codigo", "Impuesto" as "Impuesto", "Codunico" as "Codigointerno" from ZooLogic.DatosFiscalDet where CodRela = <<"'" + this.FormatearTextoSql( c_DATOSFISCALES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PerceIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PerceIIBB', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PerceIIBB
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Siguiente() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Obs" as "Obser", "Descripcio" as "Descripcion", "Expoenop" as "Exportacionesautomaticasenop", "Nroiibbobl" as "Nroobligatorio", "Afip366814" as "Datosadicionalescomprobantesa", "Autojur" as "Autocompletarjurisdic", "Autoperr" as "Autocompletarpercriesgo", "Reintegro" as "Reintegro", "Dasiprib" as "Datosadicionalessiprib", "Montomin" as "Montominimo", "Jurisdsiem" as "Retpercsiempresegunjurisdiccion", "Retsiprib" as "Artincisoretiene", "Separaiibb" as "Generacompiibbseparados", "Persiprib" as "Artincisopercibe" from ZooLogic.DATOSFISCALES where  funciones.padr( Codigo, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DATOSFISCALES.CODIGO != '' order by Codigo
			endtext
			use in select('c_DATOSFISCALES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSFISCALES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codrela" as "Codigo", "Impuesto" as "Impuesto", "Codunico" as "Codigointerno" from ZooLogic.DatosFiscalDet where CodRela = <<"'" + this.FormatearTextoSql( c_DATOSFISCALES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PerceIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PerceIIBB', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PerceIIBB
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Anterior() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Obs" as "Obser", "Descripcio" as "Descripcion", "Expoenop" as "Exportacionesautomaticasenop", "Nroiibbobl" as "Nroobligatorio", "Afip366814" as "Datosadicionalescomprobantesa", "Autojur" as "Autocompletarjurisdic", "Autoperr" as "Autocompletarpercriesgo", "Reintegro" as "Reintegro", "Dasiprib" as "Datosadicionalessiprib", "Montomin" as "Montominimo", "Jurisdsiem" as "Retpercsiempresegunjurisdiccion", "Retsiprib" as "Artincisoretiene", "Separaiibb" as "Generacompiibbseparados", "Persiprib" as "Artincisopercibe" from ZooLogic.DATOSFISCALES where  funciones.padr( Codigo, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DATOSFISCALES.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_DATOSFISCALES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSFISCALES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codrela" as "Codigo", "Impuesto" as "Impuesto", "Codunico" as "Codigointerno" from ZooLogic.DatosFiscalDet where CodRela = <<"'" + this.FormatearTextoSql( c_DATOSFISCALES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PerceIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PerceIIBB', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PerceIIBB
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Ultimo() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Obs" as "Obser", "Descripcio" as "Descripcion", "Expoenop" as "Exportacionesautomaticasenop", "Nroiibbobl" as "Nroobligatorio", "Afip366814" as "Datosadicionalescomprobantesa", "Autojur" as "Autocompletarjurisdic", "Autoperr" as "Autocompletarpercriesgo", "Reintegro" as "Reintegro", "Dasiprib" as "Datosadicionalessiprib", "Montomin" as "Montominimo", "Jurisdsiem" as "Retpercsiempresegunjurisdiccion", "Retsiprib" as "Artincisoretiene", "Separaiibb" as "Generacompiibbseparados", "Persiprib" as "Artincisopercibe" from ZooLogic.DATOSFISCALES where  DATOSFISCALES.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_DATOSFISCALES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSFISCALES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codrela" as "Codigo", "Impuesto" as "Impuesto", "Codunico" as "Codigointerno" from ZooLogic.DatosFiscalDet where CodRela = <<"'" + this.FormatearTextoSql( c_DATOSFISCALES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PerceIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PerceIIBB', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PerceIIBB
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorAtributoSecundario( tcAtributo ) as Boolean
		local lxValor as variant, llRetorno as boolean, lcXml as string , lcNombreCursor as string, lcAtributo as String, lcatributoPK as string
		lcNombreCursor = 'c_' + sys( 2015 )
		llRetorno = .t.
		lcAtributo = upper( tcAtributo )
		with this
			lcCampo = .ObtenerCampoEntidad( lcAtributo )
			lxValor = .oEntidad.&lcAtributo
			lcFiltroCodigo = ''
			if !.oentidad.EsNuevo() and .oEntidad.EsEdicion()
				lcatributoPK = .oEntidad.cAtributoPK
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Faltafw,Fecexpo,Timestamp,Bloqreg,Smodifw,Saltafw,Vmodifw,Hmodifw,Z" + ;
"adsfw,Valtafw,Ualtafw,Umodifw,Esttrans,Horaimpo,Bdaltafw,Bdmodifw,Horaexpo,Haltafw,Codigo,Obs,Descri" + ;
"pcio,Expoenop,Nroiibbobl,Afip366814,Autojur,Autoperr,Reintegro,Dasiprib,Montomin,Jurisdsiem,Retsipri" + ;
"b,Separaiibb,Persiprib" + ;
" from ZooLogic.DATOSFISCALES where  DATOSFISCALES.CODIGO != '' and " + lcFiltro )
			this.xmlacursor( lcXml, lcNombreCursor )
			if reccount( lcNombreCursor ) = 0
				llRetorno = .f.
			endif
			use in select( lcNombreCursor )
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Eliminar() As Boolean
		local loError as Exception, loEx as Exception, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg
		with this.oEntidad
			local  lxDatosfiscalesFmodifw, lxDatosfiscalesFectrans, lxDatosfiscalesFecimpo, lxDatosfiscalesFaltafw, lxDatosfiscalesFecexpo, lxDatosfiscalesTimestamp, lxDatosfiscalesBloqreg, lxDatosfiscalesSmodifw, lxDatosfiscalesSaltafw, lxDatosfiscalesVmodifw, lxDatosfiscalesHmodifw, lxDatosfiscalesZadsfw, lxDatosfiscalesValtafw, lxDatosfiscalesUaltafw, lxDatosfiscalesUmodifw, lxDatosfiscalesEsttrans, lxDatosfiscalesHoraimpo, lxDatosfiscalesBdaltafw, lxDatosfiscalesBdmodifw, lxDatosfiscalesHoraexpo, lxDatosfiscalesHaltafw, lxDatosfiscalesCodigo, lxDatosfiscalesObs, lxDatosfiscalesDescripcio, lxDatosfiscalesExpoenop, lxDatosfiscalesNroiibbobl, lxDatosfiscalesAfip366814, lxDatosfiscalesAutojur, lxDatosfiscalesAutoperr, lxDatosfiscalesReintegro, lxDatosfiscalesDasiprib, lxDatosfiscalesMontomin, lxDatosfiscalesJurisdsiem, lxDatosfiscalesRetsiprib, lxDatosfiscalesSeparaiibb, lxDatosfiscalesPersiprib
				lxDatosfiscalesFmodifw = ctod( '  /  /    ' )			lxDatosfiscalesFectrans = ctod( '  /  /    ' )			lxDatosfiscalesFecimpo = ctod( '  /  /    ' )			lxDatosfiscalesFaltafw = ctod( '  /  /    ' )			lxDatosfiscalesFecexpo = ctod( '  /  /    ' )			lxDatosfiscalesTimestamp = goLibrerias.ObtenerTimestamp()			lxDatosfiscalesBloqreg = .F.			lxDatosfiscalesSmodifw = []			lxDatosfiscalesSaltafw = []			lxDatosfiscalesVmodifw = []			lxDatosfiscalesHmodifw = []			lxDatosfiscalesZadsfw = []			lxDatosfiscalesValtafw = []			lxDatosfiscalesUaltafw = []			lxDatosfiscalesUmodifw = []			lxDatosfiscalesEsttrans = []			lxDatosfiscalesHoraimpo = []			lxDatosfiscalesBdaltafw = []			lxDatosfiscalesBdmodifw = []			lxDatosfiscalesHoraexpo = []			lxDatosfiscalesHaltafw = []			lxDatosfiscalesCodigo = []			lxDatosfiscalesObs = []			lxDatosfiscalesDescripcio = []			lxDatosfiscalesExpoenop = .F.			lxDatosfiscalesNroiibbobl = .F.			lxDatosfiscalesAfip366814 = .F.			lxDatosfiscalesAutojur = .F.			lxDatosfiscalesAutoperr = .F.			lxDatosfiscalesReintegro = .F.			lxDatosfiscalesDasiprib = .F.			lxDatosfiscalesMontomin = 0			lxDatosfiscalesJurisdsiem = []			lxDatosfiscalesRetsiprib = 0			lxDatosfiscalesSeparaiibb = .F.			lxDatosfiscalesPersiprib = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DatosFiscalDet where "CodRela" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.DATOSFISCALES where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			lnI = this.nReintentos
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar eliminar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar eliminar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar eliminar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Eliminacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Eliminacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		Finally
			this.SetearConexionGlobal()
		EndTry

		endwith
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function LlenarArrayMemo( tcCampo as String, tcAtributo as String, txValorClavePrimaria as variant ) as void 
		local lcMemos as String, lxCodigo as variant, lcCodigo as string, lnTotalMemos as integer, lcAtributo as string, lcTabla as string, lcValor as string, lnElemento as string, i as integer, lnCortar as integer, lnIndice as Integer

		lcAtributo = alltrim(tcAtributo)
		with this
			lcValor = rtrim( .oEntidad.&lcAtributo )
			lcTabla = 'DATOSFISCALES' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DATOSFISCALES.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Obs" as "Obser", "Descripcio" as "Descripcion", "Expoenop" as "Exportacionesautomaticasenop", "Nroiibbobl" as "Nroobligatorio", "Afip366814" as "Datosadicionalescomprobantesa", "Autojur" as "Autocompletarjurisdic", "Autoperr" as "Autocompletarpercriesgo", "Reintegro" as "Reintegro", "Dasiprib" as "Datosadicionalessiprib", "Montomin" as "Montominimo", "Jurisdsiem" as "Retpercsiempresegunjurisdiccion", "Retsiprib" as "Artincisoretiene", "Separaiibb" as "Generacompiibbseparados", "Persiprib" as "Artincisopercibe"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DATOSFISCALES', '', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoEntidad( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetallePerceIIBB( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DATOSFISCALDET.CODRELA != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codrela" as "Codigo", "Impuesto" as "Impuesto", "Codunico" as "Codigointerno"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePerceIIBB( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DatosFiscalDet', 'PerceIIBB', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePerceIIBB( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePerceIIBB( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSER'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'EXPORTACIONESAUTOMATICASENOP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPOENOP AS EXPORTACIONESAUTOMATICASENOP'
				Case lcAtributo == 'NROOBLIGATORIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROIIBBOBL AS NROOBLIGATORIO'
				Case lcAtributo == 'DATOSADICIONALESCOMPROBANTESA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFIP366814 AS DATOSADICIONALESCOMPROBANTESA'
				Case lcAtributo == 'AUTOCOMPLETARJURISDIC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTOJUR AS AUTOCOMPLETARJURISDIC'
				Case lcAtributo == 'AUTOCOMPLETARPERCRIESGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTOPERR AS AUTOCOMPLETARPERCRIESGO'
				Case lcAtributo == 'REINTEGRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REINTEGRO AS REINTEGRO'
				Case lcAtributo == 'DATOSADICIONALESSIPRIB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DASIPRIB AS DATOSADICIONALESSIPRIB'
				Case lcAtributo == 'MONTOMINIMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOMIN AS MONTOMINIMO'
				Case lcAtributo == 'RETPERCSIEMPRESEGUNJURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDSIEM AS RETPERCSIEMPRESEGUNJURISDICCION'
				Case lcAtributo == 'ARTINCISORETIENE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RETSIPRIB AS ARTINCISORETIENE'
				Case lcAtributo == 'GENERACOMPIIBBSEPARADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEPARAIIBB AS GENERACOMPIIBBSEPARADOS'
				Case lcAtributo == 'ARTINCISOPERCIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSIPRIB AS ARTINCISOPERCIBE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetallePerceIIBB( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODRELA AS CODIGO'
				Case lcAtributo == 'IMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPUESTO AS IMPUESTO'
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODUNICO AS CODIGOINTERNO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSER'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'EXPORTACIONESAUTOMATICASENOP'
				lcCampo = 'EXPOENOP'
			Case upper( alltrim( tcAtributo ) ) == 'NROOBLIGATORIO'
				lcCampo = 'NROIIBBOBL'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSADICIONALESCOMPROBANTESA'
				lcCampo = 'AFIP366814'
			Case upper( alltrim( tcAtributo ) ) == 'AUTOCOMPLETARJURISDIC'
				lcCampo = 'AUTOJUR'
			Case upper( alltrim( tcAtributo ) ) == 'AUTOCOMPLETARPERCRIESGO'
				lcCampo = 'AUTOPERR'
			Case upper( alltrim( tcAtributo ) ) == 'REINTEGRO'
				lcCampo = 'REINTEGRO'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSADICIONALESSIPRIB'
				lcCampo = 'DASIPRIB'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOMINIMO'
				lcCampo = 'MONTOMIN'
			Case upper( alltrim( tcAtributo ) ) == 'RETPERCSIEMPRESEGUNJURISDICCION'
				lcCampo = 'JURISDSIEM'
			Case upper( alltrim( tcAtributo ) ) == 'ARTINCISORETIENE'
				lcCampo = 'RETSIPRIB'
			Case upper( alltrim( tcAtributo ) ) == 'GENERACOMPIIBBSEPARADOS'
				lcCampo = 'SEPARAIIBB'
			Case upper( alltrim( tcAtributo ) ) == 'ARTINCISOPERCIBE'
				lcCampo = 'PERSIPRIB'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetallePerceIIBB( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODRELA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTO'
				lcCampo = 'IMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODUNICO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'PERCEIIBB'
			lcRetorno = 'DATOSFISCALDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDatosfiscalesFmodifw, lxDatosfiscalesFectrans, lxDatosfiscalesFecimpo, lxDatosfiscalesFaltafw, lxDatosfiscalesFecexpo, lxDatosfiscalesTimestamp, lxDatosfiscalesBloqreg, lxDatosfiscalesSmodifw, lxDatosfiscalesSaltafw, lxDatosfiscalesVmodifw, lxDatosfiscalesHmodifw, lxDatosfiscalesZadsfw, lxDatosfiscalesValtafw, lxDatosfiscalesUaltafw, lxDatosfiscalesUmodifw, lxDatosfiscalesEsttrans, lxDatosfiscalesHoraimpo, lxDatosfiscalesBdaltafw, lxDatosfiscalesBdmodifw, lxDatosfiscalesHoraexpo, lxDatosfiscalesHaltafw, lxDatosfiscalesCodigo, lxDatosfiscalesObs, lxDatosfiscalesDescripcio, lxDatosfiscalesExpoenop, lxDatosfiscalesNroiibbobl, lxDatosfiscalesAfip366814, lxDatosfiscalesAutojur, lxDatosfiscalesAutoperr, lxDatosfiscalesReintegro, lxDatosfiscalesDasiprib, lxDatosfiscalesMontomin, lxDatosfiscalesJurisdsiem, lxDatosfiscalesRetsiprib, lxDatosfiscalesSeparaiibb, lxDatosfiscalesPersiprib
				lxDatosfiscalesFmodifw =  .Fechamodificacionfw			lxDatosfiscalesFectrans =  .Fechatransferencia			lxDatosfiscalesFecimpo =  .Fechaimpo			lxDatosfiscalesFaltafw =  .Fechaaltafw			lxDatosfiscalesFecexpo =  .Fechaexpo			lxDatosfiscalesTimestamp = goLibrerias.ObtenerTimestamp()			lxDatosfiscalesBloqreg =  .Bloquearregistro			lxDatosfiscalesSmodifw =  .Seriemodificacionfw			lxDatosfiscalesSaltafw =  .Seriealtafw			lxDatosfiscalesVmodifw =  .Versionmodificacionfw			lxDatosfiscalesHmodifw =  .Horamodificacionfw			lxDatosfiscalesZadsfw =  .Zadsfw			lxDatosfiscalesValtafw =  .Versionaltafw			lxDatosfiscalesUaltafw =  .Usuarioaltafw			lxDatosfiscalesUmodifw =  .Usuariomodificacionfw			lxDatosfiscalesEsttrans =  .Estadotransferencia			lxDatosfiscalesHoraimpo =  .Horaimpo			lxDatosfiscalesBdaltafw =  .Basededatosaltafw			lxDatosfiscalesBdmodifw =  .Basededatosmodificacionfw			lxDatosfiscalesHoraexpo =  .Horaexpo			lxDatosfiscalesHaltafw =  .Horaaltafw			lxDatosfiscalesCodigo =  .Codigo			lxDatosfiscalesObs =  .Obser			lxDatosfiscalesDescripcio =  .Descripcion			lxDatosfiscalesExpoenop =  .Exportacionesautomaticasenop			lxDatosfiscalesNroiibbobl =  .Nroobligatorio			lxDatosfiscalesAfip366814 =  .Datosadicionalescomprobantesa			lxDatosfiscalesAutojur =  .Autocompletarjurisdic			lxDatosfiscalesAutoperr =  .Autocompletarpercriesgo			lxDatosfiscalesReintegro =  .Reintegro			lxDatosfiscalesDasiprib =  .Datosadicionalessiprib			lxDatosfiscalesMontomin =  .Montominimo			lxDatosfiscalesJurisdsiem =  upper( .RetPercSiempreSegunJurisdiccion_PK ) 			lxDatosfiscalesRetsiprib =  .Artincisoretiene			lxDatosfiscalesSeparaiibb =  .Generacompiibbseparados			lxDatosfiscalesPersiprib =  .Artincisopercibe
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.DATOSFISCALES ( "Fmodifw","Fectrans","Fecimpo","Faltafw","Fecexpo","Timestamp","Bloqreg","Smodifw","Saltafw","Vmodifw","Hmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Esttrans","Horaimpo","Bdaltafw","Bdmodifw","Horaexpo","Haltafw","Codigo","Obs","Descripcio","Expoenop","Nroiibbobl","Afip366814","Autojur","Autoperr","Reintegro","Dasiprib","Montomin","Jurisdsiem","Retsiprib","Separaiibb","Persiprib" ) values ( <<"'" + this.ConvertirDateSql( lxDatosfiscalesFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecexpo ) + "'" >>, <<lxDatosfiscalesTimestamp >>, <<iif( lxDatosfiscalesBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesDescripcio ) + "'" >>, <<iif( lxDatosfiscalesExpoenop, 1, 0 ) >>, <<iif( lxDatosfiscalesNroiibbobl, 1, 0 ) >>, <<iif( lxDatosfiscalesAfip366814, 1, 0 ) >>, <<iif( lxDatosfiscalesAutojur, 1, 0 ) >>, <<iif( lxDatosfiscalesAutoperr, 1, 0 ) >>, <<iif( lxDatosfiscalesReintegro, 1, 0 ) >>, <<iif( lxDatosfiscalesDasiprib, 1, 0 ) >>, <<lxDatosfiscalesMontomin >>, <<"'" + this.FormatearTextoSql( lxDatosfiscalesJurisdsiem ) + "'" >>, <<lxDatosfiscalesRetsiprib >>, <<iif( lxDatosfiscalesSeparaiibb, 1, 0 ) >>, <<lxDatosfiscalesPersiprib >> )
		endtext
		loColeccion.cTabla = 'DATOSFISCALES' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PerceIIBB
				if this.oEntidad.PerceIIBB.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxImpuesto_PK = loItem.Impuesto_PK
					lxCodigointerno = loItem.Codigointerno
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DatosFiscalDet("NROITEM","BLOQREG","CodRela","Impuesto","codunico" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDatosfiscalesFmodifw, lxDatosfiscalesFectrans, lxDatosfiscalesFecimpo, lxDatosfiscalesFaltafw, lxDatosfiscalesFecexpo, lxDatosfiscalesTimestamp, lxDatosfiscalesBloqreg, lxDatosfiscalesSmodifw, lxDatosfiscalesSaltafw, lxDatosfiscalesVmodifw, lxDatosfiscalesHmodifw, lxDatosfiscalesZadsfw, lxDatosfiscalesValtafw, lxDatosfiscalesUaltafw, lxDatosfiscalesUmodifw, lxDatosfiscalesEsttrans, lxDatosfiscalesHoraimpo, lxDatosfiscalesBdaltafw, lxDatosfiscalesBdmodifw, lxDatosfiscalesHoraexpo, lxDatosfiscalesHaltafw, lxDatosfiscalesCodigo, lxDatosfiscalesObs, lxDatosfiscalesDescripcio, lxDatosfiscalesExpoenop, lxDatosfiscalesNroiibbobl, lxDatosfiscalesAfip366814, lxDatosfiscalesAutojur, lxDatosfiscalesAutoperr, lxDatosfiscalesReintegro, lxDatosfiscalesDasiprib, lxDatosfiscalesMontomin, lxDatosfiscalesJurisdsiem, lxDatosfiscalesRetsiprib, lxDatosfiscalesSeparaiibb, lxDatosfiscalesPersiprib
				lxDatosfiscalesFmodifw =  .Fechamodificacionfw			lxDatosfiscalesFectrans =  .Fechatransferencia			lxDatosfiscalesFecimpo =  .Fechaimpo			lxDatosfiscalesFaltafw =  .Fechaaltafw			lxDatosfiscalesFecexpo =  .Fechaexpo			lxDatosfiscalesTimestamp = goLibrerias.ObtenerTimestamp()			lxDatosfiscalesBloqreg =  .Bloquearregistro			lxDatosfiscalesSmodifw =  .Seriemodificacionfw			lxDatosfiscalesSaltafw =  .Seriealtafw			lxDatosfiscalesVmodifw =  .Versionmodificacionfw			lxDatosfiscalesHmodifw =  .Horamodificacionfw			lxDatosfiscalesZadsfw =  .Zadsfw			lxDatosfiscalesValtafw =  .Versionaltafw			lxDatosfiscalesUaltafw =  .Usuarioaltafw			lxDatosfiscalesUmodifw =  .Usuariomodificacionfw			lxDatosfiscalesEsttrans =  .Estadotransferencia			lxDatosfiscalesHoraimpo =  .Horaimpo			lxDatosfiscalesBdaltafw =  .Basededatosaltafw			lxDatosfiscalesBdmodifw =  .Basededatosmodificacionfw			lxDatosfiscalesHoraexpo =  .Horaexpo			lxDatosfiscalesHaltafw =  .Horaaltafw			lxDatosfiscalesCodigo =  .Codigo			lxDatosfiscalesObs =  .Obser			lxDatosfiscalesDescripcio =  .Descripcion			lxDatosfiscalesExpoenop =  .Exportacionesautomaticasenop			lxDatosfiscalesNroiibbobl =  .Nroobligatorio			lxDatosfiscalesAfip366814 =  .Datosadicionalescomprobantesa			lxDatosfiscalesAutojur =  .Autocompletarjurisdic			lxDatosfiscalesAutoperr =  .Autocompletarpercriesgo			lxDatosfiscalesReintegro =  .Reintegro			lxDatosfiscalesDasiprib =  .Datosadicionalessiprib			lxDatosfiscalesMontomin =  .Montominimo			lxDatosfiscalesJurisdsiem =  upper( .RetPercSiempreSegunJurisdiccion_PK ) 			lxDatosfiscalesRetsiprib =  .Artincisoretiene			lxDatosfiscalesSeparaiibb =  .Generacompiibbseparados			lxDatosfiscalesPersiprib =  .Artincisopercibe
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  DATOSFISCALES.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.DATOSFISCALES set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDatosfiscalesFecexpo ) + "'">>, "Timestamp" = <<lxDatosfiscalesTimestamp>>, "Bloqreg" = <<iif( lxDatosfiscalesBloqreg, 1, 0 )>>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesVmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesUmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesHaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesObs ) + "'">>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesDescripcio ) + "'">>, "Expoenop" = <<iif( lxDatosfiscalesExpoenop, 1, 0 )>>, "Nroiibbobl" = <<iif( lxDatosfiscalesNroiibbobl, 1, 0 )>>, "Afip366814" = <<iif( lxDatosfiscalesAfip366814, 1, 0 )>>, "Autojur" = <<iif( lxDatosfiscalesAutojur, 1, 0 )>>, "Autoperr" = <<iif( lxDatosfiscalesAutoperr, 1, 0 )>>, "Reintegro" = <<iif( lxDatosfiscalesReintegro, 1, 0 )>>, "Dasiprib" = <<iif( lxDatosfiscalesDasiprib, 1, 0 )>>, "Montomin" = <<lxDatosfiscalesMontomin>>, "Jurisdsiem" = <<"'" + this.FormatearTextoSql( lxDatosfiscalesJurisdsiem ) + "'">>, "Retsiprib" = <<lxDatosfiscalesRetsiprib>>, "Separaiibb" = <<iif( lxDatosfiscalesSeparaiibb, 1, 0 )>>, "Persiprib" = <<lxDatosfiscalesPersiprib>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DATOSFISCALES' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DatosFiscalDet where "CodRela" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PerceIIBB
				if this.oEntidad.PerceIIBB.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxImpuesto_PK = loItem.Impuesto_PK
					lxCodigointerno = loItem.Codigointerno
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DatosFiscalDet("NROITEM","BLOQREG","CodRela","Impuesto","codunico" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasDelete() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  DATOSFISCALES.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.DATOSFISCALES where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DatosFiscalDet where "CodRela" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'DATOSFISCALES' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
		
			.oCompAccionesautomaticasparadatosfiscales.lNuevo = .EsNuevo()
			.oCompAccionesautomaticasparadatosfiscales.lEdicion = .EsEdicion()
			.oCompAccionesautomaticasparadatosfiscales.lEliminar = .lEliminar
			.oCompAccionesautomaticasparadatosfiscales.lAnular = .lAnular
			loColSentencias = .oCompAccionesautomaticasparadatosfiscales.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.DATOSFISCALES set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  DATOSFISCALES.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.DATOSFISCALES where  DATOSFISCALES.CODIGO != ''" )
			this.xmlacursor( lcXml, 'c_CantReg' )
		lnCantReg = c_CantReg.Total
		use in select('c_CantReg')
		return lnCantReg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTimestampActual() as integer
		local lnTimeStamp as integer, lcCursor as string
		lnTimeStamp = 0
		lcCursor = sys(2015)

			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.DATOSFISCALES where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  DATOSFISCALES.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSFISCALES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.DATOSFISCALES Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.DATOSFISCALES set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, obs = ] + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, ExpoEnOP = ] + Transform( iif( &lcCursor..ExpoEnOP, 1, 0 ))+ [, Nroiibbobl = ] + Transform( iif( &lcCursor..Nroiibbobl, 1, 0 ))+ [, AFIP366814 = ] + Transform( iif( &lcCursor..AFIP366814, 1, 0 ))+ [, Autojur = ] + Transform( iif( &lcCursor..Autojur, 1, 0 ))+ [, Autoperr = ] + Transform( iif( &lcCursor..Autoperr, 1, 0 ))+ [, Reintegro = ] + Transform( iif( &lcCursor..Reintegro, 1, 0 ))+ [, DASiprib = ] + Transform( iif( &lcCursor..DASiprib, 1, 0 ))+ [, MontoMin = ] + transform( &lcCursor..MontoMin )+ [, JurisdSiem = ] + "'" + this.FormatearTextoSql( &lcCursor..JurisdSiem ) + "'"+ [, RetSIPRIB = ] + transform( &lcCursor..RetSIPRIB )+ [, SeparaIIBB = ] + Transform( iif( &lcCursor..SeparaIIBB, 1, 0 ))+ [, PerSIPRIB = ] + transform( &lcCursor..PerSIPRIB ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FECIMPO, FALTAFW, FECEXPO, TIMESTAMP, BLOQREG, SMODIFW, SALTAFW, VMODIFW, HMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, ESTTRANS, HORAIMPO, BDALTAFW, BDMODIFW, HORAEXPO, HALTAFW, Codigo, obs, Descripcio, ExpoEnOP, Nroiibbobl, AFIP366814, Autojur, Autoperr, Reintegro, DASiprib, MontoMin, JurisdSiem, RetSIPRIB, SeparaIIBB, PerSIPRIB
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + Transform( iif( &lcCursor..ExpoEnOP, 1, 0 )) + ',' + Transform( iif( &lcCursor..Nroiibbobl, 1, 0 )) + ',' + Transform( iif( &lcCursor..AFIP366814, 1, 0 )) + ',' + Transform( iif( &lcCursor..Autojur, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Autoperr, 1, 0 )) + ',' + Transform( iif( &lcCursor..Reintegro, 1, 0 )) + ',' + Transform( iif( &lcCursor..DASiprib, 1, 0 )) + ',' + transform( &lcCursor..MontoMin ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..JurisdSiem ) + "'" + ',' + transform( &lcCursor..RetSIPRIB ) + ',' + Transform( iif( &lcCursor..SeparaIIBB, 1, 0 )) + ',' + transform( &lcCursor..PerSIPRIB )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.DATOSFISCALES ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSFISCALES'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DatosFiscalDet Where CodRela] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDATOSFISCALES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodRela in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","CodRela","Impuesto","codunico"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DatosFiscalDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodRela    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Impuesto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codunico   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DATOSFISCALES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DATOSFISCALES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DATOSFISCALES_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDATOSFISCALES'
				llRetorno = .T.
		EndCase
		Return llRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function ImportarTablaDeTrabajo( toConexion as Object ) As Void
		local llEjecutarRollback as Boolean
		llEjecutarRollback = .F.
		try
			do While this.nCantVeces > 0
				this.nCantVeces = this.nCantVeces - 1

				this.InicializarMensajesConexion()

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_DatosFiscales')

				if this.oMensajesConexion.Count>0
					goServicios.Errores.LevantarExcepcion( this.ObtenerMensajesConexion() )
				endif

			enddo
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	protected function ValidarDatosAImportar() as boolean
		local lcCursor as String, llRetorno as boolean, lxVar as Variant, llCondicion as boolean
		lcCursor = This.oEntidad.cPrefijoImportar + 'DATOSFISCALES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DATOSFISCALES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSFISCALES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSFISCALES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DatosFiscales') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DatosFiscales
Create Table ZooLogic.TablaTrabajo_DatosFiscales ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"codigo" char( 8 )  null, 
"obs" varchar(max)  null, 
"descripcio" char( 50 )  null, 
"expoenop" bit  null, 
"nroiibbobl" bit  null, 
"afip366814" bit  null, 
"autojur" bit  null, 
"autoperr" bit  null, 
"reintegro" bit  null, 
"dasiprib" bit  null, 
"montomin" numeric( 10, 2 )  null, 
"jurisdsiem" char( 8 )  null, 
"retsiprib" numeric( 2, 0 )  null, 
"separaiibb" bit  null, 
"persiprib" numeric( 2, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_DatosFiscales' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_DatosFiscales' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSFISCALES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('expoenop','expoenop')
			.AgregarMapeo('nroiibbobl','nroiibbobl')
			.AgregarMapeo('afip366814','afip366814')
			.AgregarMapeo('autojur','autojur')
			.AgregarMapeo('autoperr','autoperr')
			.AgregarMapeo('reintegro','reintegro')
			.AgregarMapeo('dasiprib','dasiprib')
			.AgregarMapeo('montomin','montomin')
			.AgregarMapeo('jurisdsiem','jurisdsiem')
			.AgregarMapeo('retsiprib','retsiprib')
			.AgregarMapeo('separaiibb','separaiibb')
			.AgregarMapeo('persiprib','persiprib')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_DatosFiscales'
			.ConsultaOrigen = 'select * from ' + lcCursor
			Select( lcCursor )
			Count to This.nCantVeces
			This.nCantVeces = ceiling( This.nCantVeces / This.nCantABorrar )
			if !this.oEntidad.VerificarContexto( 'CB' )
				use in ( lcCursor )
			endif
			.ImportarMasivamente( toConexion )
		endwith
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion( tcTablaTrabajo ) as String
		local lcCadena as String, lcTabla as String, lcEntidad as String, loLogueo as Object, lcDescripcionFW as string
		lcTabla = alltrim( Upper( tcTablaTrabajo ) )
		loLogueo = this.oLogueo.oInfoLog
		lcEntidad = alltrim( Upper( This.oEntidad.ObtenerNombre() ) )
		lcDescripcionFW = "IMPORTACION"
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.EXPOENOP = isnull( d.EXPOENOP, t.EXPOENOP ),t.NROIIBBOBL = isnull( d.NROIIBBOBL, t.NROIIBBOBL ),t.AFIP366814 = isnull( d.AFIP366814, t.AFIP366814 ),t.AUTOJUR = isnull( d.AUTOJUR, t.AUTOJUR ),t.AUTOPERR = isnull( d.AUTOPERR, t.AUTOPERR ),t.REINTEGRO = isnull( d.REINTEGRO, t.REINTEGRO ),t.DASIPRIB = isnull( d.DASIPRIB, t.DASIPRIB ),t.MONTOMIN = isnull( d.MONTOMIN, t.MONTOMIN ),t.JURISDSIEM = isnull( d.JURISDSIEM, t.JURISDSIEM ),t.RETSIPRIB = isnull( d.RETSIPRIB, t.RETSIPRIB ),t.SEPARAIIBB = isnull( d.SEPARAIIBB, t.SEPARAIIBB ),t.PERSIPRIB = isnull( d.PERSIPRIB, t.PERSIPRIB )
					from ZooLogic.DATOSFISCALES t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.DATOSFISCALES(Fmodifw,Fectrans,Fecimpo,Faltafw,Fecexpo,Timestamp,Bloqreg,Smodifw,Saltafw,Vmodifw,Hmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Esttrans,Horaimpo,Bdaltafw,Bdmodifw,Horaexpo,Haltafw,Codigo,Obs,Descripcio,Expoenop,Nroiibbobl,Afip366814,Autojur,Autoperr,Reintegro,Dasiprib,Montomin,Jurisdsiem,Retsiprib,Separaiibb,Persiprib)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.DESCRIPCIO,''),isnull( d.EXPOENOP,0),isnull( d.NROIIBBOBL,0),isnull( d.AFIP366814,0),isnull( d.AUTOJUR,0),isnull( d.AUTOPERR,0),isnull( d.REINTEGRO,0),isnull( d.DASIPRIB,0),isnull( d.MONTOMIN,0),isnull( d.JURISDSIEM,''),isnull( d.RETSIPRIB,0),isnull( d.SEPARAIIBB,0),isnull( d.PERSIPRIB,0)
						From deleted d left join ZooLogic.DATOSFISCALES pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DatosFiscalDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DATOSFISCALES_DatosFiscalDet
ON ZooLogic.TablaTrabajo_DATOSFISCALES_DatosFiscalDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODRELA = isnull( d.CODRELA, t.CODRELA ),
t.IMPUESTO = isnull( d.IMPUESTO, t.IMPUESTO ),
t.CODUNICO = isnull( d.CODUNICO, t.CODUNICO )
from ZooLogic.DatosFiscalDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DatosFiscalDet
( 
"NROITEM",
"BLOQREG",
"CODRELA",
"IMPUESTO",
"CODUNICO"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.CODRELA,
d.IMPUESTO,
d.CODUNICO
From deleted d left join ZooLogic.DatosFiscalDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DatosFiscales') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DatosFiscales
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DATOSFISCALES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSFISCALES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSFISCALES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSFISCALES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSFISCALES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSFISCALES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Perceiibb.Limpiar()
					.Perceiibb.SetearEsNavegacion( .lProcesando )
					.Perceiibb.Cargar()
					.Timestamp = nvl( c_DATOSFISCALES.Timestamp, 0 )
					.Bloquearregistro = nvl( c_DATOSFISCALES.Bloquearregistro, .F. )
					.Seriemodificacionfw = nvl( c_DATOSFISCALES.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_DATOSFISCALES.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_DATOSFISCALES.Versionmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_DATOSFISCALES.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_DATOSFISCALES.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_DATOSFISCALES.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_DATOSFISCALES.Usuariomodificacionfw, [] )
					.Estadotransferencia = nvl( c_DATOSFISCALES.Estadotransferencia, [] )
					.Horaimpo = nvl( c_DATOSFISCALES.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_DATOSFISCALES.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_DATOSFISCALES.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_DATOSFISCALES.Horaexpo, [] )
					.Horaaltafw = nvl( c_DATOSFISCALES.Horaaltafw, [] )
					.Codigo = nvl( c_DATOSFISCALES.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obser')
					.Obser = lcValor 
					.Descripcion = nvl( c_DATOSFISCALES.Descripcion, [] )
					.Exportacionesautomaticasenop = nvl( c_DATOSFISCALES.Exportacionesautomaticasenop, .F. )
					.Nroobligatorio = nvl( c_DATOSFISCALES.Nroobligatorio, .F. )
					.Datosadicionalescomprobantesa = nvl( c_DATOSFISCALES.Datosadicionalescomprobantesa, .F. )
					.Autocompletarjurisdic = nvl( c_DATOSFISCALES.Autocompletarjurisdic, .F. )
					.Autocompletarpercriesgo = nvl( c_DATOSFISCALES.Autocompletarpercriesgo, .F. )
					.Reintegro = nvl( c_DATOSFISCALES.Reintegro, .F. )
					.Datosadicionalessiprib = nvl( c_DATOSFISCALES.Datosadicionalessiprib, .F. )
					.Montominimo = nvl( c_DATOSFISCALES.Montominimo, 0 )
					.Retpercsiempresegunjurisdiccion_PK =  nvl( c_DATOSFISCALES.Retpercsiempresegunjurisdiccion, [] )
					.Artincisoretiene = nvl( c_DATOSFISCALES.Artincisoretiene, 0 )
					.Generacompiibbseparados = nvl( c_DATOSFISCALES.Generacompiibbseparados, .F. )
					.Artincisopercibe = nvl( c_DATOSFISCALES.Artincisopercibe, 0 )
				Catch To loError
					goServicios.Errores.LevantarExcepcion( loError )
				Finally
					.lCargando = .f.
				EndTry
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DespuesBeginTransaction() as Void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function AntesEndTransaction() as Void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function FinalDeTransaction() as Void
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.PerceIIBB
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_DATOSFISCALES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.DATOSFISCALES' )
		endtext
		this.oConexion.EjecutarSql( lcSentencia, 'c_last_user_update', set( 'Datasession' ) )
		ldRetorno = {^0001-01-01 00:00:00}
		if reccount( 'c_last_user_update' ) > 0 and !isnull( c_last_user_update.last_update )
			ldRetorno = c_last_user_update.last_update
		endif
		return ldRetorno
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerIdentificadoresPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from ZooLogic.DATOSFISCALES 
								Where   DATOSFISCALES.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DATOSFISCALES", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Obs" as "Obser", "Descripcio" as "Descripcion", "Expoenop" as "Exportacionesautomaticasenop", "Nroiibbobl" as "Nroobligatorio", "Afip366814" as "Datosadicionalescomprobantesa", "Autojur" as "Autocompletarjurisdic", "Autoperr" as "Autocompletarpercriesgo", "Reintegro" as "Reintegro", "Dasiprib" as "Datosadicionalessiprib", "Montomin" as "Montominimo", "Jurisdsiem" as "Retpercsiempresegunjurisdiccion", "Retsiprib" as "Artincisoretiene", "Separaiibb" as "Generacompiibbseparados", "Persiprib" as "Artincisopercibe"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.DATOSFISCALES 
								Where   DATOSFISCALES.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSql( lcSQL, lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc

enddefine

define class ObjetoBusqueda as custom
	Tabla = 'DATOSFISCALES'
	Filtro = " DATOSFISCALES.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DATOSFISCALES.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = ""
	FiltroSubEntidad = ''

	*--------------------------------------------------------------------------------------------------------
	function init( toEntidad as object ) as boolean
		with this
			text to .cEstructura noshow 
<?xml version = "1.0" encoding="Windows-1252" standalone="yes"?>
<VFPData xml:space="preserve">
	<xsd:schema id="VFPData" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
		<xsd:element name="VFPData" msdata:IsDataSet="true">
			<xsd:complexType>
				<xsd:choice maxOccurs="unbounded">
					<xsd:element name="row" minOccurs="0" maxOccurs="unbounded">
						<xsd:complexType>
							<xsd:attribute name="entidad" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tabla" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="15"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="campo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="claveprimaria" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="muestrarelacion" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="permitemodificar" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="esentidad" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="claveforanea" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tipodato" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="longitud" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="decimales" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="valorsugerido" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="obligatorio" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="admitebusqueda" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiqueta" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="160"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="dominio" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="30"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="detalle" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="tipo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributoforaneo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="clavecandidata" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="mascara" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="25"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="ofuncionalidad" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="relaciones" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="filtrobuscador" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="grupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="subgrupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="orden" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="4"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="alta" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluiratrib" type="xsd:boolean" use="required"/>
							<xsd:attribute name="excluiratrib" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluirbussubent" type="xsd:boolean" use="required"/>
							<xsd:attribute name="utilizamismarelacion" type="xsd:boolean" use="required"/>
						</xsd:complexType>
					</xsd:element>
				</xsd:choice>
				<xsd:anyAttribute namespace="http://www.w3.org/XML/1998/namespace" processContents="lax"/>
			</xsd:complexType>
		</xsd:element>
	</xsd:schema>
	<row entidad="DATOSFISCALES                           " atributo="FECHAMODIFICACIONFW                     " tabla="DATOSFISCALES  " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="FECHATRANSFERENCIA                      " tabla="DATOSFISCALES  " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="FECHAIMPO                               " tabla="DATOSFISCALES  " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="FECHAALTAFW                             " tabla="DATOSFISCALES  " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="FECHAEXPO                               " tabla="DATOSFISCALES  " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="PERCEIIBB                               " tabla="DATOSFISCALDET " campo="CODRELA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Impuestos                                                                                                                                                       " dominio="DETALLEITEMDATOSFISCALES      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="TIMESTAMP                               " tabla="DATOSFISCALES  " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="BLOQUEARREGISTRO                        " tabla="DATOSFISCALES  " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="SERIEMODIFICACIONFW                     " tabla="DATOSFISCALES  " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="SERIEALTAFW                             " tabla="DATOSFISCALES  " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="VERSIONMODIFICACIONFW                   " tabla="DATOSFISCALES  " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="HORAMODIFICACIONFW                      " tabla="DATOSFISCALES  " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="ZADSFW                                  " tabla="DATOSFISCALES  " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="VERSIONALTAFW                           " tabla="DATOSFISCALES  " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="USUARIOALTAFW                           " tabla="DATOSFISCALES  " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="USUARIOMODIFICACIONFW                   " tabla="DATOSFISCALES  " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="ESTADOTRANSFERENCIA                     " tabla="DATOSFISCALES  " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="HORAIMPO                                " tabla="DATOSFISCALES  " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="BASEDEDATOSALTAFW                       " tabla="DATOSFISCALES  " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DATOSFISCALES  " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="HORAEXPO                                " tabla="DATOSFISCALES  " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="HORAALTAFW                              " tabla="DATOSFISCALES  " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="CODIGO                                  " tabla="DATOSFISCALES  " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="OBSER                                   " tabla="DATOSFISCALES  " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="DESCRIPCION                             " tabla="DATOSFISCALES  " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="EXPORTACIONESAUTOMATICASENOP            " tabla="DATOSFISCALES  " campo="EXPOENOP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Exportaciones para SIRE en órdenes de pago                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="NROOBLIGATORIO                          " tabla="DATOSFISCALES  " campo="NROIIBBOBL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Nro. de IIBB obligatorio para convenio local o multilateral                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="DATOSADICIONALESCOMPROBANTESA           " tabla="DATOSFISCALES  " campo="AFIP366814" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="AFIP - R.G. 4520/19 régimen informativo de comprobantes clase A                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="AUTOCOMPLETARJURISDIC                   " tabla="DATOSFISCALES  " campo="AUTOJUR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Autocompletar jurisdicciones de las percepciones en clientes                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="AUTOCOMPLETARPERCRIESGO                 " tabla="DATOSFISCALES  " campo="AUTOPERR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Autocompletar percepciones de alto riesgo fiscal en clientes                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="REINTEGRO                               " tabla="DATOSFISCALES  " campo="REINTEGRO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Reintegro de IVA                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="DATOSADICIONALESSIPRIB                  " tabla="DATOSFISCALES  " campo="DASIPRIB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="IIBB Santa Fe (SIPRIB)                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="MONTOMINIMO                             " tabla="DATOSFISCALES  " campo="MONTOMIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="70                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="414" etiqueta="Monto mínimo de facturación                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="RETPERCSIEMPRESEGUNJURISDICCION         " tabla="DATOSFISCALES  " campo="JURISDSIEM" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="JURISDICCION                            " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Retiene/percibe siempre en jurisdicción                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="ARTINCISORETIENE                        " tabla="DATOSFISCALES  " campo="RETSIPRIB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Artículo inciso por el que retiene                                                                                                                              " dominio="COMBOSIPRIBRETENCION          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="GENERACOMPIIBBSEPARADOS                 " tabla="DATOSFISCALES  " campo="SEPARAIIBB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Genera un comprobante por cada retención de IIBB en la orden de pago                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSFISCALES                           " atributo="ARTINCISOPERCIBE                        " tabla="DATOSFISCALES  " campo="PERSIPRIB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Artículo inciso por el que percibe                                                                                                                              " dominio="COMBOSIPRIBPERCEPCION         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="JURISDICCION                            " atributo="DESCRIPCION                             " tabla="JURISDIC       " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Ret.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join JURISDIC On DATOSFISCALES.JURISDSIEM = JURISDIC.codigo And  JURISDIC.CODIGO != ''                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext


			.listadecampos = .cEstructura
			.cEstructuraSinDetalle = .cEstructura
			.oEntidad = toEntidad
			.Indice = .Indice
			.Filtro = .Filtro
		endwith
	endfunc

enddefine