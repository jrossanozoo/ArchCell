
define class Din_EntidadENVIODECUENTACORRIENTEPORMAILAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ENVIODECUENTACORRIENTEPORMAIL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_ECMPK'
	cTablaPrincipal = 'ENVCCMAIL'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxEnvccmailFmodifw, lxEnvccmailFecimpo, lxEnvccmailFectrans, lxEnvccmailFaltafw, lxEnvccmailFecexpo, lxEnvccmailHoraexpo, lxEnvccmailHoraimpo, lxEnvccmailHaltafw, lxEnvccmailHmodifw, lxEnvccmailVmodifw, lxEnvccmailZadsfw, lxEnvccmailValtafw, lxEnvccmailUmodifw, lxEnvccmailSmodifw, lxEnvccmailUaltafw, lxEnvccmailSaltafw, lxEnvccmailEsttrans, lxEnvccmailBdaltafw, lxEnvccmailBdmodifw, lxEnvccmailCodigo, lxEnvccmailFechad, lxEnvccmailFechah, lxEnvccmailFpersond, lxEnvccmailFpersonh, lxEnvccmailComppend, lxEnvccmailSaldopn, lxEnvccmailSalsincan, lxEnvccmailAgrusaldos, lxEnvccmailCheqterc, lxEnvccmailCbdatos, lxEnvccmailClobs, lxEnvccmailListados
				lxEnvccmailFmodifw =  .Fechamodificacionfw			lxEnvccmailFecimpo =  .Fechaimpo			lxEnvccmailFectrans =  .Fechatransferencia			lxEnvccmailFaltafw =  .Fechaaltafw			lxEnvccmailFecexpo =  .Fechaexpo			lxEnvccmailHoraexpo =  .Horaexpo			lxEnvccmailHoraimpo =  .Horaimpo			lxEnvccmailHaltafw =  .Horaaltafw			lxEnvccmailHmodifw =  .Horamodificacionfw			lxEnvccmailVmodifw =  .Versionmodificacionfw			lxEnvccmailZadsfw =  .Zadsfw			lxEnvccmailValtafw =  .Versionaltafw			lxEnvccmailUmodifw =  .Usuariomodificacionfw			lxEnvccmailSmodifw =  .Seriemodificacionfw			lxEnvccmailUaltafw =  .Usuarioaltafw			lxEnvccmailSaltafw =  .Seriealtafw			lxEnvccmailEsttrans =  .Estadotransferencia			lxEnvccmailBdaltafw =  .Basededatosaltafw			lxEnvccmailBdmodifw =  .Basededatosmodificacionfw			lxEnvccmailCodigo =  .Codigo			lxEnvccmailFechad =  .Fechadesde			lxEnvccmailFechah =  .Fechahasta			lxEnvccmailFpersond =  upper( .ClienteDesde_PK ) 			lxEnvccmailFpersonh =  upper( .ClienteHasta_PK ) 			lxEnvccmailComppend =  .Comprobantespendientes			lxEnvccmailSaldopn =  .Saldo			lxEnvccmailSalsincan =  .Saldosdecuentasincancelar			lxEnvccmailAgrusaldos =  .Agruparsaldos			lxEnvccmailCheqterc =  .Chequesdeterceros			lxEnvccmailCbdatos =  .Basededatos			lxEnvccmailClobs =  .Observacion			lxEnvccmailListados =  .Combopersonalizacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxEnvccmailCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ENVCCMAIL ( "Fmodifw","Fecimpo","Fectrans","Faltafw","Fecexpo","Horaexpo","Horaimpo","Haltafw","Hmodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Esttrans","Bdaltafw","Bdmodifw","Codigo","Fechad","Fechah","Fpersond","Fpersonh","Comppend","Saldopn","Salsincan","Agrusaldos","Cheqterc","Cbdatos","Clobs","Listados" ) values ( <<"'" + this.ConvertirDateSql( lxEnvccmailFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailBdmodifw ) + "'" >>, <<lxEnvccmailCodigo >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFechad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailFpersond ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailFpersonh ) + "'" >>, <<lxEnvccmailComppend >>, <<lxEnvccmailSaldopn >>, <<lxEnvccmailSalsincan >>, <<iif( lxEnvccmailAgrusaldos, 1, 0 ) >>, <<iif( lxEnvccmailCheqterc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvccmailCbdatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailClobs ) + "'" >>, <<lxEnvccmailListados >> )
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
			local  lxEnvccmailFmodifw, lxEnvccmailFecimpo, lxEnvccmailFectrans, lxEnvccmailFaltafw, lxEnvccmailFecexpo, lxEnvccmailHoraexpo, lxEnvccmailHoraimpo, lxEnvccmailHaltafw, lxEnvccmailHmodifw, lxEnvccmailVmodifw, lxEnvccmailZadsfw, lxEnvccmailValtafw, lxEnvccmailUmodifw, lxEnvccmailSmodifw, lxEnvccmailUaltafw, lxEnvccmailSaltafw, lxEnvccmailEsttrans, lxEnvccmailBdaltafw, lxEnvccmailBdmodifw, lxEnvccmailCodigo, lxEnvccmailFechad, lxEnvccmailFechah, lxEnvccmailFpersond, lxEnvccmailFpersonh, lxEnvccmailComppend, lxEnvccmailSaldopn, lxEnvccmailSalsincan, lxEnvccmailAgrusaldos, lxEnvccmailCheqterc, lxEnvccmailCbdatos, lxEnvccmailClobs, lxEnvccmailListados
				lxEnvccmailFmodifw =  .Fechamodificacionfw			lxEnvccmailFecimpo =  .Fechaimpo			lxEnvccmailFectrans =  .Fechatransferencia			lxEnvccmailFaltafw =  .Fechaaltafw			lxEnvccmailFecexpo =  .Fechaexpo			lxEnvccmailHoraexpo =  .Horaexpo			lxEnvccmailHoraimpo =  .Horaimpo			lxEnvccmailHaltafw =  .Horaaltafw			lxEnvccmailHmodifw =  .Horamodificacionfw			lxEnvccmailVmodifw =  .Versionmodificacionfw			lxEnvccmailZadsfw =  .Zadsfw			lxEnvccmailValtafw =  .Versionaltafw			lxEnvccmailUmodifw =  .Usuariomodificacionfw			lxEnvccmailSmodifw =  .Seriemodificacionfw			lxEnvccmailUaltafw =  .Usuarioaltafw			lxEnvccmailSaltafw =  .Seriealtafw			lxEnvccmailEsttrans =  .Estadotransferencia			lxEnvccmailBdaltafw =  .Basededatosaltafw			lxEnvccmailBdmodifw =  .Basededatosmodificacionfw			lxEnvccmailCodigo =  .Codigo			lxEnvccmailFechad =  .Fechadesde			lxEnvccmailFechah =  .Fechahasta			lxEnvccmailFpersond =  upper( .ClienteDesde_PK ) 			lxEnvccmailFpersonh =  upper( .ClienteHasta_PK ) 			lxEnvccmailComppend =  .Comprobantespendientes			lxEnvccmailSaldopn =  .Saldo			lxEnvccmailSalsincan =  .Saldosdecuentasincancelar			lxEnvccmailAgrusaldos =  .Agruparsaldos			lxEnvccmailCheqterc =  .Chequesdeterceros			lxEnvccmailCbdatos =  .Basededatos			lxEnvccmailClobs =  .Observacion			lxEnvccmailListados =  .Combopersonalizacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ENVCCMAIL set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxEnvccmailFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxEnvccmailFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxEnvccmailFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxEnvccmailFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxEnvccmailFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxEnvccmailHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxEnvccmailHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxEnvccmailZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxEnvccmailEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailBdmodifw ) + "'">>,"Codigo" = <<lxEnvccmailCodigo>>,"Fechad" = <<"'" + this.ConvertirDateSql( lxEnvccmailFechad ) + "'">>,"Fechah" = <<"'" + this.ConvertirDateSql( lxEnvccmailFechah ) + "'">>,"Fpersond" = <<"'" + this.FormatearTextoSql( lxEnvccmailFpersond ) + "'">>,"Fpersonh" = <<"'" + this.FormatearTextoSql( lxEnvccmailFpersonh ) + "'">>,"Comppend" = <<lxEnvccmailComppend>>,"Saldopn" = <<lxEnvccmailSaldopn>>,"Salsincan" = <<lxEnvccmailSalsincan>>,"Agrusaldos" = <<iif( lxEnvccmailAgrusaldos, 1, 0 )>>,"Cheqterc" = <<iif( lxEnvccmailCheqterc, 1, 0 )>>,"Cbdatos" = <<"'" + this.FormatearTextoSql( lxEnvccmailCbdatos ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxEnvccmailClobs ) + "'">>,"Listados" = <<lxEnvccmailListados>> where "Codigo" = <<lxEnvccmailCodigo>> and  ENVCCMAIL.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.ENVCCMAIL where " + this.ConvertirFuncionesSql( " ENVCCMAIL.CODIGO != 0" ) )
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
			Local lxEnvccmailCodigo
			lxEnvccmailCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Fpersond" as "Clientedesde", "Fpersonh" as "Clientehasta", "Comppend" as "Comprobantespendientes", "Saldopn" as "Saldo", "Salsincan" as "Saldosdecuentasincancelar", "Agrusaldos" as "Agruparsaldos", "Cheqterc" as "Chequesdeterceros", "Cbdatos" as "Basededatos", "Clobs" as "Observacion", "Listados" as "Combopersonalizacion" from ZooLogic.ENVCCMAIL where "Codigo" = <<lxEnvccmailCodigo>> and  ENVCCMAIL.CODIGO != 0
			endtext
			use in select('c_ENVIODECUENTACORRIENTEPORMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODECUENTACORRIENTEPORMAIL', set( 'Datasession' ) )

			if reccount( 'c_ENVIODECUENTACORRIENTEPORMAIL' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxEnvccmailCodigo as Variant
		llRetorno = .t.
		lxEnvccmailCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ENVCCMAIL where "Codigo" = <<lxEnvccmailCodigo>> and  ENVCCMAIL.CODIGO != 0
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Fpersond" as "Clientedesde", "Fpersonh" as "Clientehasta", "Comppend" as "Comprobantespendientes", "Saldopn" as "Saldo", "Salsincan" as "Saldosdecuentasincancelar", "Agrusaldos" as "Agruparsaldos", "Cheqterc" as "Chequesdeterceros", "Cbdatos" as "Basededatos", "Clobs" as "Observacion", "Listados" as "Combopersonalizacion" from ZooLogic.ENVCCMAIL where  ENVCCMAIL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_ENVIODECUENTACORRIENTEPORMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODECUENTACORRIENTEPORMAIL', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Fpersond" as "Clientedesde", "Fpersonh" as "Clientehasta", "Comppend" as "Comprobantespendientes", "Saldopn" as "Saldo", "Salsincan" as "Saldosdecuentasincancelar", "Agrusaldos" as "Agruparsaldos", "Cheqterc" as "Chequesdeterceros", "Cbdatos" as "Basededatos", "Clobs" as "Observacion", "Listados" as "Combopersonalizacion" from ZooLogic.ENVCCMAIL where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ENVCCMAIL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_ENVIODECUENTACORRIENTEPORMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODECUENTACORRIENTEPORMAIL', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Fpersond" as "Clientedesde", "Fpersonh" as "Clientehasta", "Comppend" as "Comprobantespendientes", "Saldopn" as "Saldo", "Salsincan" as "Saldosdecuentasincancelar", "Agrusaldos" as "Agruparsaldos", "Cheqterc" as "Chequesdeterceros", "Cbdatos" as "Basededatos", "Clobs" as "Observacion", "Listados" as "Combopersonalizacion" from ZooLogic.ENVCCMAIL where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ENVCCMAIL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_ENVIODECUENTACORRIENTEPORMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODECUENTACORRIENTEPORMAIL', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Fpersond" as "Clientedesde", "Fpersonh" as "Clientehasta", "Comppend" as "Comprobantespendientes", "Saldopn" as "Saldo", "Salsincan" as "Saldosdecuentasincancelar", "Agrusaldos" as "Agruparsaldos", "Cheqterc" as "Chequesdeterceros", "Cbdatos" as "Basededatos", "Clobs" as "Observacion", "Listados" as "Combopersonalizacion" from ZooLogic.ENVCCMAIL where  ENVCCMAIL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_ENVIODECUENTACORRIENTEPORMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODECUENTACORRIENTEPORMAIL', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.CODIGO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecimpo,Fectrans,Faltafw,Fecexpo,Horaexpo,Horaimpo,Haltafw,Hmodifw,Vmodifw,Zadsfw,Va" + ;
"ltafw,Umodifw,Smodifw,Ualtafw,Saltafw,Esttrans,Bdaltafw,Bdmodifw,Codigo,Fechad,Fechah,Fpersond,Fpers" + ;
"onh,Comppend,Saldopn,Salsincan,Agrusaldos,Cheqterc,Cbdatos,Clobs,Listados" + ;
" from ZooLogic.ENVCCMAIL where  ENVCCMAIL.CODIGO != 0 and " + lcFiltro )
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
			local  lxEnvccmailFmodifw, lxEnvccmailFecimpo, lxEnvccmailFectrans, lxEnvccmailFaltafw, lxEnvccmailFecexpo, lxEnvccmailHoraexpo, lxEnvccmailHoraimpo, lxEnvccmailHaltafw, lxEnvccmailHmodifw, lxEnvccmailVmodifw, lxEnvccmailZadsfw, lxEnvccmailValtafw, lxEnvccmailUmodifw, lxEnvccmailSmodifw, lxEnvccmailUaltafw, lxEnvccmailSaltafw, lxEnvccmailEsttrans, lxEnvccmailBdaltafw, lxEnvccmailBdmodifw, lxEnvccmailCodigo, lxEnvccmailFechad, lxEnvccmailFechah, lxEnvccmailFpersond, lxEnvccmailFpersonh, lxEnvccmailComppend, lxEnvccmailSaldopn, lxEnvccmailSalsincan, lxEnvccmailAgrusaldos, lxEnvccmailCheqterc, lxEnvccmailCbdatos, lxEnvccmailClobs, lxEnvccmailListados
				lxEnvccmailFmodifw = ctod( '  /  /    ' )			lxEnvccmailFecimpo = ctod( '  /  /    ' )			lxEnvccmailFectrans = ctod( '  /  /    ' )			lxEnvccmailFaltafw = ctod( '  /  /    ' )			lxEnvccmailFecexpo = ctod( '  /  /    ' )			lxEnvccmailHoraexpo = []			lxEnvccmailHoraimpo = []			lxEnvccmailHaltafw = []			lxEnvccmailHmodifw = []			lxEnvccmailVmodifw = []			lxEnvccmailZadsfw = []			lxEnvccmailValtafw = []			lxEnvccmailUmodifw = []			lxEnvccmailSmodifw = []			lxEnvccmailUaltafw = []			lxEnvccmailSaltafw = []			lxEnvccmailEsttrans = []			lxEnvccmailBdaltafw = []			lxEnvccmailBdmodifw = []			lxEnvccmailCodigo = 0			lxEnvccmailFechad = ctod( '  /  /    ' )			lxEnvccmailFechah = ctod( '  /  /    ' )			lxEnvccmailFpersond = []			lxEnvccmailFpersonh = []			lxEnvccmailComppend = 0			lxEnvccmailSaldopn = 0			lxEnvccmailSalsincan = 0			lxEnvccmailAgrusaldos = .F.			lxEnvccmailCheqterc = .F.			lxEnvccmailCbdatos = []			lxEnvccmailClobs = []			lxEnvccmailListados = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ENVCCMAIL where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ENVCCMAIL' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ENVCCMAIL.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Fpersond" as "Clientedesde", "Fpersonh" as "Clientehasta", "Comppend" as "Comprobantespendientes", "Saldopn" as "Saldo", "Salsincan" as "Saldosdecuentasincancelar", "Agrusaldos" as "Agruparsaldos", "Cheqterc" as "Chequesdeterceros", "Cbdatos" as "Basededatos", "Clobs" as "Observacion", "Listados" as "Combopersonalizacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ENVCCMAIL', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAD AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAH AS FECHAHASTA'
				Case lcAtributo == 'CLIENTEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSOND AS CLIENTEDESDE'
				Case lcAtributo == 'CLIENTEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSONH AS CLIENTEHASTA'
				Case lcAtributo == 'COMPROBANTESPENDIENTES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPPEND AS COMPROBANTESPENDIENTES'
				Case lcAtributo == 'SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDOPN AS SALDO'
				Case lcAtributo == 'SALDOSDECUENTASINCANCELAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALSINCAN AS SALDOSDECUENTASINCANCELAR'
				Case lcAtributo == 'AGRUPARSALDOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUSALDOS AS AGRUPARSALDOS'
				Case lcAtributo == 'CHEQUESDETERCEROS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHEQTERC AS CHEQUESDETERCEROS'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDATOS AS BASEDEDATOS'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'COMBOPERSONALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTADOS AS COMBOPERSONALIZACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECHAD'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAH'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESDE'
				lcCampo = 'FPERSOND'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEHASTA'
				lcCampo = 'FPERSONH'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTESPENDIENTES'
				lcCampo = 'COMPPEND'
			Case upper( alltrim( tcAtributo ) ) == 'SALDO'
				lcCampo = 'SALDOPN'
			Case upper( alltrim( tcAtributo ) ) == 'SALDOSDECUENTASINCANCELAR'
				lcCampo = 'SALSINCAN'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPARSALDOS'
				lcCampo = 'AGRUSALDOS'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUESDETERCEROS'
				lcCampo = 'CHEQTERC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'CBDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'COMBOPERSONALIZACION'
				lcCampo = 'LISTADOS'
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
			local  lxEnvccmailFmodifw, lxEnvccmailFecimpo, lxEnvccmailFectrans, lxEnvccmailFaltafw, lxEnvccmailFecexpo, lxEnvccmailHoraexpo, lxEnvccmailHoraimpo, lxEnvccmailHaltafw, lxEnvccmailHmodifw, lxEnvccmailVmodifw, lxEnvccmailZadsfw, lxEnvccmailValtafw, lxEnvccmailUmodifw, lxEnvccmailSmodifw, lxEnvccmailUaltafw, lxEnvccmailSaltafw, lxEnvccmailEsttrans, lxEnvccmailBdaltafw, lxEnvccmailBdmodifw, lxEnvccmailCodigo, lxEnvccmailFechad, lxEnvccmailFechah, lxEnvccmailFpersond, lxEnvccmailFpersonh, lxEnvccmailComppend, lxEnvccmailSaldopn, lxEnvccmailSalsincan, lxEnvccmailAgrusaldos, lxEnvccmailCheqterc, lxEnvccmailCbdatos, lxEnvccmailClobs, lxEnvccmailListados
				lxEnvccmailFmodifw =  .Fechamodificacionfw			lxEnvccmailFecimpo =  .Fechaimpo			lxEnvccmailFectrans =  .Fechatransferencia			lxEnvccmailFaltafw =  .Fechaaltafw			lxEnvccmailFecexpo =  .Fechaexpo			lxEnvccmailHoraexpo =  .Horaexpo			lxEnvccmailHoraimpo =  .Horaimpo			lxEnvccmailHaltafw =  .Horaaltafw			lxEnvccmailHmodifw =  .Horamodificacionfw			lxEnvccmailVmodifw =  .Versionmodificacionfw			lxEnvccmailZadsfw =  .Zadsfw			lxEnvccmailValtafw =  .Versionaltafw			lxEnvccmailUmodifw =  .Usuariomodificacionfw			lxEnvccmailSmodifw =  .Seriemodificacionfw			lxEnvccmailUaltafw =  .Usuarioaltafw			lxEnvccmailSaltafw =  .Seriealtafw			lxEnvccmailEsttrans =  .Estadotransferencia			lxEnvccmailBdaltafw =  .Basededatosaltafw			lxEnvccmailBdmodifw =  .Basededatosmodificacionfw			lxEnvccmailCodigo =  .Codigo			lxEnvccmailFechad =  .Fechadesde			lxEnvccmailFechah =  .Fechahasta			lxEnvccmailFpersond =  upper( .ClienteDesde_PK ) 			lxEnvccmailFpersonh =  upper( .ClienteHasta_PK ) 			lxEnvccmailComppend =  .Comprobantespendientes			lxEnvccmailSaldopn =  .Saldo			lxEnvccmailSalsincan =  .Saldosdecuentasincancelar			lxEnvccmailAgrusaldos =  .Agruparsaldos			lxEnvccmailCheqterc =  .Chequesdeterceros			lxEnvccmailCbdatos =  .Basededatos			lxEnvccmailClobs =  .Observacion			lxEnvccmailListados =  .Combopersonalizacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ENVCCMAIL ( "Fmodifw","Fecimpo","Fectrans","Faltafw","Fecexpo","Horaexpo","Horaimpo","Haltafw","Hmodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Esttrans","Bdaltafw","Bdmodifw","Codigo","Fechad","Fechah","Fpersond","Fpersonh","Comppend","Saldopn","Salsincan","Agrusaldos","Cheqterc","Cbdatos","Clobs","Listados" ) values ( <<"'" + this.ConvertirDateSql( lxEnvccmailFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailBdmodifw ) + "'" >>, <<lxEnvccmailCodigo >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFechad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvccmailFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailFpersond ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailFpersonh ) + "'" >>, <<lxEnvccmailComppend >>, <<lxEnvccmailSaldopn >>, <<lxEnvccmailSalsincan >>, <<iif( lxEnvccmailAgrusaldos, 1, 0 ) >>, <<iif( lxEnvccmailCheqterc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvccmailCbdatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvccmailClobs ) + "'" >>, <<lxEnvccmailListados >> )
		endtext
		loColeccion.cTabla = 'ENVCCMAIL' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxEnvccmailFmodifw, lxEnvccmailFecimpo, lxEnvccmailFectrans, lxEnvccmailFaltafw, lxEnvccmailFecexpo, lxEnvccmailHoraexpo, lxEnvccmailHoraimpo, lxEnvccmailHaltafw, lxEnvccmailHmodifw, lxEnvccmailVmodifw, lxEnvccmailZadsfw, lxEnvccmailValtafw, lxEnvccmailUmodifw, lxEnvccmailSmodifw, lxEnvccmailUaltafw, lxEnvccmailSaltafw, lxEnvccmailEsttrans, lxEnvccmailBdaltafw, lxEnvccmailBdmodifw, lxEnvccmailCodigo, lxEnvccmailFechad, lxEnvccmailFechah, lxEnvccmailFpersond, lxEnvccmailFpersonh, lxEnvccmailComppend, lxEnvccmailSaldopn, lxEnvccmailSalsincan, lxEnvccmailAgrusaldos, lxEnvccmailCheqterc, lxEnvccmailCbdatos, lxEnvccmailClobs, lxEnvccmailListados
				lxEnvccmailFmodifw =  .Fechamodificacionfw			lxEnvccmailFecimpo =  .Fechaimpo			lxEnvccmailFectrans =  .Fechatransferencia			lxEnvccmailFaltafw =  .Fechaaltafw			lxEnvccmailFecexpo =  .Fechaexpo			lxEnvccmailHoraexpo =  .Horaexpo			lxEnvccmailHoraimpo =  .Horaimpo			lxEnvccmailHaltafw =  .Horaaltafw			lxEnvccmailHmodifw =  .Horamodificacionfw			lxEnvccmailVmodifw =  .Versionmodificacionfw			lxEnvccmailZadsfw =  .Zadsfw			lxEnvccmailValtafw =  .Versionaltafw			lxEnvccmailUmodifw =  .Usuariomodificacionfw			lxEnvccmailSmodifw =  .Seriemodificacionfw			lxEnvccmailUaltafw =  .Usuarioaltafw			lxEnvccmailSaltafw =  .Seriealtafw			lxEnvccmailEsttrans =  .Estadotransferencia			lxEnvccmailBdaltafw =  .Basededatosaltafw			lxEnvccmailBdmodifw =  .Basededatosmodificacionfw			lxEnvccmailCodigo =  .Codigo			lxEnvccmailFechad =  .Fechadesde			lxEnvccmailFechah =  .Fechahasta			lxEnvccmailFpersond =  upper( .ClienteDesde_PK ) 			lxEnvccmailFpersonh =  upper( .ClienteHasta_PK ) 			lxEnvccmailComppend =  .Comprobantespendientes			lxEnvccmailSaldopn =  .Saldo			lxEnvccmailSalsincan =  .Saldosdecuentasincancelar			lxEnvccmailAgrusaldos =  .Agruparsaldos			lxEnvccmailCheqterc =  .Chequesdeterceros			lxEnvccmailCbdatos =  .Basededatos			lxEnvccmailClobs =  .Observacion			lxEnvccmailListados =  .Combopersonalizacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ENVCCMAIL.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.ENVCCMAIL set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxEnvccmailFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxEnvccmailFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxEnvccmailFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxEnvccmailFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxEnvccmailFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxEnvccmailHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxEnvccmailHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxEnvccmailZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxEnvccmailEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEnvccmailBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEnvccmailBdmodifw ) + "'">>, "Codigo" = <<lxEnvccmailCodigo>>, "Fechad" = <<"'" + this.ConvertirDateSql( lxEnvccmailFechad ) + "'">>, "Fechah" = <<"'" + this.ConvertirDateSql( lxEnvccmailFechah ) + "'">>, "Fpersond" = <<"'" + this.FormatearTextoSql( lxEnvccmailFpersond ) + "'">>, "Fpersonh" = <<"'" + this.FormatearTextoSql( lxEnvccmailFpersonh ) + "'">>, "Comppend" = <<lxEnvccmailComppend>>, "Saldopn" = <<lxEnvccmailSaldopn>>, "Salsincan" = <<lxEnvccmailSalsincan>>, "Agrusaldos" = <<iif( lxEnvccmailAgrusaldos, 1, 0 )>>, "Cheqterc" = <<iif( lxEnvccmailCheqterc, 1, 0 )>>, "Cbdatos" = <<"'" + this.FormatearTextoSql( lxEnvccmailCbdatos ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxEnvccmailClobs ) + "'">>, "Listados" = <<lxEnvccmailListados>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ENVCCMAIL' 
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
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ENVCCMAIL.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.ENVCCMAIL where ' + lcFiltro )
			loColeccion.cTabla = 'ENVCCMAIL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ENVCCMAIL where  ENVCCMAIL.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ENVCCMAIL where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  ENVCCMAIL.CODIGO != 0" )
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
					if empty( .oNumeraciones.ObtenerServicio('CODIGO') ) and iif( type( '.CODIGO' ) = 'C', int( val( .CODIGO ) ),.CODIGO ) = .oNumeraciones.UltimoNumero( 'CODIGO' )
						.oNumeraciones.Actualizar( 'CODIGO' )
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
					.CODIGO = .oNumeraciones.grabar( 'CODIGO' )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODECUENTACORRIENTEPORMAIL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ENVCCMAIL Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ENVCCMAIL set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, FECHAD = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAD ) + "'"+ [, FECHAH = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'"+ [, FPersonD = ] + "'" + this.FormatearTextoSql( &lcCursor..FPersonD ) + "'"+ [, FPersonH = ] + "'" + this.FormatearTextoSql( &lcCursor..FPersonH ) + "'"+ [, CompPend = ] + transform( &lcCursor..CompPend )+ [, SaldoPN = ] + transform( &lcCursor..SaldoPN )+ [, SalSinCan = ] + transform( &lcCursor..SalSinCan )+ [, AgruSaldos = ] + Transform( iif( &lcCursor..AgruSaldos, 1, 0 ))+ [, CheqTerc = ] + Transform( iif( &lcCursor..CheqTerc, 1, 0 ))+ [, cBdatos = ] + "'" + this.FormatearTextoSql( &lcCursor..cBdatos ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, listados = ] + transform( &lcCursor..listados ) + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECIMPO, FECTRANS, FALTAFW, FECEXPO, HORAEXPO, HORAIMPO, HALTAFW, HMODIFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, SALTAFW, ESTTRANS, BDALTAFW, BDMODIFW, CODIGO, FECHAD, FECHAH, FPersonD, FPersonH, CompPend, SaldoPN, SalSinCan, AgruSaldos, CheqTerc, cBdatos, CLOBS, listados
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPersonD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPersonH ) + "'" + ',' + transform( &lcCursor..CompPend ) + ',' + transform( &lcCursor..SaldoPN ) + ',' + transform( &lcCursor..SalSinCan ) + ',' + Transform( iif( &lcCursor..AgruSaldos, 1, 0 )) + ',' + Transform( iif( &lcCursor..CheqTerc, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBdatos ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + transform( &lcCursor..listados )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ENVCCMAIL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODECUENTACORRIENTEPORMAIL'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número interno: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ENVIODECUENTACORRIENTEPORMAIL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ENVIODECUENTACORRIENTEPORMAIL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ENVIODECUENTACORRIENTEPORMAIL_CLOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ENVCCMAIL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ENVIODECUENTACORRIENTEPORMAIL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ENVIODECUENTACORRIENTEPORMAIL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODECUENTACORRIENTEPORMAIL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODECUENTACORRIENTEPORMAIL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECHAD    
		* Validar ANTERIORES A 1/1/1753  FECHAH    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ENVCCMAIL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ENVCCMAIL
Create Table ZooLogic.TablaTrabajo_ENVCCMAIL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" numeric( 8, 0 )  null, 
"fechad" datetime  null, 
"fechah" datetime  null, 
"fpersond" char( 10 )  null, 
"fpersonh" char( 10 )  null, 
"comppend" numeric( 3, 0 )  null, 
"saldopn" numeric( 15, 0 )  null, 
"salsincan" numeric( 3, 0 )  null, 
"agrusaldos" bit  null, 
"cheqterc" bit  null, 
"cbdatos" char( 15 )  null, 
"clobs" varchar(max)  null, 
"listados" numeric( 15, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ENVCCMAIL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ENVCCMAIL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODECUENTACORRIENTEPORMAIL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fechad','fechad')
			.AgregarMapeo('fechah','fechah')
			.AgregarMapeo('fpersond','fpersond')
			.AgregarMapeo('fpersonh','fpersonh')
			.AgregarMapeo('comppend','comppend')
			.AgregarMapeo('saldopn','saldopn')
			.AgregarMapeo('salsincan','salsincan')
			.AgregarMapeo('agrusaldos','agrusaldos')
			.AgregarMapeo('cheqterc','cheqterc')
			.AgregarMapeo('cbdatos','cbdatos')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('listados','listados')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ENVCCMAIL'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FECHAD = isnull( d.FECHAD, t.FECHAD ),t.FECHAH = isnull( d.FECHAH, t.FECHAH ),t.FPERSOND = isnull( d.FPERSOND, t.FPERSOND ),t.FPERSONH = isnull( d.FPERSONH, t.FPERSONH ),t.COMPPEND = isnull( d.COMPPEND, t.COMPPEND ),t.SALDOPN = isnull( d.SALDOPN, t.SALDOPN ),t.SALSINCAN = isnull( d.SALSINCAN, t.SALSINCAN ),t.AGRUSALDOS = isnull( d.AGRUSALDOS, t.AGRUSALDOS ),t.CHEQTERC = isnull( d.CHEQTERC, t.CHEQTERC ),t.CBDATOS = isnull( d.CBDATOS, t.CBDATOS ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.LISTADOS = isnull( d.LISTADOS, t.LISTADOS )
					from ZooLogic.ENVCCMAIL t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.ENVCCMAIL(Fmodifw,Fecimpo,Fectrans,Faltafw,Fecexpo,Horaexpo,Horaimpo,Haltafw,Hmodifw,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Saltafw,Esttrans,Bdaltafw,Bdmodifw,Codigo,Fechad,Fechah,Fpersond,Fpersonh,Comppend,Saldopn,Salsincan,Agrusaldos,Cheqterc,Cbdatos,Clobs,Listados)
					Select isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,0),isnull( d.FECHAD,''),isnull( d.FECHAH,''),isnull( d.FPERSOND,''),isnull( d.FPERSONH,''),isnull( d.COMPPEND,0),isnull( d.SALDOPN,0),isnull( d.SALSINCAN,0),isnull( d.AGRUSALDOS,0),isnull( d.CHEQTERC,0),isnull( d.CBDATOS,''),isnull( d.CLOBS,''),isnull( d.LISTADOS,0)
						From deleted d left join ZooLogic.ENVCCMAIL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ENVCCMAIL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ENVCCMAIL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ENVIODECUENTACORRIENTEPORMAIL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Horaexpo, [] )
					.Horaimpo = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Horaimpo, [] )
					.Horaaltafw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Codigo, 0 )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Fechahasta, ctod( '  /  /    ' ) ) )
					.Clientedesde_PK =  nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Clientedesde, [] )
					.Clientehasta_PK =  nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Clientehasta, [] )
					.Comprobantespendientes = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Comprobantespendientes, 0 )
					.Saldo = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Saldo, 0 )
					.Saldosdecuentasincancelar = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Saldosdecuentasincancelar, 0 )
					.Agruparsaldos = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Agruparsaldos, .F. )
					.Chequesdeterceros = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Chequesdeterceros, .F. )
					.Basededatos = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Basededatos, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Combopersonalizacion = nvl( c_ENVIODECUENTACORRIENTEPORMAIL.Combopersonalizacion, 0 )
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
		return c_ENVIODECUENTACORRIENTEPORMAIL.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ENVCCMAIL' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.ENVCCMAIL 
								Where   ENVCCMAIL.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ENVCCMAIL", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Fpersond" as "Clientedesde", "Fpersonh" as "Clientehasta", "Comppend" as "Comprobantespendientes", "Saldopn" as "Saldo", "Salsincan" as "Saldosdecuentasincancelar", "Agrusaldos" as "Agruparsaldos", "Cheqterc" as "Chequesdeterceros", "Cbdatos" as "Basededatos", "Clobs" as "Observacion", "Listados" as "Combopersonalizacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ENVCCMAIL 
								Where   ENVCCMAIL.CODIGO != 0
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
	Tabla = 'ENVCCMAIL'
	Filtro = " ENVCCMAIL.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ENVCCMAIL.CODIGO != 0"
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
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="FECHAMODIFICACIONFW                     " tabla="ENVCCMAIL      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="FECHAIMPO                               " tabla="ENVCCMAIL      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="FECHATRANSFERENCIA                      " tabla="ENVCCMAIL      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="FECHAALTAFW                             " tabla="ENVCCMAIL      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="FECHAEXPO                               " tabla="ENVCCMAIL      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="HORAEXPO                                " tabla="ENVCCMAIL      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="HORAIMPO                                " tabla="ENVCCMAIL      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="HORAALTAFW                              " tabla="ENVCCMAIL      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="HORAMODIFICACIONFW                      " tabla="ENVCCMAIL      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="VERSIONMODIFICACIONFW                   " tabla="ENVCCMAIL      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="ZADSFW                                  " tabla="ENVCCMAIL      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="VERSIONALTAFW                           " tabla="ENVCCMAIL      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="USUARIOMODIFICACIONFW                   " tabla="ENVCCMAIL      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="SERIEMODIFICACIONFW                     " tabla="ENVCCMAIL      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="USUARIOALTAFW                           " tabla="ENVCCMAIL      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="SERIEALTAFW                             " tabla="ENVCCMAIL      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="ESTADOTRANSFERENCIA                     " tabla="ENVCCMAIL      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="BASEDEDATOSALTAFW                       " tabla="ENVCCMAIL      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ENVCCMAIL      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="CODIGO                                  " tabla="ENVCCMAIL      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="FECHADESDE                              " tabla="ENVCCMAIL      " campo="FECHAD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha desde                                                                                                                                                                                                                                               " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="FECHAHASTA                              " tabla="ENVCCMAIL      " campo="FECHAH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="6" etiqueta="Fecha hasta                                                                                                                                                                                                                                               " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="CLIENTEDESDE                            " tabla="ENVCCMAIL      " campo="FPERSOND  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Cliente desde                                                                                                                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="CLIENTEHASTA                            " tabla="ENVCCMAIL      " campo="FPERSONH  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="404" etiqueta="Cliente hasta                                                                                                                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="COMPROBANTESPENDIENTES                  " tabla="ENVCCMAIL      " campo="COMPPEND  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="406" etiqueta="Comprobantes pendientes                                                                                                                                                                                                                                   " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="SALDO                                   " tabla="ENVCCMAIL      " campo="SALDOPN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="408" etiqueta="Saldo                                                                                                                                                                                                                                                     " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="SALDOSDECUENTASINCANCELAR               " tabla="ENVCCMAIL      " campo="SALSINCAN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="410" etiqueta="Saldos de cuenta sin cancelar                                                                                                                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="AGRUPARSALDOS                           " tabla="ENVCCMAIL      " campo="AGRUSALDOS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="412" etiqueta="Agrupar saldos                                                                                                                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="CHEQUESDETERCEROS                       " tabla="ENVCCMAIL      " campo="CHEQTERC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="414" etiqueta="Incluir cheques de terceros                                                                                                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="BASEDEDATOS                             " tabla="ENVCCMAIL      " campo="CBDATOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Base de datos                                                                                                                                                                                                                                             " dominio="COMBOSUCURSALESCONVACIO       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="OBSERVACION                             " tabla="ENVCCMAIL      " campo="CLOBS     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODECUENTACORRIENTEPORMAIL           " atributo="COMBOPERSONALIZACION                    " tabla="ENVCCMAIL      " campo="LISTADOS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Personalizaciones                                                                                                                                                                                                                                         " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="403" etiqueta="Detalle Cli.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On ENVCCMAIL.FPERSOND = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="405" etiqueta="Detalle Cli.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On ENVCCMAIL.FPERSONH = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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