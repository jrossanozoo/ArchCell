
define class Din_EntidadCAJAESTADOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CAJAESTADO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_034PK'
	cTablaPrincipal = 'CAJAESTA'
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
			local  lxCajaestaFecexpo, lxCajaestaFaltafw, lxCajaestaFmodifw, lxCajaestaFecimpo, lxCajaestaFectrans, lxCajaestaTimestamp, lxCajaestaZadsfw, lxCajaestaSaltafw, lxCajaestaUaltafw, lxCajaestaHmodifw, lxCajaestaValtafw, lxCajaestaUmodifw, lxCajaestaVmodifw, lxCajaestaSmodifw, lxCajaestaEsttrans, lxCajaestaHoraimpo, lxCajaestaHoraexpo, lxCajaestaHaltafw, lxCajaestaBdmodifw, lxCajaestaBdaltafw, lxCajaestaObs, lxCajaestaNumcaja, lxCajaestaDescrip, lxCajaestaFecha, lxCajaestaIdcajaaud, lxCajaestaEstado, lxCajaestaIdusuariop, lxCajaestaFechap, lxCajaestaArqueo, lxCajaestaUsavend, lxCajaestaTotmoneda
				lxCajaestaFecexpo =  .Fechaexpo			lxCajaestaFaltafw =  .Fechaaltafw			lxCajaestaFmodifw =  .Fechamodificacionfw			lxCajaestaFecimpo =  .Fechaimpo			lxCajaestaFectrans =  .Fechatransferencia			lxCajaestaTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaestaZadsfw =  .Zadsfw			lxCajaestaSaltafw =  .Seriealtafw			lxCajaestaUaltafw =  .Usuarioaltafw			lxCajaestaHmodifw =  .Horamodificacionfw			lxCajaestaValtafw =  .Versionaltafw			lxCajaestaUmodifw =  .Usuariomodificacionfw			lxCajaestaVmodifw =  .Versionmodificacionfw			lxCajaestaSmodifw =  .Seriemodificacionfw			lxCajaestaEsttrans =  .Estadotransferencia			lxCajaestaHoraimpo =  .Horaimpo			lxCajaestaHoraexpo =  .Horaexpo			lxCajaestaHaltafw =  .Horaaltafw			lxCajaestaBdmodifw =  .Basededatosmodificacionfw			lxCajaestaBdaltafw =  .Basededatosaltafw			lxCajaestaObs =  .Observacion			lxCajaestaNumcaja =  .Id			lxCajaestaDescrip =  .Descripcion			lxCajaestaFecha =  .Fecha			lxCajaestaIdcajaaud =  .Idcajaauditoria			lxCajaestaEstado =  .Estado			lxCajaestaIdusuariop =  .Usuarioprocesando			lxCajaestaFechap =  .Fechaprocesando			lxCajaestaArqueo =  .Arqueoalcierre			lxCajaestaUsavend =  .Usavendedorarqueoencierre			lxCajaestaTotmoneda =  .Ocultartotalmoneda
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCajaestaNumcaja = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CAJAESTA ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fectrans","Timestamp","Zadsfw","Saltafw","Ualtafw","Hmodifw","Valtafw","Umodifw","Vmodifw","Smodifw","Esttrans","Horaimpo","Horaexpo","Haltafw","Bdmodifw","Bdaltafw","Obs","Numcaja","Descrip","Fecha","Idcajaaud","Estado","Idusuariop","Fechap","Arqueo","Usavend","Totmoneda" ) values ( <<"'" + this.ConvertirDateSql( lxCajaestaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFectrans ) + "'" >>, <<lxCajaestaTimestamp >>, <<"'" + this.FormatearTextoSql( lxCajaestaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaObs ) + "'" >>, <<lxCajaestaNumcaja >>, <<"'" + this.FormatearTextoSql( lxCajaestaDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFecha ) + "'" >>, <<lxCajaestaIdcajaaud >>, <<"'" + this.FormatearTextoSql( lxCajaestaEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaIdusuariop ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFechap ) + "'" >>, <<iif( lxCajaestaArqueo, 1, 0 ) >>, <<iif( lxCajaestaUsavend, 1, 0 ) >>, <<iif( lxCajaestaTotmoneda, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ID
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
		this.oEntidad.Timestamp = lxCajaestaTimestamp
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
		return this.oEntidad.ID
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxCajaestaFecexpo, lxCajaestaFaltafw, lxCajaestaFmodifw, lxCajaestaFecimpo, lxCajaestaFectrans, lxCajaestaTimestamp, lxCajaestaZadsfw, lxCajaestaSaltafw, lxCajaestaUaltafw, lxCajaestaHmodifw, lxCajaestaValtafw, lxCajaestaUmodifw, lxCajaestaVmodifw, lxCajaestaSmodifw, lxCajaestaEsttrans, lxCajaestaHoraimpo, lxCajaestaHoraexpo, lxCajaestaHaltafw, lxCajaestaBdmodifw, lxCajaestaBdaltafw, lxCajaestaObs, lxCajaestaNumcaja, lxCajaestaDescrip, lxCajaestaFecha, lxCajaestaIdcajaaud, lxCajaestaEstado, lxCajaestaIdusuariop, lxCajaestaFechap, lxCajaestaArqueo, lxCajaestaUsavend, lxCajaestaTotmoneda
				lxCajaestaFecexpo =  .Fechaexpo			lxCajaestaFaltafw =  .Fechaaltafw			lxCajaestaFmodifw =  .Fechamodificacionfw			lxCajaestaFecimpo =  .Fechaimpo			lxCajaestaFectrans =  .Fechatransferencia			lxCajaestaTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaestaZadsfw =  .Zadsfw			lxCajaestaSaltafw =  .Seriealtafw			lxCajaestaUaltafw =  .Usuarioaltafw			lxCajaestaHmodifw =  .Horamodificacionfw			lxCajaestaValtafw =  .Versionaltafw			lxCajaestaUmodifw =  .Usuariomodificacionfw			lxCajaestaVmodifw =  .Versionmodificacionfw			lxCajaestaSmodifw =  .Seriemodificacionfw			lxCajaestaEsttrans =  .Estadotransferencia			lxCajaestaHoraimpo =  .Horaimpo			lxCajaestaHoraexpo =  .Horaexpo			lxCajaestaHaltafw =  .Horaaltafw			lxCajaestaBdmodifw =  .Basededatosmodificacionfw			lxCajaestaBdaltafw =  .Basededatosaltafw			lxCajaestaObs =  .Observacion			lxCajaestaNumcaja =  .Id			lxCajaestaDescrip =  .Descripcion			lxCajaestaFecha =  .Fecha			lxCajaestaIdcajaaud =  .Idcajaauditoria			lxCajaestaEstado =  .Estado			lxCajaestaIdusuariop =  .Usuarioprocesando			lxCajaestaFechap =  .Fechaprocesando			lxCajaestaArqueo =  .Arqueoalcierre			lxCajaestaUsavend =  .Usavendedorarqueoencierre			lxCajaestaTotmoneda =  .Ocultartotalmoneda
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
			lxValorClavePrimaria = .oEntidad.ID
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CAJAESTA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCajaestaFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCajaestaFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCajaestaFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCajaestaFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCajaestaFectrans ) + "'">>,"Timestamp" = <<lxCajaestaTimestamp>>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCajaestaZadsfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCajaestaSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCajaestaUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaHmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCajaestaValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaSmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCajaestaEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCajaestaHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCajaestaHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCajaestaHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCajaestaBdaltafw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCajaestaObs ) + "'">>,"Numcaja" = <<lxCajaestaNumcaja>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxCajaestaDescrip ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCajaestaFecha ) + "'">>,"Idcajaaud" = <<lxCajaestaIdcajaaud>>,"Estado" = <<"'" + this.FormatearTextoSql( lxCajaestaEstado ) + "'">>,"Idusuariop" = <<"'" + this.FormatearTextoSql( lxCajaestaIdusuariop ) + "'">>,"Fechap" = <<"'" + this.ConvertirDateSql( lxCajaestaFechap ) + "'">>,"Arqueo" = <<iif( lxCajaestaArqueo, 1, 0 )>>,"Usavend" = <<iif( lxCajaestaUsavend, 1, 0 )>>,"Totmoneda" = <<iif( lxCajaestaTotmoneda, 1, 0 )>> where "Numcaja" = <<lxCajaestaNumcaja>> and  CAJAESTA.NUMCAJA != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCajaestaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NumCaja from ZooLogic.CAJAESTA where " + this.ConvertirFuncionesSql( " CAJAESTA.NUMCAJA != 0" ) )
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
			Local lxCajaestaNumcaja
			lxCajaestaNumcaja = .Id

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion", "Numcaja" as "Id", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Idcajaaud" as "Idcajaauditoria", "Estado" as "Estado", "Idusuariop" as "Usuarioprocesando", "Fechap" as "Fechaprocesando", "Arqueo" as "Arqueoalcierre", "Usavend" as "Usavendedorarqueoencierre", "Totmoneda" as "Ocultartotalmoneda" from ZooLogic.CAJAESTA where "Numcaja" = <<lxCajaestaNumcaja>> and  CAJAESTA.NUMCAJA != 0
			endtext
			use in select('c_CAJAESTADO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAESTADO', set( 'Datasession' ) )

			if reccount( 'c_CAJAESTADO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCajaestaNumcaja as Variant
		llRetorno = .t.
		lxCajaestaNumcaja = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CAJAESTA where "Numcaja" = <<lxCajaestaNumcaja>> and  CAJAESTA.NUMCAJA != 0
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
				lcOrden =  str( .Id, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion", "Numcaja" as "Id", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Idcajaaud" as "Idcajaauditoria", "Estado" as "Estado", "Idusuariop" as "Usuarioprocesando", "Fechap" as "Fechaprocesando", "Arqueo" as "Arqueoalcierre", "Usavend" as "Usavendedorarqueoencierre", "Totmoneda" as "Ocultartotalmoneda" from ZooLogic.CAJAESTA where  CAJAESTA.NUMCAJA != 0 order by NumCaja
			endtext
			use in select('c_CAJAESTADO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAESTADO', set( 'Datasession' ) )
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
				lcOrden =  str( .Id, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion", "Numcaja" as "Id", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Idcajaaud" as "Idcajaauditoria", "Estado" as "Estado", "Idusuariop" as "Usuarioprocesando", "Fechap" as "Fechaprocesando", "Arqueo" as "Arqueoalcierre", "Usavend" as "Usavendedorarqueoencierre", "Totmoneda" as "Ocultartotalmoneda" from ZooLogic.CAJAESTA where  str( NumCaja, 2, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAJAESTA.NUMCAJA != 0 order by NumCaja
			endtext
			use in select('c_CAJAESTADO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAESTADO', set( 'Datasession' ) )
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
				lcOrden =  str( .Id, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion", "Numcaja" as "Id", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Idcajaaud" as "Idcajaauditoria", "Estado" as "Estado", "Idusuariop" as "Usuarioprocesando", "Fechap" as "Fechaprocesando", "Arqueo" as "Arqueoalcierre", "Usavend" as "Usavendedorarqueoencierre", "Totmoneda" as "Ocultartotalmoneda" from ZooLogic.CAJAESTA where  str( NumCaja, 2, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAJAESTA.NUMCAJA != 0 order by NumCaja desc
			endtext
			use in select('c_CAJAESTADO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAESTADO', set( 'Datasession' ) )
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
				lcOrden =  str( .Id, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion", "Numcaja" as "Id", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Idcajaaud" as "Idcajaauditoria", "Estado" as "Estado", "Idusuariop" as "Usuarioprocesando", "Fechap" as "Fechaprocesando", "Arqueo" as "Arqueoalcierre", "Usavend" as "Usavendedorarqueoencierre", "Totmoneda" as "Ocultartotalmoneda" from ZooLogic.CAJAESTA where  CAJAESTA.NUMCAJA != 0 order by NumCaja desc
			endtext
			use in select('c_CAJAESTADO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAESTADO', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.ID )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fmodifw,Fecimpo,Fectrans,Timestamp,Zadsfw,Saltafw,Ualtafw,Hmodifw,Valtafw,Um" + ;
"odifw,Vmodifw,Smodifw,Esttrans,Horaimpo,Horaexpo,Haltafw,Bdmodifw,Bdaltafw,Obs,Numcaja,Descrip,Fecha" + ;
",Idcajaaud,Estado,Idusuariop,Fechap,Arqueo,Usavend,Totmoneda" + ;
" from ZooLogic.CAJAESTA where  CAJAESTA.NUMCAJA != 0 and " + lcFiltro )
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
			local  lxCajaestaFecexpo, lxCajaestaFaltafw, lxCajaestaFmodifw, lxCajaestaFecimpo, lxCajaestaFectrans, lxCajaestaTimestamp, lxCajaestaZadsfw, lxCajaestaSaltafw, lxCajaestaUaltafw, lxCajaestaHmodifw, lxCajaestaValtafw, lxCajaestaUmodifw, lxCajaestaVmodifw, lxCajaestaSmodifw, lxCajaestaEsttrans, lxCajaestaHoraimpo, lxCajaestaHoraexpo, lxCajaestaHaltafw, lxCajaestaBdmodifw, lxCajaestaBdaltafw, lxCajaestaObs, lxCajaestaNumcaja, lxCajaestaDescrip, lxCajaestaFecha, lxCajaestaIdcajaaud, lxCajaestaEstado, lxCajaestaIdusuariop, lxCajaestaFechap, lxCajaestaArqueo, lxCajaestaUsavend, lxCajaestaTotmoneda
				lxCajaestaFecexpo = ctod( '  /  /    ' )			lxCajaestaFaltafw = ctod( '  /  /    ' )			lxCajaestaFmodifw = ctod( '  /  /    ' )			lxCajaestaFecimpo = ctod( '  /  /    ' )			lxCajaestaFectrans = ctod( '  /  /    ' )			lxCajaestaTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaestaZadsfw = []			lxCajaestaSaltafw = []			lxCajaestaUaltafw = []			lxCajaestaHmodifw = []			lxCajaestaValtafw = []			lxCajaestaUmodifw = []			lxCajaestaVmodifw = []			lxCajaestaSmodifw = []			lxCajaestaEsttrans = []			lxCajaestaHoraimpo = []			lxCajaestaHoraexpo = []			lxCajaestaHaltafw = []			lxCajaestaBdmodifw = []			lxCajaestaBdaltafw = []			lxCajaestaObs = []			lxCajaestaNumcaja = 0			lxCajaestaDescrip = []			lxCajaestaFecha = ctod( '  /  /    ' )			lxCajaestaIdcajaaud = 0			lxCajaestaEstado = []			lxCajaestaIdusuariop = []			lxCajaestaFechap = ctod( '  /  /    ' )			lxCajaestaArqueo = .F.			lxCajaestaUsavend = .F.			lxCajaestaTotmoneda = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CAJAESTA where "NumCaja" = ] + transform( .oEntidad.ID )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CAJAESTA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NumCaja = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NumCaja, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CAJAESTA.NUMCAJA != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion", "Numcaja" as "Id", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Idcajaaud" as "Idcajaauditoria", "Estado" as "Estado", "Idusuariop" as "Usuarioprocesando", "Fechap" as "Fechaprocesando", "Arqueo" as "Arqueoalcierre", "Usavend" as "Usavendedorarqueoencierre", "Totmoneda" as "Ocultartotalmoneda"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CAJAESTA', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'ID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCAJA AS ID'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'IDCAJAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJAAUD AS IDCAJAAUDITORIA'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADO'
				Case lcAtributo == 'USUARIOPROCESANDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDUSUARIOP AS USUARIOPROCESANDO'
				Case lcAtributo == 'FECHAPROCESANDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAP AS FECHAPROCESANDO'
				Case lcAtributo == 'ARQUEOALCIERRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARQUEO AS ARQUEOALCIERRE'
				Case lcAtributo == 'USAVENDEDORARQUEOENCIERRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USAVEND AS USAVENDEDORARQUEOENCIERRE'
				Case lcAtributo == 'OCULTARTOTALMONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTMONEDA AS OCULTARTOTALMONEDA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'ID'
				lcCampo = 'NUMCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'IDCAJAAUDITORIA'
				lcCampo = 'IDCAJAAUD'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOPROCESANDO'
				lcCampo = 'IDUSUARIOP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAPROCESANDO'
				lcCampo = 'FECHAP'
			Case upper( alltrim( tcAtributo ) ) == 'ARQUEOALCIERRE'
				lcCampo = 'ARQUEO'
			Case upper( alltrim( tcAtributo ) ) == 'USAVENDEDORARQUEOENCIERRE'
				lcCampo = 'USAVEND'
			Case upper( alltrim( tcAtributo ) ) == 'OCULTARTOTALMONEDA'
				lcCampo = 'TOTMONEDA'
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
			local  lxCajaestaFecexpo, lxCajaestaFaltafw, lxCajaestaFmodifw, lxCajaestaFecimpo, lxCajaestaFectrans, lxCajaestaTimestamp, lxCajaestaZadsfw, lxCajaestaSaltafw, lxCajaestaUaltafw, lxCajaestaHmodifw, lxCajaestaValtafw, lxCajaestaUmodifw, lxCajaestaVmodifw, lxCajaestaSmodifw, lxCajaestaEsttrans, lxCajaestaHoraimpo, lxCajaestaHoraexpo, lxCajaestaHaltafw, lxCajaestaBdmodifw, lxCajaestaBdaltafw, lxCajaestaObs, lxCajaestaNumcaja, lxCajaestaDescrip, lxCajaestaFecha, lxCajaestaIdcajaaud, lxCajaestaEstado, lxCajaestaIdusuariop, lxCajaestaFechap, lxCajaestaArqueo, lxCajaestaUsavend, lxCajaestaTotmoneda
				lxCajaestaFecexpo =  .Fechaexpo			lxCajaestaFaltafw =  .Fechaaltafw			lxCajaestaFmodifw =  .Fechamodificacionfw			lxCajaestaFecimpo =  .Fechaimpo			lxCajaestaFectrans =  .Fechatransferencia			lxCajaestaTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaestaZadsfw =  .Zadsfw			lxCajaestaSaltafw =  .Seriealtafw			lxCajaestaUaltafw =  .Usuarioaltafw			lxCajaestaHmodifw =  .Horamodificacionfw			lxCajaestaValtafw =  .Versionaltafw			lxCajaestaUmodifw =  .Usuariomodificacionfw			lxCajaestaVmodifw =  .Versionmodificacionfw			lxCajaestaSmodifw =  .Seriemodificacionfw			lxCajaestaEsttrans =  .Estadotransferencia			lxCajaestaHoraimpo =  .Horaimpo			lxCajaestaHoraexpo =  .Horaexpo			lxCajaestaHaltafw =  .Horaaltafw			lxCajaestaBdmodifw =  .Basededatosmodificacionfw			lxCajaestaBdaltafw =  .Basededatosaltafw			lxCajaestaObs =  .Observacion			lxCajaestaNumcaja =  .Id			lxCajaestaDescrip =  .Descripcion			lxCajaestaFecha =  .Fecha			lxCajaestaIdcajaaud =  .Idcajaauditoria			lxCajaestaEstado =  .Estado			lxCajaestaIdusuariop =  .Usuarioprocesando			lxCajaestaFechap =  .Fechaprocesando			lxCajaestaArqueo =  .Arqueoalcierre			lxCajaestaUsavend =  .Usavendedorarqueoencierre			lxCajaestaTotmoneda =  .Ocultartotalmoneda
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CAJAESTA ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fectrans","Timestamp","Zadsfw","Saltafw","Ualtafw","Hmodifw","Valtafw","Umodifw","Vmodifw","Smodifw","Esttrans","Horaimpo","Horaexpo","Haltafw","Bdmodifw","Bdaltafw","Obs","Numcaja","Descrip","Fecha","Idcajaaud","Estado","Idusuariop","Fechap","Arqueo","Usavend","Totmoneda" ) values ( <<"'" + this.ConvertirDateSql( lxCajaestaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFectrans ) + "'" >>, <<lxCajaestaTimestamp >>, <<"'" + this.FormatearTextoSql( lxCajaestaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaObs ) + "'" >>, <<lxCajaestaNumcaja >>, <<"'" + this.FormatearTextoSql( lxCajaestaDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFecha ) + "'" >>, <<lxCajaestaIdcajaaud >>, <<"'" + this.FormatearTextoSql( lxCajaestaEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaestaIdusuariop ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaestaFechap ) + "'" >>, <<iif( lxCajaestaArqueo, 1, 0 ) >>, <<iif( lxCajaestaUsavend, 1, 0 ) >>, <<iif( lxCajaestaTotmoneda, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'CAJAESTA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.ID )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCajaestaFecexpo, lxCajaestaFaltafw, lxCajaestaFmodifw, lxCajaestaFecimpo, lxCajaestaFectrans, lxCajaestaTimestamp, lxCajaestaZadsfw, lxCajaestaSaltafw, lxCajaestaUaltafw, lxCajaestaHmodifw, lxCajaestaValtafw, lxCajaestaUmodifw, lxCajaestaVmodifw, lxCajaestaSmodifw, lxCajaestaEsttrans, lxCajaestaHoraimpo, lxCajaestaHoraexpo, lxCajaestaHaltafw, lxCajaestaBdmodifw, lxCajaestaBdaltafw, lxCajaestaObs, lxCajaestaNumcaja, lxCajaestaDescrip, lxCajaestaFecha, lxCajaestaIdcajaaud, lxCajaestaEstado, lxCajaestaIdusuariop, lxCajaestaFechap, lxCajaestaArqueo, lxCajaestaUsavend, lxCajaestaTotmoneda
				lxCajaestaFecexpo =  .Fechaexpo			lxCajaestaFaltafw =  .Fechaaltafw			lxCajaestaFmodifw =  .Fechamodificacionfw			lxCajaestaFecimpo =  .Fechaimpo			lxCajaestaFectrans =  .Fechatransferencia			lxCajaestaTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaestaZadsfw =  .Zadsfw			lxCajaestaSaltafw =  .Seriealtafw			lxCajaestaUaltafw =  .Usuarioaltafw			lxCajaestaHmodifw =  .Horamodificacionfw			lxCajaestaValtafw =  .Versionaltafw			lxCajaestaUmodifw =  .Usuariomodificacionfw			lxCajaestaVmodifw =  .Versionmodificacionfw			lxCajaestaSmodifw =  .Seriemodificacionfw			lxCajaestaEsttrans =  .Estadotransferencia			lxCajaestaHoraimpo =  .Horaimpo			lxCajaestaHoraexpo =  .Horaexpo			lxCajaestaHaltafw =  .Horaaltafw			lxCajaestaBdmodifw =  .Basededatosmodificacionfw			lxCajaestaBdaltafw =  .Basededatosaltafw			lxCajaestaObs =  .Observacion			lxCajaestaNumcaja =  .Id			lxCajaestaDescrip =  .Descripcion			lxCajaestaFecha =  .Fecha			lxCajaestaIdcajaaud =  .Idcajaauditoria			lxCajaestaEstado =  .Estado			lxCajaestaIdusuariop =  .Usuarioprocesando			lxCajaestaFechap =  .Fechaprocesando			lxCajaestaArqueo =  .Arqueoalcierre			lxCajaestaUsavend =  .Usavendedorarqueoencierre			lxCajaestaTotmoneda =  .Ocultartotalmoneda
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ID
			lcValorClavePrimariaString = transform( this.oEntidad.ID )

			lcFiltro = ["Numcaja" = ] + lcValorClavePrimariaString  + [ and  CAJAESTA.NUMCAJA != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CAJAESTA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCajaestaFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCajaestaFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCajaestaFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCajaestaFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCajaestaFectrans ) + "'">>, "Timestamp" = <<lxCajaestaTimestamp>>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCajaestaZadsfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCajaestaSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCajaestaUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaHmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCajaestaValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaSmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCajaestaEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCajaestaHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCajaestaHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCajaestaHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCajaestaBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCajaestaBdaltafw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCajaestaObs ) + "'">>, "Numcaja" = <<lxCajaestaNumcaja>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxCajaestaDescrip ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCajaestaFecha ) + "'">>, "Idcajaaud" = <<lxCajaestaIdcajaaud>>, "Estado" = <<"'" + this.FormatearTextoSql( lxCajaestaEstado ) + "'">>, "Idusuariop" = <<"'" + this.FormatearTextoSql( lxCajaestaIdusuariop ) + "'">>, "Fechap" = <<"'" + this.ConvertirDateSql( lxCajaestaFechap ) + "'">>, "Arqueo" = <<iif( lxCajaestaArqueo, 1, 0 )>>, "Usavend" = <<iif( lxCajaestaUsavend, 1, 0 )>>, "Totmoneda" = <<iif( lxCajaestaTotmoneda, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CAJAESTA' 
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
			lxValorClavePrimaria = this.oEntidad.ID
			lcValorClavePrimariaString = transform( this.oEntidad.ID )

			lcFiltro = ["Numcaja" = ] + lcValorClavePrimariaString  + [ and  CAJAESTA.NUMCAJA != 0]
		loColeccion.Agregar( 'delete from ZooLogic.CAJAESTA where ' + lcFiltro )
			loColeccion.cTabla = 'CAJAESTA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CAJAESTA where  CAJAESTA.NUMCAJA != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CAJAESTA where NumCaja = " + transform( this.oEntidad.ID )+ " and  CAJAESTA.NUMCAJA != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAESTADO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CAJAESTA Where NumCaja = ] + transform( &lcCursor..NumCaja ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CAJAESTA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, NumCaja = ] + transform( &lcCursor..NumCaja )+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Estado = ] + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"+ [, idUsuarioP = ] + "'" + this.FormatearTextoSql( &lcCursor..idUsuarioP ) + "'"+ [, Fechap = ] + "'" + this.ConvertirDateSql( &lcCursor..Fechap ) + "'"+ [, Arqueo = ] + Transform( iif( &lcCursor..Arqueo, 1, 0 ))+ [, UsaVend = ] + Transform( iif( &lcCursor..UsaVend, 1, 0 ))+ [, TotMoneda = ] + Transform( iif( &lcCursor..TotMoneda, 1, 0 )) + [ Where NumCaja = ] + transform( &lcCursor..NumCaja ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FMODIFW, FECIMPO, FECTRANS, TIMESTAMP, ZADSFW, SALTAFW, UALTAFW, HMODIFW, VALTAFW, UMODIFW, VMODIFW, SMODIFW, ESTTRANS, HORAIMPO, HORAEXPO, HALTAFW, BDMODIFW, BDALTAFW, Obs, NumCaja, Descrip, Fecha, Estado, idUsuarioP, Fechap, Arqueo, UsaVend, TotMoneda
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NumCaja ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idUsuarioP ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fechap ) + "'" + ',' + Transform( iif( &lcCursor..Arqueo, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..UsaVend, 1, 0 )) + ',' + Transform( iif( &lcCursor..TotMoneda, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CAJAESTA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAESTADO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NumCaja N (2) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número de caja: ' + transform( &tcCursor..NumCaja    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CAJAESTADO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAJAESTADO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAJAESTADO_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CajaEsta')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CAJAESTADO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NumCaja
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CAJAESTADO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAESTADO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NumCaja as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NumCaja, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAESTADO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  Fechap    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CajaEsta') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CajaEsta
Create Table ZooLogic.TablaTrabajo_CajaEsta ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"zadsfw" varchar(max)  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"obs" varchar(max)  null, 
"numcaja" numeric( 2, 0 )  null, 
"descrip" char( 40 )  null, 
"fecha" datetime  null, 
"idcajaaud" numeric( 10, 0 )  null, 
"estado" char( 1 )  null, 
"idusuariop" char( 254 )  null, 
"fechap" datetime  null, 
"arqueo" bit  null, 
"usavend" bit  null, 
"totmoneda" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CajaEsta' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CajaEsta' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAESTADO'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('numcaja','numcaja')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('idcajaaud','idcajaaud')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('idusuariop','idusuariop')
			.AgregarMapeo('fechap','fechap')
			.AgregarMapeo('arqueo','arqueo')
			.AgregarMapeo('usavend','usavend')
			.AgregarMapeo('totmoneda','totmoneda')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CajaEsta'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.OBS = isnull( d.OBS, t.OBS ),t.NUMCAJA = isnull( d.NUMCAJA, t.NUMCAJA ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.IDCAJAAUD = isnull( d.IDCAJAAUD, t.IDCAJAAUD ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.IDUSUARIOP = isnull( d.IDUSUARIOP, t.IDUSUARIOP ),t.FECHAP = isnull( d.FECHAP, t.FECHAP ),t.ARQUEO = isnull( d.ARQUEO, t.ARQUEO ),t.USAVEND = isnull( d.USAVEND, t.USAVEND ),t.TOTMONEDA = isnull( d.TOTMONEDA, t.TOTMONEDA )
					from ZooLogic.CAJAESTA t inner join deleted d 
							 on t.NumCaja = d.NumCaja
				-- Fin Updates
				insert into ZooLogic.CAJAESTA(Fecexpo,Faltafw,Fmodifw,Fecimpo,Fectrans,Timestamp,Zadsfw,Saltafw,Ualtafw,Hmodifw,Valtafw,Umodifw,Vmodifw,Smodifw,Esttrans,Horaimpo,Horaexpo,Haltafw,Bdmodifw,Bdaltafw,Obs,Numcaja,Descrip,Fecha,Idcajaaud,Estado,Idusuariop,Fechap,Arqueo,Usavend,Totmoneda)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.ZADSFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.OBS,''),isnull( d.NUMCAJA,0),isnull( d.DESCRIP,''),isnull( d.FECHA,''),isnull( d.IDCAJAAUD,0),isnull( d.ESTADO,''),isnull( d.IDUSUARIOP,''),isnull( d.FECHAP,''),isnull( d.ARQUEO,0),isnull( d.USAVEND,0),isnull( d.TOTMONEDA,0)
						From deleted d left join ZooLogic.CAJAESTA pk 
							 on d.NumCaja = pk.NumCaja
						Where pk.NumCaja Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CajaEsta') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CajaEsta
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CAJAESTADO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAESTADO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAESTADO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAESTADO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAESTADO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAESTADO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_CAJAESTADO.Timestamp, 0 )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriealtafw = nvl( c_CAJAESTADO.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CAJAESTADO.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_CAJAESTADO.Horamodificacionfw, [] )
					.Versionaltafw = nvl( c_CAJAESTADO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CAJAESTADO.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CAJAESTADO.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CAJAESTADO.Seriemodificacionfw, [] )
					.Estadotransferencia = nvl( c_CAJAESTADO.Estadotransferencia, [] )
					.Horaimpo = nvl( c_CAJAESTADO.Horaimpo, [] )
					.Horaexpo = nvl( c_CAJAESTADO.Horaexpo, [] )
					.Horaaltafw = nvl( c_CAJAESTADO.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CAJAESTADO.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CAJAESTADO.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Id = nvl( c_CAJAESTADO.Id, 0 )
					.Descripcion = nvl( c_CAJAESTADO.Descripcion, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAESTADO.Fecha, ctod( '  /  /    ' ) ) )
					.Idcajaauditoria = nvl( c_CAJAESTADO.Idcajaauditoria, 0 )
					.Estado = nvl( c_CAJAESTADO.Estado, [] )
					.Usuarioprocesando = nvl( c_CAJAESTADO.Usuarioprocesando, [] )
					.Fechaprocesando = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAESTADO.Fechaprocesando, ctod( '  /  /    ' ) ) )
					.Arqueoalcierre = nvl( c_CAJAESTADO.Arqueoalcierre, .F. )
					.Usavendedorarqueoencierre = nvl( c_CAJAESTADO.Usavendedorarqueoencierre, .F. )
					.Ocultartotalmoneda = nvl( c_CAJAESTADO.Ocultartotalmoneda, .F. )
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
		return c_CAJAESTADO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CAJAESTA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NumCaja"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NumCaja as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NumCaja from (
							select * 
								from ZooLogic.CAJAESTA 
								Where   CAJAESTA.NUMCAJA != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CAJAESTA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NumCaja"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion", "Numcaja" as "Id", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Idcajaaud" as "Idcajaauditoria", "Estado" as "Estado", "Idusuariop" as "Usuarioprocesando", "Fechap" as "Fechaprocesando", "Arqueo" as "Arqueoalcierre", "Usavend" as "Usavendedorarqueoencierre", "Totmoneda" as "Ocultartotalmoneda"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CAJAESTA 
								Where   CAJAESTA.NUMCAJA != 0
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
	Tabla = 'CAJAESTA'
	Filtro = " CAJAESTA.NUMCAJA != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CAJAESTA.NUMCAJA != 0"
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
	<row entidad="CAJAESTADO                              " atributo="FECHAEXPO                               " tabla="CAJAESTA       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="FECHAALTAFW                             " tabla="CAJAESTA       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="FECHAMODIFICACIONFW                     " tabla="CAJAESTA       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="FECHAIMPO                               " tabla="CAJAESTA       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="FECHATRANSFERENCIA                      " tabla="CAJAESTA       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="TIMESTAMP                               " tabla="CAJAESTA       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="ZADSFW                                  " tabla="CAJAESTA       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="SERIEALTAFW                             " tabla="CAJAESTA       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="USUARIOALTAFW                           " tabla="CAJAESTA       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="HORAMODIFICACIONFW                      " tabla="CAJAESTA       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="VERSIONALTAFW                           " tabla="CAJAESTA       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="USUARIOMODIFICACIONFW                   " tabla="CAJAESTA       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="VERSIONMODIFICACIONFW                   " tabla="CAJAESTA       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="SERIEMODIFICACIONFW                     " tabla="CAJAESTA       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="ESTADOTRANSFERENCIA                     " tabla="CAJAESTA       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="HORAIMPO                                " tabla="CAJAESTA       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="HORAEXPO                                " tabla="CAJAESTA       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="HORAALTAFW                              " tabla="CAJAESTA       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CAJAESTA       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="BASEDEDATOSALTAFW                       " tabla="CAJAESTA       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="OBSERVACION                             " tabla="CAJAESTA       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="ID                                      " tabla="CAJAESTA       " campo="NUMCAJA   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Número de caja                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCIONESTADO                       " tabla="CAJAESTA       " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Estado                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="FECHA                                   " tabla="CAJAESTA       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="IDCAJAAUDITORIA                         " tabla="CAJAESTA       " campo="IDCAJAAUD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id Caja Auditoria                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="ESTADO                                  " tabla="CAJAESTA       " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;C&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="0" etiqueta="Estado                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="USUARIOPROCESANDO                       " tabla="CAJAESTA       " campo="IDUSUARIOP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="idUsuario                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="FECHAPROCESANDO                         " tabla="CAJAESTA       " campo="FECHAP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="ARQUEOALCIERRE                          " tabla="CAJAESTA       " campo="ARQUEO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Arqueo obligatorio al cierre                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="USAVENDEDORARQUEOENCIERRE               " tabla="CAJAESTA       " campo="USAVEND   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Traslada vendedor del arqueo al cierre                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="OCULTARTOTALMONEDA                      " tabla="CAJAESTA       " campo="TOTMONEDA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Ocultar totales de moneda                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="FECHAULTIMAAPERTURA                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Fecha de última apertura                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="HORAULTIMAAPERTURA                      " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Hora de última apertura                                                                                                                                         " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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