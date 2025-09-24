
define class Din_EntidadERRORESCFIBM4610KC4AD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ERRORESCFIBM4610KC4'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_KC4PK'
	cTablaPrincipal = 'IBM4610KC4'
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
			local  lxIbm4610kc4Fecexpo, lxIbm4610kc4Fectrans, lxIbm4610kc4Fmodifw, lxIbm4610kc4Faltafw, lxIbm4610kc4Fecimpo, lxIbm4610kc4Cdet, lxIbm4610kc4Cresp, lxIbm4610kc4Cobsi, lxIbm4610kc4Cdeti, lxIbm4610kc4Cobs, lxIbm4610kc4Crespi, lxIbm4610kc4Cexcep, lxIbm4610kc4Bloqreg, lxIbm4610kc4Ualtafw, lxIbm4610kc4Umodifw, lxIbm4610kc4Zadsfw, lxIbm4610kc4Valtafw, lxIbm4610kc4Vmodifw, lxIbm4610kc4Smodifw, lxIbm4610kc4Haltafw, lxIbm4610kc4Saltafw, lxIbm4610kc4Esttrans, lxIbm4610kc4Bdmodifw, lxIbm4610kc4Horaexpo, lxIbm4610kc4Hmodifw, lxIbm4610kc4Bdaltafw, lxIbm4610kc4Horaimpo, lxIbm4610kc4Ccod
				lxIbm4610kc4Fecexpo =  .Fechaexpo			lxIbm4610kc4Fectrans =  .Fechatransferencia			lxIbm4610kc4Fmodifw =  .Fechamodificacionfw			lxIbm4610kc4Faltafw =  .Fechaaltafw			lxIbm4610kc4Fecimpo =  .Fechaimpo			lxIbm4610kc4Cdet =  .Detalle			lxIbm4610kc4Cresp =  .Respuesta			lxIbm4610kc4Cobsi =  .Observacioneningles			lxIbm4610kc4Cdeti =  .Detalleeningles			lxIbm4610kc4Cobs =  .Observacion			lxIbm4610kc4Crespi =  .Respuestaeningles			lxIbm4610kc4Cexcep =  .Lanzaexcepcion			lxIbm4610kc4Bloqreg =  .Bloquearregistro			lxIbm4610kc4Ualtafw =  .Usuarioaltafw			lxIbm4610kc4Umodifw =  .Usuariomodificacionfw			lxIbm4610kc4Zadsfw =  .Zadsfw			lxIbm4610kc4Valtafw =  .Versionaltafw			lxIbm4610kc4Vmodifw =  .Versionmodificacionfw			lxIbm4610kc4Smodifw =  .Seriemodificacionfw			lxIbm4610kc4Haltafw =  .Horaaltafw			lxIbm4610kc4Saltafw =  .Seriealtafw			lxIbm4610kc4Esttrans =  .Estadotransferencia			lxIbm4610kc4Bdmodifw =  .Basededatosmodificacionfw			lxIbm4610kc4Horaexpo =  .Horaexpo			lxIbm4610kc4Hmodifw =  .Horamodificacionfw			lxIbm4610kc4Bdaltafw =  .Basededatosaltafw			lxIbm4610kc4Horaimpo =  .Horaimpo			lxIbm4610kc4Ccod =  .Codigo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxIbm4610kc4Ccod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IBM4610KC4 ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Cdet","Cresp","Cobsi","Cdeti","Cobs","Crespi","Cexcep","Bloqreg","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Smodifw","Haltafw","Saltafw","Esttrans","Bdmodifw","Horaexpo","Hmodifw","Bdaltafw","Horaimpo","Ccod" ) values ( <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Faltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cresp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobsi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdeti ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Crespi ) + "'" >>, <<iif( lxIbm4610kc4Cexcep, 1, 0 ) >>, <<iif( lxIbm4610kc4Bloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ualtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Umodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Zadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Valtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Vmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Smodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Haltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Saltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Esttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Hmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ccod ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
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
			local  lxIbm4610kc4Fecexpo, lxIbm4610kc4Fectrans, lxIbm4610kc4Fmodifw, lxIbm4610kc4Faltafw, lxIbm4610kc4Fecimpo, lxIbm4610kc4Cdet, lxIbm4610kc4Cresp, lxIbm4610kc4Cobsi, lxIbm4610kc4Cdeti, lxIbm4610kc4Cobs, lxIbm4610kc4Crespi, lxIbm4610kc4Cexcep, lxIbm4610kc4Bloqreg, lxIbm4610kc4Ualtafw, lxIbm4610kc4Umodifw, lxIbm4610kc4Zadsfw, lxIbm4610kc4Valtafw, lxIbm4610kc4Vmodifw, lxIbm4610kc4Smodifw, lxIbm4610kc4Haltafw, lxIbm4610kc4Saltafw, lxIbm4610kc4Esttrans, lxIbm4610kc4Bdmodifw, lxIbm4610kc4Horaexpo, lxIbm4610kc4Hmodifw, lxIbm4610kc4Bdaltafw, lxIbm4610kc4Horaimpo, lxIbm4610kc4Ccod
				lxIbm4610kc4Fecexpo =  .Fechaexpo			lxIbm4610kc4Fectrans =  .Fechatransferencia			lxIbm4610kc4Fmodifw =  .Fechamodificacionfw			lxIbm4610kc4Faltafw =  .Fechaaltafw			lxIbm4610kc4Fecimpo =  .Fechaimpo			lxIbm4610kc4Cdet =  .Detalle			lxIbm4610kc4Cresp =  .Respuesta			lxIbm4610kc4Cobsi =  .Observacioneningles			lxIbm4610kc4Cdeti =  .Detalleeningles			lxIbm4610kc4Cobs =  .Observacion			lxIbm4610kc4Crespi =  .Respuestaeningles			lxIbm4610kc4Cexcep =  .Lanzaexcepcion			lxIbm4610kc4Bloqreg =  .Bloquearregistro			lxIbm4610kc4Ualtafw =  .Usuarioaltafw			lxIbm4610kc4Umodifw =  .Usuariomodificacionfw			lxIbm4610kc4Zadsfw =  .Zadsfw			lxIbm4610kc4Valtafw =  .Versionaltafw			lxIbm4610kc4Vmodifw =  .Versionmodificacionfw			lxIbm4610kc4Smodifw =  .Seriemodificacionfw			lxIbm4610kc4Haltafw =  .Horaaltafw			lxIbm4610kc4Saltafw =  .Seriealtafw			lxIbm4610kc4Esttrans =  .Estadotransferencia			lxIbm4610kc4Bdmodifw =  .Basededatosmodificacionfw			lxIbm4610kc4Horaexpo =  .Horaexpo			lxIbm4610kc4Hmodifw =  .Horamodificacionfw			lxIbm4610kc4Bdaltafw =  .Basededatosaltafw			lxIbm4610kc4Horaimpo =  .Horaimpo			lxIbm4610kc4Ccod =  .Codigo
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IBM4610KC4 set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Faltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecimpo ) + "'">>,"Cdet" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdet ) + "'">>,"Cresp" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cresp ) + "'">>,"Cobsi" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobsi ) + "'">>,"Cdeti" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdeti ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobs ) + "'">>,"Crespi" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Crespi ) + "'">>,"Cexcep" = <<iif( lxIbm4610kc4Cexcep, 1, 0 )>>,"Bloqreg" = <<iif( lxIbm4610kc4Bloqreg, 1, 0 )>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ualtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Umodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Zadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Valtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Vmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Smodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Haltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Saltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Esttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Hmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaimpo ) + "'">>,"Ccod" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ccod ) + "'">> where "Ccod" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ccod ) + "'">> and  IBM4610KC4.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ZooLogic.IBM4610KC4 where " + this.ConvertirFuncionesSql( " IBM4610KC4.CCOD != ''" ) )
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
			Local lxIbm4610kc4Ccod
			lxIbm4610kc4Ccod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Cdet" as "Detalle", "Cresp" as "Respuesta", "Cobsi" as "Observacioneningles", "Cdeti" as "Detalleeningles", "Cobs" as "Observacion", "Crespi" as "Respuestaeningles", "Cexcep" as "Lanzaexcepcion", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo" from ZooLogic.IBM4610KC4 where "Ccod" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ccod ) + "'">> and  IBM4610KC4.CCOD != ''
			endtext
			use in select('c_ERRORESCFIBM4610KC4')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ERRORESCFIBM4610KC4', set( 'Datasession' ) )

			if reccount( 'c_ERRORESCFIBM4610KC4' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxIbm4610kc4Ccod as Variant
		llRetorno = .t.
		lxIbm4610kc4Ccod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IBM4610KC4 where "Ccod" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ccod ) + "'">> and  IBM4610KC4.CCOD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Cdet" as "Detalle", "Cresp" as "Respuesta", "Cobsi" as "Observacioneningles", "Cdeti" as "Detalleeningles", "Cobs" as "Observacion", "Crespi" as "Respuestaeningles", "Cexcep" as "Lanzaexcepcion", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo" from ZooLogic.IBM4610KC4 where  IBM4610KC4.CCOD != '' order by cCod
			endtext
			use in select('c_ERRORESCFIBM4610KC4')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ERRORESCFIBM4610KC4', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Cdet" as "Detalle", "Cresp" as "Respuesta", "Cobsi" as "Observacioneningles", "Cdeti" as "Detalleeningles", "Cobs" as "Observacion", "Crespi" as "Respuestaeningles", "Cexcep" as "Lanzaexcepcion", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo" from ZooLogic.IBM4610KC4 where  funciones.padr( cCod, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IBM4610KC4.CCOD != '' order by cCod
			endtext
			use in select('c_ERRORESCFIBM4610KC4')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ERRORESCFIBM4610KC4', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Cdet" as "Detalle", "Cresp" as "Respuesta", "Cobsi" as "Observacioneningles", "Cdeti" as "Detalleeningles", "Cobs" as "Observacion", "Crespi" as "Respuestaeningles", "Cexcep" as "Lanzaexcepcion", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo" from ZooLogic.IBM4610KC4 where  funciones.padr( cCod, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IBM4610KC4.CCOD != '' order by cCod desc
			endtext
			use in select('c_ERRORESCFIBM4610KC4')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ERRORESCFIBM4610KC4', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Cdet" as "Detalle", "Cresp" as "Respuesta", "Cobsi" as "Observacioneningles", "Cdeti" as "Detalleeningles", "Cobs" as "Observacion", "Crespi" as "Respuestaeningles", "Cexcep" as "Lanzaexcepcion", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo" from ZooLogic.IBM4610KC4 where  IBM4610KC4.CCOD != '' order by cCod desc
			endtext
			use in select('c_ERRORESCFIBM4610KC4')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ERRORESCFIBM4610KC4', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Cdet,Cresp,Cobsi,Cdeti,Cobs,Crespi,Cexcep,Bloqreg,U" + ;
"altafw,Umodifw,Zadsfw,Valtafw,Vmodifw,Smodifw,Haltafw,Saltafw,Esttrans,Bdmodifw,Horaexpo,Hmodifw,Bda" + ;
"ltafw,Horaimpo,Ccod" + ;
" from ZooLogic.IBM4610KC4 where  IBM4610KC4.CCOD != '' and " + lcFiltro )
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
			local  lxIbm4610kc4Fecexpo, lxIbm4610kc4Fectrans, lxIbm4610kc4Fmodifw, lxIbm4610kc4Faltafw, lxIbm4610kc4Fecimpo, lxIbm4610kc4Cdet, lxIbm4610kc4Cresp, lxIbm4610kc4Cobsi, lxIbm4610kc4Cdeti, lxIbm4610kc4Cobs, lxIbm4610kc4Crespi, lxIbm4610kc4Cexcep, lxIbm4610kc4Bloqreg, lxIbm4610kc4Ualtafw, lxIbm4610kc4Umodifw, lxIbm4610kc4Zadsfw, lxIbm4610kc4Valtafw, lxIbm4610kc4Vmodifw, lxIbm4610kc4Smodifw, lxIbm4610kc4Haltafw, lxIbm4610kc4Saltafw, lxIbm4610kc4Esttrans, lxIbm4610kc4Bdmodifw, lxIbm4610kc4Horaexpo, lxIbm4610kc4Hmodifw, lxIbm4610kc4Bdaltafw, lxIbm4610kc4Horaimpo, lxIbm4610kc4Ccod
				lxIbm4610kc4Fecexpo = ctod( '  /  /    ' )			lxIbm4610kc4Fectrans = ctod( '  /  /    ' )			lxIbm4610kc4Fmodifw = ctod( '  /  /    ' )			lxIbm4610kc4Faltafw = ctod( '  /  /    ' )			lxIbm4610kc4Fecimpo = ctod( '  /  /    ' )			lxIbm4610kc4Cdet = []			lxIbm4610kc4Cresp = []			lxIbm4610kc4Cobsi = []			lxIbm4610kc4Cdeti = []			lxIbm4610kc4Cobs = []			lxIbm4610kc4Crespi = []			lxIbm4610kc4Cexcep = .F.			lxIbm4610kc4Bloqreg = .F.			lxIbm4610kc4Ualtafw = []			lxIbm4610kc4Umodifw = []			lxIbm4610kc4Zadsfw = []			lxIbm4610kc4Valtafw = []			lxIbm4610kc4Vmodifw = []			lxIbm4610kc4Smodifw = []			lxIbm4610kc4Haltafw = []			lxIbm4610kc4Saltafw = []			lxIbm4610kc4Esttrans = []			lxIbm4610kc4Bdmodifw = []			lxIbm4610kc4Horaexpo = []			lxIbm4610kc4Hmodifw = []			lxIbm4610kc4Bdaltafw = []			lxIbm4610kc4Horaimpo = []			lxIbm4610kc4Ccod = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IBM4610KC4 where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IBM4610KC4' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where cCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(cCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IBM4610KC4.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Cdet" as "Detalle", "Cresp" as "Respuesta", "Cobsi" as "Observacioneningles", "Cdeti" as "Detalleeningles", "Cobs" as "Observacion", "Crespi" as "Respuestaeningles", "Cexcep" as "Lanzaexcepcion", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IBM4610KC4', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'DETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDET AS DETALLE'
				Case lcAtributo == 'RESPUESTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRESP AS RESPUESTA'
				Case lcAtributo == 'OBSERVACIONENINGLES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBSI AS OBSERVACIONENINGLES'
				Case lcAtributo == 'DETALLEENINGLES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDETI AS DETALLEENINGLES'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERVACION'
				Case lcAtributo == 'RESPUESTAENINGLES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRESPI AS RESPUESTAENINGLES'
				Case lcAtributo == 'LANZAEXCEPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CEXCEP AS LANZAEXCEPCION'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'DETALLE'
				lcCampo = 'CDET'
			Case upper( alltrim( tcAtributo ) ) == 'RESPUESTA'
				lcCampo = 'CRESP'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACIONENINGLES'
				lcCampo = 'COBSI'
			Case upper( alltrim( tcAtributo ) ) == 'DETALLEENINGLES'
				lcCampo = 'CDETI'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'RESPUESTAENINGLES'
				lcCampo = 'CRESPI'
			Case upper( alltrim( tcAtributo ) ) == 'LANZAEXCEPCION'
				lcCampo = 'CEXCEP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
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
			local  lxIbm4610kc4Fecexpo, lxIbm4610kc4Fectrans, lxIbm4610kc4Fmodifw, lxIbm4610kc4Faltafw, lxIbm4610kc4Fecimpo, lxIbm4610kc4Cdet, lxIbm4610kc4Cresp, lxIbm4610kc4Cobsi, lxIbm4610kc4Cdeti, lxIbm4610kc4Cobs, lxIbm4610kc4Crespi, lxIbm4610kc4Cexcep, lxIbm4610kc4Bloqreg, lxIbm4610kc4Ualtafw, lxIbm4610kc4Umodifw, lxIbm4610kc4Zadsfw, lxIbm4610kc4Valtafw, lxIbm4610kc4Vmodifw, lxIbm4610kc4Smodifw, lxIbm4610kc4Haltafw, lxIbm4610kc4Saltafw, lxIbm4610kc4Esttrans, lxIbm4610kc4Bdmodifw, lxIbm4610kc4Horaexpo, lxIbm4610kc4Hmodifw, lxIbm4610kc4Bdaltafw, lxIbm4610kc4Horaimpo, lxIbm4610kc4Ccod
				lxIbm4610kc4Fecexpo =  .Fechaexpo			lxIbm4610kc4Fectrans =  .Fechatransferencia			lxIbm4610kc4Fmodifw =  .Fechamodificacionfw			lxIbm4610kc4Faltafw =  .Fechaaltafw			lxIbm4610kc4Fecimpo =  .Fechaimpo			lxIbm4610kc4Cdet =  .Detalle			lxIbm4610kc4Cresp =  .Respuesta			lxIbm4610kc4Cobsi =  .Observacioneningles			lxIbm4610kc4Cdeti =  .Detalleeningles			lxIbm4610kc4Cobs =  .Observacion			lxIbm4610kc4Crespi =  .Respuestaeningles			lxIbm4610kc4Cexcep =  .Lanzaexcepcion			lxIbm4610kc4Bloqreg =  .Bloquearregistro			lxIbm4610kc4Ualtafw =  .Usuarioaltafw			lxIbm4610kc4Umodifw =  .Usuariomodificacionfw			lxIbm4610kc4Zadsfw =  .Zadsfw			lxIbm4610kc4Valtafw =  .Versionaltafw			lxIbm4610kc4Vmodifw =  .Versionmodificacionfw			lxIbm4610kc4Smodifw =  .Seriemodificacionfw			lxIbm4610kc4Haltafw =  .Horaaltafw			lxIbm4610kc4Saltafw =  .Seriealtafw			lxIbm4610kc4Esttrans =  .Estadotransferencia			lxIbm4610kc4Bdmodifw =  .Basededatosmodificacionfw			lxIbm4610kc4Horaexpo =  .Horaexpo			lxIbm4610kc4Hmodifw =  .Horamodificacionfw			lxIbm4610kc4Bdaltafw =  .Basededatosaltafw			lxIbm4610kc4Horaimpo =  .Horaimpo			lxIbm4610kc4Ccod =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IBM4610KC4 ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Cdet","Cresp","Cobsi","Cdeti","Cobs","Crespi","Cexcep","Bloqreg","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Smodifw","Haltafw","Saltafw","Esttrans","Bdmodifw","Horaexpo","Hmodifw","Bdaltafw","Horaimpo","Ccod" ) values ( <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Faltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cresp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobsi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdeti ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Crespi ) + "'" >>, <<iif( lxIbm4610kc4Cexcep, 1, 0 ) >>, <<iif( lxIbm4610kc4Bloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ualtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Umodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Zadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Valtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Vmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Smodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Haltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Saltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Esttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Hmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ccod ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IBM4610KC4' 
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
			local  lxIbm4610kc4Fecexpo, lxIbm4610kc4Fectrans, lxIbm4610kc4Fmodifw, lxIbm4610kc4Faltafw, lxIbm4610kc4Fecimpo, lxIbm4610kc4Cdet, lxIbm4610kc4Cresp, lxIbm4610kc4Cobsi, lxIbm4610kc4Cdeti, lxIbm4610kc4Cobs, lxIbm4610kc4Crespi, lxIbm4610kc4Cexcep, lxIbm4610kc4Bloqreg, lxIbm4610kc4Ualtafw, lxIbm4610kc4Umodifw, lxIbm4610kc4Zadsfw, lxIbm4610kc4Valtafw, lxIbm4610kc4Vmodifw, lxIbm4610kc4Smodifw, lxIbm4610kc4Haltafw, lxIbm4610kc4Saltafw, lxIbm4610kc4Esttrans, lxIbm4610kc4Bdmodifw, lxIbm4610kc4Horaexpo, lxIbm4610kc4Hmodifw, lxIbm4610kc4Bdaltafw, lxIbm4610kc4Horaimpo, lxIbm4610kc4Ccod
				lxIbm4610kc4Fecexpo =  .Fechaexpo			lxIbm4610kc4Fectrans =  .Fechatransferencia			lxIbm4610kc4Fmodifw =  .Fechamodificacionfw			lxIbm4610kc4Faltafw =  .Fechaaltafw			lxIbm4610kc4Fecimpo =  .Fechaimpo			lxIbm4610kc4Cdet =  .Detalle			lxIbm4610kc4Cresp =  .Respuesta			lxIbm4610kc4Cobsi =  .Observacioneningles			lxIbm4610kc4Cdeti =  .Detalleeningles			lxIbm4610kc4Cobs =  .Observacion			lxIbm4610kc4Crespi =  .Respuestaeningles			lxIbm4610kc4Cexcep =  .Lanzaexcepcion			lxIbm4610kc4Bloqreg =  .Bloquearregistro			lxIbm4610kc4Ualtafw =  .Usuarioaltafw			lxIbm4610kc4Umodifw =  .Usuariomodificacionfw			lxIbm4610kc4Zadsfw =  .Zadsfw			lxIbm4610kc4Valtafw =  .Versionaltafw			lxIbm4610kc4Vmodifw =  .Versionmodificacionfw			lxIbm4610kc4Smodifw =  .Seriemodificacionfw			lxIbm4610kc4Haltafw =  .Horaaltafw			lxIbm4610kc4Saltafw =  .Seriealtafw			lxIbm4610kc4Esttrans =  .Estadotransferencia			lxIbm4610kc4Bdmodifw =  .Basededatosmodificacionfw			lxIbm4610kc4Horaexpo =  .Horaexpo			lxIbm4610kc4Hmodifw =  .Horamodificacionfw			lxIbm4610kc4Bdaltafw =  .Basededatosaltafw			lxIbm4610kc4Horaimpo =  .Horaimpo			lxIbm4610kc4Ccod =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  IBM4610KC4.CCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.IBM4610KC4 set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Faltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxIbm4610kc4Fecimpo ) + "'">>, "Cdet" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdet ) + "'">>, "Cresp" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cresp ) + "'">>, "Cobsi" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobsi ) + "'">>, "Cdeti" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cdeti ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Cobs ) + "'">>, "Crespi" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Crespi ) + "'">>, "Cexcep" = <<iif( lxIbm4610kc4Cexcep, 1, 0 )>>, "Bloqreg" = <<iif( lxIbm4610kc4Bloqreg, 1, 0 )>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ualtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Umodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Zadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Valtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Vmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Smodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Haltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Saltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Esttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Hmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Bdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Horaimpo ) + "'">>, "Ccod" = <<"'" + this.FormatearTextoSql( lxIbm4610kc4Ccod ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IBM4610KC4' 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  IBM4610KC4.CCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.IBM4610KC4 where ' + lcFiltro )
			loColeccion.cTabla = 'IBM4610KC4' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IBM4610KC4 where  IBM4610KC4.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IBM4610KC4 where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  IBM4610KC4.CCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ERRORESCFIBM4610KC4'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IBM4610KC4 Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IBM4610KC4 set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, cDet = ] + "'" + this.FormatearTextoSql( &lcCursor..cDet ) + "'"+ [, cResp = ] + "'" + this.FormatearTextoSql( &lcCursor..cResp ) + "'"+ [, cObsI = ] + "'" + this.FormatearTextoSql( &lcCursor..cObsI ) + "'"+ [, cDetI = ] + "'" + this.FormatearTextoSql( &lcCursor..cDetI ) + "'"+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, cRespI = ] + "'" + this.FormatearTextoSql( &lcCursor..cRespI ) + "'"+ [, cExcep = ] + Transform( iif( &lcCursor..cExcep, 1, 0 ))+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + [ Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, cDet, cResp, cObsI, cDetI, cObs, cRespI, cExcep, BLOQREG, UALTAFW, UMODIFW, ZADSFW, VALTAFW, VMODIFW, SMODIFW, HALTAFW, SALTAFW, ESTTRANS, BDMODIFW, HORAEXPO, HMODIFW, BDALTAFW, HORAIMPO, cCod
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDet ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cResp ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObsI ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDetI ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRespI ) + "'" + ',' + Transform( iif( &lcCursor..cExcep, 1, 0 )) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IBM4610KC4 ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ERRORESCFIBM4610KC4'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCod C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..cCod       )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ERRORESCFIBM4610KC4'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ERRORESCFIBM4610KC4_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ibm4610kc4')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ERRORESCFIBM4610KC4'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ERRORESCFIBM4610KC4. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ERRORESCFIBM4610KC4'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ERRORESCFIBM4610KC4'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ibm4610kc4') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ibm4610kc4
Create Table ZooLogic.TablaTrabajo_ibm4610kc4 ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"cdet" char( 254 )  null, 
"cresp" char( 254 )  null, 
"cobsi" char( 254 )  null, 
"cdeti" char( 254 )  null, 
"cobs" char( 254 )  null, 
"crespi" char( 254 )  null, 
"cexcep" bit  null, 
"bloqreg" bit  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ccod" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ibm4610kc4' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ibm4610kc4' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ERRORESCFIBM4610KC4'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('cdet','cdet')
			.AgregarMapeo('cresp','cresp')
			.AgregarMapeo('cobsi','cobsi')
			.AgregarMapeo('cdeti','cdeti')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('crespi','crespi')
			.AgregarMapeo('cexcep','cexcep')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ccod','ccod')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ibm4610kc4'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.CDET = isnull( d.CDET, t.CDET ),t.CRESP = isnull( d.CRESP, t.CRESP ),t.COBSI = isnull( d.COBSI, t.COBSI ),t.CDETI = isnull( d.CDETI, t.CDETI ),t.COBS = isnull( d.COBS, t.COBS ),t.CRESPI = isnull( d.CRESPI, t.CRESPI ),t.CEXCEP = isnull( d.CEXCEP, t.CEXCEP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CCOD = isnull( d.CCOD, t.CCOD )
					from ZooLogic.IBM4610KC4 t inner join deleted d 
							 on t.cCod = d.cCod
				-- Fin Updates
				insert into ZooLogic.IBM4610KC4(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Cdet,Cresp,Cobsi,Cdeti,Cobs,Crespi,Cexcep,Bloqreg,Ualtafw,Umodifw,Zadsfw,Valtafw,Vmodifw,Smodifw,Haltafw,Saltafw,Esttrans,Bdmodifw,Horaexpo,Hmodifw,Bdaltafw,Horaimpo,Ccod)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.CDET,''),isnull( d.CRESP,''),isnull( d.COBSI,''),isnull( d.CDETI,''),isnull( d.COBS,''),isnull( d.CRESPI,''),isnull( d.CEXCEP,0),isnull( d.BLOQREG,0),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.CCOD,'')
						From deleted d left join ZooLogic.IBM4610KC4 pk 
							 on d.cCod = pk.cCod
						Where pk.cCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ibm4610kc4') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ibm4610kc4
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ERRORESCFIBM4610KC4' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ERRORESCFIBM4610KC4.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ERRORESCFIBM4610KC4.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ERRORESCFIBM4610KC4.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ERRORESCFIBM4610KC4.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ERRORESCFIBM4610KC4.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Detalle = nvl( c_ERRORESCFIBM4610KC4.Detalle, [] )
					.Respuesta = nvl( c_ERRORESCFIBM4610KC4.Respuesta, [] )
					.Observacioneningles = nvl( c_ERRORESCFIBM4610KC4.Observacioneningles, [] )
					.Detalleeningles = nvl( c_ERRORESCFIBM4610KC4.Detalleeningles, [] )
					.Observacion = nvl( c_ERRORESCFIBM4610KC4.Observacion, [] )
					.Respuestaeningles = nvl( c_ERRORESCFIBM4610KC4.Respuestaeningles, [] )
					.Lanzaexcepcion = nvl( c_ERRORESCFIBM4610KC4.Lanzaexcepcion, .F. )
					.Bloquearregistro = nvl( c_ERRORESCFIBM4610KC4.Bloquearregistro, .F. )
					.Usuarioaltafw = nvl( c_ERRORESCFIBM4610KC4.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ERRORESCFIBM4610KC4.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ERRORESCFIBM4610KC4.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_ERRORESCFIBM4610KC4.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_ERRORESCFIBM4610KC4.Seriemodificacionfw, [] )
					.Horaaltafw = nvl( c_ERRORESCFIBM4610KC4.Horaaltafw, [] )
					.Seriealtafw = nvl( c_ERRORESCFIBM4610KC4.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_ERRORESCFIBM4610KC4.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_ERRORESCFIBM4610KC4.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_ERRORESCFIBM4610KC4.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_ERRORESCFIBM4610KC4.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_ERRORESCFIBM4610KC4.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_ERRORESCFIBM4610KC4.Horaimpo, [] )
					.Codigo = nvl( c_ERRORESCFIBM4610KC4.Codigo, [] )
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
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_ERRORESCFIBM4610KC4.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IBM4610KC4' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,cCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    cCod from (
							select * 
								from ZooLogic.IBM4610KC4 
								Where   IBM4610KC4.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IBM4610KC4", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Cdet" as "Detalle", "Cresp" as "Respuesta", "Cobsi" as "Observacioneningles", "Cdeti" as "Detalleeningles", "Cobs" as "Observacion", "Crespi" as "Respuestaeningles", "Cexcep" as "Lanzaexcepcion", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IBM4610KC4 
								Where   IBM4610KC4.CCOD != ''
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
	Tabla = 'IBM4610KC4'
	Filtro = " IBM4610KC4.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IBM4610KC4.CCOD != ''"
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
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="FECHAEXPO                               " tabla="IBM4610KC4     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="FECHATRANSFERENCIA                      " tabla="IBM4610KC4     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="FECHAMODIFICACIONFW                     " tabla="IBM4610KC4     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="FECHAALTAFW                             " tabla="IBM4610KC4     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="FECHAIMPO                               " tabla="IBM4610KC4     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="DETALLE                                 " tabla="IBM4610KC4     " campo="CDET      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Detalle                                                                                                                                                         " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="RESPUESTA                               " tabla="IBM4610KC4     " campo="CRESP     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Respuesta                                                                                                                                                       " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="OBSERVACIONENINGLES                     " tabla="IBM4610KC4     " campo="COBSI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Observación Inglés                                                                                                                                              " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="DETALLEENINGLES                         " tabla="IBM4610KC4     " campo="CDETI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Detalle Inglés                                                                                                                                                  " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="OBSERVACION                             " tabla="IBM4610KC4     " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="RESPUESTAENINGLES                       " tabla="IBM4610KC4     " campo="CRESPI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Respuesta Inglés                                                                                                                                                " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="LANZAEXCEPCION                          " tabla="IBM4610KC4     " campo="CEXCEP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Lanza excepción                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="BLOQUEARREGISTRO                        " tabla="IBM4610KC4     " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="USUARIOALTAFW                           " tabla="IBM4610KC4     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="USUARIOMODIFICACIONFW                   " tabla="IBM4610KC4     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="ZADSFW                                  " tabla="IBM4610KC4     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="VERSIONALTAFW                           " tabla="IBM4610KC4     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="VERSIONMODIFICACIONFW                   " tabla="IBM4610KC4     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="SERIEMODIFICACIONFW                     " tabla="IBM4610KC4     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="HORAALTAFW                              " tabla="IBM4610KC4     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="SERIEALTAFW                             " tabla="IBM4610KC4     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="ESTADOTRANSFERENCIA                     " tabla="IBM4610KC4     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IBM4610KC4     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="HORAEXPO                                " tabla="IBM4610KC4     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="HORAMODIFICACIONFW                      " tabla="IBM4610KC4     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="BASEDEDATOSALTAFW                       " tabla="IBM4610KC4     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="HORAIMPO                                " tabla="IBM4610KC4     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORESCFIBM4610KC4                     " atributo="CODIGO                                  " tabla="IBM4610KC4     " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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