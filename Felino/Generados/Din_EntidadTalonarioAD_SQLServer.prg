
define class Din_EntidadTALONARIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TALONARIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_046PK'
	cTablaPrincipal = 'NUMERACIONES'
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
			local  lxNumeracionesFecexpo, lxNumeracionesFecimpo, lxNumeracionesFmodifw, lxNumeracionesFectrans, lxNumeracionesFaltafw, lxNumeracionesEntidad, lxNumeracionesTimestamp, lxNumeracionesDelegnum, lxNumeracionesValtafw, lxNumeracionesZadsfw, lxNumeracionesVmodifw, lxNumeracionesUmodifw, lxNumeracionesHoraimpo, lxNumeracionesUaltafw, lxNumeracionesSmodifw, lxNumeracionesHmodifw, lxNumeracionesSaltafw, lxNumeracionesHoraexpo, lxNumeracionesEsttrans, lxNumeracionesHaltafw, lxNumeracionesBdaltafw, lxNumeracionesFormula, lxNumeracionesBdmodifw, lxNumeracionesAsigna, lxNumeracionesTalonario, lxNumeracionesPobs, lxNumeracionesNumero, lxNumeracionesAtributo, lxNumeracionesLetra, lxNumeracionesPtoven, lxNumeracionesServicio, lxNumeracionesTalorela, lxNumeracionesMaximo, lxNumeracionesResernro
				lxNumeracionesFecexpo =  .Fechaexpo			lxNumeracionesFecimpo =  .Fechaimpo			lxNumeracionesFmodifw =  .Fechamodificacionfw			lxNumeracionesFectrans =  .Fechatransferencia			lxNumeracionesFaltafw =  .Fechaaltafw			lxNumeracionesEntidad =  .Entidad			lxNumeracionesTimestamp = goLibrerias.ObtenerTimestamp()			lxNumeracionesDelegnum =  .Delegarnumeracion			lxNumeracionesValtafw =  .Versionaltafw			lxNumeracionesZadsfw =  .Zadsfw			lxNumeracionesVmodifw =  .Versionmodificacionfw			lxNumeracionesUmodifw =  .Usuariomodificacionfw			lxNumeracionesHoraimpo =  .Horaimpo			lxNumeracionesUaltafw =  .Usuarioaltafw			lxNumeracionesSmodifw =  .Seriemodificacionfw			lxNumeracionesHmodifw =  .Horamodificacionfw			lxNumeracionesSaltafw =  .Seriealtafw			lxNumeracionesHoraexpo =  .Horaexpo			lxNumeracionesEsttrans =  .Estadotransferencia			lxNumeracionesHaltafw =  .Horaaltafw			lxNumeracionesBdaltafw =  .Basededatosaltafw			lxNumeracionesFormula =  .Formula			lxNumeracionesBdmodifw =  .Basededatosmodificacionfw			lxNumeracionesAsigna =  .Asignacion			lxNumeracionesTalonario =  .Codigo			lxNumeracionesPobs =  .Obs			lxNumeracionesNumero =  .Numero			lxNumeracionesAtributo =  .Atributo			lxNumeracionesLetra =  .Letra			lxNumeracionesPtoven =  .Puntodeventa			lxNumeracionesServicio =  .Servicio			lxNumeracionesTalorela =  upper( .Talonariorela_PK ) 			lxNumeracionesMaximo =  .Maximonumero			lxNumeracionesResernro =  .Reservarnumero
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxNumeracionesTalonario = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.NUMERACIONES ( "Fecexpo","Fecimpo","Fmodifw","Fectrans","Faltafw","Entidad","Timestamp","Delegnum","Valtafw","Zadsfw","Vmodifw","Umodifw","Horaimpo","Ualtafw","Smodifw","Hmodifw","Saltafw","Horaexpo","Esttrans","Haltafw","Bdaltafw","Formula","Bdmodifw","Asigna","Talonario","Pobs","Numero","Atributo","Letra","Ptoven","Servicio","Talorela","Maximo","Resernro" ) values ( <<"'" + this.ConvertirDateSql( lxNumeracionesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesEntidad ) + "'" >>, <<lxNumeracionesTimestamp >>, <<iif( lxNumeracionesDelegnum, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxNumeracionesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesFormula ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesBdmodifw ) + "'" >>, <<lxNumeracionesAsigna >>, <<"'" + this.FormatearTextoSql( lxNumeracionesTalonario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesPobs ) + "'" >>, <<lxNumeracionesNumero >>, <<"'" + this.FormatearTextoSql( lxNumeracionesAtributo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesLetra ) + "'" >>, <<lxNumeracionesPtoven >>, <<"'" + this.FormatearTextoSql( lxNumeracionesServicio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesTalorela ) + "'" >>, <<lxNumeracionesMaximo >>, <<iif( lxNumeracionesResernro, 1, 0 ) >> )
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
		this.oEntidad.Timestamp = lxNumeracionesTimestamp
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
			local  lxNumeracionesFecexpo, lxNumeracionesFecimpo, lxNumeracionesFmodifw, lxNumeracionesFectrans, lxNumeracionesFaltafw, lxNumeracionesEntidad, lxNumeracionesTimestamp, lxNumeracionesDelegnum, lxNumeracionesValtafw, lxNumeracionesZadsfw, lxNumeracionesVmodifw, lxNumeracionesUmodifw, lxNumeracionesHoraimpo, lxNumeracionesUaltafw, lxNumeracionesSmodifw, lxNumeracionesHmodifw, lxNumeracionesSaltafw, lxNumeracionesHoraexpo, lxNumeracionesEsttrans, lxNumeracionesHaltafw, lxNumeracionesBdaltafw, lxNumeracionesFormula, lxNumeracionesBdmodifw, lxNumeracionesAsigna, lxNumeracionesTalonario, lxNumeracionesPobs, lxNumeracionesNumero, lxNumeracionesAtributo, lxNumeracionesLetra, lxNumeracionesPtoven, lxNumeracionesServicio, lxNumeracionesTalorela, lxNumeracionesMaximo, lxNumeracionesResernro
				lxNumeracionesFecexpo =  .Fechaexpo			lxNumeracionesFecimpo =  .Fechaimpo			lxNumeracionesFmodifw =  .Fechamodificacionfw			lxNumeracionesFectrans =  .Fechatransferencia			lxNumeracionesFaltafw =  .Fechaaltafw			lxNumeracionesEntidad =  .Entidad			lxNumeracionesTimestamp = goLibrerias.ObtenerTimestamp()			lxNumeracionesDelegnum =  .Delegarnumeracion			lxNumeracionesValtafw =  .Versionaltafw			lxNumeracionesZadsfw =  .Zadsfw			lxNumeracionesVmodifw =  .Versionmodificacionfw			lxNumeracionesUmodifw =  .Usuariomodificacionfw			lxNumeracionesHoraimpo =  .Horaimpo			lxNumeracionesUaltafw =  .Usuarioaltafw			lxNumeracionesSmodifw =  .Seriemodificacionfw			lxNumeracionesHmodifw =  .Horamodificacionfw			lxNumeracionesSaltafw =  .Seriealtafw			lxNumeracionesHoraexpo =  .Horaexpo			lxNumeracionesEsttrans =  .Estadotransferencia			lxNumeracionesHaltafw =  .Horaaltafw			lxNumeracionesBdaltafw =  .Basededatosaltafw			lxNumeracionesFormula =  .Formula			lxNumeracionesBdmodifw =  .Basededatosmodificacionfw			lxNumeracionesAsigna =  .Asignacion			lxNumeracionesTalonario =  .Codigo			lxNumeracionesPobs =  .Obs			lxNumeracionesNumero =  .Numero			lxNumeracionesAtributo =  .Atributo			lxNumeracionesLetra =  .Letra			lxNumeracionesPtoven =  .Puntodeventa			lxNumeracionesServicio =  .Servicio			lxNumeracionesTalorela =  upper( .Talonariorela_PK ) 			lxNumeracionesMaximo =  .Maximonumero			lxNumeracionesResernro =  .Reservarnumero
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
				update ZooLogic.NUMERACIONES set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxNumeracionesFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxNumeracionesFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxNumeracionesFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxNumeracionesFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxNumeracionesFaltafw ) + "'">>,"Entidad" = <<"'" + this.FormatearTextoSql( lxNumeracionesEntidad ) + "'">>,"Timestamp" = <<lxNumeracionesTimestamp>>,"Delegnum" = <<iif( lxNumeracionesDelegnum, 1, 0 )>>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxNumeracionesZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxNumeracionesHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesSaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxNumeracionesHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxNumeracionesEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesBdaltafw ) + "'">>,"Formula" = <<"'" + this.FormatearTextoSql( lxNumeracionesFormula ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesBdmodifw ) + "'">>,"Asigna" = <<lxNumeracionesAsigna>>,"Talonario" = <<"'" + this.FormatearTextoSql( lxNumeracionesTalonario ) + "'">>,"Pobs" = <<"'" + this.FormatearTextoSql( lxNumeracionesPobs ) + "'">>,"Numero" = <<lxNumeracionesNumero>>,"Atributo" = <<"'" + this.FormatearTextoSql( lxNumeracionesAtributo ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxNumeracionesLetra ) + "'">>,"Ptoven" = <<lxNumeracionesPtoven>>,"Servicio" = <<"'" + this.FormatearTextoSql( lxNumeracionesServicio ) + "'">>,"Talorela" = <<"'" + this.FormatearTextoSql( lxNumeracionesTalorela ) + "'">>,"Maximo" = <<lxNumeracionesMaximo>>,"Resernro" = <<iif( lxNumeracionesResernro, 1, 0 )>> where "Talonario" = <<"'" + this.FormatearTextoSql( lxNumeracionesTalonario ) + "'">> and  NUMERACIONES.TALONARIO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxNumeracionesTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Talonario from ZooLogic.NUMERACIONES where " + this.ConvertirFuncionesSql( " NUMERACIONES.TALONARIO != ''" ) )
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
			Local lxNumeracionesTalonario
			lxNumeracionesTalonario = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Entidad" as "Entidad", "Timestamp" as "Timestamp", "Delegnum" as "Delegarnumeracion", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Formula" as "Formula", "Bdmodifw" as "Basededatosmodificacionfw", "Asigna" as "Asignacion", "Talonario" as "Codigo", "Pobs" as "Obs", "Numero" as "Numero", "Atributo" as "Atributo", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Servicio" as "Servicio", "Talorela" as "Talonariorela", "Maximo" as "Maximonumero", "Resernro" as "Reservarnumero" from ZooLogic.NUMERACIONES where "Talonario" = <<"'" + this.FormatearTextoSql( lxNumeracionesTalonario ) + "'">> and  NUMERACIONES.TALONARIO != ''
			endtext
			use in select('c_TALONARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALONARIO', set( 'Datasession' ) )

			if reccount( 'c_TALONARIO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxNumeracionesTalonario as Variant
		llRetorno = .t.
		lxNumeracionesTalonario = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.NUMERACIONES where "Talonario" = <<"'" + this.FormatearTextoSql( lxNumeracionesTalonario ) + "'">> and  NUMERACIONES.TALONARIO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Entidad" as "Entidad", "Timestamp" as "Timestamp", "Delegnum" as "Delegarnumeracion", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Formula" as "Formula", "Bdmodifw" as "Basededatosmodificacionfw", "Asigna" as "Asignacion", "Talonario" as "Codigo", "Pobs" as "Obs", "Numero" as "Numero", "Atributo" as "Atributo", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Servicio" as "Servicio", "Talorela" as "Talonariorela", "Maximo" as "Maximonumero", "Resernro" as "Reservarnumero" from ZooLogic.NUMERACIONES where  NUMERACIONES.TALONARIO != '' order by Talonario
			endtext
			use in select('c_TALONARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALONARIO', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Entidad" as "Entidad", "Timestamp" as "Timestamp", "Delegnum" as "Delegarnumeracion", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Formula" as "Formula", "Bdmodifw" as "Basededatosmodificacionfw", "Asigna" as "Asignacion", "Talonario" as "Codigo", "Pobs" as "Obs", "Numero" as "Numero", "Atributo" as "Atributo", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Servicio" as "Servicio", "Talorela" as "Talonariorela", "Maximo" as "Maximonumero", "Resernro" as "Reservarnumero" from ZooLogic.NUMERACIONES where  funciones.padr( Talonario, 35, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  NUMERACIONES.TALONARIO != '' order by Talonario
			endtext
			use in select('c_TALONARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALONARIO', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Entidad" as "Entidad", "Timestamp" as "Timestamp", "Delegnum" as "Delegarnumeracion", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Formula" as "Formula", "Bdmodifw" as "Basededatosmodificacionfw", "Asigna" as "Asignacion", "Talonario" as "Codigo", "Pobs" as "Obs", "Numero" as "Numero", "Atributo" as "Atributo", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Servicio" as "Servicio", "Talorela" as "Talonariorela", "Maximo" as "Maximonumero", "Resernro" as "Reservarnumero" from ZooLogic.NUMERACIONES where  funciones.padr( Talonario, 35, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  NUMERACIONES.TALONARIO != '' order by Talonario desc
			endtext
			use in select('c_TALONARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALONARIO', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Entidad" as "Entidad", "Timestamp" as "Timestamp", "Delegnum" as "Delegarnumeracion", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Formula" as "Formula", "Bdmodifw" as "Basededatosmodificacionfw", "Asigna" as "Asignacion", "Talonario" as "Codigo", "Pobs" as "Obs", "Numero" as "Numero", "Atributo" as "Atributo", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Servicio" as "Servicio", "Talorela" as "Talonariorela", "Maximo" as "Maximonumero", "Resernro" as "Reservarnumero" from ZooLogic.NUMERACIONES where  NUMERACIONES.TALONARIO != '' order by Talonario desc
			endtext
			use in select('c_TALONARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALONARIO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fecimpo,Fmodifw,Fectrans,Faltafw,Entidad,Timestamp,Delegnum,Valtafw,Zadsfw,Vmodifw,U" + ;
"modifw,Horaimpo,Ualtafw,Smodifw,Hmodifw,Saltafw,Horaexpo,Esttrans,Haltafw,Bdaltafw,Formula,Bdmodifw," + ;
"Asigna,Talonario,Pobs,Numero,Atributo,Letra,Ptoven,Servicio,Talorela,Maximo,Resernro" + ;
" from ZooLogic.NUMERACIONES where  NUMERACIONES.TALONARIO != '' and " + lcFiltro )
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
			local  lxNumeracionesFecexpo, lxNumeracionesFecimpo, lxNumeracionesFmodifw, lxNumeracionesFectrans, lxNumeracionesFaltafw, lxNumeracionesEntidad, lxNumeracionesTimestamp, lxNumeracionesDelegnum, lxNumeracionesValtafw, lxNumeracionesZadsfw, lxNumeracionesVmodifw, lxNumeracionesUmodifw, lxNumeracionesHoraimpo, lxNumeracionesUaltafw, lxNumeracionesSmodifw, lxNumeracionesHmodifw, lxNumeracionesSaltafw, lxNumeracionesHoraexpo, lxNumeracionesEsttrans, lxNumeracionesHaltafw, lxNumeracionesBdaltafw, lxNumeracionesFormula, lxNumeracionesBdmodifw, lxNumeracionesAsigna, lxNumeracionesTalonario, lxNumeracionesPobs, lxNumeracionesNumero, lxNumeracionesAtributo, lxNumeracionesLetra, lxNumeracionesPtoven, lxNumeracionesServicio, lxNumeracionesTalorela, lxNumeracionesMaximo, lxNumeracionesResernro
				lxNumeracionesFecexpo = ctod( '  /  /    ' )			lxNumeracionesFecimpo = ctod( '  /  /    ' )			lxNumeracionesFmodifw = ctod( '  /  /    ' )			lxNumeracionesFectrans = ctod( '  /  /    ' )			lxNumeracionesFaltafw = ctod( '  /  /    ' )			lxNumeracionesEntidad = []			lxNumeracionesTimestamp = goLibrerias.ObtenerTimestamp()			lxNumeracionesDelegnum = .F.			lxNumeracionesValtafw = []			lxNumeracionesZadsfw = []			lxNumeracionesVmodifw = []			lxNumeracionesUmodifw = []			lxNumeracionesHoraimpo = []			lxNumeracionesUaltafw = []			lxNumeracionesSmodifw = []			lxNumeracionesHmodifw = []			lxNumeracionesSaltafw = []			lxNumeracionesHoraexpo = []			lxNumeracionesEsttrans = []			lxNumeracionesHaltafw = []			lxNumeracionesBdaltafw = []			lxNumeracionesFormula = []			lxNumeracionesBdmodifw = []			lxNumeracionesAsigna = 0			lxNumeracionesTalonario = []			lxNumeracionesPobs = []			lxNumeracionesNumero = 0			lxNumeracionesAtributo = []			lxNumeracionesLetra = []			lxNumeracionesPtoven = 0			lxNumeracionesServicio = []			lxNumeracionesTalorela = []			lxNumeracionesMaximo = 0			lxNumeracionesResernro = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.NUMERACIONES where "Talonario" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'NUMERACIONES' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Talonario = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Talonario, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  NUMERACIONES.TALONARIO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Entidad" as "Entidad", "Timestamp" as "Timestamp", "Delegnum" as "Delegarnumeracion", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Formula" as "Formula", "Bdmodifw" as "Basededatosmodificacionfw", "Asigna" as "Asignacion", "Talonario" as "Codigo", "Pobs" as "Obs", "Numero" as "Numero", "Atributo" as "Atributo", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Servicio" as "Servicio", "Talorela" as "Talonariorela", "Maximo" as "Maximonumero", "Resernro" as "Reservarnumero"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'NUMERACIONES', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTIDAD AS ENTIDAD'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'DELEGARNUMERACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DELEGNUM AS DELEGARNUMERACION'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'FORMULA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FORMULA AS FORMULA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ASIGNACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ASIGNA AS ASIGNACION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALONARIO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'POBS AS OBS'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'ATRIBUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATRIBUTO AS ATRIBUTO'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'SERVICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERVICIO AS SERVICIO'
				Case lcAtributo == 'TALONARIORELA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALORELA AS TALONARIORELA'
				Case lcAtributo == 'MAXIMONUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAXIMO AS MAXIMONUMERO'
				Case lcAtributo == 'RESERVARNUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESERNRO AS RESERVARNUMERO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'ENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'DELEGARNUMERACION'
				lcCampo = 'DELEGNUM'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA'
				lcCampo = 'FORMULA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ASIGNACION'
				lcCampo = 'ASIGNA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'TALONARIO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'POBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTO'
				lcCampo = 'ATRIBUTO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'SERVICIO'
				lcCampo = 'SERVICIO'
			Case upper( alltrim( tcAtributo ) ) == 'TALONARIORELA'
				lcCampo = 'TALORELA'
			Case upper( alltrim( tcAtributo ) ) == 'MAXIMONUMERO'
				lcCampo = 'MAXIMO'
			Case upper( alltrim( tcAtributo ) ) == 'RESERVARNUMERO'
				lcCampo = 'RESERNRO'
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
			local  lxNumeracionesFecexpo, lxNumeracionesFecimpo, lxNumeracionesFmodifw, lxNumeracionesFectrans, lxNumeracionesFaltafw, lxNumeracionesEntidad, lxNumeracionesTimestamp, lxNumeracionesDelegnum, lxNumeracionesValtafw, lxNumeracionesZadsfw, lxNumeracionesVmodifw, lxNumeracionesUmodifw, lxNumeracionesHoraimpo, lxNumeracionesUaltafw, lxNumeracionesSmodifw, lxNumeracionesHmodifw, lxNumeracionesSaltafw, lxNumeracionesHoraexpo, lxNumeracionesEsttrans, lxNumeracionesHaltafw, lxNumeracionesBdaltafw, lxNumeracionesFormula, lxNumeracionesBdmodifw, lxNumeracionesAsigna, lxNumeracionesTalonario, lxNumeracionesPobs, lxNumeracionesNumero, lxNumeracionesAtributo, lxNumeracionesLetra, lxNumeracionesPtoven, lxNumeracionesServicio, lxNumeracionesTalorela, lxNumeracionesMaximo, lxNumeracionesResernro
				lxNumeracionesFecexpo =  .Fechaexpo			lxNumeracionesFecimpo =  .Fechaimpo			lxNumeracionesFmodifw =  .Fechamodificacionfw			lxNumeracionesFectrans =  .Fechatransferencia			lxNumeracionesFaltafw =  .Fechaaltafw			lxNumeracionesEntidad =  .Entidad			lxNumeracionesTimestamp = goLibrerias.ObtenerTimestamp()			lxNumeracionesDelegnum =  .Delegarnumeracion			lxNumeracionesValtafw =  .Versionaltafw			lxNumeracionesZadsfw =  .Zadsfw			lxNumeracionesVmodifw =  .Versionmodificacionfw			lxNumeracionesUmodifw =  .Usuariomodificacionfw			lxNumeracionesHoraimpo =  .Horaimpo			lxNumeracionesUaltafw =  .Usuarioaltafw			lxNumeracionesSmodifw =  .Seriemodificacionfw			lxNumeracionesHmodifw =  .Horamodificacionfw			lxNumeracionesSaltafw =  .Seriealtafw			lxNumeracionesHoraexpo =  .Horaexpo			lxNumeracionesEsttrans =  .Estadotransferencia			lxNumeracionesHaltafw =  .Horaaltafw			lxNumeracionesBdaltafw =  .Basededatosaltafw			lxNumeracionesFormula =  .Formula			lxNumeracionesBdmodifw =  .Basededatosmodificacionfw			lxNumeracionesAsigna =  .Asignacion			lxNumeracionesTalonario =  .Codigo			lxNumeracionesPobs =  .Obs			lxNumeracionesNumero =  .Numero			lxNumeracionesAtributo =  .Atributo			lxNumeracionesLetra =  .Letra			lxNumeracionesPtoven =  .Puntodeventa			lxNumeracionesServicio =  .Servicio			lxNumeracionesTalorela =  upper( .Talonariorela_PK ) 			lxNumeracionesMaximo =  .Maximonumero			lxNumeracionesResernro =  .Reservarnumero
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.NUMERACIONES ( "Fecexpo","Fecimpo","Fmodifw","Fectrans","Faltafw","Entidad","Timestamp","Delegnum","Valtafw","Zadsfw","Vmodifw","Umodifw","Horaimpo","Ualtafw","Smodifw","Hmodifw","Saltafw","Horaexpo","Esttrans","Haltafw","Bdaltafw","Formula","Bdmodifw","Asigna","Talonario","Pobs","Numero","Atributo","Letra","Ptoven","Servicio","Talorela","Maximo","Resernro" ) values ( <<"'" + this.ConvertirDateSql( lxNumeracionesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNumeracionesFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesEntidad ) + "'" >>, <<lxNumeracionesTimestamp >>, <<iif( lxNumeracionesDelegnum, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxNumeracionesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesFormula ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesBdmodifw ) + "'" >>, <<lxNumeracionesAsigna >>, <<"'" + this.FormatearTextoSql( lxNumeracionesTalonario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesPobs ) + "'" >>, <<lxNumeracionesNumero >>, <<"'" + this.FormatearTextoSql( lxNumeracionesAtributo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesLetra ) + "'" >>, <<lxNumeracionesPtoven >>, <<"'" + this.FormatearTextoSql( lxNumeracionesServicio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNumeracionesTalorela ) + "'" >>, <<lxNumeracionesMaximo >>, <<iif( lxNumeracionesResernro, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'NUMERACIONES' 
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
			local  lxNumeracionesFecexpo, lxNumeracionesFecimpo, lxNumeracionesFmodifw, lxNumeracionesFectrans, lxNumeracionesFaltafw, lxNumeracionesEntidad, lxNumeracionesTimestamp, lxNumeracionesDelegnum, lxNumeracionesValtafw, lxNumeracionesZadsfw, lxNumeracionesVmodifw, lxNumeracionesUmodifw, lxNumeracionesHoraimpo, lxNumeracionesUaltafw, lxNumeracionesSmodifw, lxNumeracionesHmodifw, lxNumeracionesSaltafw, lxNumeracionesHoraexpo, lxNumeracionesEsttrans, lxNumeracionesHaltafw, lxNumeracionesBdaltafw, lxNumeracionesFormula, lxNumeracionesBdmodifw, lxNumeracionesAsigna, lxNumeracionesTalonario, lxNumeracionesPobs, lxNumeracionesNumero, lxNumeracionesAtributo, lxNumeracionesLetra, lxNumeracionesPtoven, lxNumeracionesServicio, lxNumeracionesTalorela, lxNumeracionesMaximo, lxNumeracionesResernro
				lxNumeracionesFecexpo =  .Fechaexpo			lxNumeracionesFecimpo =  .Fechaimpo			lxNumeracionesFmodifw =  .Fechamodificacionfw			lxNumeracionesFectrans =  .Fechatransferencia			lxNumeracionesFaltafw =  .Fechaaltafw			lxNumeracionesEntidad =  .Entidad			lxNumeracionesTimestamp = goLibrerias.ObtenerTimestamp()			lxNumeracionesDelegnum =  .Delegarnumeracion			lxNumeracionesValtafw =  .Versionaltafw			lxNumeracionesZadsfw =  .Zadsfw			lxNumeracionesVmodifw =  .Versionmodificacionfw			lxNumeracionesUmodifw =  .Usuariomodificacionfw			lxNumeracionesHoraimpo =  .Horaimpo			lxNumeracionesUaltafw =  .Usuarioaltafw			lxNumeracionesSmodifw =  .Seriemodificacionfw			lxNumeracionesHmodifw =  .Horamodificacionfw			lxNumeracionesSaltafw =  .Seriealtafw			lxNumeracionesHoraexpo =  .Horaexpo			lxNumeracionesEsttrans =  .Estadotransferencia			lxNumeracionesHaltafw =  .Horaaltafw			lxNumeracionesBdaltafw =  .Basededatosaltafw			lxNumeracionesFormula =  .Formula			lxNumeracionesBdmodifw =  .Basededatosmodificacionfw			lxNumeracionesAsigna =  .Asignacion			lxNumeracionesTalonario =  .Codigo			lxNumeracionesPobs =  .Obs			lxNumeracionesNumero =  .Numero			lxNumeracionesAtributo =  .Atributo			lxNumeracionesLetra =  .Letra			lxNumeracionesPtoven =  .Puntodeventa			lxNumeracionesServicio =  .Servicio			lxNumeracionesTalorela =  upper( .Talonariorela_PK ) 			lxNumeracionesMaximo =  .Maximonumero			lxNumeracionesResernro =  .Reservarnumero
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Talonario" = ] + lcValorClavePrimariaString  + [ and  NUMERACIONES.TALONARIO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.NUMERACIONES set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxNumeracionesFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxNumeracionesFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxNumeracionesFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxNumeracionesFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxNumeracionesFaltafw ) + "'">>, "Entidad" = <<"'" + this.FormatearTextoSql( lxNumeracionesEntidad ) + "'">>, "Timestamp" = <<lxNumeracionesTimestamp>>, "Delegnum" = <<iif( lxNumeracionesDelegnum, 1, 0 )>>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxNumeracionesZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxNumeracionesHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesSaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxNumeracionesHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxNumeracionesEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxNumeracionesBdaltafw ) + "'">>, "Formula" = <<"'" + this.FormatearTextoSql( lxNumeracionesFormula ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxNumeracionesBdmodifw ) + "'">>, "Asigna" = <<lxNumeracionesAsigna>>, "Talonario" = <<"'" + this.FormatearTextoSql( lxNumeracionesTalonario ) + "'">>, "Pobs" = <<"'" + this.FormatearTextoSql( lxNumeracionesPobs ) + "'">>, "Numero" = <<lxNumeracionesNumero>>, "Atributo" = <<"'" + this.FormatearTextoSql( lxNumeracionesAtributo ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxNumeracionesLetra ) + "'">>, "Ptoven" = <<lxNumeracionesPtoven>>, "Servicio" = <<"'" + this.FormatearTextoSql( lxNumeracionesServicio ) + "'">>, "Talorela" = <<"'" + this.FormatearTextoSql( lxNumeracionesTalorela ) + "'">>, "Maximo" = <<lxNumeracionesMaximo>>, "Resernro" = <<iif( lxNumeracionesResernro, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'NUMERACIONES' 
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

			lcFiltro = ["Talonario" = ] + lcValorClavePrimariaString  + [ and  NUMERACIONES.TALONARIO != '']
		loColeccion.Agregar( 'delete from ZooLogic.NUMERACIONES where ' + lcFiltro )
			loColeccion.cTabla = 'NUMERACIONES' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.NUMERACIONES where  NUMERACIONES.TALONARIO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.NUMERACIONES where Talonario = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  NUMERACIONES.TALONARIO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TALONARIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.NUMERACIONES Where Talonario = ] + "'" + this.FormatearTextoSql( &lcCursor..Talonario ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.NUMERACIONES set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Delegnum = ] + Transform( iif( &lcCursor..Delegnum, 1, 0 ))+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, formula = ] + "'" + this.FormatearTextoSql( &lcCursor..formula ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Asigna = ] + transform( &lcCursor..Asigna )+ [, Talonario = ] + "'" + this.FormatearTextoSql( &lcCursor..Talonario ) + "'"+ [, pobs = ] + "'" + this.FormatearTextoSql( &lcCursor..pobs ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, atributo = ] + "'" + this.FormatearTextoSql( &lcCursor..atributo ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, PtoVen = ] + transform( &lcCursor..PtoVen )+ [, servicio = ] + "'" + this.FormatearTextoSql( &lcCursor..servicio ) + "'"+ [, talorela = ] + "'" + this.FormatearTextoSql( &lcCursor..talorela ) + "'"+ [, maximo = ] + transform( &lcCursor..maximo )+ [, ReserNro = ] + Transform( iif( &lcCursor..ReserNro, 1, 0 )) + [ Where Talonario = ] + "'" + this.FormatearTextoSql( &lcCursor..Talonario ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECIMPO, FMODIFW, FECTRANS, FALTAFW, Entidad, TIMESTAMP, Delegnum, VALTAFW, ZADSFW, VMODIFW, UMODIFW, HORAIMPO, UALTAFW, SMODIFW, HMODIFW, SALTAFW, HORAEXPO, ESTTRANS, HALTAFW, BDALTAFW, formula, BDMODIFW, Asigna, Talonario, pobs, Numero, atributo, Letra, PtoVen, servicio, talorela, maximo, ReserNro
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Delegnum, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..formula ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..Asigna ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Talonario ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..pobs ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..atributo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..PtoVen ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..servicio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..talorela ) + "'" + ',' + transform( &lcCursor..maximo ) + ',' + Transform( iif( &lcCursor..ReserNro, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.NUMERACIONES ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TALONARIO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Talonario C (35) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Talonario: ' + transform( &tcCursor..Talonario  )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TALONARIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TALONARIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TALONARIO_POBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_numeraciones')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TALONARIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Talonario
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TALONARIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TALONARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Talonario as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Talonario, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TALONARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_numeraciones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_numeraciones
Create Table ZooLogic.TablaTrabajo_numeraciones ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"entidad" char( 150 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"delegnum" bit  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"formula" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"asigna" numeric( 1, 0 )  null, 
"talonario" char( 35 )  null, 
"pobs" varchar(max)  null, 
"numero" numeric( 10, 0 )  null, 
"atributo" char( 40 )  null, 
"letra" char( 1 )  null, 
"ptoven" numeric( 4, 0 )  null, 
"servicio" char( 40 )  null, 
"talorela" char( 35 )  null, 
"maximo" numeric( 10, 0 )  null, 
"resernro" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_numeraciones' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_numeraciones' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TALONARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('entidad','entidad')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('delegnum','delegnum')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('formula','formula')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('asigna','asigna')
			.AgregarMapeo('talonario','talonario')
			.AgregarMapeo('pobs','pobs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('atributo','atributo')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptoven','ptoven')
			.AgregarMapeo('servicio','servicio')
			.AgregarMapeo('talorela','talorela')
			.AgregarMapeo('maximo','maximo')
			.AgregarMapeo('resernro','resernro')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_numeraciones'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.ENTIDAD = isnull( d.ENTIDAD, t.ENTIDAD ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DELEGNUM = isnull( d.DELEGNUM, t.DELEGNUM ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.FORMULA = isnull( d.FORMULA, t.FORMULA ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ASIGNA = isnull( d.ASIGNA, t.ASIGNA ),t.TALONARIO = isnull( d.TALONARIO, t.TALONARIO ),t.POBS = isnull( d.POBS, t.POBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.ATRIBUTO = isnull( d.ATRIBUTO, t.ATRIBUTO ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVEN = isnull( d.PTOVEN, t.PTOVEN ),t.SERVICIO = isnull( d.SERVICIO, t.SERVICIO ),t.TALORELA = isnull( d.TALORELA, t.TALORELA ),t.MAXIMO = isnull( d.MAXIMO, t.MAXIMO ),t.RESERNRO = isnull( d.RESERNRO, t.RESERNRO )
					from ZooLogic.NUMERACIONES t inner join deleted d 
							 on t.Talonario = d.Talonario
				-- Fin Updates
				insert into ZooLogic.NUMERACIONES(Fecexpo,Fecimpo,Fmodifw,Fectrans,Faltafw,Entidad,Timestamp,Delegnum,Valtafw,Zadsfw,Vmodifw,Umodifw,Horaimpo,Ualtafw,Smodifw,Hmodifw,Saltafw,Horaexpo,Esttrans,Haltafw,Bdaltafw,Formula,Bdmodifw,Asigna,Talonario,Pobs,Numero,Atributo,Letra,Ptoven,Servicio,Talorela,Maximo,Resernro)
					Select isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.ENTIDAD,''),isnull( d.TIMESTAMP,0),isnull( d.DELEGNUM,0),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.FORMULA,''),isnull( d.BDMODIFW,''),isnull( d.ASIGNA,0),isnull( d.TALONARIO,''),isnull( d.POBS,''),isnull( d.NUMERO,0),isnull( d.ATRIBUTO,''),isnull( d.LETRA,''),isnull( d.PTOVEN,0),isnull( d.SERVICIO,''),isnull( d.TALORELA,''),isnull( d.MAXIMO,0),isnull( d.RESERNRO,0)
						From deleted d left join ZooLogic.NUMERACIONES pk 
							 on d.Talonario = pk.Talonario
						Where pk.Talonario Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_numeraciones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_numeraciones
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TALONARIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALONARIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALONARIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALONARIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALONARIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALONARIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Entidad = nvl( c_TALONARIO.Entidad, [] )
					.Timestamp = nvl( c_TALONARIO.Timestamp, 0 )
					.Delegarnumeracion = nvl( c_TALONARIO.Delegarnumeracion, .F. )
					.Versionaltafw = nvl( c_TALONARIO.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_TALONARIO.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_TALONARIO.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_TALONARIO.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_TALONARIO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_TALONARIO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_TALONARIO.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_TALONARIO.Seriealtafw, [] )
					.Horaexpo = nvl( c_TALONARIO.Horaexpo, [] )
					.Estadotransferencia = nvl( c_TALONARIO.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_TALONARIO.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_TALONARIO.Basededatosaltafw, [] )
					.Formula = nvl( c_TALONARIO.Formula, [] )
					.Basededatosmodificacionfw = nvl( c_TALONARIO.Basededatosmodificacionfw, [] )
					.Asignacion = nvl( c_TALONARIO.Asignacion, 0 )
					.Codigo = nvl( c_TALONARIO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Numero = nvl( c_TALONARIO.Numero, 0 )
					.Atributo = nvl( c_TALONARIO.Atributo, [] )
					.Letra = nvl( c_TALONARIO.Letra, [] )
					.Puntodeventa = nvl( c_TALONARIO.Puntodeventa, 0 )
					.Servicio = nvl( c_TALONARIO.Servicio, [] )
					.Talonariorela_PK =  nvl( c_TALONARIO.Talonariorela, [] )
					.Maximonumero = nvl( c_TALONARIO.Maximonumero, 0 )
					.Reservarnumero = nvl( c_TALONARIO.Reservarnumero, .F. )
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
		return c_TALONARIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.NUMERACIONES' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Talonario"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Talonario as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Talonario from (
							select * 
								from ZooLogic.NUMERACIONES 
								Where   NUMERACIONES.TALONARIO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "NUMERACIONES", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Talonario"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Entidad" as "Entidad", "Timestamp" as "Timestamp", "Delegnum" as "Delegarnumeracion", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Formula" as "Formula", "Bdmodifw" as "Basededatosmodificacionfw", "Asigna" as "Asignacion", "Talonario" as "Codigo", "Pobs" as "Obs", "Numero" as "Numero", "Atributo" as "Atributo", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Servicio" as "Servicio", "Talorela" as "Talonariorela", "Maximo" as "Maximonumero", "Resernro" as "Reservarnumero"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.NUMERACIONES 
								Where   NUMERACIONES.TALONARIO != ''
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
	Tabla = 'NUMERACIONES'
	Filtro = " NUMERACIONES.TALONARIO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " NUMERACIONES.TALONARIO != ''"
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
	<row entidad="TALONARIO                               " atributo="FECHAEXPO                               " tabla="NUMERACIONES   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="FECHAIMPO                               " tabla="NUMERACIONES   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="FECHAMODIFICACIONFW                     " tabla="NUMERACIONES   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="FECHATRANSFERENCIA                      " tabla="NUMERACIONES   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="FECHAALTAFW                             " tabla="NUMERACIONES   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="ENTIDAD                                 " tabla="NUMERACIONES   " campo="ENTIDAD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="=&quot;FACTURA&quot;                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="2" etiqueta="Entidad                                                                                                                                                         " dominio="COMBORELANUMERACIONES         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="TIMESTAMP                               " tabla="NUMERACIONES   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="DELEGARNUMERACION                       " tabla="NUMERACIONES   " campo="DELEGNUM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Delegar numeración                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="VERSIONALTAFW                           " tabla="NUMERACIONES   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="ZADSFW                                  " tabla="NUMERACIONES   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="VERSIONMODIFICACIONFW                   " tabla="NUMERACIONES   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="USUARIOMODIFICACIONFW                   " tabla="NUMERACIONES   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="HORAIMPO                                " tabla="NUMERACIONES   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="USUARIOALTAFW                           " tabla="NUMERACIONES   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="SERIEMODIFICACIONFW                     " tabla="NUMERACIONES   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="HORAMODIFICACIONFW                      " tabla="NUMERACIONES   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="SERIEALTAFW                             " tabla="NUMERACIONES   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="HORAEXPO                                " tabla="NUMERACIONES   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="ESTADOTRANSFERENCIA                     " tabla="NUMERACIONES   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="HORAALTAFW                              " tabla="NUMERACIONES   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="BASEDEDATOSALTAFW                       " tabla="NUMERACIONES   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="FORMULA                                 " tabla="NUMERACIONES   " campo="FORMULA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fórmula                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="NUMERACIONES   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="ASIGNACION                              " tabla="NUMERACIONES   " campo="ASIGNA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Asignación de número                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="CODIGO                                  " tabla="NUMERACIONES   " campo="TALONARIO " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="35" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Talonario                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="OBS                                     " tabla="NUMERACIONES   " campo="POBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="NUMERO                                  " tabla="NUMERACIONES   " campo="NUMERO    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Último Número                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="ATRIBUTO                                " tabla="NUMERACIONES   " campo="ATRIBUTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Atributo                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="LETRA                                   " tabla="NUMERACIONES   " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="PUNTODEVENTA                            " tabla="NUMERACIONES   " campo="PTOVEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Punto de Venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="SERVICIO                                " tabla="NUMERACIONES   " campo="SERVICIO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Servicio                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="TALONARIORELA                           " tabla="NUMERACIONES   " campo="TALORELA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALONARIO                               " tipodato="C         " longitud="35" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Enumera en                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="MAXIMONUMERO                            " tabla="NUMERACIONES   " campo="MAXIMO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Máximo número                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALONARIO                               " atributo="RESERVARNUMERO                          " tabla="NUMERACIONES   " campo="RESERNRO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Reservar número                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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