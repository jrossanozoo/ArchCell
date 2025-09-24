
define class Din_EntidadINFORMEVENTASLPSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_INFORMEVENTASLPS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IVSPK'
	cTablaPrincipal = 'INFOVTASLPS'
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
			local  lxInfovtaslpsFecexpo, lxInfovtaslpsFectrans, lxInfovtaslpsFecimpo, lxInfovtaslpsFaltafw, lxInfovtaslpsFmodifw, lxInfovtaslpsFecinfo, lxInfovtaslpsIndentif, lxInfovtaslpsEstado, lxInfovtaslpsTimestamp, lxInfovtaslpsZadsfw, lxInfovtaslpsSmodifw, lxInfovtaslpsUmodifw, lxInfovtaslpsUaltafw, lxInfovtaslpsValtafw, lxInfovtaslpsSaltafw, lxInfovtaslpsVmodifw, lxInfovtaslpsHoraexpo, lxInfovtaslpsHmodifw, lxInfovtaslpsBdmodifw, lxInfovtaslpsBdaltafw, lxInfovtaslpsEsttrans, lxInfovtaslpsHorainfo, lxInfovtaslpsMensaje, lxInfovtaslpsHaltafw, lxInfovtaslpsHoraimpo, lxInfovtaslpsCodigo
				lxInfovtaslpsFecexpo =  .Fechaexpo			lxInfovtaslpsFectrans =  .Fechatransferencia			lxInfovtaslpsFecimpo =  .Fechaimpo			lxInfovtaslpsFaltafw =  .Fechaaltafw			lxInfovtaslpsFmodifw =  .Fechamodificacionfw			lxInfovtaslpsFecinfo =  .Fechainforme			lxInfovtaslpsIndentif =  .Identificador			lxInfovtaslpsEstado =  .Estado			lxInfovtaslpsTimestamp = goLibrerias.ObtenerTimestamp()			lxInfovtaslpsZadsfw =  .Zadsfw			lxInfovtaslpsSmodifw =  .Seriemodificacionfw			lxInfovtaslpsUmodifw =  .Usuariomodificacionfw			lxInfovtaslpsUaltafw =  .Usuarioaltafw			lxInfovtaslpsValtafw =  .Versionaltafw			lxInfovtaslpsSaltafw =  .Seriealtafw			lxInfovtaslpsVmodifw =  .Versionmodificacionfw			lxInfovtaslpsHoraexpo =  .Horaexpo			lxInfovtaslpsHmodifw =  .Horamodificacionfw			lxInfovtaslpsBdmodifw =  .Basededatosmodificacionfw			lxInfovtaslpsBdaltafw =  .Basededatosaltafw			lxInfovtaslpsEsttrans =  .Estadotransferencia			lxInfovtaslpsHorainfo =  .Horainforme			lxInfovtaslpsMensaje =  .Mensaje			lxInfovtaslpsHaltafw =  .Horaaltafw			lxInfovtaslpsHoraimpo =  .Horaimpo			lxInfovtaslpsCodigo =  .Codigo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxInfovtaslpsCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.INFOVTASLPS ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Fecinfo","Indentif","Estado","Timestamp","Zadsfw","Smodifw","Umodifw","Ualtafw","Valtafw","Saltafw","Vmodifw","Horaexpo","Hmodifw","Bdmodifw","Bdaltafw","Esttrans","Horainfo","Mensaje","Haltafw","Horaimpo","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecinfo ) + "'" >>, <<lxInfovtaslpsIndentif >>, <<lxInfovtaslpsEstado >>, <<lxInfovtaslpsTimestamp >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHorainfo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsMensaje ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsCodigo ) + "'" >> )
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
		this.oEntidad.Timestamp = lxInfovtaslpsTimestamp
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
			local  lxInfovtaslpsFecexpo, lxInfovtaslpsFectrans, lxInfovtaslpsFecimpo, lxInfovtaslpsFaltafw, lxInfovtaslpsFmodifw, lxInfovtaslpsFecinfo, lxInfovtaslpsIndentif, lxInfovtaslpsEstado, lxInfovtaslpsTimestamp, lxInfovtaslpsZadsfw, lxInfovtaslpsSmodifw, lxInfovtaslpsUmodifw, lxInfovtaslpsUaltafw, lxInfovtaslpsValtafw, lxInfovtaslpsSaltafw, lxInfovtaslpsVmodifw, lxInfovtaslpsHoraexpo, lxInfovtaslpsHmodifw, lxInfovtaslpsBdmodifw, lxInfovtaslpsBdaltafw, lxInfovtaslpsEsttrans, lxInfovtaslpsHorainfo, lxInfovtaslpsMensaje, lxInfovtaslpsHaltafw, lxInfovtaslpsHoraimpo, lxInfovtaslpsCodigo
				lxInfovtaslpsFecexpo =  .Fechaexpo			lxInfovtaslpsFectrans =  .Fechatransferencia			lxInfovtaslpsFecimpo =  .Fechaimpo			lxInfovtaslpsFaltafw =  .Fechaaltafw			lxInfovtaslpsFmodifw =  .Fechamodificacionfw			lxInfovtaslpsFecinfo =  .Fechainforme			lxInfovtaslpsIndentif =  .Identificador			lxInfovtaslpsEstado =  .Estado			lxInfovtaslpsTimestamp = goLibrerias.ObtenerTimestamp()			lxInfovtaslpsZadsfw =  .Zadsfw			lxInfovtaslpsSmodifw =  .Seriemodificacionfw			lxInfovtaslpsUmodifw =  .Usuariomodificacionfw			lxInfovtaslpsUaltafw =  .Usuarioaltafw			lxInfovtaslpsValtafw =  .Versionaltafw			lxInfovtaslpsSaltafw =  .Seriealtafw			lxInfovtaslpsVmodifw =  .Versionmodificacionfw			lxInfovtaslpsHoraexpo =  .Horaexpo			lxInfovtaslpsHmodifw =  .Horamodificacionfw			lxInfovtaslpsBdmodifw =  .Basededatosmodificacionfw			lxInfovtaslpsBdaltafw =  .Basededatosaltafw			lxInfovtaslpsEsttrans =  .Estadotransferencia			lxInfovtaslpsHorainfo =  .Horainforme			lxInfovtaslpsMensaje =  .Mensaje			lxInfovtaslpsHaltafw =  .Horaaltafw			lxInfovtaslpsHoraimpo =  .Horaimpo			lxInfovtaslpsCodigo =  .Codigo
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
				update ZooLogic.INFOVTASLPS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFmodifw ) + "'">>,"Fecinfo" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecinfo ) + "'">>,"Indentif" = <<lxInfovtaslpsIndentif>>,"Estado" = <<lxInfovtaslpsEstado>>,"Timestamp" = <<lxInfovtaslpsTimestamp>>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsZadsfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsEsttrans ) + "'">>,"Horainfo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHorainfo ) + "'">>,"Mensaje" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsMensaje ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraimpo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsCodigo ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsCodigo ) + "'">> and  INFOVTASLPS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxInfovtaslpsTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.INFOVTASLPS where " + this.ConvertirFuncionesSql( " INFOVTASLPS.CODIGO != ''" ) )
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
			Local lxInfovtaslpsCodigo
			lxInfovtaslpsCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecinfo" as "Fechainforme", "Indentif" as "Identificador", "Estado" as "Estado", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horainfo" as "Horainforme", "Mensaje" as "Mensaje", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo" from ZooLogic.INFOVTASLPS where "Codigo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsCodigo ) + "'">> and  INFOVTASLPS.CODIGO != ''
			endtext
			use in select('c_INFORMEVENTASLPS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMEVENTASLPS', set( 'Datasession' ) )

			if reccount( 'c_INFORMEVENTASLPS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxInfovtaslpsCodigo as Variant
		llRetorno = .t.
		lxInfovtaslpsCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.INFOVTASLPS where "Codigo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsCodigo ) + "'">> and  INFOVTASLPS.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecinfo" as "Fechainforme", "Indentif" as "Identificador", "Estado" as "Estado", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horainfo" as "Horainforme", "Mensaje" as "Mensaje", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo" from ZooLogic.INFOVTASLPS where  INFOVTASLPS.CODIGO != '' order by CODIGO
			endtext
			use in select('c_INFORMEVENTASLPS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMEVENTASLPS', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecinfo" as "Fechainforme", "Indentif" as "Identificador", "Estado" as "Estado", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horainfo" as "Horainforme", "Mensaje" as "Mensaje", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo" from ZooLogic.INFOVTASLPS where  funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INFOVTASLPS.CODIGO != '' order by CODIGO
			endtext
			use in select('c_INFORMEVENTASLPS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMEVENTASLPS', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecinfo" as "Fechainforme", "Indentif" as "Identificador", "Estado" as "Estado", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horainfo" as "Horainforme", "Mensaje" as "Mensaje", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo" from ZooLogic.INFOVTASLPS where  funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INFOVTASLPS.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_INFORMEVENTASLPS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMEVENTASLPS', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecinfo" as "Fechainforme", "Indentif" as "Identificador", "Estado" as "Estado", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horainfo" as "Horainforme", "Mensaje" as "Mensaje", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo" from ZooLogic.INFOVTASLPS where  INFOVTASLPS.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_INFORMEVENTASLPS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INFORMEVENTASLPS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Fecinfo,Indentif,Estado,Timestamp,Zadsfw,Smodifw,Um" + ;
"odifw,Ualtafw,Valtafw,Saltafw,Vmodifw,Horaexpo,Hmodifw,Bdmodifw,Bdaltafw,Esttrans,Horainfo,Mensaje,H" + ;
"altafw,Horaimpo,Codigo" + ;
" from ZooLogic.INFOVTASLPS where  INFOVTASLPS.CODIGO != '' and " + lcFiltro )
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
			local  lxInfovtaslpsFecexpo, lxInfovtaslpsFectrans, lxInfovtaslpsFecimpo, lxInfovtaslpsFaltafw, lxInfovtaslpsFmodifw, lxInfovtaslpsFecinfo, lxInfovtaslpsIndentif, lxInfovtaslpsEstado, lxInfovtaslpsTimestamp, lxInfovtaslpsZadsfw, lxInfovtaslpsSmodifw, lxInfovtaslpsUmodifw, lxInfovtaslpsUaltafw, lxInfovtaslpsValtafw, lxInfovtaslpsSaltafw, lxInfovtaslpsVmodifw, lxInfovtaslpsHoraexpo, lxInfovtaslpsHmodifw, lxInfovtaslpsBdmodifw, lxInfovtaslpsBdaltafw, lxInfovtaslpsEsttrans, lxInfovtaslpsHorainfo, lxInfovtaslpsMensaje, lxInfovtaslpsHaltafw, lxInfovtaslpsHoraimpo, lxInfovtaslpsCodigo
				lxInfovtaslpsFecexpo = ctod( '  /  /    ' )			lxInfovtaslpsFectrans = ctod( '  /  /    ' )			lxInfovtaslpsFecimpo = ctod( '  /  /    ' )			lxInfovtaslpsFaltafw = ctod( '  /  /    ' )			lxInfovtaslpsFmodifw = ctod( '  /  /    ' )			lxInfovtaslpsFecinfo = ctod( '  /  /    ' )			lxInfovtaslpsIndentif = 0			lxInfovtaslpsEstado = 0			lxInfovtaslpsTimestamp = goLibrerias.ObtenerTimestamp()			lxInfovtaslpsZadsfw = []			lxInfovtaslpsSmodifw = []			lxInfovtaslpsUmodifw = []			lxInfovtaslpsUaltafw = []			lxInfovtaslpsValtafw = []			lxInfovtaslpsSaltafw = []			lxInfovtaslpsVmodifw = []			lxInfovtaslpsHoraexpo = []			lxInfovtaslpsHmodifw = []			lxInfovtaslpsBdmodifw = []			lxInfovtaslpsBdaltafw = []			lxInfovtaslpsEsttrans = []			lxInfovtaslpsHorainfo = []			lxInfovtaslpsMensaje = []			lxInfovtaslpsHaltafw = []			lxInfovtaslpsHoraimpo = []			lxInfovtaslpsCodigo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.INFOVTASLPS where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'INFOVTASLPS' + '_' + tcCampo
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
		lcWhere = " Where  INFOVTASLPS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecinfo" as "Fechainforme", "Indentif" as "Identificador", "Estado" as "Estado", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horainfo" as "Horainforme", "Mensaje" as "Mensaje", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'INFOVTASLPS', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAINFORME'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECINFO AS FECHAINFORME'
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INDENTIF AS IDENTIFICADOR'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAINFORME'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAINFO AS HORAINFORME'
				Case lcAtributo == 'MENSAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MENSAJE AS MENSAJE'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAINFORME'
				lcCampo = 'FECINFO'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'INDENTIF'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAINFORME'
				lcCampo = 'HORAINFO'
			Case upper( alltrim( tcAtributo ) ) == 'MENSAJE'
				lcCampo = 'MENSAJE'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
			local  lxInfovtaslpsFecexpo, lxInfovtaslpsFectrans, lxInfovtaslpsFecimpo, lxInfovtaslpsFaltafw, lxInfovtaslpsFmodifw, lxInfovtaslpsFecinfo, lxInfovtaslpsIndentif, lxInfovtaslpsEstado, lxInfovtaslpsTimestamp, lxInfovtaslpsZadsfw, lxInfovtaslpsSmodifw, lxInfovtaslpsUmodifw, lxInfovtaslpsUaltafw, lxInfovtaslpsValtafw, lxInfovtaslpsSaltafw, lxInfovtaslpsVmodifw, lxInfovtaslpsHoraexpo, lxInfovtaslpsHmodifw, lxInfovtaslpsBdmodifw, lxInfovtaslpsBdaltafw, lxInfovtaslpsEsttrans, lxInfovtaslpsHorainfo, lxInfovtaslpsMensaje, lxInfovtaslpsHaltafw, lxInfovtaslpsHoraimpo, lxInfovtaslpsCodigo
				lxInfovtaslpsFecexpo =  .Fechaexpo			lxInfovtaslpsFectrans =  .Fechatransferencia			lxInfovtaslpsFecimpo =  .Fechaimpo			lxInfovtaslpsFaltafw =  .Fechaaltafw			lxInfovtaslpsFmodifw =  .Fechamodificacionfw			lxInfovtaslpsFecinfo =  .Fechainforme			lxInfovtaslpsIndentif =  .Identificador			lxInfovtaslpsEstado =  .Estado			lxInfovtaslpsTimestamp = goLibrerias.ObtenerTimestamp()			lxInfovtaslpsZadsfw =  .Zadsfw			lxInfovtaslpsSmodifw =  .Seriemodificacionfw			lxInfovtaslpsUmodifw =  .Usuariomodificacionfw			lxInfovtaslpsUaltafw =  .Usuarioaltafw			lxInfovtaslpsValtafw =  .Versionaltafw			lxInfovtaslpsSaltafw =  .Seriealtafw			lxInfovtaslpsVmodifw =  .Versionmodificacionfw			lxInfovtaslpsHoraexpo =  .Horaexpo			lxInfovtaslpsHmodifw =  .Horamodificacionfw			lxInfovtaslpsBdmodifw =  .Basededatosmodificacionfw			lxInfovtaslpsBdaltafw =  .Basededatosaltafw			lxInfovtaslpsEsttrans =  .Estadotransferencia			lxInfovtaslpsHorainfo =  .Horainforme			lxInfovtaslpsMensaje =  .Mensaje			lxInfovtaslpsHaltafw =  .Horaaltafw			lxInfovtaslpsHoraimpo =  .Horaimpo			lxInfovtaslpsCodigo =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.INFOVTASLPS ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Fecinfo","Indentif","Estado","Timestamp","Zadsfw","Smodifw","Umodifw","Ualtafw","Valtafw","Saltafw","Vmodifw","Horaexpo","Hmodifw","Bdmodifw","Bdaltafw","Esttrans","Horainfo","Mensaje","Haltafw","Horaimpo","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecinfo ) + "'" >>, <<lxInfovtaslpsIndentif >>, <<lxInfovtaslpsEstado >>, <<lxInfovtaslpsTimestamp >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHorainfo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsMensaje ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInfovtaslpsCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'INFOVTASLPS' 
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
			local  lxInfovtaslpsFecexpo, lxInfovtaslpsFectrans, lxInfovtaslpsFecimpo, lxInfovtaslpsFaltafw, lxInfovtaslpsFmodifw, lxInfovtaslpsFecinfo, lxInfovtaslpsIndentif, lxInfovtaslpsEstado, lxInfovtaslpsTimestamp, lxInfovtaslpsZadsfw, lxInfovtaslpsSmodifw, lxInfovtaslpsUmodifw, lxInfovtaslpsUaltafw, lxInfovtaslpsValtafw, lxInfovtaslpsSaltafw, lxInfovtaslpsVmodifw, lxInfovtaslpsHoraexpo, lxInfovtaslpsHmodifw, lxInfovtaslpsBdmodifw, lxInfovtaslpsBdaltafw, lxInfovtaslpsEsttrans, lxInfovtaslpsHorainfo, lxInfovtaslpsMensaje, lxInfovtaslpsHaltafw, lxInfovtaslpsHoraimpo, lxInfovtaslpsCodigo
				lxInfovtaslpsFecexpo =  .Fechaexpo			lxInfovtaslpsFectrans =  .Fechatransferencia			lxInfovtaslpsFecimpo =  .Fechaimpo			lxInfovtaslpsFaltafw =  .Fechaaltafw			lxInfovtaslpsFmodifw =  .Fechamodificacionfw			lxInfovtaslpsFecinfo =  .Fechainforme			lxInfovtaslpsIndentif =  .Identificador			lxInfovtaslpsEstado =  .Estado			lxInfovtaslpsTimestamp = goLibrerias.ObtenerTimestamp()			lxInfovtaslpsZadsfw =  .Zadsfw			lxInfovtaslpsSmodifw =  .Seriemodificacionfw			lxInfovtaslpsUmodifw =  .Usuariomodificacionfw			lxInfovtaslpsUaltafw =  .Usuarioaltafw			lxInfovtaslpsValtafw =  .Versionaltafw			lxInfovtaslpsSaltafw =  .Seriealtafw			lxInfovtaslpsVmodifw =  .Versionmodificacionfw			lxInfovtaslpsHoraexpo =  .Horaexpo			lxInfovtaslpsHmodifw =  .Horamodificacionfw			lxInfovtaslpsBdmodifw =  .Basededatosmodificacionfw			lxInfovtaslpsBdaltafw =  .Basededatosaltafw			lxInfovtaslpsEsttrans =  .Estadotransferencia			lxInfovtaslpsHorainfo =  .Horainforme			lxInfovtaslpsMensaje =  .Mensaje			lxInfovtaslpsHaltafw =  .Horaaltafw			lxInfovtaslpsHoraimpo =  .Horaimpo			lxInfovtaslpsCodigo =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  INFOVTASLPS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.INFOVTASLPS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFmodifw ) + "'">>, "Fecinfo" = <<"'" + this.ConvertirDateSql( lxInfovtaslpsFecinfo ) + "'">>, "Indentif" = <<lxInfovtaslpsIndentif>>, "Estado" = <<lxInfovtaslpsEstado>>, "Timestamp" = <<lxInfovtaslpsTimestamp>>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsZadsfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsEsttrans ) + "'">>, "Horainfo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHorainfo ) + "'">>, "Mensaje" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsMensaje ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsHoraimpo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxInfovtaslpsCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'INFOVTASLPS' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  INFOVTASLPS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.INFOVTASLPS where ' + lcFiltro )
			loColeccion.cTabla = 'INFOVTASLPS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.INFOVTASLPS where  INFOVTASLPS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.INFOVTASLPS where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  INFOVTASLPS.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMEVENTASLPS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.INFOVTASLPS Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.INFOVTASLPS set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECINFO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECINFO ) + "'"+ [, INDENTIF = ] + transform( &lcCursor..INDENTIF )+ [, ESTADO = ] + transform( &lcCursor..ESTADO )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAINFO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAINFO ) + "'"+ [, MENSAJE = ] + "'" + this.FormatearTextoSql( &lcCursor..MENSAJE ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, FECINFO, INDENTIF, ESTADO, TIMESTAMP, ZADSFW, SMODIFW, UMODIFW, UALTAFW, VALTAFW, SALTAFW, VMODIFW, HORAEXPO, HMODIFW, BDMODIFW, BDALTAFW, ESTTRANS, HORAINFO, MENSAJE, HALTAFW, HORAIMPO, CODIGO
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECINFO ) + "'" + ',' + transform( &lcCursor..INDENTIF )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ESTADO ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAINFO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MENSAJE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.INFOVTASLPS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMEVENTASLPS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'INFORMEVENTASLPS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'INFORMEVENTASLPS_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_INFOVTASLPS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'INFORMEVENTASLPS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad INFORMEVENTASLPS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMEVENTASLPS'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMEVENTASLPS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECINFO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_INFOVTASLPS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_INFOVTASLPS
Create Table ZooLogic.TablaTrabajo_INFOVTASLPS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecinfo" datetime  null, 
"indentif" numeric( 15, 0 )  null, 
"estado" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"zadsfw" varchar(max)  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horainfo" char( 5 )  null, 
"mensaje" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"codigo" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_INFOVTASLPS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_INFOVTASLPS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INFORMEVENTASLPS'
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecinfo','fecinfo')
			.AgregarMapeo('indentif','indentif')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horainfo','horainfo')
			.AgregarMapeo('mensaje','mensaje')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('codigo','codigo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_INFOVTASLPS'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECINFO = isnull( d.FECINFO, t.FECINFO ),t.INDENTIF = isnull( d.INDENTIF, t.INDENTIF ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAINFO = isnull( d.HORAINFO, t.HORAINFO ),t.MENSAJE = isnull( d.MENSAJE, t.MENSAJE ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.INFOVTASLPS t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.INFOVTASLPS(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Fecinfo,Indentif,Estado,Timestamp,Zadsfw,Smodifw,Umodifw,Ualtafw,Valtafw,Saltafw,Vmodifw,Horaexpo,Hmodifw,Bdmodifw,Bdaltafw,Esttrans,Horainfo,Mensaje,Haltafw,Horaimpo,Codigo)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECINFO,''),isnull( d.INDENTIF,0),isnull( d.ESTADO,0),isnull( d.TIMESTAMP,0),isnull( d.ZADSFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAINFO,''),isnull( d.MENSAJE,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.CODIGO,'')
						From deleted d left join ZooLogic.INFOVTASLPS pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_INFOVTASLPS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_INFOVTASLPS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_INFORMEVENTASLPS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INFORMEVENTASLPS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_INFORMEVENTASLPS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INFORMEVENTASLPS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INFORMEVENTASLPS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INFORMEVENTASLPS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechainforme = GoLibrerias.ObtenerFechaFormateada( nvl( c_INFORMEVENTASLPS.Fechainforme, ctod( '  /  /    ' ) ) )
					.Identificador = nvl( c_INFORMEVENTASLPS.Identificador, 0 )
					.Estado = nvl( c_INFORMEVENTASLPS.Estado, 0 )
					.Timestamp = nvl( c_INFORMEVENTASLPS.Timestamp, 0 )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriemodificacionfw = nvl( c_INFORMEVENTASLPS.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_INFORMEVENTASLPS.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_INFORMEVENTASLPS.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_INFORMEVENTASLPS.Versionaltafw, [] )
					.Seriealtafw = nvl( c_INFORMEVENTASLPS.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_INFORMEVENTASLPS.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_INFORMEVENTASLPS.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_INFORMEVENTASLPS.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_INFORMEVENTASLPS.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_INFORMEVENTASLPS.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_INFORMEVENTASLPS.Estadotransferencia, [] )
					.Horainforme = nvl( c_INFORMEVENTASLPS.Horainforme, [] )
					.Mensaje = nvl( c_INFORMEVENTASLPS.Mensaje, [] )
					.Horaaltafw = nvl( c_INFORMEVENTASLPS.Horaaltafw, [] )
					.Horaimpo = nvl( c_INFORMEVENTASLPS.Horaimpo, [] )
					.Codigo = nvl( c_INFORMEVENTASLPS.Codigo, [] )
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
		return c_INFORMEVENTASLPS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.INFOVTASLPS' )
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
								from ZooLogic.INFOVTASLPS 
								Where   INFOVTASLPS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "INFOVTASLPS", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecinfo" as "Fechainforme", "Indentif" as "Identificador", "Estado" as "Estado", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horainfo" as "Horainforme", "Mensaje" as "Mensaje", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.INFOVTASLPS 
								Where   INFOVTASLPS.CODIGO != ''
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
	Tabla = 'INFOVTASLPS'
	Filtro = " INFOVTASLPS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " INFOVTASLPS.CODIGO != ''"
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
	<row entidad="INFORMEVENTASLPS                        " atributo="FECHAEXPO                               " tabla="INFOVTASLPS    " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="FECHATRANSFERENCIA                      " tabla="INFOVTASLPS    " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="FECHAIMPO                               " tabla="INFOVTASLPS    " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="FECHAALTAFW                             " tabla="INFOVTASLPS    " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="FECHAMODIFICACIONFW                     " tabla="INFOVTASLPS    " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="FECHAINFORME                            " tabla="INFOVTASLPS    " campo="FECINFO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Fecha informe                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="IDENTIFICADOR                           " tabla="INFOVTASLPS    " campo="INDENTIF  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Identificador                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="ESTADO                                  " tabla="INFOVTASLPS    " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Estado                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="TIMESTAMP                               " tabla="INFOVTASLPS    " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="ZADSFW                                  " tabla="INFOVTASLPS    " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="SERIEMODIFICACIONFW                     " tabla="INFOVTASLPS    " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="USUARIOMODIFICACIONFW                   " tabla="INFOVTASLPS    " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="USUARIOALTAFW                           " tabla="INFOVTASLPS    " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="VERSIONALTAFW                           " tabla="INFOVTASLPS    " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="SERIEALTAFW                             " tabla="INFOVTASLPS    " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="VERSIONMODIFICACIONFW                   " tabla="INFOVTASLPS    " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="HORAEXPO                                " tabla="INFOVTASLPS    " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="HORAMODIFICACIONFW                      " tabla="INFOVTASLPS    " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="INFOVTASLPS    " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="BASEDEDATOSALTAFW                       " tabla="INFOVTASLPS    " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="ESTADOTRANSFERENCIA                     " tabla="INFOVTASLPS    " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="HORAINFORME                             " tabla="INFOVTASLPS    " campo="HORAINFO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Hora informe                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="MENSAJE                                 " tabla="INFOVTASLPS    " campo="MENSAJE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Mensaje                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="HORAALTAFW                              " tabla="INFOVTASLPS    " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="HORAIMPO                                " tabla="INFOVTASLPS    " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INFORMEVENTASLPS                        " atributo="CODIGO                                  " tabla="INFOVTASLPS    " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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