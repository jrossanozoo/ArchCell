
define class Din_EntidadPROVINCIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PROVINCIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_013PK'
	cTablaPrincipal = 'PROVINCI'
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
			local  lxProvinciFecexpo, lxProvinciFectrans, lxProvinciFecimpo, lxProvinciFaltafw, lxProvinciFmodifw, lxProvinciTimestamp, lxProvinciSaltafw, lxProvinciSmodifw, lxProvinciUmodifw, lxProvinciUaltafw, lxProvinciZadsfw, lxProvinciValtafw, lxProvinciVmodifw, lxProvinciHmodifw, lxProvinciHoraexpo, lxProvinciEsttrans, lxProvinciBdmodifw, lxProvinciHoraimpo, lxProvinciHaltafw, lxProvinciBdaltafw, lxProvinciPrv_cod, lxProvinciPobs, lxProvinciPrv_des, lxProvinciArba, lxProvinciPrv_jur, lxProvinciPrv_ivalib
				lxProvinciFecexpo =  .Fechaexpo			lxProvinciFectrans =  .Fechatransferencia			lxProvinciFecimpo =  .Fechaimpo			lxProvinciFaltafw =  .Fechaaltafw			lxProvinciFmodifw =  .Fechamodificacionfw			lxProvinciTimestamp = goLibrerias.ObtenerTimestamp()			lxProvinciSaltafw =  .Seriealtafw			lxProvinciSmodifw =  .Seriemodificacionfw			lxProvinciUmodifw =  .Usuariomodificacionfw			lxProvinciUaltafw =  .Usuarioaltafw			lxProvinciZadsfw =  .Zadsfw			lxProvinciValtafw =  .Versionaltafw			lxProvinciVmodifw =  .Versionmodificacionfw			lxProvinciHmodifw =  .Horamodificacionfw			lxProvinciHoraexpo =  .Horaexpo			lxProvinciEsttrans =  .Estadotransferencia			lxProvinciBdmodifw =  .Basededatosmodificacionfw			lxProvinciHoraimpo =  .Horaimpo			lxProvinciHaltafw =  .Horaaltafw			lxProvinciBdaltafw =  .Basededatosaltafw			lxProvinciPrv_cod =  .Codigo			lxProvinciPobs =  .Observacion			lxProvinciPrv_des =  .Descripcion			lxProvinciArba =  .Equivalenciaarba			lxProvinciPrv_jur =  .Jurisdiccion			lxProvinciPrv_ivalib =  .Ivaliberado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxProvinciPrv_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PROVINCI ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Timestamp","Saltafw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Hmodifw","Horaexpo","Esttrans","Bdmodifw","Horaimpo","Haltafw","Bdaltafw","Prv_cod","Pobs","Prv_des","Arba","Prv_jur","Prv_ivalib" ) values ( <<"'" + this.ConvertirDateSql( lxProvinciFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFmodifw ) + "'" >>, <<lxProvinciTimestamp >>, <<"'" + this.FormatearTextoSql( lxProvinciSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPrv_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPrv_des ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciArba ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPrv_jur ) + "'" >>, <<iif( lxProvinciPrv_ivalib, 1, 0 ) >> )
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
		this.oEntidad.Timestamp = lxProvinciTimestamp
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
			local  lxProvinciFecexpo, lxProvinciFectrans, lxProvinciFecimpo, lxProvinciFaltafw, lxProvinciFmodifw, lxProvinciTimestamp, lxProvinciSaltafw, lxProvinciSmodifw, lxProvinciUmodifw, lxProvinciUaltafw, lxProvinciZadsfw, lxProvinciValtafw, lxProvinciVmodifw, lxProvinciHmodifw, lxProvinciHoraexpo, lxProvinciEsttrans, lxProvinciBdmodifw, lxProvinciHoraimpo, lxProvinciHaltafw, lxProvinciBdaltafw, lxProvinciPrv_cod, lxProvinciPobs, lxProvinciPrv_des, lxProvinciArba, lxProvinciPrv_jur, lxProvinciPrv_ivalib
				lxProvinciFecexpo =  .Fechaexpo			lxProvinciFectrans =  .Fechatransferencia			lxProvinciFecimpo =  .Fechaimpo			lxProvinciFaltafw =  .Fechaaltafw			lxProvinciFmodifw =  .Fechamodificacionfw			lxProvinciTimestamp = goLibrerias.ObtenerTimestamp()			lxProvinciSaltafw =  .Seriealtafw			lxProvinciSmodifw =  .Seriemodificacionfw			lxProvinciUmodifw =  .Usuariomodificacionfw			lxProvinciUaltafw =  .Usuarioaltafw			lxProvinciZadsfw =  .Zadsfw			lxProvinciValtafw =  .Versionaltafw			lxProvinciVmodifw =  .Versionmodificacionfw			lxProvinciHmodifw =  .Horamodificacionfw			lxProvinciHoraexpo =  .Horaexpo			lxProvinciEsttrans =  .Estadotransferencia			lxProvinciBdmodifw =  .Basededatosmodificacionfw			lxProvinciHoraimpo =  .Horaimpo			lxProvinciHaltafw =  .Horaaltafw			lxProvinciBdaltafw =  .Basededatosaltafw			lxProvinciPrv_cod =  .Codigo			lxProvinciPobs =  .Observacion			lxProvinciPrv_des =  .Descripcion			lxProvinciArba =  .Equivalenciaarba			lxProvinciPrv_jur =  .Jurisdiccion			lxProvinciPrv_ivalib =  .Ivaliberado
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
				update ZooLogic.PROVINCI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxProvinciFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxProvinciFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxProvinciFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxProvinciFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxProvinciFmodifw ) + "'">>,"Timestamp" = <<lxProvinciTimestamp>>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxProvinciSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxProvinciSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxProvinciUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxProvinciUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxProvinciZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxProvinciValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxProvinciVmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxProvinciHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxProvinciHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxProvinciEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProvinciBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxProvinciHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxProvinciHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProvinciBdaltafw ) + "'">>,"Prv_cod" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_cod ) + "'">>,"Pobs" = <<"'" + this.FormatearTextoSql( lxProvinciPobs ) + "'">>,"Prv_des" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_des ) + "'">>,"Arba" = <<"'" + this.FormatearTextoSql( lxProvinciArba ) + "'">>,"Prv_jur" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_jur ) + "'">>,"Prv_ivalib" = <<iif( lxProvinciPrv_ivalib, 1, 0 )>> where "Prv_cod" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_cod ) + "'">> and  PROVINCI.PRV_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxProvinciTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 PRV_COD from ZooLogic.PROVINCI where " + this.ConvertirFuncionesSql( " PROVINCI.PRV_COD != ''" ) )
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
			Local lxProvinciPrv_cod
			lxProvinciPrv_cod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Prv_cod" as "Codigo", "Pobs" as "Observacion", "Prv_des" as "Descripcion", "Arba" as "Equivalenciaarba", "Prv_jur" as "Jurisdiccion", "Prv_ivalib" as "Ivaliberado" from ZooLogic.PROVINCI where "Prv_cod" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_cod ) + "'">> and  PROVINCI.PRV_COD != ''
			endtext
			use in select('c_PROVINCIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVINCIA', set( 'Datasession' ) )

			if reccount( 'c_PROVINCIA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxProvinciPrv_cod as Variant
		llRetorno = .t.
		lxProvinciPrv_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PROVINCI where "Prv_cod" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_cod ) + "'">> and  PROVINCI.PRV_COD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Prv_cod" as "Codigo", "Pobs" as "Observacion", "Prv_des" as "Descripcion", "Arba" as "Equivalenciaarba", "Prv_jur" as "Jurisdiccion", "Prv_ivalib" as "Ivaliberado" from ZooLogic.PROVINCI where  PROVINCI.PRV_COD != '' order by PRV_COD
			endtext
			use in select('c_PROVINCIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVINCIA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Prv_cod" as "Codigo", "Pobs" as "Observacion", "Prv_des" as "Descripcion", "Arba" as "Equivalenciaarba", "Prv_jur" as "Jurisdiccion", "Prv_ivalib" as "Ivaliberado" from ZooLogic.PROVINCI where  funciones.padr( PRV_COD, 2, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROVINCI.PRV_COD != '' order by PRV_COD
			endtext
			use in select('c_PROVINCIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVINCIA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Prv_cod" as "Codigo", "Pobs" as "Observacion", "Prv_des" as "Descripcion", "Arba" as "Equivalenciaarba", "Prv_jur" as "Jurisdiccion", "Prv_ivalib" as "Ivaliberado" from ZooLogic.PROVINCI where  funciones.padr( PRV_COD, 2, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROVINCI.PRV_COD != '' order by PRV_COD desc
			endtext
			use in select('c_PROVINCIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVINCIA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Prv_cod" as "Codigo", "Pobs" as "Observacion", "Prv_des" as "Descripcion", "Arba" as "Equivalenciaarba", "Prv_jur" as "Jurisdiccion", "Prv_ivalib" as "Ivaliberado" from ZooLogic.PROVINCI where  PROVINCI.PRV_COD != '' order by PRV_COD desc
			endtext
			use in select('c_PROVINCIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVINCIA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Timestamp,Saltafw,Smodifw,Umodifw,Ualtafw,Zadsfw,Va" + ;
"ltafw,Vmodifw,Hmodifw,Horaexpo,Esttrans,Bdmodifw,Horaimpo,Haltafw,Bdaltafw,Prv_cod,Pobs,Prv_des,Arba" + ;
",Prv_jur,Prv_ivalib" + ;
" from ZooLogic.PROVINCI where  PROVINCI.PRV_COD != '' and " + lcFiltro )
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
			local  lxProvinciFecexpo, lxProvinciFectrans, lxProvinciFecimpo, lxProvinciFaltafw, lxProvinciFmodifw, lxProvinciTimestamp, lxProvinciSaltafw, lxProvinciSmodifw, lxProvinciUmodifw, lxProvinciUaltafw, lxProvinciZadsfw, lxProvinciValtafw, lxProvinciVmodifw, lxProvinciHmodifw, lxProvinciHoraexpo, lxProvinciEsttrans, lxProvinciBdmodifw, lxProvinciHoraimpo, lxProvinciHaltafw, lxProvinciBdaltafw, lxProvinciPrv_cod, lxProvinciPobs, lxProvinciPrv_des, lxProvinciArba, lxProvinciPrv_jur, lxProvinciPrv_ivalib
				lxProvinciFecexpo = ctod( '  /  /    ' )			lxProvinciFectrans = ctod( '  /  /    ' )			lxProvinciFecimpo = ctod( '  /  /    ' )			lxProvinciFaltafw = ctod( '  /  /    ' )			lxProvinciFmodifw = ctod( '  /  /    ' )			lxProvinciTimestamp = goLibrerias.ObtenerTimestamp()			lxProvinciSaltafw = []			lxProvinciSmodifw = []			lxProvinciUmodifw = []			lxProvinciUaltafw = []			lxProvinciZadsfw = []			lxProvinciValtafw = []			lxProvinciVmodifw = []			lxProvinciHmodifw = []			lxProvinciHoraexpo = []			lxProvinciEsttrans = []			lxProvinciBdmodifw = []			lxProvinciHoraimpo = []			lxProvinciHaltafw = []			lxProvinciBdaltafw = []			lxProvinciPrv_cod = []			lxProvinciPobs = []			lxProvinciPrv_des = []			lxProvinciArba = []			lxProvinciPrv_jur = []			lxProvinciPrv_ivalib = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PROVINCI where "PRV_COD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PROVINCI' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where PRV_COD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(PRV_COD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PROVINCI.PRV_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Prv_cod" as "Codigo", "Pobs" as "Observacion", "Prv_des" as "Descripcion", "Arba" as "Equivalenciaarba", "Prv_jur" as "Jurisdiccion", "Prv_ivalib" as "Ivaliberado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PROVINCI', '', tnTope )
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
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRV_COD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'POBS AS OBSERVACION'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRV_DES AS DESCRIPCION'
				Case lcAtributo == 'EQUIVALENCIAARBA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARBA AS EQUIVALENCIAARBA'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRV_JUR AS JURISDICCION'
				Case lcAtributo == 'IVALIBERADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRV_IVALIB AS IVALIBERADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'PRV_COD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'POBS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'PRV_DES'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIAARBA'
				lcCampo = 'ARBA'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'PRV_JUR'
			Case upper( alltrim( tcAtributo ) ) == 'IVALIBERADO'
				lcCampo = 'PRV_IVALIB'
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
			local  lxProvinciFecexpo, lxProvinciFectrans, lxProvinciFecimpo, lxProvinciFaltafw, lxProvinciFmodifw, lxProvinciTimestamp, lxProvinciSaltafw, lxProvinciSmodifw, lxProvinciUmodifw, lxProvinciUaltafw, lxProvinciZadsfw, lxProvinciValtafw, lxProvinciVmodifw, lxProvinciHmodifw, lxProvinciHoraexpo, lxProvinciEsttrans, lxProvinciBdmodifw, lxProvinciHoraimpo, lxProvinciHaltafw, lxProvinciBdaltafw, lxProvinciPrv_cod, lxProvinciPobs, lxProvinciPrv_des, lxProvinciArba, lxProvinciPrv_jur, lxProvinciPrv_ivalib
				lxProvinciFecexpo =  .Fechaexpo			lxProvinciFectrans =  .Fechatransferencia			lxProvinciFecimpo =  .Fechaimpo			lxProvinciFaltafw =  .Fechaaltafw			lxProvinciFmodifw =  .Fechamodificacionfw			lxProvinciTimestamp = goLibrerias.ObtenerTimestamp()			lxProvinciSaltafw =  .Seriealtafw			lxProvinciSmodifw =  .Seriemodificacionfw			lxProvinciUmodifw =  .Usuariomodificacionfw			lxProvinciUaltafw =  .Usuarioaltafw			lxProvinciZadsfw =  .Zadsfw			lxProvinciValtafw =  .Versionaltafw			lxProvinciVmodifw =  .Versionmodificacionfw			lxProvinciHmodifw =  .Horamodificacionfw			lxProvinciHoraexpo =  .Horaexpo			lxProvinciEsttrans =  .Estadotransferencia			lxProvinciBdmodifw =  .Basededatosmodificacionfw			lxProvinciHoraimpo =  .Horaimpo			lxProvinciHaltafw =  .Horaaltafw			lxProvinciBdaltafw =  .Basededatosaltafw			lxProvinciPrv_cod =  .Codigo			lxProvinciPobs =  .Observacion			lxProvinciPrv_des =  .Descripcion			lxProvinciArba =  .Equivalenciaarba			lxProvinciPrv_jur =  .Jurisdiccion			lxProvinciPrv_ivalib =  .Ivaliberado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PROVINCI ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Timestamp","Saltafw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Hmodifw","Horaexpo","Esttrans","Bdmodifw","Horaimpo","Haltafw","Bdaltafw","Prv_cod","Pobs","Prv_des","Arba","Prv_jur","Prv_ivalib" ) values ( <<"'" + this.ConvertirDateSql( lxProvinciFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvinciFmodifw ) + "'" >>, <<lxProvinciTimestamp >>, <<"'" + this.FormatearTextoSql( lxProvinciSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPrv_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPrv_des ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciArba ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvinciPrv_jur ) + "'" >>, <<iif( lxProvinciPrv_ivalib, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'PROVINCI' 
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
			local  lxProvinciFecexpo, lxProvinciFectrans, lxProvinciFecimpo, lxProvinciFaltafw, lxProvinciFmodifw, lxProvinciTimestamp, lxProvinciSaltafw, lxProvinciSmodifw, lxProvinciUmodifw, lxProvinciUaltafw, lxProvinciZadsfw, lxProvinciValtafw, lxProvinciVmodifw, lxProvinciHmodifw, lxProvinciHoraexpo, lxProvinciEsttrans, lxProvinciBdmodifw, lxProvinciHoraimpo, lxProvinciHaltafw, lxProvinciBdaltafw, lxProvinciPrv_cod, lxProvinciPobs, lxProvinciPrv_des, lxProvinciArba, lxProvinciPrv_jur, lxProvinciPrv_ivalib
				lxProvinciFecexpo =  .Fechaexpo			lxProvinciFectrans =  .Fechatransferencia			lxProvinciFecimpo =  .Fechaimpo			lxProvinciFaltafw =  .Fechaaltafw			lxProvinciFmodifw =  .Fechamodificacionfw			lxProvinciTimestamp = goLibrerias.ObtenerTimestamp()			lxProvinciSaltafw =  .Seriealtafw			lxProvinciSmodifw =  .Seriemodificacionfw			lxProvinciUmodifw =  .Usuariomodificacionfw			lxProvinciUaltafw =  .Usuarioaltafw			lxProvinciZadsfw =  .Zadsfw			lxProvinciValtafw =  .Versionaltafw			lxProvinciVmodifw =  .Versionmodificacionfw			lxProvinciHmodifw =  .Horamodificacionfw			lxProvinciHoraexpo =  .Horaexpo			lxProvinciEsttrans =  .Estadotransferencia			lxProvinciBdmodifw =  .Basededatosmodificacionfw			lxProvinciHoraimpo =  .Horaimpo			lxProvinciHaltafw =  .Horaaltafw			lxProvinciBdaltafw =  .Basededatosaltafw			lxProvinciPrv_cod =  .Codigo			lxProvinciPobs =  .Observacion			lxProvinciPrv_des =  .Descripcion			lxProvinciArba =  .Equivalenciaarba			lxProvinciPrv_jur =  .Jurisdiccion			lxProvinciPrv_ivalib =  .Ivaliberado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Prv_cod" = ] + lcValorClavePrimariaString  + [ and  PROVINCI.PRV_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PROVINCI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxProvinciFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxProvinciFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxProvinciFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxProvinciFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxProvinciFmodifw ) + "'">>, "Timestamp" = <<lxProvinciTimestamp>>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxProvinciSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxProvinciSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxProvinciUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxProvinciUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxProvinciZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxProvinciValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxProvinciVmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxProvinciHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxProvinciHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxProvinciEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProvinciBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxProvinciHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxProvinciHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProvinciBdaltafw ) + "'">>, "Prv_cod" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_cod ) + "'">>, "Pobs" = <<"'" + this.FormatearTextoSql( lxProvinciPobs ) + "'">>, "Prv_des" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_des ) + "'">>, "Arba" = <<"'" + this.FormatearTextoSql( lxProvinciArba ) + "'">>, "Prv_jur" = <<"'" + this.FormatearTextoSql( lxProvinciPrv_jur ) + "'">>, "Prv_ivalib" = <<iif( lxProvinciPrv_ivalib, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PROVINCI' 
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

			lcFiltro = ["Prv_cod" = ] + lcValorClavePrimariaString  + [ and  PROVINCI.PRV_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.PROVINCI where ' + lcFiltro )
			loColeccion.cTabla = 'PROVINCI' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PROVINCI where  PROVINCI.PRV_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PROVINCI where PRV_COD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PROVINCI.PRV_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVINCIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PROVINCI Where PRV_COD = ] + "'" + this.FormatearTextoSql( &lcCursor..PRV_COD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.PROVINCI set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, PRV_COD = ] + "'" + this.FormatearTextoSql( &lcCursor..PRV_COD ) + "'"+ [, PObs = ] + "'" + this.FormatearTextoSql( &lcCursor..PObs ) + "'"+ [, PRV_DES = ] + "'" + this.FormatearTextoSql( &lcCursor..PRV_DES ) + "'"+ [, Arba = ] + "'" + this.FormatearTextoSql( &lcCursor..Arba ) + "'"+ [, PRV_JUR = ] + "'" + this.FormatearTextoSql( &lcCursor..PRV_JUR ) + "'"+ [, PRV_IVALIB = ] + Transform( iif( &lcCursor..PRV_IVALIB, 1, 0 )) + [ Where PRV_COD = ] + "'" + this.FormatearTextoSql( &lcCursor..PRV_COD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, TIMESTAMP, SALTAFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HMODIFW, HORAEXPO, ESTTRANS, BDMODIFW, HORAIMPO, HALTAFW, BDALTAFW, PRV_COD, PObs, PRV_DES, Arba, PRV_JUR, PRV_IVALIB
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PRV_COD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PRV_DES ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Arba ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PRV_JUR ) + "'" + ',' + Transform( iif( &lcCursor..PRV_IVALIB, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.PROVINCI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVINCIA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( PRV_COD C (2) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..PRV_COD    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PROVINCIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROVINCIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROVINCIA_POBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PROVINCI')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PROVINCIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..PRV_COD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PROVINCIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVINCIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,PRV_COD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( PRV_COD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVINCIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROVINCI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROVINCI
Create Table ZooLogic.TablaTrabajo_PROVINCI ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"prv_cod" char( 2 )  null, 
"pobs" varchar(max)  null, 
"prv_des" char( 50 )  null, 
"arba" char( 1 )  null, 
"prv_jur" char( 3 )  null, 
"prv_ivalib" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PROVINCI' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PROVINCI' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVINCIA'
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
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('prv_cod','prv_cod')
			.AgregarMapeo('pobs','pobs')
			.AgregarMapeo('prv_des','prv_des')
			.AgregarMapeo('arba','arba')
			.AgregarMapeo('prv_jur','prv_jur')
			.AgregarMapeo('prv_ivalib','prv_ivalib')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PROVINCI'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.PRV_COD = isnull( d.PRV_COD, t.PRV_COD ),t.POBS = isnull( d.POBS, t.POBS ),t.PRV_DES = isnull( d.PRV_DES, t.PRV_DES ),t.ARBA = isnull( d.ARBA, t.ARBA ),t.PRV_JUR = isnull( d.PRV_JUR, t.PRV_JUR ),t.PRV_IVALIB = isnull( d.PRV_IVALIB, t.PRV_IVALIB )
					from ZooLogic.PROVINCI t inner join deleted d 
							 on t.PRV_COD = d.PRV_COD
				-- Fin Updates
				insert into ZooLogic.PROVINCI(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Timestamp,Saltafw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Hmodifw,Horaexpo,Esttrans,Bdmodifw,Horaimpo,Haltafw,Bdaltafw,Prv_cod,Pobs,Prv_des,Arba,Prv_jur,Prv_ivalib)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.PRV_COD,''),isnull( d.POBS,''),isnull( d.PRV_DES,''),isnull( d.ARBA,''),isnull( d.PRV_JUR,''),isnull( d.PRV_IVALIB,0)
						From deleted d left join ZooLogic.PROVINCI pk 
							 on d.PRV_COD = pk.PRV_COD
						Where pk.PRV_COD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROVINCI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROVINCI
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PROVINCIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVINCIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVINCIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVINCIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVINCIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVINCIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_PROVINCIA.Timestamp, 0 )
					.Seriealtafw = nvl( c_PROVINCIA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_PROVINCIA.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_PROVINCIA.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_PROVINCIA.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_PROVINCIA.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_PROVINCIA.Versionmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_PROVINCIA.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_PROVINCIA.Horaexpo, [] )
					.Estadotransferencia = nvl( c_PROVINCIA.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_PROVINCIA.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_PROVINCIA.Horaimpo, [] )
					.Horaaltafw = nvl( c_PROVINCIA.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_PROVINCIA.Basededatosaltafw, [] )
					.Codigo = nvl( c_PROVINCIA.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Descripcion = nvl( c_PROVINCIA.Descripcion, [] )
					.Equivalenciaarba = nvl( c_PROVINCIA.Equivalenciaarba, [] )
					.Jurisdiccion = nvl( c_PROVINCIA.Jurisdiccion, [] )
					.Ivaliberado = nvl( c_PROVINCIA.Ivaliberado, .F. )
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
		return c_PROVINCIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PROVINCI' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "PRV_COD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,PRV_COD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    PRV_COD from (
							select * 
								from ZooLogic.PROVINCI 
								Where   PROVINCI.PRV_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PROVINCI", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "PRV_COD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Prv_cod" as "Codigo", "Pobs" as "Observacion", "Prv_des" as "Descripcion", "Arba" as "Equivalenciaarba", "Prv_jur" as "Jurisdiccion", "Prv_ivalib" as "Ivaliberado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PROVINCI 
								Where   PROVINCI.PRV_COD != ''
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
	Tabla = 'PROVINCI'
	Filtro = " PROVINCI.PRV_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PROVINCI.PRV_COD != ''"
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
	<row entidad="PROVINCIA                               " atributo="FECHAEXPO                               " tabla="PROVINCI       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="FECHATRANSFERENCIA                      " tabla="PROVINCI       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="FECHAIMPO                               " tabla="PROVINCI       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="FECHAALTAFW                             " tabla="PROVINCI       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="FECHAMODIFICACIONFW                     " tabla="PROVINCI       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="TIMESTAMP                               " tabla="PROVINCI       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="SERIEALTAFW                             " tabla="PROVINCI       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="SERIEMODIFICACIONFW                     " tabla="PROVINCI       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="USUARIOMODIFICACIONFW                   " tabla="PROVINCI       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="USUARIOALTAFW                           " tabla="PROVINCI       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="ZADSFW                                  " tabla="PROVINCI       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="VERSIONALTAFW                           " tabla="PROVINCI       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="VERSIONMODIFICACIONFW                   " tabla="PROVINCI       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="HORAMODIFICACIONFW                      " tabla="PROVINCI       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="HORAEXPO                                " tabla="PROVINCI       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="ESTADOTRANSFERENCIA                     " tabla="PROVINCI       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PROVINCI       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="HORAIMPO                                " tabla="PROVINCI       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="HORAALTAFW                              " tabla="PROVINCI       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="BASEDEDATOSALTAFW                       " tabla="PROVINCI       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="CODIGO                                  " tabla="PROVINCI       " campo="PRV_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="OBSERVACION                             " tabla="PROVINCI       " campo="POBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="EQUIVALENCIAARBA                        " tabla="PROVINCI       " campo="ARBA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Código ARBA                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="JURISDICCION                            " tabla="PROVINCI       " campo="PRV_JUR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Jurisdicción                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="IVALIBERADO                             " tabla="PROVINCI       " campo="PRV_IVALIB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="IVA liberado ley 19640                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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