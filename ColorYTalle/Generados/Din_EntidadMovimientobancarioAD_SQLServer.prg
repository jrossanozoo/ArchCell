
define class Din_EntidadMOVIMIENTOBANCARIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MOVIMIENTOBANCARIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [CuentaBancaria + str( Orden, 5, 0) + dtos( Fecha ) + Hora + Concepto + Referencia + str( Numero, 10, 0) + str( Importe, 15, 2)]
	cExpresionCCPorCampos = [#tabla#.CtaBanc + str( #tabla#.Orden, 5, 0) + dtos( #tabla#.Fecha ) + #tabla#.Hora + #tabla#.Concepto + #tabla#.Refe + str( #tabla#.Numero, 10, 0) + str( #tabla#.Importe, 15, 2)]
	cTagClaveCandidata = '_MBCCC'
	cTagClavePk = '_MBCPK'
	cTablaPrincipal = 'MOVBANC'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
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
			local  lxMovbancFectrans, lxMovbancFaltafw, lxMovbancFmodifw, lxMovbancFecimpo, lxMovbancFecexpo, lxMovbancFecha, lxMovbancHoraexpo, lxMovbancHoraimpo, lxMovbancHaltafw, lxMovbancSmodifw, lxMovbancVmodifw, lxMovbancZadsfw, lxMovbancValtafw, lxMovbancUmodifw, lxMovbancSaltafw, lxMovbancUaltafw, lxMovbancHmodifw, lxMovbancBdmodifw, lxMovbancEsttrans, lxMovbancBdaltafw, lxMovbancCodigo, lxMovbancHora, lxMovbancCtabanc, lxMovbancOrden, lxMovbancConcepto, lxMovbancRefe, lxMovbancDatad1, lxMovbancDatad2, lxMovbancDatad3, lxMovbancNumero, lxMovbancImporte, lxMovbancSaldo, lxMovbancObs
				lxMovbancFectrans =  .Fechatransferencia			lxMovbancFaltafw =  .Fechaaltafw			lxMovbancFmodifw =  .Fechamodificacionfw			lxMovbancFecimpo =  .Fechaimpo			lxMovbancFecexpo =  .Fechaexpo			lxMovbancFecha =  .Fecha			lxMovbancHoraexpo =  .Horaexpo			lxMovbancHoraimpo =  .Horaimpo			lxMovbancHaltafw =  .Horaaltafw			lxMovbancSmodifw =  .Seriemodificacionfw			lxMovbancVmodifw =  .Versionmodificacionfw			lxMovbancZadsfw =  .Zadsfw			lxMovbancValtafw =  .Versionaltafw			lxMovbancUmodifw =  .Usuariomodificacionfw			lxMovbancSaltafw =  .Seriealtafw			lxMovbancUaltafw =  .Usuarioaltafw			lxMovbancHmodifw =  .Horamodificacionfw			lxMovbancBdmodifw =  .Basededatosmodificacionfw			lxMovbancEsttrans =  .Estadotransferencia			lxMovbancBdaltafw =  .Basededatosaltafw			lxMovbancCodigo =  .Identificador			lxMovbancHora =  .Hora			lxMovbancCtabanc =  upper( .CuentaBancaria_PK ) 			lxMovbancOrden =  .Orden			lxMovbancConcepto =  upper( .Concepto_PK ) 			lxMovbancRefe =  .Referencia			lxMovbancDatad1 =  .Datoadicional1			lxMovbancDatad2 =  .Datoadicional2			lxMovbancDatad3 =  .Datoadicional3			lxMovbancNumero =  .Numero			lxMovbancImporte =  .Importe			lxMovbancSaldo =  .Saldo			lxMovbancObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMovbancCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MOVBANC ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Fecha","Horaexpo","Horaimpo","Haltafw","Smodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Ualtafw","Hmodifw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Hora","Ctabanc","Orden","Concepto","Refe","Datad1","Datad2","Datad3","Numero","Importe","Saldo","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxMovbancFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancCtabanc ) + "'" >>, <<lxMovbancOrden >>, <<"'" + this.FormatearTextoSql( lxMovbancConcepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancRefe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancDatad1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancDatad2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancDatad3 ) + "'" >>, <<lxMovbancNumero >>, <<lxMovbancImporte >>, <<lxMovbancSaldo >>, <<"'" + this.FormatearTextoSql( lxMovbancObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = lxValorClavePrimaria

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
			If this.ConsultarPorClaveCandidata()
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
			endif
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.IDENTIFICADOR
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxMovbancFectrans, lxMovbancFaltafw, lxMovbancFmodifw, lxMovbancFecimpo, lxMovbancFecexpo, lxMovbancFecha, lxMovbancHoraexpo, lxMovbancHoraimpo, lxMovbancHaltafw, lxMovbancSmodifw, lxMovbancVmodifw, lxMovbancZadsfw, lxMovbancValtafw, lxMovbancUmodifw, lxMovbancSaltafw, lxMovbancUaltafw, lxMovbancHmodifw, lxMovbancBdmodifw, lxMovbancEsttrans, lxMovbancBdaltafw, lxMovbancCodigo, lxMovbancHora, lxMovbancCtabanc, lxMovbancOrden, lxMovbancConcepto, lxMovbancRefe, lxMovbancDatad1, lxMovbancDatad2, lxMovbancDatad3, lxMovbancNumero, lxMovbancImporte, lxMovbancSaldo, lxMovbancObs
				lxMovbancFectrans =  .Fechatransferencia			lxMovbancFaltafw =  .Fechaaltafw			lxMovbancFmodifw =  .Fechamodificacionfw			lxMovbancFecimpo =  .Fechaimpo			lxMovbancFecexpo =  .Fechaexpo			lxMovbancFecha =  .Fecha			lxMovbancHoraexpo =  .Horaexpo			lxMovbancHoraimpo =  .Horaimpo			lxMovbancHaltafw =  .Horaaltafw			lxMovbancSmodifw =  .Seriemodificacionfw			lxMovbancVmodifw =  .Versionmodificacionfw			lxMovbancZadsfw =  .Zadsfw			lxMovbancValtafw =  .Versionaltafw			lxMovbancUmodifw =  .Usuariomodificacionfw			lxMovbancSaltafw =  .Seriealtafw			lxMovbancUaltafw =  .Usuarioaltafw			lxMovbancHmodifw =  .Horamodificacionfw			lxMovbancBdmodifw =  .Basededatosmodificacionfw			lxMovbancEsttrans =  .Estadotransferencia			lxMovbancBdaltafw =  .Basededatosaltafw			lxMovbancCodigo =  .Identificador			lxMovbancHora =  .Hora			lxMovbancCtabanc =  upper( .CuentaBancaria_PK ) 			lxMovbancOrden =  .Orden			lxMovbancConcepto =  upper( .Concepto_PK ) 			lxMovbancRefe =  .Referencia			lxMovbancDatad1 =  .Datoadicional1			lxMovbancDatad2 =  .Datoadicional2			lxMovbancDatad3 =  .Datoadicional3			lxMovbancNumero =  .Numero			lxMovbancImporte =  .Importe			lxMovbancSaldo =  .Saldo			lxMovbancObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.IDENTIFICADOR
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.MOVBANC set "Fectrans" = <<"'" + this.ConvertirDateSql( lxMovbancFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMovbancFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxMovbancFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxMovbancFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxMovbancFecexpo ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxMovbancFecha ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMovbancHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMovbancHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMovbancHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMovbancSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMovbancVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMovbancZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMovbancValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMovbancUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMovbancSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMovbancUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMovbancHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMovbancBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMovbancEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMovbancBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxMovbancCodigo ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxMovbancHora ) + "'">>,"Ctabanc" = <<"'" + this.FormatearTextoSql( lxMovbancCtabanc ) + "'">>,"Orden" = <<lxMovbancOrden>>,"Concepto" = <<"'" + this.FormatearTextoSql( lxMovbancConcepto ) + "'">>,"Refe" = <<"'" + this.FormatearTextoSql( lxMovbancRefe ) + "'">>,"Datad1" = <<"'" + this.FormatearTextoSql( lxMovbancDatad1 ) + "'">>,"Datad2" = <<"'" + this.FormatearTextoSql( lxMovbancDatad2 ) + "'">>,"Datad3" = <<"'" + this.FormatearTextoSql( lxMovbancDatad3 ) + "'">>,"Numero" = <<lxMovbancNumero>>,"Importe" = <<lxMovbancImporte>>,"Saldo" = <<lxMovbancSaldo>>,"Obs" = <<"'" + this.FormatearTextoSql( lxMovbancObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxMovbancCodigo ) + "'">> and  MOVBANC.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.MOVBANC where " + this.ConvertirFuncionesSql( " MOVBANC.CODIGO != ''" ) )
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
			Local lxMovbancCodigo
			lxMovbancCodigo = .Identificador

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion" from ZooLogic.MOVBANC where "Codigo" = <<"'" + this.FormatearTextoSql( lxMovbancCodigo ) + "'">> and  MOVBANC.CODIGO != ''
			endtext
			use in select('c_MOVIMIENTOBANCARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTOBANCARIO', set( 'Datasession' ) )

			if reccount( 'c_MOVIMIENTOBANCARIO' ) = 0
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
			Local lxMOVBANCCtaBanc As Variant, lxMOVBANCOrden As Variant, lxMOVBANCFecha As Variant, lxMOVBANCHora As Variant, lxMOVBANCConcepto As Variant, lxMOVBANCRefe As Variant, lxMOVBANCNumero As Variant, lxMOVBANCImporte As Variant
			lxMOVBANCCtaBanc = .CuentaBancaria_Pk
			lxMOVBANCOrden = .Orden
			lxMOVBANCFecha = .Fecha
			lxMOVBANCHora = .Hora
			lxMOVBANCConcepto = .Concepto_Pk
			lxMOVBANCRefe = .Referencia
			lxMOVBANCNumero = .Numero
			lxMOVBANCImporte = .Importe
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion" from ZooLogic.MOVBANC where  MOVBANC.CODIGO != '' And CtaBanc = <<"'" + this.FormatearTextoSql( lxMOVBANCCtaBanc ) + "'">> and Orden = <<lxMOVBANCOrden>> and Fecha = <<"'" + this.ConvertirDateSql( lxMOVBANCFecha ) + "'">> and Hora = <<"'" + this.FormatearTextoSql( lxMOVBANCHora ) + "'">> and Concepto = <<"'" + this.FormatearTextoSql( lxMOVBANCConcepto ) + "'">> and Refe = <<"'" + this.FormatearTextoSql( lxMOVBANCRefe ) + "'">> and Numero = <<lxMOVBANCNumero>> and Importe = <<lxMOVBANCImporte>>
			endtext
			use in select('c_MOVIMIENTOBANCARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTOBANCARIO', set( 'Datasession' ) )
			if reccount( 'c_MOVIMIENTOBANCARIO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMovbancCodigo as Variant
		llRetorno = .t.
		lxMovbancCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MOVBANC where "Codigo" = <<"'" + this.FormatearTextoSql( lxMovbancCodigo ) + "'">> and  MOVBANC.CODIGO != ''
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Hora + .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion" from ZooLogic.MOVBANC where  MOVBANC.CODIGO != '' order by Fecha,Hora,Codigo
			endtext
			use in select('c_MOVIMIENTOBANCARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTOBANCARIO', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Hora + .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion" from ZooLogic.MOVBANC where  funciones.dtos( Fecha ) + funciones.padr( Hora, 5, ' ' ) + funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MOVBANC.CODIGO != '' order by Fecha,Hora,Codigo
			endtext
			use in select('c_MOVIMIENTOBANCARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTOBANCARIO', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Hora + .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion" from ZooLogic.MOVBANC where  funciones.dtos( Fecha ) + funciones.padr( Hora, 5, ' ' ) + funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MOVBANC.CODIGO != '' order by Fecha desc,Hora desc,Codigo desc
			endtext
			use in select('c_MOVIMIENTOBANCARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTOBANCARIO', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Hora + .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion" from ZooLogic.MOVBANC where  MOVBANC.CODIGO != '' order by Fecha desc,Hora desc,Codigo desc
			endtext
			use in select('c_MOVIMIENTOBANCARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MOVIMIENTOBANCARIO', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Fecha,Horaexpo,Horaimpo,Haltafw,Smodifw,Vmodifw,Zad" + ;
"sfw,Valtafw,Umodifw,Saltafw,Ualtafw,Hmodifw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Hora,Ctabanc,Orden,Con" + ;
"cepto,Refe,Datad1,Datad2,Datad3,Numero,Importe,Saldo,Obs" + ;
" from ZooLogic.MOVBANC where  MOVBANC.CODIGO != '' and " + lcFiltro )
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
			local  lxMovbancFectrans, lxMovbancFaltafw, lxMovbancFmodifw, lxMovbancFecimpo, lxMovbancFecexpo, lxMovbancFecha, lxMovbancHoraexpo, lxMovbancHoraimpo, lxMovbancHaltafw, lxMovbancSmodifw, lxMovbancVmodifw, lxMovbancZadsfw, lxMovbancValtafw, lxMovbancUmodifw, lxMovbancSaltafw, lxMovbancUaltafw, lxMovbancHmodifw, lxMovbancBdmodifw, lxMovbancEsttrans, lxMovbancBdaltafw, lxMovbancCodigo, lxMovbancHora, lxMovbancCtabanc, lxMovbancOrden, lxMovbancConcepto, lxMovbancRefe, lxMovbancDatad1, lxMovbancDatad2, lxMovbancDatad3, lxMovbancNumero, lxMovbancImporte, lxMovbancSaldo, lxMovbancObs
				lxMovbancFectrans = ctod( '  /  /    ' )			lxMovbancFaltafw = ctod( '  /  /    ' )			lxMovbancFmodifw = ctod( '  /  /    ' )			lxMovbancFecimpo = ctod( '  /  /    ' )			lxMovbancFecexpo = ctod( '  /  /    ' )			lxMovbancFecha = ctod( '  /  /    ' )			lxMovbancHoraexpo = []			lxMovbancHoraimpo = []			lxMovbancHaltafw = []			lxMovbancSmodifw = []			lxMovbancVmodifw = []			lxMovbancZadsfw = []			lxMovbancValtafw = []			lxMovbancUmodifw = []			lxMovbancSaltafw = []			lxMovbancUaltafw = []			lxMovbancHmodifw = []			lxMovbancBdmodifw = []			lxMovbancEsttrans = []			lxMovbancBdaltafw = []			lxMovbancCodigo = []			lxMovbancHora = []			lxMovbancCtabanc = []			lxMovbancOrden = 0			lxMovbancConcepto = []			lxMovbancRefe = []			lxMovbancDatad1 = []			lxMovbancDatad2 = []			lxMovbancDatad3 = []			lxMovbancNumero = 0			lxMovbancImporte = 0			lxMovbancSaldo = 0			lxMovbancObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MOVBANC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MOVBANC' + '_' + tcCampo
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
		lcWhere = " Where  MOVBANC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MOVBANC', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS IDENTIFICADOR'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'CUENTABANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANC AS CUENTABANCARIA'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'REFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REFE AS REFERENCIA'
				Case lcAtributo == 'DATOADICIONAL1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DATAD1 AS DATOADICIONAL1'
				Case lcAtributo == 'DATOADICIONAL2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DATAD2 AS DATOADICIONAL2'
				Case lcAtributo == 'DATOADICIONAL3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DATAD3 AS DATOADICIONAL3'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'IMPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTE AS IMPORTE'
				Case lcAtributo == 'SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDO AS SALDO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIA'
				lcCampo = 'CTABANC'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'REFERENCIA'
				lcCampo = 'REFE'
			Case upper( alltrim( tcAtributo ) ) == 'DATOADICIONAL1'
				lcCampo = 'DATAD1'
			Case upper( alltrim( tcAtributo ) ) == 'DATOADICIONAL2'
				lcCampo = 'DATAD2'
			Case upper( alltrim( tcAtributo ) ) == 'DATOADICIONAL3'
				lcCampo = 'DATAD3'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTE'
				lcCampo = 'IMPORTE'
			Case upper( alltrim( tcAtributo ) ) == 'SALDO'
				lcCampo = 'SALDO'
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
			local  lxMovbancFectrans, lxMovbancFaltafw, lxMovbancFmodifw, lxMovbancFecimpo, lxMovbancFecexpo, lxMovbancFecha, lxMovbancHoraexpo, lxMovbancHoraimpo, lxMovbancHaltafw, lxMovbancSmodifw, lxMovbancVmodifw, lxMovbancZadsfw, lxMovbancValtafw, lxMovbancUmodifw, lxMovbancSaltafw, lxMovbancUaltafw, lxMovbancHmodifw, lxMovbancBdmodifw, lxMovbancEsttrans, lxMovbancBdaltafw, lxMovbancCodigo, lxMovbancHora, lxMovbancCtabanc, lxMovbancOrden, lxMovbancConcepto, lxMovbancRefe, lxMovbancDatad1, lxMovbancDatad2, lxMovbancDatad3, lxMovbancNumero, lxMovbancImporte, lxMovbancSaldo, lxMovbancObs
				lxMovbancFectrans =  .Fechatransferencia			lxMovbancFaltafw =  .Fechaaltafw			lxMovbancFmodifw =  .Fechamodificacionfw			lxMovbancFecimpo =  .Fechaimpo			lxMovbancFecexpo =  .Fechaexpo			lxMovbancFecha =  .Fecha			lxMovbancHoraexpo =  .Horaexpo			lxMovbancHoraimpo =  .Horaimpo			lxMovbancHaltafw =  .Horaaltafw			lxMovbancSmodifw =  .Seriemodificacionfw			lxMovbancVmodifw =  .Versionmodificacionfw			lxMovbancZadsfw =  .Zadsfw			lxMovbancValtafw =  .Versionaltafw			lxMovbancUmodifw =  .Usuariomodificacionfw			lxMovbancSaltafw =  .Seriealtafw			lxMovbancUaltafw =  .Usuarioaltafw			lxMovbancHmodifw =  .Horamodificacionfw			lxMovbancBdmodifw =  .Basededatosmodificacionfw			lxMovbancEsttrans =  .Estadotransferencia			lxMovbancBdaltafw =  .Basededatosaltafw			lxMovbancCodigo =  .Identificador			lxMovbancHora =  .Hora			lxMovbancCtabanc =  upper( .CuentaBancaria_PK ) 			lxMovbancOrden =  .Orden			lxMovbancConcepto =  upper( .Concepto_PK ) 			lxMovbancRefe =  .Referencia			lxMovbancDatad1 =  .Datoadicional1			lxMovbancDatad2 =  .Datoadicional2			lxMovbancDatad3 =  .Datoadicional3			lxMovbancNumero =  .Numero			lxMovbancImporte =  .Importe			lxMovbancSaldo =  .Saldo			lxMovbancObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MOVBANC ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Fecha","Horaexpo","Horaimpo","Haltafw","Smodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Ualtafw","Hmodifw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Hora","Ctabanc","Orden","Concepto","Refe","Datad1","Datad2","Datad3","Numero","Importe","Saldo","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxMovbancFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMovbancFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancCtabanc ) + "'" >>, <<lxMovbancOrden >>, <<"'" + this.FormatearTextoSql( lxMovbancConcepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancRefe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancDatad1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancDatad2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMovbancDatad3 ) + "'" >>, <<lxMovbancNumero >>, <<lxMovbancImporte >>, <<lxMovbancSaldo >>, <<"'" + this.FormatearTextoSql( lxMovbancObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'MOVBANC' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxMovbancFectrans, lxMovbancFaltafw, lxMovbancFmodifw, lxMovbancFecimpo, lxMovbancFecexpo, lxMovbancFecha, lxMovbancHoraexpo, lxMovbancHoraimpo, lxMovbancHaltafw, lxMovbancSmodifw, lxMovbancVmodifw, lxMovbancZadsfw, lxMovbancValtafw, lxMovbancUmodifw, lxMovbancSaltafw, lxMovbancUaltafw, lxMovbancHmodifw, lxMovbancBdmodifw, lxMovbancEsttrans, lxMovbancBdaltafw, lxMovbancCodigo, lxMovbancHora, lxMovbancCtabanc, lxMovbancOrden, lxMovbancConcepto, lxMovbancRefe, lxMovbancDatad1, lxMovbancDatad2, lxMovbancDatad3, lxMovbancNumero, lxMovbancImporte, lxMovbancSaldo, lxMovbancObs
				lxMovbancFectrans =  .Fechatransferencia			lxMovbancFaltafw =  .Fechaaltafw			lxMovbancFmodifw =  .Fechamodificacionfw			lxMovbancFecimpo =  .Fechaimpo			lxMovbancFecexpo =  .Fechaexpo			lxMovbancFecha =  .Fecha			lxMovbancHoraexpo =  .Horaexpo			lxMovbancHoraimpo =  .Horaimpo			lxMovbancHaltafw =  .Horaaltafw			lxMovbancSmodifw =  .Seriemodificacionfw			lxMovbancVmodifw =  .Versionmodificacionfw			lxMovbancZadsfw =  .Zadsfw			lxMovbancValtafw =  .Versionaltafw			lxMovbancUmodifw =  .Usuariomodificacionfw			lxMovbancSaltafw =  .Seriealtafw			lxMovbancUaltafw =  .Usuarioaltafw			lxMovbancHmodifw =  .Horamodificacionfw			lxMovbancBdmodifw =  .Basededatosmodificacionfw			lxMovbancEsttrans =  .Estadotransferencia			lxMovbancBdaltafw =  .Basededatosaltafw			lxMovbancCodigo =  .Identificador			lxMovbancHora =  .Hora			lxMovbancCtabanc =  upper( .CuentaBancaria_PK ) 			lxMovbancOrden =  .Orden			lxMovbancConcepto =  upper( .Concepto_PK ) 			lxMovbancRefe =  .Referencia			lxMovbancDatad1 =  .Datoadicional1			lxMovbancDatad2 =  .Datoadicional2			lxMovbancDatad3 =  .Datoadicional3			lxMovbancNumero =  .Numero			lxMovbancImporte =  .Importe			lxMovbancSaldo =  .Saldo			lxMovbancObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MOVBANC.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MOVBANC set "Fectrans" = <<"'" + this.ConvertirDateSql( lxMovbancFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMovbancFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMovbancFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMovbancFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMovbancFecexpo ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxMovbancFecha ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMovbancHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMovbancHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMovbancHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMovbancSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMovbancVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMovbancZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMovbancValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMovbancUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMovbancSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMovbancUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMovbancHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMovbancBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMovbancEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMovbancBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxMovbancCodigo ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxMovbancHora ) + "'">>, "Ctabanc" = <<"'" + this.FormatearTextoSql( lxMovbancCtabanc ) + "'">>, "Orden" = <<lxMovbancOrden>>, "Concepto" = <<"'" + this.FormatearTextoSql( lxMovbancConcepto ) + "'">>, "Refe" = <<"'" + this.FormatearTextoSql( lxMovbancRefe ) + "'">>, "Datad1" = <<"'" + this.FormatearTextoSql( lxMovbancDatad1 ) + "'">>, "Datad2" = <<"'" + this.FormatearTextoSql( lxMovbancDatad2 ) + "'">>, "Datad3" = <<"'" + this.FormatearTextoSql( lxMovbancDatad3 ) + "'">>, "Numero" = <<lxMovbancNumero>>, "Importe" = <<lxMovbancImporte>>, "Saldo" = <<lxMovbancSaldo>>, "Obs" = <<"'" + this.FormatearTextoSql( lxMovbancObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MOVBANC' 
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
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MOVBANC.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MOVBANC where ' + lcFiltro )
			loColeccion.cTabla = 'MOVBANC' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MOVBANC where  MOVBANC.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MOVBANC where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.IDENTIFICADOR ) + "'"+ " and  MOVBANC.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxMOVBANCFecha as variant, lxMOVBANCHora as variant, lxMOVBANCCtaBanc as variant, lxMOVBANCOrden as variant, lxMOVBANCConcepto as variant, lxMOVBANCRefe as variant, lxMOVBANCNumero as variant, lxMOVBANCImporte as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTOBANCARIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MOVBANC Where  CtaBanc = ] + "'" + this.FormatearTextoSql( &lcCursor..CtaBanc    ) + "'" + [ and Orden = ] + transform( &lcCursor..Orden      ) + [ and Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha      ) + "'" + [ and Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora       ) + "'" + [ and Concepto = ] + "'" + this.FormatearTextoSql( &lcCursor..Concepto   ) + "'" + [ and Refe = ] + "'" + this.FormatearTextoSql( &lcCursor..Refe       ) + "'" + [ and Numero = ] + transform( &lcCursor..Numero     ) + [ and Importe = ] + transform( &lcCursor..Importe    ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.MOVBANC set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, CtaBanc = ] + "'" + this.FormatearTextoSql( &lcCursor..CtaBanc ) + "'"+ [, Orden = ] + transform( &lcCursor..Orden )+ [, Concepto = ] + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'"+ [, Refe = ] + "'" + this.FormatearTextoSql( &lcCursor..Refe ) + "'"+ [, DatAd1 = ] + "'" + this.FormatearTextoSql( &lcCursor..DatAd1 ) + "'"+ [, DatAd2 = ] + "'" + this.FormatearTextoSql( &lcCursor..DatAd2 ) + "'"+ [, DatAd3 = ] + "'" + this.FormatearTextoSql( &lcCursor..DatAd3 ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Importe = ] + transform( &lcCursor..Importe )+ [, Saldo = ] + transform( &lcCursor..Saldo )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.MOVBANC Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FALTAFW, FMODIFW, FECIMPO, FECEXPO, Fecha, HORAEXPO, HORAIMPO, HALTAFW, SMODIFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SALTAFW, UALTAFW, HMODIFW, BDMODIFW, ESTTRANS, BDALTAFW, Codigo, Hora, CtaBanc, Orden, Concepto, Refe, DatAd1, DatAd2, DatAd3, Numero, Importe, Saldo, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CtaBanc ) + "'" + ',' + transform( &lcCursor..Orden ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Refe ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DatAd1 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DatAd2 ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DatAd3 ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + transform( &lcCursor..Importe ) + ',' + transform( &lcCursor..Saldo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.MOVBANC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTOBANCARIO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Cuenta bancaria: ' + transform( &tcCursor..CtaBanc    )
		lcRetorno = lcRetorno + ' - Orden: ' + transform( &tcCursor..Orden      )
		lcRetorno = lcRetorno + ' - Fecha de carga de operación: ' + transform( &tcCursor..Fecha      )
		lcRetorno = lcRetorno + ' - Hora: ' + transform( &tcCursor..Hora       )
		lcRetorno = lcRetorno + ' - Concepto: ' + transform( &tcCursor..Concepto   )
		lcRetorno = lcRetorno + ' - Referencia: ' + transform( &tcCursor..Refe       )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
		lcRetorno = lcRetorno + ' - Importe: ' + transform( &tcCursor..Importe    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'MOVIMIENTOBANCARIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MOVIMIENTOBANCARIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MOVIMIENTOBANCARIO_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MOVBANC')

				if this.oMensajesConexion.Count>0
					goServicios.Errores.LevantarExcepcion( this.ObtenerMensajesConexion() )
				endif

			enddo
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	protected function AplicarReglaDeNegocioTablaDeTrabajo( toConexion as Object ) As Void
		local llEjecutarRollback as Boolean, lcCursor as String, llNoVienePorDiseño as Boolean
		llEjecutarRollback = .F.
		try
			
			toConexion.EjecutarNonQuery( 'DISABLE TRIGGER ALL ON ZooLogic.TablaTrabajo_MOVBANC' )
			
			lcCursor = this.oentidad.cprefijoimportar + this.oentidad.cnombre
			this.AbrirCursores( PcXmlDatos, this.oEntidad.cPrefijoImportar )
			select (lcCursor)
			
			*** Valor sugerido Fecha
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "Fecha" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET Fecha = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Fecha ) = 1" )
			endif
			
			*** Valor sugerido Hora
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "Hora" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET Hora = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Hora ) = 1" )
			endif
			
			*** Valor sugerido Orden
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "Orden" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET Orden = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Orden ) = 1" )
			endif
			
			*** Valor sugerido NumeroCuenta
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "NumeroCuenta" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET  = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty(  ) = 1" )
			endif
			
			*** Valor sugerido Referencia
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "Referencia" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET Refe = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Refe ) = 1" )
			endif
			
			*** Valor sugerido DatoAdicional1
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "DatoAdicional1" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET DatAd1 = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( DatAd1 ) = 1" )
			endif
			
			*** Valor sugerido DatoAdicional2
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "DatoAdicional2" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET DatAd2 = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( DatAd2 ) = 1" )
			endif
			
			*** Valor sugerido DatoAdicional3
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "DatoAdicional3" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET DatAd3 = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( DatAd3 ) = 1" )
			endif
			
			*** Valor sugerido Numero
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "Numero" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET Numero = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Numero ) = 1" )
			endif
			
			*** Valor sugerido Importe
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "Importe" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET Importe = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Importe ) = 1" )
			endif
			
			*** Valor sugerido Saldo
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MOVIMIENTOBANCARIO", "", "Saldo" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_MOVBANC SET Saldo = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Saldo ) = 1" )
			endif
			
			use in ( lcCursor )
			
			lcInsertBaseLogueo = [INSERT INTO ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, EstadoDelSistema, Aplicacion, Version, Serie, Usuario, NombrePc, UsuarioPc, OrigenLogueo, Mensaje, Excepcion ) ]
			lcCamposLogueo = [Fecha, Nivel, Logger, Accion, BaseDeDatos, EstadoDelSistema, Aplicacion, Version, Serie, Usuario, NombrePc, UsuarioPc, OrigenLogueo, Excepcion, Mensaje]
			lcBD = goServicios.Seguridad.cBaseDeDatosSeleccionada
			lcApp = _Screen.Zoo.App.Nombre
			lcVersion = _Screen.Zoo.App.ObtenerVersion()
			lcSerie = _Screen.Zoo.App.cSerie
			lcUsuario = goServicios.Seguridad.cUsuarioLogueado
			lcValuesLogueoComunes = [SELECT GetDate(), 'INFO', '', 'Validacion IMPO','] + lcBD + [',0,'] + lcApp + [','] + lcVersion + [','] + lcSerie  + [','] + lcUsuario +[','NOMBREPC','USUARIOPC','ORIGENLOGUEO','',]
			
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_MOVBANC','ZooLogic.TablaTrabajoErroresValidacion_MOVBANC', 'FECTRANS', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_MOVBANC','ZooLogic.TablaTrabajoErroresValidacion_MOVBANC', 'FALTAFW', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_MOVBANC','ZooLogic.TablaTrabajoErroresValidacion_MOVBANC', 'FMODIFW', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_MOVBANC','ZooLogic.TablaTrabajoErroresValidacion_MOVBANC', 'FECIMPO', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_MOVBANC','ZooLogic.TablaTrabajoErroresValidacion_MOVBANC', 'FECEXPO', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fechacalendario( 'ZooLogic.TablaTrabajo_MOVBANC','ZooLogic.TablaTrabajoErroresValidacion_MOVBANC', 'Fecha', toConexion )

			* Fecha obligatorio
			lcWhere = 'WHERE Funciones.Empty( Fecha ) = 1 '
			lcExpresionMensaje  = [CASE WHEN Funciones.Empty( Fecha ) = 1 THEN 'Debe cargar el campo Fecha.' ELSE 'El dato buscado ' + RTRIM( CAST( Fecha AS VARCHAR(255) ) ) + ' de la entidad  no existe.' END]
			this.ValidacionBasicaObligatorioFKFecha( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) 

			* CuentaBancaria obligatorio y FK 
			lcWhere = 'WHERE Funciones.Empty( CtaBanc ) = 1 or CtaBanc NOT IN ( SELECT CBCod from ZooLogic.CtaBan )'
			lcExpresionMensaje  = [CASE WHEN Funciones.Empty( CtaBanc ) = 1 THEN 'Debe cargar el campo CuentaBancaria.' ELSE 'El dato buscado ' + RTRIM( CAST( CtaBanc AS VARCHAR(255) ) ) + ' de la entidad CUENTABANCARIA no existe.' END]
			this.ValidacionBasicaObligatorioFKCuentaBancaria( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) 

			* Importe obligatorio
			lcWhere = 'WHERE Funciones.Empty( Importe ) = 1 '
			lcExpresionMensaje  = [CASE WHEN Funciones.Empty( Importe ) = 1 THEN 'Debe cargar el campo Importe.' ELSE 'El dato buscado ' + RTRIM( CAST( Importe AS VARCHAR(255) ) ) + ' de la entidad  no existe.' END]
			this.ValidacionBasicaObligatorioFKImporte( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) 

			* Concepto FK 
			lcWhere = 'WHERE Funciones.Empty( Concepto ) = 0 AND  Concepto NOT IN ( SELECT Codigo FROM ZooLogic.ConEntFin )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Concepto AS VARCHAR(255) ) ) + ' de la entidad CONCEPTOENTIDADFINANCIERA no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_MOVBANC ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
			
			this.oEntidad.EjecutarReglaDeNegocioPersonalizadaImportacion( toConexion )
			toConexion.EjecutarNonQuery( 'ENABLE TRIGGER ALL ON ZooLogic.TablaTrabajo_MOVBANC' )
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasicaObligatorioFKFecha( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) as void
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_MOVBANC ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
		toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasicaObligatorioFKCuentaBancaria( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) as void
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_MOVBANC ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
		toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasicaObligatorioFKImporte( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) as void
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_MOVBANC ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
		toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_MOVBANC ] + lcWhere )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	*--------------------------------------------------------------------------------------------------------
	protected function ValidarDatosAImportar() as boolean
		local lcCursor as String, llRetorno as boolean, lxVar as Variant, llCondicion as boolean
		lcCursor = This.oEntidad.cPrefijoImportar + 'MOVIMIENTOBANCARIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..CtaBanc ) or isnull( &lcCursor..Orden ) or isnull( &lcCursor..Fecha ) or isnull( &lcCursor..Hora ) or isnull( &lcCursor..Concepto ) or isnull( &lcCursor..Refe ) or isnull( &lcCursor..Numero ) or isnull( &lcCursor..Importe )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MOVIMIENTOBANCARIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTOBANCARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,CtaBanc + str( Orden, 5, 0) + dtos( Fecha ) + Hora + Concepto + Refe + str( Numero, 10, 0) + str( Importe, 15, 2) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CtaBanc + str( Orden, 5, 0) + dtos( Fecha ) + Hora + Concepto + Refe + str( Numero, 10, 0) + str( Importe, 15, 2), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTOBANCARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MOVBANC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MOVBANC
Create Table ZooLogic.TablaTrabajo_MOVBANC ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fecha" datetime  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 20 )  null, 
"hora" char( 5 )  null, 
"ctabanc" char( 5 )  null, 
"orden" numeric( 5, 0 )  null, 
"concepto" char( 10 )  null, 
"refe" char( 100 )  null, 
"datad1" char( 50 )  null, 
"datad2" char( 50 )  null, 
"datad3" char( 50 )  null, 
"numero" numeric( 10, 0 )  null, 
"importe" numeric( 15, 2 )  null, 
"saldo" numeric( 15, 2 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MOVBANC' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MOVBANC' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearTablaDeTrabajoDetalles( toConexion as Object ) as void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MOVIMIENTOBANCARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('ctabanc','ctabanc')
			.AgregarMapeo('orden','orden')
			.AgregarMapeo('concepto','concepto')
			.AgregarMapeo('refe','refe')
			.AgregarMapeo('datad1','datad1')
			.AgregarMapeo('datad2','datad2')
			.AgregarMapeo('datad3','datad3')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('importe','importe')
			.AgregarMapeo('saldo','saldo')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MOVBANC'
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
	protected function CargarTablaDeTrabajoDetalles( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.HORA = isnull( d.HORA, t.HORA ),t.CTABANC = isnull( d.CTABANC, t.CTABANC ),t.ORDEN = isnull( d.ORDEN, t.ORDEN ),t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),t.REFE = isnull( d.REFE, t.REFE ),t.DATAD1 = isnull( d.DATAD1, t.DATAD1 ),t.DATAD2 = isnull( d.DATAD2, t.DATAD2 ),t.DATAD3 = isnull( d.DATAD3, t.DATAD3 ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.IMPORTE = isnull( d.IMPORTE, t.IMPORTE ),t.SALDO = isnull( d.SALDO, t.SALDO ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.MOVBANC t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.CtaBanc = d.CtaBanc
							 and  t.Orden = d.Orden
							 and  t.Fecha = d.Fecha
							 and  t.Hora = d.Hora
							 and  t.Concepto = d.Concepto
							 and  t.Refe = d.Refe
							 and  t.Numero = d.Numero
							 and  t.Importe = d.Importe
				-- Fin Updates
				insert into ZooLogic.MOVBANC(Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Fecha,Horaexpo,Horaimpo,Haltafw,Smodifw,Vmodifw,Zadsfw,Valtafw,Umodifw,Saltafw,Ualtafw,Hmodifw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Hora,Ctabanc,Orden,Concepto,Refe,Datad1,Datad2,Datad3,Numero,Importe,Saldo,Obs)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FECHA,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.HORA,''),isnull( d.CTABANC,''),isnull( d.ORDEN,0),isnull( d.CONCEPTO,''),isnull( d.REFE,''),isnull( d.DATAD1,''),isnull( d.DATAD2,''),isnull( d.DATAD3,''),isnull( d.NUMERO,0),isnull( d.IMPORTE,0),isnull( d.SALDO,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.MOVBANC pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.MOVBANC cc 
							 on  d.CtaBanc = cc.CtaBanc
							 and  d.Orden = cc.Orden
							 and  d.Fecha = cc.Fecha
							 and  d.Hora = cc.Hora
							 and  d.Concepto = cc.Concepto
							 and  d.Refe = cc.Refe
							 and  d.Numero = cc.Numero
							 and  d.Importe = cc.Importe
						Where pk.Codigo Is Null 
							 and cc.CtaBanc Is Null 
							 and cc.Orden Is Null 
							 and cc.Fecha Is Null 
							 and cc.Hora Is Null 
							 and cc.Concepto Is Null 
							 and cc.Refe Is Null 
							 and cc.Numero Is Null 
							 and cc.Importe Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CUENTA BANCARIA ' + cast( d.CtaBanc as Varchar(5) ) + ', ORDEN ' + cast( d.Orden as Varchar(5) ) + ', FECHA DE CARGA DE OPERACIÓN ' + cast( d.Fecha as Varchar(8) ) + ', HORA ' + cast( d.Hora as Varchar(5) ) + ', CONCEPTO ' + cast( d.Concepto as Varchar(10) ) + ', REFERENCIA ' + cast( d.Refe as Varchar(100) ) + ', NÚMERO ' + cast( d.Numero as Varchar(10) ) + ', IMPORTE ' + cast( d.Importe as Varchar(15) ) + '','La clave principal no es la esperada'
					from ZooLogic.MOVBANC t inner join deleted d 
							on   t.CtaBanc = d.CtaBanc
							 and  t.Orden = d.Orden
							 and  t.Fecha = d.Fecha
							 and  t.Hora = d.Hora
							 and  t.Concepto = d.Concepto
							 and  t.Refe = d.Refe
							 and  t.Numero = d.Numero
							 and  t.Importe = d.Importe
						left join deleted h 
							 on t.Codigo = h.Codigo
							 where h.Codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CUENTA BANCARIA ' + cast( d.CtaBanc as Varchar(5) ) + ', ORDEN ' + cast( d.Orden as Varchar(5) ) + ', FECHA DE CARGA DE OPERACIÓN ' + cast( d.Fecha as Varchar(8) ) + ', HORA ' + cast( d.Hora as Varchar(5) ) + ', CONCEPTO ' + cast( d.Concepto as Varchar(10) ) + ', REFERENCIA ' + cast( d.Refe as Varchar(100) ) + ', NÚMERO ' + cast( d.Numero as Varchar(10) ) + ', IMPORTE ' + cast( d.Importe as Varchar(15) ) + '','La clave principal a importar ya existe'
					from ZooLogic.MOVBANC t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.CtaBanc = h.CtaBanc
							 and   t.Orden = h.Orden
							 and   t.Fecha = h.Fecha
							 and   t.Hora = h.Hora
							 and   t.Concepto = h.Concepto
							 and   t.Refe = h.Refe
							 and   t.Numero = h.Numero
							 and   t.Importe = h.Importe
							where   h.CtaBanc is null 
							 and   h.Orden is null 
							 and   h.Fecha is null 
							 and   h.Hora is null 
							 and   h.Concepto is null 
							 and   h.Refe is null 
							 and   h.Numero is null 
							 and   h.Importe is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MOVBANC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MOVBANC
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MOVIMIENTOBANCARIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTOBANCARIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTOBANCARIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTOBANCARIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTOBANCARIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTOBANCARIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_MOVIMIENTOBANCARIO.Fecha, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_MOVIMIENTOBANCARIO.Horaexpo, [] )
					.Horaimpo = nvl( c_MOVIMIENTOBANCARIO.Horaimpo, [] )
					.Horaaltafw = nvl( c_MOVIMIENTOBANCARIO.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_MOVIMIENTOBANCARIO.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_MOVIMIENTOBANCARIO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_MOVIMIENTOBANCARIO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_MOVIMIENTOBANCARIO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_MOVIMIENTOBANCARIO.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_MOVIMIENTOBANCARIO.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_MOVIMIENTOBANCARIO.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_MOVIMIENTOBANCARIO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_MOVIMIENTOBANCARIO.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_MOVIMIENTOBANCARIO.Basededatosaltafw, [] )
					.Identificador = nvl( c_MOVIMIENTOBANCARIO.Identificador, [] )
					.Hora = nvl( c_MOVIMIENTOBANCARIO.Hora, [] )
					.Cuentabancaria_PK =  nvl( c_MOVIMIENTOBANCARIO.Cuentabancaria, [] )
					.Orden = nvl( c_MOVIMIENTOBANCARIO.Orden, 0 )
					.Concepto_PK =  nvl( c_MOVIMIENTOBANCARIO.Concepto, [] )
					.Referencia = nvl( c_MOVIMIENTOBANCARIO.Referencia, [] )
					.Datoadicional1 = nvl( c_MOVIMIENTOBANCARIO.Datoadicional1, [] )
					.Datoadicional2 = nvl( c_MOVIMIENTOBANCARIO.Datoadicional2, [] )
					.Datoadicional3 = nvl( c_MOVIMIENTOBANCARIO.Datoadicional3, [] )
					.Numero = nvl( c_MOVIMIENTOBANCARIO.Numero, 0 )
					.Importe = nvl( c_MOVIMIENTOBANCARIO.Importe, 0 )
					.Saldo = nvl( c_MOVIMIENTOBANCARIO.Saldo, 0 )
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
			lxRetorno = c_MOVIMIENTOBANCARIO.IDENTIFICADOR
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
		return c_MOVIMIENTOBANCARIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MOVBANC' )
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
								from ZooLogic.MOVBANC 
								Where   MOVBANC.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MOVBANC", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Identificador", "Hora" as "Hora", "Ctabanc" as "Cuentabancaria", "Orden" as "Orden", "Concepto" as "Concepto", "Refe" as "Referencia", "Datad1" as "Datoadicional1", "Datad2" as "Datoadicional2", "Datad3" as "Datoadicional3", "Numero" as "Numero", "Importe" as "Importe", "Saldo" as "Saldo", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MOVBANC 
								Where   MOVBANC.CODIGO != ''
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
	Tabla = 'MOVBANC'
	Filtro = " MOVBANC.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MOVBANC.CODIGO != ''"
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
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="FECHATRANSFERENCIA                      " tabla="MOVBANC        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="FECHAALTAFW                             " tabla="MOVBANC        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="FECHAMODIFICACIONFW                     " tabla="MOVBANC        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="FECHAIMPO                               " tabla="MOVBANC        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="FECHAEXPO                               " tabla="MOVBANC        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="FECHA                                   " tabla="MOVBANC        " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Fecha de carga de operación                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="HORAEXPO                                " tabla="MOVBANC        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="HORAIMPO                                " tabla="MOVBANC        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="HORAALTAFW                              " tabla="MOVBANC        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="SERIEMODIFICACIONFW                     " tabla="MOVBANC        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="VERSIONMODIFICACIONFW                   " tabla="MOVBANC        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="ZADSFW                                  " tabla="MOVBANC        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="VERSIONALTAFW                           " tabla="MOVBANC        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="USUARIOMODIFICACIONFW                   " tabla="MOVBANC        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="SERIEALTAFW                             " tabla="MOVBANC        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="USUARIOALTAFW                           " tabla="MOVBANC        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="HORAMODIFICACIONFW                      " tabla="MOVBANC        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MOVBANC        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="ESTADOTRANSFERENCIA                     " tabla="MOVBANC        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="BASEDEDATOSALTAFW                       " tabla="MOVBANC        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="IDENTIFICADOR                           " tabla="MOVBANC        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="HORA                                    " tabla="MOVBANC        " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="CUENTABANCARIA                          " tabla="MOVBANC        " campo="CTABANC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Cuenta bancaria                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="ORDEN                                   " tabla="MOVBANC        " campo="ORDEN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Orden                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="CONCEPTO                                " tabla="MOVBANC        " campo="CONCEPTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOENTIDADFINANCIERA               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Concepto                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="NUMEROCUENTA                            " tabla="CTABAN         " campo="CBNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número de cuenta bancaria                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="CuentaBancaria.Numero                                                                                                                                                                                                                                         " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" left join CtaBan on MOVBANC.CTABANC = CtaBan.CBCod                                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="REFERENCIA                              " tabla="MOVBANC        " campo="REFE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Referencia                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="6" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="DATOADICIONAL1                          " tabla="MOVBANC        " campo="DATAD1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Información adicional 1                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="MONEDA                                  " tabla="CTABAN         " campo="CBMONEDA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="CuentaBancaria.MonedaCuenta                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" left join CtaBan on MOVBANC.CTABANC = CtaBan.CBCod                                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="DATOADICIONAL2                          " tabla="MOVBANC        " campo="DATAD2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Información adicional 2                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="DATOADICIONAL3                          " tabla="MOVBANC        " campo="DATAD3    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Información adicional 3                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="NUMERO                                  " tabla="MOVBANC        " campo="NUMERO    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="7" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="IMPORTE                                 " tabla="MOVBANC        " campo="IMPORTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="28" etiqueta="Importe                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="8" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="SALDO                                   " tabla="MOVBANC        " campo="SALDO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Saldo                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOVIMIENTOBANCARIO                      " atributo="OBSERVACION                             " tabla="MOVBANC        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On MOVBANC.CTABANC = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOENTIDADFINANCIERA               " atributo="CONCEPTO                                " tabla="CONENTFIN      " campo="CONCEPTO  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Con.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONENTFIN On MOVBANC.CONCEPTO = CONENTFIN.Codigo And  CONENTFIN.CODIGO != ''                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CTABAN.CBMONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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