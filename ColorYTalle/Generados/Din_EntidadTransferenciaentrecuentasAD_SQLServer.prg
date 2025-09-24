
define class Din_EntidadTRANSFERENCIAENTRECUENTASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TRANSFERENCIAENTRECUENTAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_TECPK'
	cTablaPrincipal = 'TRANCTAS'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxTranctasFecexpo, lxTranctasFaltafw, lxTranctasFecimpo, lxTranctasFmodifw, lxTranctasFectrans, lxTranctasHoraimpo, lxTranctasHoraexpo, lxTranctasHaltafw, lxTranctasHmodifw, lxTranctasSmodifw, lxTranctasVmodifw, lxTranctasZadsfw, lxTranctasUmodifw, lxTranctasValtafw, lxTranctasSaltafw, lxTranctasUaltafw, lxTranctasBdmodifw, lxTranctasEsttrans, lxTranctasBdaltafw, lxTranctasCodigo, lxTranctasCtarec, lxTranctasCtatran, lxTranctasNumero, lxTranctasIngreso, lxTranctasFecrec, lxTranctasFectran, lxTranctasDescri, lxTranctasHoratran, lxTranctasHorarec, lxTranctasMontorec, lxTranctasMontotra, lxTranctasIdtran, lxTranctasIdrec, lxTranctasCodtran, lxTranctasCodrec, lxTranctasRegtran, lxTranctasRegrec, lxTranctasCotrec, lxTranctasCottra, lxTranctasRecpesos, lxTranctasTrapesos, lxTranctasObs
				lxTranctasFecexpo =  .Fechaexpo			lxTranctasFaltafw =  .Fechaaltafw			lxTranctasFecimpo =  .Fechaimpo			lxTranctasFmodifw =  .Fechamodificacionfw			lxTranctasFectrans =  .Fechatransferencia			lxTranctasHoraimpo =  .Horaimpo			lxTranctasHoraexpo =  .Horaexpo			lxTranctasHaltafw =  .Horaaltafw			lxTranctasHmodifw =  .Horamodificacionfw			lxTranctasSmodifw =  .Seriemodificacionfw			lxTranctasVmodifw =  .Versionmodificacionfw			lxTranctasZadsfw =  .Zadsfw			lxTranctasUmodifw =  .Usuariomodificacionfw			lxTranctasValtafw =  .Versionaltafw			lxTranctasSaltafw =  .Seriealtafw			lxTranctasUaltafw =  .Usuarioaltafw			lxTranctasBdmodifw =  .Basededatosmodificacionfw			lxTranctasEsttrans =  .Estadotransferencia			lxTranctasBdaltafw =  .Basededatosaltafw			lxTranctasCodigo =  .Codigo			lxTranctasCtarec =  upper( .CuentaBancariaRecibe_PK ) 			lxTranctasCtatran =  upper( .CuentaBancariaTransfiere_PK ) 			lxTranctasNumero =  .Numero			lxTranctasIngreso =  .Fechaingreso			lxTranctasFecrec =  .Fecharecibe			lxTranctasFectran =  .Fechatransfiere			lxTranctasDescri =  .Descripcion			lxTranctasHoratran =  .Horatransfiere			lxTranctasHorarec =  .Horarecibe			lxTranctasMontorec =  .Montorecibe			lxTranctasMontotra =  .Montotransfiere			lxTranctasIdtran =  .Identificadortransfiere			lxTranctasIdrec =  .Identificadorrecibe			lxTranctasCodtran =  .Codigotransfiere			lxTranctasCodrec =  .Codigorecibe			lxTranctasRegtran =  .Idregistrotransfiere			lxTranctasRegrec =  .Idregistrorecibe			lxTranctasCotrec =  .Cotizacionmonedarecibe			lxTranctasCottra =  .Cotizacionmonedatransfiere			lxTranctasRecpesos =  .Recibealcambio			lxTranctasTrapesos =  .Transfierealcambio			lxTranctasObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTranctasCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TRANCTAS ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Horaimpo","Horaexpo","Haltafw","Hmodifw","Smodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Ualtafw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Ctarec","Ctatran","Numero","Ingreso","Fecrec","Fectran","Descri","Horatran","Horarec","Montorec","Montotra","Idtran","Idrec","Codtran","Codrec","Regtran","Regrec","Cotrec","Cottra","Recpesos","Trapesos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxTranctasFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCtarec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCtatran ) + "'" >>, <<lxTranctasNumero >>, <<"'" + this.ConvertirDateSql( lxTranctasIngreso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFecrec ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFectran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasDescri ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHoratran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHorarec ) + "'" >>, <<lxTranctasMontorec >>, <<lxTranctasMontotra >>, <<"'" + this.FormatearTextoSql( lxTranctasIdtran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasIdrec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCodtran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCodrec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasRegtran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasRegrec ) + "'" >>, <<lxTranctasCotrec >>, <<lxTranctasCottra >>, <<lxTranctasRecpesos >>, <<lxTranctasTrapesos >>, <<"'" + this.FormatearTextoSql( lxTranctasObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
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
			.ActualizarNumeraciones()
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
			.ActualizarNumeraciones()
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
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
			local  lxTranctasFecexpo, lxTranctasFaltafw, lxTranctasFecimpo, lxTranctasFmodifw, lxTranctasFectrans, lxTranctasHoraimpo, lxTranctasHoraexpo, lxTranctasHaltafw, lxTranctasHmodifw, lxTranctasSmodifw, lxTranctasVmodifw, lxTranctasZadsfw, lxTranctasUmodifw, lxTranctasValtafw, lxTranctasSaltafw, lxTranctasUaltafw, lxTranctasBdmodifw, lxTranctasEsttrans, lxTranctasBdaltafw, lxTranctasCodigo, lxTranctasCtarec, lxTranctasCtatran, lxTranctasNumero, lxTranctasIngreso, lxTranctasFecrec, lxTranctasFectran, lxTranctasDescri, lxTranctasHoratran, lxTranctasHorarec, lxTranctasMontorec, lxTranctasMontotra, lxTranctasIdtran, lxTranctasIdrec, lxTranctasCodtran, lxTranctasCodrec, lxTranctasRegtran, lxTranctasRegrec, lxTranctasCotrec, lxTranctasCottra, lxTranctasRecpesos, lxTranctasTrapesos, lxTranctasObs
				lxTranctasFecexpo =  .Fechaexpo			lxTranctasFaltafw =  .Fechaaltafw			lxTranctasFecimpo =  .Fechaimpo			lxTranctasFmodifw =  .Fechamodificacionfw			lxTranctasFectrans =  .Fechatransferencia			lxTranctasHoraimpo =  .Horaimpo			lxTranctasHoraexpo =  .Horaexpo			lxTranctasHaltafw =  .Horaaltafw			lxTranctasHmodifw =  .Horamodificacionfw			lxTranctasSmodifw =  .Seriemodificacionfw			lxTranctasVmodifw =  .Versionmodificacionfw			lxTranctasZadsfw =  .Zadsfw			lxTranctasUmodifw =  .Usuariomodificacionfw			lxTranctasValtafw =  .Versionaltafw			lxTranctasSaltafw =  .Seriealtafw			lxTranctasUaltafw =  .Usuarioaltafw			lxTranctasBdmodifw =  .Basededatosmodificacionfw			lxTranctasEsttrans =  .Estadotransferencia			lxTranctasBdaltafw =  .Basededatosaltafw			lxTranctasCodigo =  .Codigo			lxTranctasCtarec =  upper( .CuentaBancariaRecibe_PK ) 			lxTranctasCtatran =  upper( .CuentaBancariaTransfiere_PK ) 			lxTranctasNumero =  .Numero			lxTranctasIngreso =  .Fechaingreso			lxTranctasFecrec =  .Fecharecibe			lxTranctasFectran =  .Fechatransfiere			lxTranctasDescri =  .Descripcion			lxTranctasHoratran =  .Horatransfiere			lxTranctasHorarec =  .Horarecibe			lxTranctasMontorec =  .Montorecibe			lxTranctasMontotra =  .Montotransfiere			lxTranctasIdtran =  .Identificadortransfiere			lxTranctasIdrec =  .Identificadorrecibe			lxTranctasCodtran =  .Codigotransfiere			lxTranctasCodrec =  .Codigorecibe			lxTranctasRegtran =  .Idregistrotransfiere			lxTranctasRegrec =  .Idregistrorecibe			lxTranctasCotrec =  .Cotizacionmonedarecibe			lxTranctasCottra =  .Cotizacionmonedatransfiere			lxTranctasRecpesos =  .Recibealcambio			lxTranctasTrapesos =  .Transfierealcambio			lxTranctasObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TRANCTAS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTranctasFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTranctasFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTranctasFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTranctasFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTranctasFectrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTranctasHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTranctasHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTranctasHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTranctasHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTranctasSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTranctasVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTranctasZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTranctasUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTranctasValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTranctasSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTranctasUaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTranctasBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTranctasEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTranctasBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxTranctasCodigo ) + "'">>,"Ctarec" = <<"'" + this.FormatearTextoSql( lxTranctasCtarec ) + "'">>,"Ctatran" = <<"'" + this.FormatearTextoSql( lxTranctasCtatran ) + "'">>,"Numero" = <<lxTranctasNumero>>,"Ingreso" = <<"'" + this.ConvertirDateSql( lxTranctasIngreso ) + "'">>,"Fecrec" = <<"'" + this.ConvertirDateSql( lxTranctasFecrec ) + "'">>,"Fectran" = <<"'" + this.ConvertirDateSql( lxTranctasFectran ) + "'">>,"Descri" = <<"'" + this.FormatearTextoSql( lxTranctasDescri ) + "'">>,"Horatran" = <<"'" + this.FormatearTextoSql( lxTranctasHoratran ) + "'">>,"Horarec" = <<"'" + this.FormatearTextoSql( lxTranctasHorarec ) + "'">>,"Montorec" = <<lxTranctasMontorec>>,"Montotra" = <<lxTranctasMontotra>>,"Idtran" = <<"'" + this.FormatearTextoSql( lxTranctasIdtran ) + "'">>,"Idrec" = <<"'" + this.FormatearTextoSql( lxTranctasIdrec ) + "'">>,"Codtran" = <<"'" + this.FormatearTextoSql( lxTranctasCodtran ) + "'">>,"Codrec" = <<"'" + this.FormatearTextoSql( lxTranctasCodrec ) + "'">>,"Regtran" = <<"'" + this.FormatearTextoSql( lxTranctasRegtran ) + "'">>,"Regrec" = <<"'" + this.FormatearTextoSql( lxTranctasRegrec ) + "'">>,"Cotrec" = <<lxTranctasCotrec>>,"Cottra" = <<lxTranctasCottra>>,"Recpesos" = <<lxTranctasRecpesos>>,"Trapesos" = <<lxTranctasTrapesos>>,"Obs" = <<"'" + this.FormatearTextoSql( lxTranctasObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxTranctasCodigo ) + "'">> and  TRANCTAS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
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
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.TRANCTAS where " + this.ConvertirFuncionesSql( " TRANCTAS.CODIGO != ''" ) )
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
			Local lxTranctasCodigo
			lxTranctasCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion" from ZooLogic.TRANCTAS where "Codigo" = <<"'" + this.FormatearTextoSql( lxTranctasCodigo ) + "'">> and  TRANCTAS.CODIGO != ''
			endtext
			use in select('c_TRANSFERENCIAENTRECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSFERENCIAENTRECUENTAS', set( 'Datasession' ) )

			if reccount( 'c_TRANSFERENCIAENTRECUENTAS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxTranCtasNumero As Variant
			lxTranCtasNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion" from ZooLogic.TRANCTAS where  TRANCTAS.CODIGO != '' And Numero = <<lxTranCtasNumero>>
			endtext
			use in select('c_TRANSFERENCIAENTRECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSFERENCIAENTRECUENTAS', set( 'Datasession' ) )
			if reccount( 'c_TRANSFERENCIAENTRECUENTAS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTranctasCodigo as Variant
		llRetorno = .t.
		lxTranctasCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TRANCTAS where "Codigo" = <<"'" + this.FormatearTextoSql( lxTranctasCodigo ) + "'">> and  TRANCTAS.CODIGO != ''
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion" from ZooLogic.TRANCTAS where  TRANCTAS.CODIGO != '' order by Numero,Codigo
			endtext
			use in select('c_TRANSFERENCIAENTRECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSFERENCIAENTRECUENTAS', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion" from ZooLogic.TRANCTAS where  str( Numero, 10, 0) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TRANCTAS.CODIGO != '' order by Numero,Codigo
			endtext
			use in select('c_TRANSFERENCIAENTRECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSFERENCIAENTRECUENTAS', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion" from ZooLogic.TRANCTAS where  str( Numero, 10, 0) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TRANCTAS.CODIGO != '' order by Numero desc,Codigo desc
			endtext
			use in select('c_TRANSFERENCIAENTRECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSFERENCIAENTRECUENTAS', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion" from ZooLogic.TRANCTAS where  TRANCTAS.CODIGO != '' order by Numero desc,Codigo desc
			endtext
			use in select('c_TRANSFERENCIAENTRECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSFERENCIAENTRECUENTAS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Horaimpo,Horaexpo,Haltafw,Hmodifw,Smodifw,Vmodifw,Z" + ;
"adsfw,Umodifw,Valtafw,Saltafw,Ualtafw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Ctarec,Ctatran,Numero,Ingres" + ;
"o,Fecrec,Fectran,Descri,Horatran,Horarec,Montorec,Montotra,Idtran,Idrec,Codtran,Codrec,Regtran,Regre" + ;
"c,Cotrec,Cottra,Recpesos,Trapesos,Obs" + ;
" from ZooLogic.TRANCTAS where  TRANCTAS.CODIGO != '' and " + lcFiltro )
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
			local  lxTranctasFecexpo, lxTranctasFaltafw, lxTranctasFecimpo, lxTranctasFmodifw, lxTranctasFectrans, lxTranctasHoraimpo, lxTranctasHoraexpo, lxTranctasHaltafw, lxTranctasHmodifw, lxTranctasSmodifw, lxTranctasVmodifw, lxTranctasZadsfw, lxTranctasUmodifw, lxTranctasValtafw, lxTranctasSaltafw, lxTranctasUaltafw, lxTranctasBdmodifw, lxTranctasEsttrans, lxTranctasBdaltafw, lxTranctasCodigo, lxTranctasCtarec, lxTranctasCtatran, lxTranctasNumero, lxTranctasIngreso, lxTranctasFecrec, lxTranctasFectran, lxTranctasDescri, lxTranctasHoratran, lxTranctasHorarec, lxTranctasMontorec, lxTranctasMontotra, lxTranctasIdtran, lxTranctasIdrec, lxTranctasCodtran, lxTranctasCodrec, lxTranctasRegtran, lxTranctasRegrec, lxTranctasCotrec, lxTranctasCottra, lxTranctasRecpesos, lxTranctasTrapesos, lxTranctasObs
				lxTranctasFecexpo = ctod( '  /  /    ' )			lxTranctasFaltafw = ctod( '  /  /    ' )			lxTranctasFecimpo = ctod( '  /  /    ' )			lxTranctasFmodifw = ctod( '  /  /    ' )			lxTranctasFectrans = ctod( '  /  /    ' )			lxTranctasHoraimpo = []			lxTranctasHoraexpo = []			lxTranctasHaltafw = []			lxTranctasHmodifw = []			lxTranctasSmodifw = []			lxTranctasVmodifw = []			lxTranctasZadsfw = []			lxTranctasUmodifw = []			lxTranctasValtafw = []			lxTranctasSaltafw = []			lxTranctasUaltafw = []			lxTranctasBdmodifw = []			lxTranctasEsttrans = []			lxTranctasBdaltafw = []			lxTranctasCodigo = []			lxTranctasCtarec = []			lxTranctasCtatran = []			lxTranctasNumero = 0			lxTranctasIngreso = ctod( '  /  /    ' )			lxTranctasFecrec = ctod( '  /  /    ' )			lxTranctasFectran = ctod( '  /  /    ' )			lxTranctasDescri = []			lxTranctasHoratran = []			lxTranctasHorarec = []			lxTranctasMontorec = 0			lxTranctasMontotra = 0			lxTranctasIdtran = []			lxTranctasIdrec = []			lxTranctasCodtran = []			lxTranctasCodrec = []			lxTranctasRegtran = []			lxTranctasRegrec = []			lxTranctasCotrec = 0			lxTranctasCottra = 0			lxTranctasRecpesos = 0			lxTranctasTrapesos = 0			lxTranctasObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TRANCTAS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			.ActualizarNumeraciones()
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
			lcTabla = 'TRANCTAS' + '_' + tcCampo
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
		lcWhere = " Where  TRANCTAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TRANCTAS', '', tnTope )
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CUENTABANCARIARECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTAREC AS CUENTABANCARIARECIBE'
				Case lcAtributo == 'CUENTABANCARIATRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTATRAN AS CUENTABANCARIATRANSFIERE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHAINGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INGRESO AS FECHAINGRESO'
				Case lcAtributo == 'FECHARECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECREC AS FECHARECIBE'
				Case lcAtributo == 'FECHATRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRAN AS FECHATRANSFIERE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRIPCION'
				Case lcAtributo == 'HORATRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORATRAN AS HORATRANSFIERE'
				Case lcAtributo == 'HORARECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAREC AS HORARECIBE'
				Case lcAtributo == 'MONTORECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOREC AS MONTORECIBE'
				Case lcAtributo == 'MONTOTRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOTRA AS MONTOTRANSFIERE'
				Case lcAtributo == 'IDENTIFICADORTRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDTRAN AS IDENTIFICADORTRANSFIERE'
				Case lcAtributo == 'IDENTIFICADORRECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDREC AS IDENTIFICADORRECIBE'
				Case lcAtributo == 'CODIGOTRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTRAN AS CODIGOTRANSFIERE'
				Case lcAtributo == 'CODIGORECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODREC AS CODIGORECIBE'
				Case lcAtributo == 'IDREGISTROTRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGTRAN AS IDREGISTROTRANSFIERE'
				Case lcAtributo == 'IDREGISTRORECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGREC AS IDREGISTRORECIBE'
				Case lcAtributo == 'COTIZACIONMONEDARECIBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTREC AS COTIZACIONMONEDARECIBE'
				Case lcAtributo == 'COTIZACIONMONEDATRANSFIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTTRA AS COTIZACIONMONEDATRANSFIERE'
				Case lcAtributo == 'RECIBEALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPESOS AS RECIBEALCAMBIO'
				Case lcAtributo == 'TRANSFIEREALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRAPESOS AS TRANSFIEREALCAMBIO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIARECIBE'
				lcCampo = 'CTAREC'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIATRANSFIERE'
				lcCampo = 'CTATRAN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAINGRESO'
				lcCampo = 'INGRESO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHARECIBE'
				lcCampo = 'FECREC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFIERE'
				lcCampo = 'FECTRAN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'HORATRANSFIERE'
				lcCampo = 'HORATRAN'
			Case upper( alltrim( tcAtributo ) ) == 'HORARECIBE'
				lcCampo = 'HORAREC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTORECIBE'
				lcCampo = 'MONTOREC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOTRANSFIERE'
				lcCampo = 'MONTOTRA'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADORTRANSFIERE'
				lcCampo = 'IDTRAN'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADORRECIBE'
				lcCampo = 'IDREC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOTRANSFIERE'
				lcCampo = 'CODTRAN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGORECIBE'
				lcCampo = 'CODREC'
			Case upper( alltrim( tcAtributo ) ) == 'IDREGISTROTRANSFIERE'
				lcCampo = 'REGTRAN'
			Case upper( alltrim( tcAtributo ) ) == 'IDREGISTRORECIBE'
				lcCampo = 'REGREC'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACIONMONEDARECIBE'
				lcCampo = 'COTREC'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACIONMONEDATRANSFIERE'
				lcCampo = 'COTTRA'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBEALCAMBIO'
				lcCampo = 'RECPESOS'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSFIEREALCAMBIO'
				lcCampo = 'TRAPESOS'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTranctasFecexpo, lxTranctasFaltafw, lxTranctasFecimpo, lxTranctasFmodifw, lxTranctasFectrans, lxTranctasHoraimpo, lxTranctasHoraexpo, lxTranctasHaltafw, lxTranctasHmodifw, lxTranctasSmodifw, lxTranctasVmodifw, lxTranctasZadsfw, lxTranctasUmodifw, lxTranctasValtafw, lxTranctasSaltafw, lxTranctasUaltafw, lxTranctasBdmodifw, lxTranctasEsttrans, lxTranctasBdaltafw, lxTranctasCodigo, lxTranctasCtarec, lxTranctasCtatran, lxTranctasNumero, lxTranctasIngreso, lxTranctasFecrec, lxTranctasFectran, lxTranctasDescri, lxTranctasHoratran, lxTranctasHorarec, lxTranctasMontorec, lxTranctasMontotra, lxTranctasIdtran, lxTranctasIdrec, lxTranctasCodtran, lxTranctasCodrec, lxTranctasRegtran, lxTranctasRegrec, lxTranctasCotrec, lxTranctasCottra, lxTranctasRecpesos, lxTranctasTrapesos, lxTranctasObs
				lxTranctasFecexpo =  .Fechaexpo			lxTranctasFaltafw =  .Fechaaltafw			lxTranctasFecimpo =  .Fechaimpo			lxTranctasFmodifw =  .Fechamodificacionfw			lxTranctasFectrans =  .Fechatransferencia			lxTranctasHoraimpo =  .Horaimpo			lxTranctasHoraexpo =  .Horaexpo			lxTranctasHaltafw =  .Horaaltafw			lxTranctasHmodifw =  .Horamodificacionfw			lxTranctasSmodifw =  .Seriemodificacionfw			lxTranctasVmodifw =  .Versionmodificacionfw			lxTranctasZadsfw =  .Zadsfw			lxTranctasUmodifw =  .Usuariomodificacionfw			lxTranctasValtafw =  .Versionaltafw			lxTranctasSaltafw =  .Seriealtafw			lxTranctasUaltafw =  .Usuarioaltafw			lxTranctasBdmodifw =  .Basededatosmodificacionfw			lxTranctasEsttrans =  .Estadotransferencia			lxTranctasBdaltafw =  .Basededatosaltafw			lxTranctasCodigo =  .Codigo			lxTranctasCtarec =  upper( .CuentaBancariaRecibe_PK ) 			lxTranctasCtatran =  upper( .CuentaBancariaTransfiere_PK ) 			lxTranctasNumero =  .Numero			lxTranctasIngreso =  .Fechaingreso			lxTranctasFecrec =  .Fecharecibe			lxTranctasFectran =  .Fechatransfiere			lxTranctasDescri =  .Descripcion			lxTranctasHoratran =  .Horatransfiere			lxTranctasHorarec =  .Horarecibe			lxTranctasMontorec =  .Montorecibe			lxTranctasMontotra =  .Montotransfiere			lxTranctasIdtran =  .Identificadortransfiere			lxTranctasIdrec =  .Identificadorrecibe			lxTranctasCodtran =  .Codigotransfiere			lxTranctasCodrec =  .Codigorecibe			lxTranctasRegtran =  .Idregistrotransfiere			lxTranctasRegrec =  .Idregistrorecibe			lxTranctasCotrec =  .Cotizacionmonedarecibe			lxTranctasCottra =  .Cotizacionmonedatransfiere			lxTranctasRecpesos =  .Recibealcambio			lxTranctasTrapesos =  .Transfierealcambio			lxTranctasObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TRANCTAS ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Horaimpo","Horaexpo","Haltafw","Hmodifw","Smodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Ualtafw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Ctarec","Ctatran","Numero","Ingreso","Fecrec","Fectran","Descri","Horatran","Horarec","Montorec","Montotra","Idtran","Idrec","Codtran","Codrec","Regtran","Regrec","Cotrec","Cottra","Recpesos","Trapesos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxTranctasFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCtarec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCtatran ) + "'" >>, <<lxTranctasNumero >>, <<"'" + this.ConvertirDateSql( lxTranctasIngreso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFecrec ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTranctasFectran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasDescri ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHoratran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasHorarec ) + "'" >>, <<lxTranctasMontorec >>, <<lxTranctasMontotra >>, <<"'" + this.FormatearTextoSql( lxTranctasIdtran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasIdrec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCodtran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasCodrec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasRegtran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTranctasRegrec ) + "'" >>, <<lxTranctasCotrec >>, <<lxTranctasCottra >>, <<lxTranctasRecpesos >>, <<lxTranctasTrapesos >>, <<"'" + this.FormatearTextoSql( lxTranctasObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'TRANCTAS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTranctasFecexpo, lxTranctasFaltafw, lxTranctasFecimpo, lxTranctasFmodifw, lxTranctasFectrans, lxTranctasHoraimpo, lxTranctasHoraexpo, lxTranctasHaltafw, lxTranctasHmodifw, lxTranctasSmodifw, lxTranctasVmodifw, lxTranctasZadsfw, lxTranctasUmodifw, lxTranctasValtafw, lxTranctasSaltafw, lxTranctasUaltafw, lxTranctasBdmodifw, lxTranctasEsttrans, lxTranctasBdaltafw, lxTranctasCodigo, lxTranctasCtarec, lxTranctasCtatran, lxTranctasNumero, lxTranctasIngreso, lxTranctasFecrec, lxTranctasFectran, lxTranctasDescri, lxTranctasHoratran, lxTranctasHorarec, lxTranctasMontorec, lxTranctasMontotra, lxTranctasIdtran, lxTranctasIdrec, lxTranctasCodtran, lxTranctasCodrec, lxTranctasRegtran, lxTranctasRegrec, lxTranctasCotrec, lxTranctasCottra, lxTranctasRecpesos, lxTranctasTrapesos, lxTranctasObs
				lxTranctasFecexpo =  .Fechaexpo			lxTranctasFaltafw =  .Fechaaltafw			lxTranctasFecimpo =  .Fechaimpo			lxTranctasFmodifw =  .Fechamodificacionfw			lxTranctasFectrans =  .Fechatransferencia			lxTranctasHoraimpo =  .Horaimpo			lxTranctasHoraexpo =  .Horaexpo			lxTranctasHaltafw =  .Horaaltafw			lxTranctasHmodifw =  .Horamodificacionfw			lxTranctasSmodifw =  .Seriemodificacionfw			lxTranctasVmodifw =  .Versionmodificacionfw			lxTranctasZadsfw =  .Zadsfw			lxTranctasUmodifw =  .Usuariomodificacionfw			lxTranctasValtafw =  .Versionaltafw			lxTranctasSaltafw =  .Seriealtafw			lxTranctasUaltafw =  .Usuarioaltafw			lxTranctasBdmodifw =  .Basededatosmodificacionfw			lxTranctasEsttrans =  .Estadotransferencia			lxTranctasBdaltafw =  .Basededatosaltafw			lxTranctasCodigo =  .Codigo			lxTranctasCtarec =  upper( .CuentaBancariaRecibe_PK ) 			lxTranctasCtatran =  upper( .CuentaBancariaTransfiere_PK ) 			lxTranctasNumero =  .Numero			lxTranctasIngreso =  .Fechaingreso			lxTranctasFecrec =  .Fecharecibe			lxTranctasFectran =  .Fechatransfiere			lxTranctasDescri =  .Descripcion			lxTranctasHoratran =  .Horatransfiere			lxTranctasHorarec =  .Horarecibe			lxTranctasMontorec =  .Montorecibe			lxTranctasMontotra =  .Montotransfiere			lxTranctasIdtran =  .Identificadortransfiere			lxTranctasIdrec =  .Identificadorrecibe			lxTranctasCodtran =  .Codigotransfiere			lxTranctasCodrec =  .Codigorecibe			lxTranctasRegtran =  .Idregistrotransfiere			lxTranctasRegrec =  .Idregistrorecibe			lxTranctasCotrec =  .Cotizacionmonedarecibe			lxTranctasCottra =  .Cotizacionmonedatransfiere			lxTranctasRecpesos =  .Recibealcambio			lxTranctasTrapesos =  .Transfierealcambio			lxTranctasObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TRANCTAS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.TRANCTAS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTranctasFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTranctasFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTranctasFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTranctasFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTranctasFectrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTranctasHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTranctasHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTranctasHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTranctasHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTranctasSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTranctasVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTranctasZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTranctasUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTranctasValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTranctasSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTranctasUaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTranctasBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTranctasEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTranctasBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxTranctasCodigo ) + "'">>, "Ctarec" = <<"'" + this.FormatearTextoSql( lxTranctasCtarec ) + "'">>, "Ctatran" = <<"'" + this.FormatearTextoSql( lxTranctasCtatran ) + "'">>, "Numero" = <<lxTranctasNumero>>, "Ingreso" = <<"'" + this.ConvertirDateSql( lxTranctasIngreso ) + "'">>, "Fecrec" = <<"'" + this.ConvertirDateSql( lxTranctasFecrec ) + "'">>, "Fectran" = <<"'" + this.ConvertirDateSql( lxTranctasFectran ) + "'">>, "Descri" = <<"'" + this.FormatearTextoSql( lxTranctasDescri ) + "'">>, "Horatran" = <<"'" + this.FormatearTextoSql( lxTranctasHoratran ) + "'">>, "Horarec" = <<"'" + this.FormatearTextoSql( lxTranctasHorarec ) + "'">>, "Montorec" = <<lxTranctasMontorec>>, "Montotra" = <<lxTranctasMontotra>>, "Idtran" = <<"'" + this.FormatearTextoSql( lxTranctasIdtran ) + "'">>, "Idrec" = <<"'" + this.FormatearTextoSql( lxTranctasIdrec ) + "'">>, "Codtran" = <<"'" + this.FormatearTextoSql( lxTranctasCodtran ) + "'">>, "Codrec" = <<"'" + this.FormatearTextoSql( lxTranctasCodrec ) + "'">>, "Regtran" = <<"'" + this.FormatearTextoSql( lxTranctasRegtran ) + "'">>, "Regrec" = <<"'" + this.FormatearTextoSql( lxTranctasRegrec ) + "'">>, "Cotrec" = <<lxTranctasCotrec>>, "Cottra" = <<lxTranctasCottra>>, "Recpesos" = <<lxTranctasRecpesos>>, "Trapesos" = <<lxTranctasTrapesos>>, "Obs" = <<"'" + this.FormatearTextoSql( lxTranctasObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TRANCTAS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TRANCTAS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.TRANCTAS where ' + lcFiltro )
			loColeccion.cTabla = 'TRANCTAS' 
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
		
			.oCompCuentabancariatransferencia.lNuevo = .EsNuevo()
			.oCompCuentabancariatransferencia.lEdicion = .EsEdicion()
			.oCompCuentabancariatransferencia.lEliminar = .lEliminar
			.oCompCuentabancariatransferencia.lAnular = .lAnular
			loColSentencias = .oCompCuentabancariatransferencia.grabar()
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
			lcRetorno = [update ZooLogic.TRANCTAS set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  TRANCTAS.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TRANCTAS where  TRANCTAS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TRANCTAS where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  TRANCTAS.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarNumeraciones() as void
		local loError as exception
		dodefault()

		with this.oEntidad
			if .VerificarContexto( 'C' )
			else
				.lCargando = .t.
				try
					if empty( .oNumeraciones.ObtenerServicio('NUMERO') ) and iif( type( '.NUMERO' ) = 'C', int( val( .NUMERO ) ),.NUMERO ) = .oNumeraciones.UltimoNumero( 'NUMERO' )
						.oNumeraciones.Actualizar( 'NUMERO' )
					endif
				catch to loError
					goServicios.Errores.LevantarExcepcion( loError ) 
				finally
					.lCargando = .f.
				endtry
			endif
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function GrabarNumeraciones() as void

		dodefault()

		with this.oEntidad
			.lCargando = .t.
			Try
				If .VerificarContexto( 'C' )
				Else
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
				EndIf
			Catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			Finally
				.lCargando = .f.
			EndTry
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSFERENCIAENTRECUENTAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TRANCTAS Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TRANCTAS set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, CtaRec = ] + "'" + this.FormatearTextoSql( &lcCursor..CtaRec ) + "'"+ [, CtaTran = ] + "'" + this.FormatearTextoSql( &lcCursor..CtaTran ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Ingreso = ] + "'" + this.ConvertirDateSql( &lcCursor..Ingreso ) + "'"+ [, FecRec = ] + "'" + this.ConvertirDateSql( &lcCursor..FecRec ) + "'"+ [, FecTran = ] + "'" + this.ConvertirDateSql( &lcCursor..FecTran ) + "'"+ [, Descri = ] + "'" + this.FormatearTextoSql( &lcCursor..Descri ) + "'"+ [, HoraTran = ] + "'" + this.FormatearTextoSql( &lcCursor..HoraTran ) + "'"+ [, HoraRec = ] + "'" + this.FormatearTextoSql( &lcCursor..HoraRec ) + "'"+ [, MontoRec = ] + transform( &lcCursor..MontoRec )+ [, MontoTra = ] + transform( &lcCursor..MontoTra )+ [, IdTran = ] + "'" + this.FormatearTextoSql( &lcCursor..IdTran ) + "'"+ [, IdRec = ] + "'" + this.FormatearTextoSql( &lcCursor..IdRec ) + "'"+ [, CodTran = ] + "'" + this.FormatearTextoSql( &lcCursor..CodTran ) + "'"+ [, CodRec = ] + "'" + this.FormatearTextoSql( &lcCursor..CodRec ) + "'"+ [, RegTran = ] + "'" + this.FormatearTextoSql( &lcCursor..RegTran ) + "'"+ [, RegRec = ] + "'" + this.FormatearTextoSql( &lcCursor..RegRec ) + "'"+ [, CotRec = ] + transform( &lcCursor..CotRec )+ [, CotTra = ] + transform( &lcCursor..CotTra )+ [, RecPesos = ] + transform( &lcCursor..RecPesos )+ [, TraPesos = ] + transform( &lcCursor..TraPesos )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FECIMPO, FMODIFW, FECTRANS, HORAIMPO, HORAEXPO, HALTAFW, HMODIFW, SMODIFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, SALTAFW, UALTAFW, BDMODIFW, ESTTRANS, BDALTAFW, Codigo, CtaRec, CtaTran, Numero, Ingreso, FecRec, FecTran, Descri, HoraTran, HoraRec, MontoRec, MontoTra, IdTran, IdRec, CodTran, CodRec, RegTran, RegRec, CotRec, CotTra, RecPesos, TraPesos, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CtaRec ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CtaTran ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Ingreso ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecRec ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecTran ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descri ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HoraTran ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HoraRec ) + "'" + ',' + transform( &lcCursor..MontoRec ) + ',' + transform( &lcCursor..MontoTra ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdTran ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdRec ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodTran ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodRec ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..RegTran ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RegRec ) + "'" + ',' + transform( &lcCursor..CotRec ) + ',' + transform( &lcCursor..CotTra ) + ',' + transform( &lcCursor..RecPesos ) + ',' + transform( &lcCursor..TraPesos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.TRANCTAS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSFERENCIAENTRECUENTAS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'TRANSFERENCIAENTRECUENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TRANSFERENCIAENTRECUENTAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TRANSFERENCIAENTRECUENTAS_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TranCtas')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TRANSFERENCIAENTRECUENTAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TRANSFERENCIAENTRECUENTAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSFERENCIAENTRECUENTAS'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSFERENCIAENTRECUENTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  Ingreso   
		* Validar ANTERIORES A 1/1/1753  FecRec    
		* Validar ANTERIORES A 1/1/1753  FecTran   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TranCtas') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TranCtas
Create Table ZooLogic.TablaTrabajo_TranCtas ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"ctarec" char( 5 )  null, 
"ctatran" char( 5 )  null, 
"numero" numeric( 10, 0 )  null, 
"ingreso" datetime  null, 
"fecrec" datetime  null, 
"fectran" datetime  null, 
"descri" char( 100 )  null, 
"horatran" char( 5 )  null, 
"horarec" char( 5 )  null, 
"montorec" numeric( 15, 2 )  null, 
"montotra" numeric( 15, 2 )  null, 
"idtran" char( 30 )  null, 
"idrec" char( 30 )  null, 
"codtran" char( 30 )  null, 
"codrec" char( 30 )  null, 
"regtran" char( 20 )  null, 
"regrec" char( 20 )  null, 
"cotrec" numeric( 15, 5 )  null, 
"cottra" numeric( 15, 5 )  null, 
"recpesos" numeric( 15, 2 )  null, 
"trapesos" numeric( 15, 2 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TranCtas' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TranCtas' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSFERENCIAENTRECUENTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('ctarec','ctarec')
			.AgregarMapeo('ctatran','ctatran')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('ingreso','ingreso')
			.AgregarMapeo('fecrec','fecrec')
			.AgregarMapeo('fectran','fectran')
			.AgregarMapeo('descri','descri')
			.AgregarMapeo('horatran','horatran')
			.AgregarMapeo('horarec','horarec')
			.AgregarMapeo('montorec','montorec')
			.AgregarMapeo('montotra','montotra')
			.AgregarMapeo('idtran','idtran')
			.AgregarMapeo('idrec','idrec')
			.AgregarMapeo('codtran','codtran')
			.AgregarMapeo('codrec','codrec')
			.AgregarMapeo('regtran','regtran')
			.AgregarMapeo('regrec','regrec')
			.AgregarMapeo('cotrec','cotrec')
			.AgregarMapeo('cottra','cottra')
			.AgregarMapeo('recpesos','recpesos')
			.AgregarMapeo('trapesos','trapesos')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TranCtas'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CTAREC = isnull( d.CTAREC, t.CTAREC ),t.CTATRAN = isnull( d.CTATRAN, t.CTATRAN ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.INGRESO = isnull( d.INGRESO, t.INGRESO ),t.FECREC = isnull( d.FECREC, t.FECREC ),t.FECTRAN = isnull( d.FECTRAN, t.FECTRAN ),t.DESCRI = isnull( d.DESCRI, t.DESCRI ),t.HORATRAN = isnull( d.HORATRAN, t.HORATRAN ),t.HORAREC = isnull( d.HORAREC, t.HORAREC ),t.MONTOREC = isnull( d.MONTOREC, t.MONTOREC ),t.MONTOTRA = isnull( d.MONTOTRA, t.MONTOTRA ),t.IDTRAN = isnull( d.IDTRAN, t.IDTRAN ),t.IDREC = isnull( d.IDREC, t.IDREC ),t.CODTRAN = isnull( d.CODTRAN, t.CODTRAN ),t.CODREC = isnull( d.CODREC, t.CODREC ),t.REGTRAN = isnull( d.REGTRAN, t.REGTRAN ),t.REGREC = isnull( d.REGREC, t.REGREC ),t.COTREC = isnull( d.COTREC, t.COTREC ),t.COTTRA = isnull( d.COTTRA, t.COTTRA ),t.RECPESOS = isnull( d.RECPESOS, t.RECPESOS ),t.TRAPESOS = isnull( d.TRAPESOS, t.TRAPESOS ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.TRANCTAS t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.TRANCTAS(Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Horaimpo,Horaexpo,Haltafw,Hmodifw,Smodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Saltafw,Ualtafw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Ctarec,Ctatran,Numero,Ingreso,Fecrec,Fectran,Descri,Horatran,Horarec,Montorec,Montotra,Idtran,Idrec,Codtran,Codrec,Regtran,Regrec,Cotrec,Cottra,Recpesos,Trapesos,Obs)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.CTAREC,''),isnull( d.CTATRAN,''),isnull( d.NUMERO,0),isnull( d.INGRESO,''),isnull( d.FECREC,''),isnull( d.FECTRAN,''),isnull( d.DESCRI,''),isnull( d.HORATRAN,''),isnull( d.HORAREC,''),isnull( d.MONTOREC,0),isnull( d.MONTOTRA,0),isnull( d.IDTRAN,''),isnull( d.IDREC,''),isnull( d.CODTRAN,''),isnull( d.CODREC,''),isnull( d.REGTRAN,''),isnull( d.REGREC,''),isnull( d.COTREC,0),isnull( d.COTTRA,0),isnull( d.RECPESOS,0),isnull( d.TRAPESOS,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.TRANCTAS pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TranCtas') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TranCtas
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TRANSFERENCIAENTRECUENTAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_TRANSFERENCIAENTRECUENTAS.Horaimpo, [] )
					.Horaexpo = nvl( c_TRANSFERENCIAENTRECUENTAS.Horaexpo, [] )
					.Horaaltafw = nvl( c_TRANSFERENCIAENTRECUENTAS.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_TRANSFERENCIAENTRECUENTAS.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_TRANSFERENCIAENTRECUENTAS.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_TRANSFERENCIAENTRECUENTAS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_TRANSFERENCIAENTRECUENTAS.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_TRANSFERENCIAENTRECUENTAS.Versionaltafw, [] )
					.Seriealtafw = nvl( c_TRANSFERENCIAENTRECUENTAS.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_TRANSFERENCIAENTRECUENTAS.Usuarioaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_TRANSFERENCIAENTRECUENTAS.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_TRANSFERENCIAENTRECUENTAS.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_TRANSFERENCIAENTRECUENTAS.Basededatosaltafw, [] )
					.Codigo = nvl( c_TRANSFERENCIAENTRECUENTAS.Codigo, [] )
					.Cuentabancariarecibe_PK =  nvl( c_TRANSFERENCIAENTRECUENTAS.Cuentabancariarecibe, [] )
					.Cuentabancariatransfiere_PK =  nvl( c_TRANSFERENCIAENTRECUENTAS.Cuentabancariatransfiere, [] )
					.Numero = nvl( c_TRANSFERENCIAENTRECUENTAS.Numero, 0 )
					.Fechaingreso = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fechaingreso, ctod( '  /  /    ' ) ) )
					.Fecharecibe = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fecharecibe, ctod( '  /  /    ' ) ) )
					.Fechatransfiere = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSFERENCIAENTRECUENTAS.Fechatransfiere, ctod( '  /  /    ' ) ) )
					.Descripcion = nvl( c_TRANSFERENCIAENTRECUENTAS.Descripcion, [] )
					.Horatransfiere = nvl( c_TRANSFERENCIAENTRECUENTAS.Horatransfiere, [] )
					.Horarecibe = nvl( c_TRANSFERENCIAENTRECUENTAS.Horarecibe, [] )
					.Montorecibe = nvl( c_TRANSFERENCIAENTRECUENTAS.Montorecibe, 0 )
					.Montotransfiere = nvl( c_TRANSFERENCIAENTRECUENTAS.Montotransfiere, 0 )
					.Identificadortransfiere = nvl( c_TRANSFERENCIAENTRECUENTAS.Identificadortransfiere, [] )
					.Identificadorrecibe = nvl( c_TRANSFERENCIAENTRECUENTAS.Identificadorrecibe, [] )
					.Codigotransfiere = nvl( c_TRANSFERENCIAENTRECUENTAS.Codigotransfiere, [] )
					.Codigorecibe = nvl( c_TRANSFERENCIAENTRECUENTAS.Codigorecibe, [] )
					.Idregistrotransfiere = nvl( c_TRANSFERENCIAENTRECUENTAS.Idregistrotransfiere, [] )
					.Idregistrorecibe = nvl( c_TRANSFERENCIAENTRECUENTAS.Idregistrorecibe, [] )
					.Cotizacionmonedarecibe = nvl( c_TRANSFERENCIAENTRECUENTAS.Cotizacionmonedarecibe, 0 )
					.Cotizacionmonedatransfiere = nvl( c_TRANSFERENCIAENTRECUENTAS.Cotizacionmonedatransfiere, 0 )
					.Recibealcambio = nvl( c_TRANSFERENCIAENTRECUENTAS.Recibealcambio, 0 )
					.Transfierealcambio = nvl( c_TRANSFERENCIAENTRECUENTAS.Transfierealcambio, 0 )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
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
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_TRANSFERENCIAENTRECUENTAS.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_TRANSFERENCIAENTRECUENTAS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TRANCTAS' )
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
								from ZooLogic.TRANCTAS 
								Where   TRANCTAS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TRANCTAS", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Ctarec" as "Cuentabancariarecibe", "Ctatran" as "Cuentabancariatransfiere", "Numero" as "Numero", "Ingreso" as "Fechaingreso", "Fecrec" as "Fecharecibe", "Fectran" as "Fechatransfiere", "Descri" as "Descripcion", "Horatran" as "Horatransfiere", "Horarec" as "Horarecibe", "Montorec" as "Montorecibe", "Montotra" as "Montotransfiere", "Idtran" as "Identificadortransfiere", "Idrec" as "Identificadorrecibe", "Codtran" as "Codigotransfiere", "Codrec" as "Codigorecibe", "Regtran" as "Idregistrotransfiere", "Regrec" as "Idregistrorecibe", "Cotrec" as "Cotizacionmonedarecibe", "Cottra" as "Cotizacionmonedatransfiere", "Recpesos" as "Recibealcambio", "Trapesos" as "Transfierealcambio", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TRANCTAS 
								Where   TRANCTAS.CODIGO != ''
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
	Tabla = 'TRANCTAS'
	Filtro = " TRANCTAS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TRANCTAS.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "TranCtas.Numero"
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
										<xsd:maxLength value="250"/>
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
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHAEXPO                               " tabla="TRANCTAS       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHAALTAFW                             " tabla="TRANCTAS       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHAIMPO                               " tabla="TRANCTAS       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHAMODIFICACIONFW                     " tabla="TRANCTAS       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHATRANSFERENCIA                      " tabla="TRANCTAS       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="HORAIMPO                                " tabla="TRANCTAS       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="HORAEXPO                                " tabla="TRANCTAS       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="HORAALTAFW                              " tabla="TRANCTAS       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="HORAMODIFICACIONFW                      " tabla="TRANCTAS       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="SERIEMODIFICACIONFW                     " tabla="TRANCTAS       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="VERSIONMODIFICACIONFW                   " tabla="TRANCTAS       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="ZADSFW                                  " tabla="TRANCTAS       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="USUARIOMODIFICACIONFW                   " tabla="TRANCTAS       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="VERSIONALTAFW                           " tabla="TRANCTAS       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="SERIEALTAFW                             " tabla="TRANCTAS       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="USUARIOALTAFW                           " tabla="TRANCTAS       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TRANCTAS       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="ESTADOTRANSFERENCIA                     " tabla="TRANCTAS       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="BASEDEDATOSALTAFW                       " tabla="TRANCTAS       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="CODIGO                                  " tabla="TRANCTAS       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="CUENTABANCARIARECIBE                    " tabla="TRANCTAS       " campo="CTAREC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="24" etiqueta="Cuenta bancaria recepción                                                                                                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="CUENTABANCARIATRANSFIERE                " tabla="TRANCTAS       " campo="CTATRAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Cuenta bancaria transferencia                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="NUMERO                                  " tabla="TRANCTAS       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="CLAVEDEBUSQUEDA               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHAINGRESO                            " tabla="TRANCTAS       " campo="INGRESO   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="4" etiqueta="Fecha de ingreso                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="MONEDACUENTATRANSFIERE                  " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Moneda cuenta bancaria transferencia                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="CuentaBancariaTransfiere.MonedaCuenta_pk                                                                                                                                                                                                                      " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" left join CtaBan on TRANCTAS.CTATRAN = CtaBan.CBCod                                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="MONEDACUENTARECIBE                      " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Moneda cuenta bancaria recepción                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="CuentaBancariaRecibe.MonedaCuenta_pk                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" left join CtaBan on TRANCTAS.CTAREC = CtaBan.CBCod                                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHARECIBE                             " tabla="TRANCTAS       " campo="FECREC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="28" etiqueta="Fecha recepción                                                                                                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="FECHATRANSFIERE                         " tabla="TRANCTAS       " campo="FECTRAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Fecha transferencia                                                                                                                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="DESCRIPCION                             " tabla="TRANCTAS       " campo="DESCRI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Descripción                                                                                                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="HORATRANSFIERE                          " tabla="TRANCTAS       " campo="HORATRAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Hora transferencia                                                                                                                                                                                                                                        " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="HORARECIBE                              " tabla="TRANCTAS       " campo="HORAREC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Hora recepción                                                                                                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="MONTORECIBE                             " tabla="TRANCTAS       " campo="MONTOREC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="32" etiqueta="Monto recepción                                                                                                                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="MONTOTRANSFIERE                         " tabla="TRANCTAS       " campo="MONTOTRA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="16" etiqueta="Monto transferencia                                                                                                                                                                                                                                       " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="IDENTIFICADORTRANSFIERE                 " tabla="TRANCTAS       " campo="IDTRAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Identificador transferencia                                                                                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="IDENTIFICADORRECIBE                     " tabla="TRANCTAS       " campo="IDREC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Identificador recepción                                                                                                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="CODIGOTRANSFIERE                        " tabla="TRANCTAS       " campo="CODTRAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Código del banco transferencia                                                                                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="CODIGORECIBE                            " tabla="TRANCTAS       " campo="CODREC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="Código del banco recepción                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="IDREGISTROTRANSFIERE                    " tabla="TRANCTAS       " campo="REGTRAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Id registro transferencia                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="IDREGISTRORECIBE                        " tabla="TRANCTAS       " campo="REGREC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Id registro recepción                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="COTIZACIONMONEDARECIBE                  " tabla="TRANCTAS       " campo="COTREC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Cotización Recibe                                                                                                                                                                                                                                         " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="COTIZACIONMONEDATRANSFIERE              " tabla="TRANCTAS       " campo="COTTRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Cotización transfiere                                                                                                                                                                                                                                     " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="RECIBEALCAMBIO                          " tabla="TRANCTAS       " campo="RECPESOS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Importe recibe al cambio                                                                                                                                                                                                                                  " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="TRANSFIEREALCAMBIO                      " tabla="TRANCTAS       " campo="TRAPESOS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Importe transfiere al cambio                                                                                                                                                                                                                              " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSFERENCIAENTRECUENTAS               " atributo="OBSERVACION                             " tabla="TRANCTAS       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observación                                                                                                                                                                                                                                               " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="25" etiqueta="Detalle Cue.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On TRANCTAS.CTAREC = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Cue.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On TRANCTAS.CTATRAN = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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