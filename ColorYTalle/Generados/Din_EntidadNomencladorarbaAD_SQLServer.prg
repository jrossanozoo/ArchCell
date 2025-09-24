
define class Din_EntidadNOMENCLADORARBAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_NOMENCLADORARBA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_NARPK'
	cTablaPrincipal = 'NMCARBA'
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
			local  lxNmcarbaFecimpo, lxNmcarbaFecexpo, lxNmcarbaFectrans, lxNmcarbaFmodifw, lxNmcarbaFaltafw, lxNmcarbaSaltafw, lxNmcarbaSmodifw, lxNmcarbaVmodifw, lxNmcarbaZadsfw, lxNmcarbaUmodifw, lxNmcarbaValtafw, lxNmcarbaHmodifw, lxNmcarbaUaltafw, lxNmcarbaHaltafw, lxNmcarbaHoraimpo, lxNmcarbaBdmodifw, lxNmcarbaHoraexpo, lxNmcarbaBdaltafw, lxNmcarbaEsttrans, lxNmcarbaTimestamp, lxNmcarbaBloqreg, lxNmcarbaNmcobs, lxNmcarbaNmccod, lxNmcarbaNmcdes, lxNmcarbaNmcum
				lxNmcarbaFecimpo =  .Fechaimpo			lxNmcarbaFecexpo =  .Fechaexpo			lxNmcarbaFectrans =  .Fechatransferencia			lxNmcarbaFmodifw =  .Fechamodificacionfw			lxNmcarbaFaltafw =  .Fechaaltafw			lxNmcarbaSaltafw =  .Seriealtafw			lxNmcarbaSmodifw =  .Seriemodificacionfw			lxNmcarbaVmodifw =  .Versionmodificacionfw			lxNmcarbaZadsfw =  .Zadsfw			lxNmcarbaUmodifw =  .Usuariomodificacionfw			lxNmcarbaValtafw =  .Versionaltafw			lxNmcarbaHmodifw =  .Horamodificacionfw			lxNmcarbaUaltafw =  .Usuarioaltafw			lxNmcarbaHaltafw =  .Horaaltafw			lxNmcarbaHoraimpo =  .Horaimpo			lxNmcarbaBdmodifw =  .Basededatosmodificacionfw			lxNmcarbaHoraexpo =  .Horaexpo			lxNmcarbaBdaltafw =  .Basededatosaltafw			lxNmcarbaEsttrans =  .Estadotransferencia			lxNmcarbaTimestamp = goLibrerias.ObtenerTimestamp()			lxNmcarbaBloqreg =  .Bloquearregistro			lxNmcarbaNmcobs =  .Observacion			lxNmcarbaNmccod =  .Codigo			lxNmcarbaNmcdes =  .Descripcion			lxNmcarbaNmcum =  upper( .UnidadDeMedida_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxNmcarbaNmccod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.NMCARBA ( "Fecimpo","Fecexpo","Fectrans","Fmodifw","Faltafw","Saltafw","Smodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Hmodifw","Ualtafw","Haltafw","Horaimpo","Bdmodifw","Horaexpo","Bdaltafw","Esttrans","Timestamp","Bloqreg","Nmcobs","Nmccod","Nmcdes","Nmcum" ) values ( <<"'" + this.ConvertirDateSql( lxNmcarbaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaEsttrans ) + "'" >>, <<lxNmcarbaTimestamp >>, <<iif( lxNmcarbaBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmcobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmccod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmcdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmcum ) + "'" >> )
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
		this.oEntidad.Timestamp = lxNmcarbaTimestamp
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
			local  lxNmcarbaFecimpo, lxNmcarbaFecexpo, lxNmcarbaFectrans, lxNmcarbaFmodifw, lxNmcarbaFaltafw, lxNmcarbaSaltafw, lxNmcarbaSmodifw, lxNmcarbaVmodifw, lxNmcarbaZadsfw, lxNmcarbaUmodifw, lxNmcarbaValtafw, lxNmcarbaHmodifw, lxNmcarbaUaltafw, lxNmcarbaHaltafw, lxNmcarbaHoraimpo, lxNmcarbaBdmodifw, lxNmcarbaHoraexpo, lxNmcarbaBdaltafw, lxNmcarbaEsttrans, lxNmcarbaTimestamp, lxNmcarbaBloqreg, lxNmcarbaNmcobs, lxNmcarbaNmccod, lxNmcarbaNmcdes, lxNmcarbaNmcum
				lxNmcarbaFecimpo =  .Fechaimpo			lxNmcarbaFecexpo =  .Fechaexpo			lxNmcarbaFectrans =  .Fechatransferencia			lxNmcarbaFmodifw =  .Fechamodificacionfw			lxNmcarbaFaltafw =  .Fechaaltafw			lxNmcarbaSaltafw =  .Seriealtafw			lxNmcarbaSmodifw =  .Seriemodificacionfw			lxNmcarbaVmodifw =  .Versionmodificacionfw			lxNmcarbaZadsfw =  .Zadsfw			lxNmcarbaUmodifw =  .Usuariomodificacionfw			lxNmcarbaValtafw =  .Versionaltafw			lxNmcarbaHmodifw =  .Horamodificacionfw			lxNmcarbaUaltafw =  .Usuarioaltafw			lxNmcarbaHaltafw =  .Horaaltafw			lxNmcarbaHoraimpo =  .Horaimpo			lxNmcarbaBdmodifw =  .Basededatosmodificacionfw			lxNmcarbaHoraexpo =  .Horaexpo			lxNmcarbaBdaltafw =  .Basededatosaltafw			lxNmcarbaEsttrans =  .Estadotransferencia			lxNmcarbaTimestamp = goLibrerias.ObtenerTimestamp()			lxNmcarbaBloqreg =  .Bloquearregistro			lxNmcarbaNmcobs =  .Observacion			lxNmcarbaNmccod =  .Codigo			lxNmcarbaNmcdes =  .Descripcion			lxNmcarbaNmcum =  upper( .UnidadDeMedida_PK ) 
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
				update ZooLogic.NMCARBA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxNmcarbaFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxNmcarbaFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxNmcarbaFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxNmcarbaFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxNmcarbaFaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxNmcarbaZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaUaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxNmcarbaHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxNmcarbaHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxNmcarbaEsttrans ) + "'">>,"Timestamp" = <<lxNmcarbaTimestamp>>,"Bloqreg" = <<iif( lxNmcarbaBloqreg, 1, 0 )>>,"Nmcobs" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmcobs ) + "'">>,"Nmccod" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmccod ) + "'">>,"Nmcdes" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmcdes ) + "'">>,"Nmcum" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmcum ) + "'">> where "Nmccod" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmccod ) + "'">> and  NMCARBA.NMCCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxNmcarbaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NMCCOD from ZooLogic.NMCARBA where " + this.ConvertirFuncionesSql( " NMCARBA.NMCCOD != ''" ) )
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
			Local lxNmcarbaNmccod
			lxNmcarbaNmccod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Nmcobs" as "Observacion", "Nmccod" as "Codigo", "Nmcdes" as "Descripcion", "Nmcum" as "Unidaddemedida" from ZooLogic.NMCARBA where "Nmccod" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmccod ) + "'">> and  NMCARBA.NMCCOD != ''
			endtext
			use in select('c_NOMENCLADORARBA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMENCLADORARBA', set( 'Datasession' ) )

			if reccount( 'c_NOMENCLADORARBA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxNmcarbaNmccod as Variant
		llRetorno = .t.
		lxNmcarbaNmccod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.NMCARBA where "Nmccod" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmccod ) + "'">> and  NMCARBA.NMCCOD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Nmcobs" as "Observacion", "Nmccod" as "Codigo", "Nmcdes" as "Descripcion", "Nmcum" as "Unidaddemedida" from ZooLogic.NMCARBA where  NMCARBA.NMCCOD != '' order by NMCCOD
			endtext
			use in select('c_NOMENCLADORARBA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMENCLADORARBA', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Nmcobs" as "Observacion", "Nmccod" as "Codigo", "Nmcdes" as "Descripcion", "Nmcum" as "Unidaddemedida" from ZooLogic.NMCARBA where  funciones.padr( NMCCOD, 6, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  NMCARBA.NMCCOD != '' order by NMCCOD
			endtext
			use in select('c_NOMENCLADORARBA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMENCLADORARBA', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Nmcobs" as "Observacion", "Nmccod" as "Codigo", "Nmcdes" as "Descripcion", "Nmcum" as "Unidaddemedida" from ZooLogic.NMCARBA where  funciones.padr( NMCCOD, 6, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  NMCARBA.NMCCOD != '' order by NMCCOD desc
			endtext
			use in select('c_NOMENCLADORARBA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMENCLADORARBA', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Nmcobs" as "Observacion", "Nmccod" as "Codigo", "Nmcdes" as "Descripcion", "Nmcum" as "Unidaddemedida" from ZooLogic.NMCARBA where  NMCARBA.NMCCOD != '' order by NMCCOD desc
			endtext
			use in select('c_NOMENCLADORARBA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMENCLADORARBA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fectrans,Fmodifw,Faltafw,Saltafw,Smodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Hmod" + ;
"ifw,Ualtafw,Haltafw,Horaimpo,Bdmodifw,Horaexpo,Bdaltafw,Esttrans,Timestamp,Bloqreg,Nmcobs,Nmccod,Nmc" + ;
"des,Nmcum" + ;
" from ZooLogic.NMCARBA where  NMCARBA.NMCCOD != '' and " + lcFiltro )
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
			local  lxNmcarbaFecimpo, lxNmcarbaFecexpo, lxNmcarbaFectrans, lxNmcarbaFmodifw, lxNmcarbaFaltafw, lxNmcarbaSaltafw, lxNmcarbaSmodifw, lxNmcarbaVmodifw, lxNmcarbaZadsfw, lxNmcarbaUmodifw, lxNmcarbaValtafw, lxNmcarbaHmodifw, lxNmcarbaUaltafw, lxNmcarbaHaltafw, lxNmcarbaHoraimpo, lxNmcarbaBdmodifw, lxNmcarbaHoraexpo, lxNmcarbaBdaltafw, lxNmcarbaEsttrans, lxNmcarbaTimestamp, lxNmcarbaBloqreg, lxNmcarbaNmcobs, lxNmcarbaNmccod, lxNmcarbaNmcdes, lxNmcarbaNmcum
				lxNmcarbaFecimpo = ctod( '  /  /    ' )			lxNmcarbaFecexpo = ctod( '  /  /    ' )			lxNmcarbaFectrans = ctod( '  /  /    ' )			lxNmcarbaFmodifw = ctod( '  /  /    ' )			lxNmcarbaFaltafw = ctod( '  /  /    ' )			lxNmcarbaSaltafw = []			lxNmcarbaSmodifw = []			lxNmcarbaVmodifw = []			lxNmcarbaZadsfw = []			lxNmcarbaUmodifw = []			lxNmcarbaValtafw = []			lxNmcarbaHmodifw = []			lxNmcarbaUaltafw = []			lxNmcarbaHaltafw = []			lxNmcarbaHoraimpo = []			lxNmcarbaBdmodifw = []			lxNmcarbaHoraexpo = []			lxNmcarbaBdaltafw = []			lxNmcarbaEsttrans = []			lxNmcarbaTimestamp = goLibrerias.ObtenerTimestamp()			lxNmcarbaBloqreg = .F.			lxNmcarbaNmcobs = []			lxNmcarbaNmccod = []			lxNmcarbaNmcdes = []			lxNmcarbaNmcum = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.NMCARBA where "NMCCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'NMCARBA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NMCCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NMCCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  NMCARBA.NMCCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Nmcobs" as "Observacion", "Nmccod" as "Codigo", "Nmcdes" as "Descripcion", "Nmcum" as "Unidaddemedida"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'NMCARBA', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
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
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMCOBS AS OBSERVACION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMCCOD AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMCDES AS DESCRIPCION'
				Case lcAtributo == 'UNIDADDEMEDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMCUM AS UNIDADDEMEDIDA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'NMCOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'NMCCOD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'NMCDES'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDA'
				lcCampo = 'NMCUM'
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
			local  lxNmcarbaFecimpo, lxNmcarbaFecexpo, lxNmcarbaFectrans, lxNmcarbaFmodifw, lxNmcarbaFaltafw, lxNmcarbaSaltafw, lxNmcarbaSmodifw, lxNmcarbaVmodifw, lxNmcarbaZadsfw, lxNmcarbaUmodifw, lxNmcarbaValtafw, lxNmcarbaHmodifw, lxNmcarbaUaltafw, lxNmcarbaHaltafw, lxNmcarbaHoraimpo, lxNmcarbaBdmodifw, lxNmcarbaHoraexpo, lxNmcarbaBdaltafw, lxNmcarbaEsttrans, lxNmcarbaTimestamp, lxNmcarbaBloqreg, lxNmcarbaNmcobs, lxNmcarbaNmccod, lxNmcarbaNmcdes, lxNmcarbaNmcum
				lxNmcarbaFecimpo =  .Fechaimpo			lxNmcarbaFecexpo =  .Fechaexpo			lxNmcarbaFectrans =  .Fechatransferencia			lxNmcarbaFmodifw =  .Fechamodificacionfw			lxNmcarbaFaltafw =  .Fechaaltafw			lxNmcarbaSaltafw =  .Seriealtafw			lxNmcarbaSmodifw =  .Seriemodificacionfw			lxNmcarbaVmodifw =  .Versionmodificacionfw			lxNmcarbaZadsfw =  .Zadsfw			lxNmcarbaUmodifw =  .Usuariomodificacionfw			lxNmcarbaValtafw =  .Versionaltafw			lxNmcarbaHmodifw =  .Horamodificacionfw			lxNmcarbaUaltafw =  .Usuarioaltafw			lxNmcarbaHaltafw =  .Horaaltafw			lxNmcarbaHoraimpo =  .Horaimpo			lxNmcarbaBdmodifw =  .Basededatosmodificacionfw			lxNmcarbaHoraexpo =  .Horaexpo			lxNmcarbaBdaltafw =  .Basededatosaltafw			lxNmcarbaEsttrans =  .Estadotransferencia			lxNmcarbaTimestamp = goLibrerias.ObtenerTimestamp()			lxNmcarbaBloqreg =  .Bloquearregistro			lxNmcarbaNmcobs =  .Observacion			lxNmcarbaNmccod =  .Codigo			lxNmcarbaNmcdes =  .Descripcion			lxNmcarbaNmcum =  upper( .UnidadDeMedida_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.NMCARBA ( "Fecimpo","Fecexpo","Fectrans","Fmodifw","Faltafw","Saltafw","Smodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Hmodifw","Ualtafw","Haltafw","Horaimpo","Bdmodifw","Horaexpo","Bdaltafw","Esttrans","Timestamp","Bloqreg","Nmcobs","Nmccod","Nmcdes","Nmcum" ) values ( <<"'" + this.ConvertirDateSql( lxNmcarbaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNmcarbaFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaEsttrans ) + "'" >>, <<lxNmcarbaTimestamp >>, <<iif( lxNmcarbaBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmcobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmccod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmcdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNmcarbaNmcum ) + "'" >> )
		endtext
		loColeccion.cTabla = 'NMCARBA' 
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
			local  lxNmcarbaFecimpo, lxNmcarbaFecexpo, lxNmcarbaFectrans, lxNmcarbaFmodifw, lxNmcarbaFaltafw, lxNmcarbaSaltafw, lxNmcarbaSmodifw, lxNmcarbaVmodifw, lxNmcarbaZadsfw, lxNmcarbaUmodifw, lxNmcarbaValtafw, lxNmcarbaHmodifw, lxNmcarbaUaltafw, lxNmcarbaHaltafw, lxNmcarbaHoraimpo, lxNmcarbaBdmodifw, lxNmcarbaHoraexpo, lxNmcarbaBdaltafw, lxNmcarbaEsttrans, lxNmcarbaTimestamp, lxNmcarbaBloqreg, lxNmcarbaNmcobs, lxNmcarbaNmccod, lxNmcarbaNmcdes, lxNmcarbaNmcum
				lxNmcarbaFecimpo =  .Fechaimpo			lxNmcarbaFecexpo =  .Fechaexpo			lxNmcarbaFectrans =  .Fechatransferencia			lxNmcarbaFmodifw =  .Fechamodificacionfw			lxNmcarbaFaltafw =  .Fechaaltafw			lxNmcarbaSaltafw =  .Seriealtafw			lxNmcarbaSmodifw =  .Seriemodificacionfw			lxNmcarbaVmodifw =  .Versionmodificacionfw			lxNmcarbaZadsfw =  .Zadsfw			lxNmcarbaUmodifw =  .Usuariomodificacionfw			lxNmcarbaValtafw =  .Versionaltafw			lxNmcarbaHmodifw =  .Horamodificacionfw			lxNmcarbaUaltafw =  .Usuarioaltafw			lxNmcarbaHaltafw =  .Horaaltafw			lxNmcarbaHoraimpo =  .Horaimpo			lxNmcarbaBdmodifw =  .Basededatosmodificacionfw			lxNmcarbaHoraexpo =  .Horaexpo			lxNmcarbaBdaltafw =  .Basededatosaltafw			lxNmcarbaEsttrans =  .Estadotransferencia			lxNmcarbaTimestamp = goLibrerias.ObtenerTimestamp()			lxNmcarbaBloqreg =  .Bloquearregistro			lxNmcarbaNmcobs =  .Observacion			lxNmcarbaNmccod =  .Codigo			lxNmcarbaNmcdes =  .Descripcion			lxNmcarbaNmcum =  upper( .UnidadDeMedida_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Nmccod" = ] + lcValorClavePrimariaString  + [ and  NMCARBA.NMCCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.NMCARBA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxNmcarbaFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxNmcarbaFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxNmcarbaFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxNmcarbaFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxNmcarbaFaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxNmcarbaZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaUaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxNmcarbaHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxNmcarbaBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxNmcarbaHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxNmcarbaBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxNmcarbaEsttrans ) + "'">>, "Timestamp" = <<lxNmcarbaTimestamp>>, "Bloqreg" = <<iif( lxNmcarbaBloqreg, 1, 0 )>>, "Nmcobs" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmcobs ) + "'">>, "Nmccod" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmccod ) + "'">>, "Nmcdes" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmcdes ) + "'">>, "Nmcum" = <<"'" + this.FormatearTextoSql( lxNmcarbaNmcum ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'NMCARBA' 
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

			lcFiltro = ["Nmccod" = ] + lcValorClavePrimariaString  + [ and  NMCARBA.NMCCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.NMCARBA where ' + lcFiltro )
			loColeccion.cTabla = 'NMCARBA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.NMCARBA where  NMCARBA.NMCCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.NMCARBA where NMCCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  NMCARBA.NMCCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMENCLADORARBA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.NMCARBA Where NMCCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..NMCCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.NMCARBA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, NMCOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..NMCOBS ) + "'"+ [, NMCCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..NMCCOD ) + "'"+ [, NMCDES = ] + "'" + this.FormatearTextoSql( &lcCursor..NMCDES ) + "'"+ [, NMCUM = ] + "'" + this.FormatearTextoSql( &lcCursor..NMCUM ) + "'" + [ Where NMCCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..NMCCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECEXPO, FECTRANS, FMODIFW, FALTAFW, SALTAFW, SMODIFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, HMODIFW, UALTAFW, HALTAFW, HORAIMPO, BDMODIFW, HORAEXPO, BDALTAFW, ESTTRANS, TIMESTAMP, BLOQREG, NMCOBS, NMCCOD, NMCDES, NMCUM
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..NMCOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NMCCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NMCDES ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NMCUM ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.NMCARBA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMENCLADORARBA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NMCCOD C (6) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..NMCCOD     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'NOMENCLADORARBA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOMENCLADORARBA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOMENCLADORARBA_NMCOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_NMCARBA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'NOMENCLADORARBA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NMCCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad NOMENCLADORARBA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMENCLADORARBA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NMCCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NMCCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMENCLADORARBA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_NMCARBA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_NMCARBA
Create Table ZooLogic.TablaTrabajo_NMCARBA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"nmcobs" varchar(max)  null, 
"nmccod" char( 6 )  null, 
"nmcdes" char( 150 )  null, 
"nmcum" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_NMCARBA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_NMCARBA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMENCLADORARBA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('nmcobs','nmcobs')
			.AgregarMapeo('nmccod','nmccod')
			.AgregarMapeo('nmcdes','nmcdes')
			.AgregarMapeo('nmcum','nmcum')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_NMCARBA'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.NMCOBS = isnull( d.NMCOBS, t.NMCOBS ),t.NMCCOD = isnull( d.NMCCOD, t.NMCCOD ),t.NMCDES = isnull( d.NMCDES, t.NMCDES ),t.NMCUM = isnull( d.NMCUM, t.NMCUM )
					from ZooLogic.NMCARBA t inner join deleted d 
							 on t.NMCCOD = d.NMCCOD
				-- Fin Updates
				insert into ZooLogic.NMCARBA(Fecimpo,Fecexpo,Fectrans,Fmodifw,Faltafw,Saltafw,Smodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Hmodifw,Ualtafw,Haltafw,Horaimpo,Bdmodifw,Horaexpo,Bdaltafw,Esttrans,Timestamp,Bloqreg,Nmcobs,Nmccod,Nmcdes,Nmcum)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),isnull( d.NMCOBS,''),isnull( d.NMCCOD,''),isnull( d.NMCDES,''),isnull( d.NMCUM,'')
						From deleted d left join ZooLogic.NMCARBA pk 
							 on d.NMCCOD = pk.NMCCOD
						Where pk.NMCCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_NMCARBA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_NMCARBA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_NOMENCLADORARBA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMENCLADORARBA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMENCLADORARBA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMENCLADORARBA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMENCLADORARBA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMENCLADORARBA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_NOMENCLADORARBA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_NOMENCLADORARBA.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_NOMENCLADORARBA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_NOMENCLADORARBA.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_NOMENCLADORARBA.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_NOMENCLADORARBA.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_NOMENCLADORARBA.Usuarioaltafw, [] )
					.Horaaltafw = nvl( c_NOMENCLADORARBA.Horaaltafw, [] )
					.Horaimpo = nvl( c_NOMENCLADORARBA.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_NOMENCLADORARBA.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_NOMENCLADORARBA.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_NOMENCLADORARBA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_NOMENCLADORARBA.Estadotransferencia, [] )
					.Timestamp = nvl( c_NOMENCLADORARBA.Timestamp, 0 )
					.Bloquearregistro = nvl( c_NOMENCLADORARBA.Bloquearregistro, .F. )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Codigo = nvl( c_NOMENCLADORARBA.Codigo, [] )
					.Descripcion = nvl( c_NOMENCLADORARBA.Descripcion, [] )
					.Unidaddemedida_PK =  nvl( c_NOMENCLADORARBA.Unidaddemedida, [] )
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
		return c_NOMENCLADORARBA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.NMCARBA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NMCCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NMCCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NMCCOD from (
							select * 
								from ZooLogic.NMCARBA 
								Where   NMCARBA.NMCCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "NMCARBA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NMCCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Nmcobs" as "Observacion", "Nmccod" as "Codigo", "Nmcdes" as "Descripcion", "Nmcum" as "Unidaddemedida"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.NMCARBA 
								Where   NMCARBA.NMCCOD != ''
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
	Tabla = 'NMCARBA'
	Filtro = " NMCARBA.NMCCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " NMCARBA.NMCCOD != ''"
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
	<row entidad="NOMENCLADORARBA                         " atributo="FECHAIMPO                               " tabla="NMCARBA        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="FECHAEXPO                               " tabla="NMCARBA        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="FECHATRANSFERENCIA                      " tabla="NMCARBA        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="FECHAMODIFICACIONFW                     " tabla="NMCARBA        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="FECHAALTAFW                             " tabla="NMCARBA        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="SERIEALTAFW                             " tabla="NMCARBA        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="SERIEMODIFICACIONFW                     " tabla="NMCARBA        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="VERSIONMODIFICACIONFW                   " tabla="NMCARBA        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="ZADSFW                                  " tabla="NMCARBA        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="USUARIOMODIFICACIONFW                   " tabla="NMCARBA        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="VERSIONALTAFW                           " tabla="NMCARBA        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="HORAMODIFICACIONFW                      " tabla="NMCARBA        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="USUARIOALTAFW                           " tabla="NMCARBA        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="HORAALTAFW                              " tabla="NMCARBA        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="HORAIMPO                                " tabla="NMCARBA        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="NMCARBA        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="HORAEXPO                                " tabla="NMCARBA        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="BASEDEDATOSALTAFW                       " tabla="NMCARBA        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="ESTADOTRANSFERENCIA                     " tabla="NMCARBA        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="TIMESTAMP                               " tabla="NMCARBA        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="BLOQUEARREGISTRO                        " tabla="NMCARBA        " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="OBSERVACION                             " tabla="NMCARBA        " campo="NMCOBS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="CODIGO                                  " tabla="NMCARBA        " campo="NMCCOD    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="DESCRIPCION                             " tabla="NMCARBA        " campo="NMCDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="UNIDADDEMEDIDA                          " tabla="NMCARBA        " campo="NMCUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDAARBA                      " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Unidad de medida ARBA                                                                                                                                           " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDAARBA                      " atributo="DESCRIPCION                             " tabla="UMARBA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UMARBA On NMCARBA.NMCUM = UMARBA.Cod And  UMARBA.COD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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