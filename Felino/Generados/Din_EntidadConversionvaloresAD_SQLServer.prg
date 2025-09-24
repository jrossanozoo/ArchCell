
define class Din_EntidadCONVERSIONVALORESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CONVERSIONVALORES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Conversion + ValorOriginal + BaseDeDatos]
	cExpresionCCPorCampos = [#tabla#.Conversion + #tabla#.valOrig + #tabla#.basedatos]
	cTagClaveCandidata = '_VCECC'
	cTagClavePk = '_VCEPK'
	cTablaPrincipal = 'CONVERVAL'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'ORGANIZACION'
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ORGANIZACION'
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
			local  lxConvervalFecexpo, lxConvervalFmodifw, lxConvervalFecimpo, lxConvervalFaltafw, lxConvervalFectrans, lxConvervalTimestamp, lxConvervalBloqreg, lxConvervalUaltafw, lxConvervalSmodifw, lxConvervalUmodifw, lxConvervalValtafw, lxConvervalSaltafw, lxConvervalZadsfw, lxConvervalVmodifw, lxConvervalHoraexpo, lxConvervalHmodifw, lxConvervalBdmodifw, lxConvervalHoraimpo, lxConvervalHaltafw, lxConvervalEsttrans, lxConvervalBdaltafw, lxConvervalCobs, lxConvervalCodigo, lxConvervalConversion, lxConvervalValorig, lxConvervalValdest, lxConvervalBasedatos
				lxConvervalFecexpo =  .Fechaexpo			lxConvervalFmodifw =  .Fechamodificacionfw			lxConvervalFecimpo =  .Fechaimpo			lxConvervalFaltafw =  .Fechaaltafw			lxConvervalFectrans =  .Fechatransferencia			lxConvervalTimestamp = goLibrerias.ObtenerTimestamp()			lxConvervalBloqreg =  .Bloquearregistro			lxConvervalUaltafw =  .Usuarioaltafw			lxConvervalSmodifw =  .Seriemodificacionfw			lxConvervalUmodifw =  .Usuariomodificacionfw			lxConvervalValtafw =  .Versionaltafw			lxConvervalSaltafw =  .Seriealtafw			lxConvervalZadsfw =  .Zadsfw			lxConvervalVmodifw =  .Versionmodificacionfw			lxConvervalHoraexpo =  .Horaexpo			lxConvervalHmodifw =  .Horamodificacionfw			lxConvervalBdmodifw =  .Basededatosmodificacionfw			lxConvervalHoraimpo =  .Horaimpo			lxConvervalHaltafw =  .Horaaltafw			lxConvervalEsttrans =  .Estadotransferencia			lxConvervalBdaltafw =  .Basededatosaltafw			lxConvervalCobs =  .Obs			lxConvervalCodigo =  .Codigo			lxConvervalConversion =  upper( .Conversion_PK ) 			lxConvervalValorig =  .Valororiginal			lxConvervalValdest =  .Valorfinal			lxConvervalBasedatos =  .Basededatos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxConvervalCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.CONVERVAL ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Bloqreg","Ualtafw","Smodifw","Umodifw","Valtafw","Saltafw","Zadsfw","Vmodifw","Horaexpo","Hmodifw","Bdmodifw","Horaimpo","Haltafw","Esttrans","Bdaltafw","Cobs","Codigo","Conversion","Valorig","Valdest","Basedatos" ) values ( <<"'" + this.ConvertirDateSql( lxConvervalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFectrans ) + "'" >>, <<lxConvervalTimestamp >>, <<iif( lxConvervalBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxConvervalUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalConversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalValorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalValdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalBasedatos ) + "'" >> )
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
		this.oEntidad.Timestamp = lxConvervalTimestamp
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
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxConvervalFecexpo, lxConvervalFmodifw, lxConvervalFecimpo, lxConvervalFaltafw, lxConvervalFectrans, lxConvervalTimestamp, lxConvervalBloqreg, lxConvervalUaltafw, lxConvervalSmodifw, lxConvervalUmodifw, lxConvervalValtafw, lxConvervalSaltafw, lxConvervalZadsfw, lxConvervalVmodifw, lxConvervalHoraexpo, lxConvervalHmodifw, lxConvervalBdmodifw, lxConvervalHoraimpo, lxConvervalHaltafw, lxConvervalEsttrans, lxConvervalBdaltafw, lxConvervalCobs, lxConvervalCodigo, lxConvervalConversion, lxConvervalValorig, lxConvervalValdest, lxConvervalBasedatos
				lxConvervalFecexpo =  .Fechaexpo			lxConvervalFmodifw =  .Fechamodificacionfw			lxConvervalFecimpo =  .Fechaimpo			lxConvervalFaltafw =  .Fechaaltafw			lxConvervalFectrans =  .Fechatransferencia			lxConvervalTimestamp = goLibrerias.ObtenerTimestamp()			lxConvervalBloqreg =  .Bloquearregistro			lxConvervalUaltafw =  .Usuarioaltafw			lxConvervalSmodifw =  .Seriemodificacionfw			lxConvervalUmodifw =  .Usuariomodificacionfw			lxConvervalValtafw =  .Versionaltafw			lxConvervalSaltafw =  .Seriealtafw			lxConvervalZadsfw =  .Zadsfw			lxConvervalVmodifw =  .Versionmodificacionfw			lxConvervalHoraexpo =  .Horaexpo			lxConvervalHmodifw =  .Horamodificacionfw			lxConvervalBdmodifw =  .Basededatosmodificacionfw			lxConvervalHoraimpo =  .Horaimpo			lxConvervalHaltafw =  .Horaaltafw			lxConvervalEsttrans =  .Estadotransferencia			lxConvervalBdaltafw =  .Basededatosaltafw			lxConvervalCobs =  .Obs			lxConvervalCodigo =  .Codigo			lxConvervalConversion =  upper( .Conversion_PK ) 			lxConvervalValorig =  .Valororiginal			lxConvervalValdest =  .Valorfinal			lxConvervalBasedatos =  .Basededatos
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
				update ORGANIZACION.CONVERVAL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxConvervalFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxConvervalFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxConvervalFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxConvervalFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxConvervalFectrans ) + "'">>,"Timestamp" = <<lxConvervalTimestamp>>,"Bloqreg" = <<iif( lxConvervalBloqreg, 1, 0 )>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxConvervalUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxConvervalSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxConvervalUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxConvervalValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxConvervalSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxConvervalZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxConvervalVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxConvervalHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxConvervalHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxConvervalBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxConvervalHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxConvervalHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxConvervalEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxConvervalBdaltafw ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxConvervalCobs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxConvervalCodigo ) + "'">>,"Conversion" = <<"'" + this.FormatearTextoSql( lxConvervalConversion ) + "'">>,"Valorig" = <<"'" + this.FormatearTextoSql( lxConvervalValorig ) + "'">>,"Valdest" = <<"'" + this.FormatearTextoSql( lxConvervalValdest ) + "'">>,"Basedatos" = <<"'" + this.FormatearTextoSql( lxConvervalBasedatos ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxConvervalCodigo ) + "'">> and  CONVERVAL.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxConvervalTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ORGANIZACION.CONVERVAL where " + this.ConvertirFuncionesSql( " CONVERVAL.CODIGO != ''" ) )
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
			Local lxConvervalCodigo
			lxConvervalCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos" from ORGANIZACION.CONVERVAL where "Codigo" = <<"'" + this.FormatearTextoSql( lxConvervalCodigo ) + "'">> and  CONVERVAL.CODIGO != ''
			endtext
			use in select('c_CONVERSIONVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONVERSIONVALORES', set( 'Datasession' ) )

			if reccount( 'c_CONVERSIONVALORES' ) = 0
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
			Local lxconverValConversion As Variant, lxconverValvalOrig As Variant, lxconverValbasedatos As Variant
			lxconverValConversion = .Conversion_Pk
			lxconverValvalOrig = .ValorOriginal
			lxconverValbasedatos = .BaseDeDatos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos" from ORGANIZACION.CONVERVAL where  CONVERVAL.CODIGO != '' And Conversion = <<"'" + this.FormatearTextoSql( lxconverValConversion ) + "'">> and valOrig = <<"'" + this.FormatearTextoSql( lxconverValvalOrig ) + "'">> and basedatos = <<"'" + this.FormatearTextoSql( lxconverValbasedatos ) + "'">>
			endtext
			use in select('c_CONVERSIONVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONVERSIONVALORES', set( 'Datasession' ) )
			if reccount( 'c_CONVERSIONVALORES' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxConvervalCodigo as Variant
		llRetorno = .t.
		lxConvervalCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.CONVERVAL where "Codigo" = <<"'" + this.FormatearTextoSql( lxConvervalCodigo ) + "'">> and  CONVERVAL.CODIGO != ''
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
				lcOrden =  .Conversion_PK + .ValorOriginal + .BaseDeDatos + .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos" from ORGANIZACION.CONVERVAL where  CONVERVAL.CODIGO != '' order by Conversion,valOrig,basedatos,codigo
			endtext
			use in select('c_CONVERSIONVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONVERSIONVALORES', set( 'Datasession' ) )
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
				lcOrden =  .Conversion_PK + .ValorOriginal + .BaseDeDatos + .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos" from ORGANIZACION.CONVERVAL where  funciones.padr( Conversion, 40, ' ' ) + funciones.padr( valOrig, 100, ' ' ) + funciones.padr( basedatos, 23, ' ' ) + funciones.padr( codigo, 100, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CONVERVAL.CODIGO != '' order by Conversion,valOrig,basedatos,codigo
			endtext
			use in select('c_CONVERSIONVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONVERSIONVALORES', set( 'Datasession' ) )
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
				lcOrden =  .Conversion_PK + .ValorOriginal + .BaseDeDatos + .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos" from ORGANIZACION.CONVERVAL where  funciones.padr( Conversion, 40, ' ' ) + funciones.padr( valOrig, 100, ' ' ) + funciones.padr( basedatos, 23, ' ' ) + funciones.padr( codigo, 100, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CONVERVAL.CODIGO != '' order by Conversion desc,valOrig desc,basedatos desc,codigo desc
			endtext
			use in select('c_CONVERSIONVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONVERSIONVALORES', set( 'Datasession' ) )
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
				lcOrden =  .Conversion_PK + .ValorOriginal + .BaseDeDatos + .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos" from ORGANIZACION.CONVERVAL where  CONVERVAL.CODIGO != '' order by Conversion desc,valOrig desc,basedatos desc,codigo desc
			endtext
			use in select('c_CONVERSIONVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONVERSIONVALORES', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Bloqreg,Ualtafw,Smodifw,Umodifw,Valtafw,S" + ;
"altafw,Zadsfw,Vmodifw,Horaexpo,Hmodifw,Bdmodifw,Horaimpo,Haltafw,Esttrans,Bdaltafw,Cobs,Codigo,Conve" + ;
"rsion,Valorig,Valdest,Basedatos" + ;
" from ORGANIZACION.CONVERVAL where  CONVERVAL.CODIGO != '' and " + lcFiltro )
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
			local  lxConvervalFecexpo, lxConvervalFmodifw, lxConvervalFecimpo, lxConvervalFaltafw, lxConvervalFectrans, lxConvervalTimestamp, lxConvervalBloqreg, lxConvervalUaltafw, lxConvervalSmodifw, lxConvervalUmodifw, lxConvervalValtafw, lxConvervalSaltafw, lxConvervalZadsfw, lxConvervalVmodifw, lxConvervalHoraexpo, lxConvervalHmodifw, lxConvervalBdmodifw, lxConvervalHoraimpo, lxConvervalHaltafw, lxConvervalEsttrans, lxConvervalBdaltafw, lxConvervalCobs, lxConvervalCodigo, lxConvervalConversion, lxConvervalValorig, lxConvervalValdest, lxConvervalBasedatos
				lxConvervalFecexpo = ctod( '  /  /    ' )			lxConvervalFmodifw = ctod( '  /  /    ' )			lxConvervalFecimpo = ctod( '  /  /    ' )			lxConvervalFaltafw = ctod( '  /  /    ' )			lxConvervalFectrans = ctod( '  /  /    ' )			lxConvervalTimestamp = goLibrerias.ObtenerTimestamp()			lxConvervalBloqreg = .F.			lxConvervalUaltafw = []			lxConvervalSmodifw = []			lxConvervalUmodifw = []			lxConvervalValtafw = []			lxConvervalSaltafw = []			lxConvervalZadsfw = []			lxConvervalVmodifw = []			lxConvervalHoraexpo = []			lxConvervalHmodifw = []			lxConvervalBdmodifw = []			lxConvervalHoraimpo = []			lxConvervalHaltafw = []			lxConvervalEsttrans = []			lxConvervalBdaltafw = []			lxConvervalCobs = []			lxConvervalCodigo = []			lxConvervalConversion = []			lxConvervalValorig = []			lxConvervalValdest = []			lxConvervalBasedatos = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.CONVERVAL where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CONVERVAL' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CONVERVAL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CONVERVAL', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CONVERSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONVERSION AS CONVERSION'
				Case lcAtributo == 'VALORORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORIG AS VALORORIGINAL'
				Case lcAtributo == 'VALORFINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALDEST AS VALORFINAL'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS BASEDEDATOS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CONVERSION'
				lcCampo = 'CONVERSION'
			Case upper( alltrim( tcAtributo ) ) == 'VALORORIGINAL'
				lcCampo = 'VALORIG'
			Case upper( alltrim( tcAtributo ) ) == 'VALORFINAL'
				lcCampo = 'VALDEST'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASEDATOS'
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
			local  lxConvervalFecexpo, lxConvervalFmodifw, lxConvervalFecimpo, lxConvervalFaltafw, lxConvervalFectrans, lxConvervalTimestamp, lxConvervalBloqreg, lxConvervalUaltafw, lxConvervalSmodifw, lxConvervalUmodifw, lxConvervalValtafw, lxConvervalSaltafw, lxConvervalZadsfw, lxConvervalVmodifw, lxConvervalHoraexpo, lxConvervalHmodifw, lxConvervalBdmodifw, lxConvervalHoraimpo, lxConvervalHaltafw, lxConvervalEsttrans, lxConvervalBdaltafw, lxConvervalCobs, lxConvervalCodigo, lxConvervalConversion, lxConvervalValorig, lxConvervalValdest, lxConvervalBasedatos
				lxConvervalFecexpo =  .Fechaexpo			lxConvervalFmodifw =  .Fechamodificacionfw			lxConvervalFecimpo =  .Fechaimpo			lxConvervalFaltafw =  .Fechaaltafw			lxConvervalFectrans =  .Fechatransferencia			lxConvervalTimestamp = goLibrerias.ObtenerTimestamp()			lxConvervalBloqreg =  .Bloquearregistro			lxConvervalUaltafw =  .Usuarioaltafw			lxConvervalSmodifw =  .Seriemodificacionfw			lxConvervalUmodifw =  .Usuariomodificacionfw			lxConvervalValtafw =  .Versionaltafw			lxConvervalSaltafw =  .Seriealtafw			lxConvervalZadsfw =  .Zadsfw			lxConvervalVmodifw =  .Versionmodificacionfw			lxConvervalHoraexpo =  .Horaexpo			lxConvervalHmodifw =  .Horamodificacionfw			lxConvervalBdmodifw =  .Basededatosmodificacionfw			lxConvervalHoraimpo =  .Horaimpo			lxConvervalHaltafw =  .Horaaltafw			lxConvervalEsttrans =  .Estadotransferencia			lxConvervalBdaltafw =  .Basededatosaltafw			lxConvervalCobs =  .Obs			lxConvervalCodigo =  .Codigo			lxConvervalConversion =  upper( .Conversion_PK ) 			lxConvervalValorig =  .Valororiginal			lxConvervalValdest =  .Valorfinal			lxConvervalBasedatos =  .Basededatos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.CONVERVAL ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Bloqreg","Ualtafw","Smodifw","Umodifw","Valtafw","Saltafw","Zadsfw","Vmodifw","Horaexpo","Hmodifw","Bdmodifw","Horaimpo","Haltafw","Esttrans","Bdaltafw","Cobs","Codigo","Conversion","Valorig","Valdest","Basedatos" ) values ( <<"'" + this.ConvertirDateSql( lxConvervalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConvervalFectrans ) + "'" >>, <<lxConvervalTimestamp >>, <<iif( lxConvervalBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxConvervalUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalConversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalValorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalValdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConvervalBasedatos ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CONVERVAL' 
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
			local  lxConvervalFecexpo, lxConvervalFmodifw, lxConvervalFecimpo, lxConvervalFaltafw, lxConvervalFectrans, lxConvervalTimestamp, lxConvervalBloqreg, lxConvervalUaltafw, lxConvervalSmodifw, lxConvervalUmodifw, lxConvervalValtafw, lxConvervalSaltafw, lxConvervalZadsfw, lxConvervalVmodifw, lxConvervalHoraexpo, lxConvervalHmodifw, lxConvervalBdmodifw, lxConvervalHoraimpo, lxConvervalHaltafw, lxConvervalEsttrans, lxConvervalBdaltafw, lxConvervalCobs, lxConvervalCodigo, lxConvervalConversion, lxConvervalValorig, lxConvervalValdest, lxConvervalBasedatos
				lxConvervalFecexpo =  .Fechaexpo			lxConvervalFmodifw =  .Fechamodificacionfw			lxConvervalFecimpo =  .Fechaimpo			lxConvervalFaltafw =  .Fechaaltafw			lxConvervalFectrans =  .Fechatransferencia			lxConvervalTimestamp = goLibrerias.ObtenerTimestamp()			lxConvervalBloqreg =  .Bloquearregistro			lxConvervalUaltafw =  .Usuarioaltafw			lxConvervalSmodifw =  .Seriemodificacionfw			lxConvervalUmodifw =  .Usuariomodificacionfw			lxConvervalValtafw =  .Versionaltafw			lxConvervalSaltafw =  .Seriealtafw			lxConvervalZadsfw =  .Zadsfw			lxConvervalVmodifw =  .Versionmodificacionfw			lxConvervalHoraexpo =  .Horaexpo			lxConvervalHmodifw =  .Horamodificacionfw			lxConvervalBdmodifw =  .Basededatosmodificacionfw			lxConvervalHoraimpo =  .Horaimpo			lxConvervalHaltafw =  .Horaaltafw			lxConvervalEsttrans =  .Estadotransferencia			lxConvervalBdaltafw =  .Basededatosaltafw			lxConvervalCobs =  .Obs			lxConvervalCodigo =  .Codigo			lxConvervalConversion =  upper( .Conversion_PK ) 			lxConvervalValorig =  .Valororiginal			lxConvervalValdest =  .Valorfinal			lxConvervalBasedatos =  .Basededatos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CONVERVAL.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.CONVERVAL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxConvervalFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxConvervalFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxConvervalFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxConvervalFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxConvervalFectrans ) + "'">>, "Timestamp" = <<lxConvervalTimestamp>>, "Bloqreg" = <<iif( lxConvervalBloqreg, 1, 0 )>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxConvervalUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxConvervalSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxConvervalUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxConvervalValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxConvervalSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxConvervalZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxConvervalVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxConvervalHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxConvervalHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxConvervalBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxConvervalHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxConvervalHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxConvervalEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxConvervalBdaltafw ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxConvervalCobs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxConvervalCodigo ) + "'">>, "Conversion" = <<"'" + this.FormatearTextoSql( lxConvervalConversion ) + "'">>, "Valorig" = <<"'" + this.FormatearTextoSql( lxConvervalValorig ) + "'">>, "Valdest" = <<"'" + this.FormatearTextoSql( lxConvervalValdest ) + "'">>, "Basedatos" = <<"'" + this.FormatearTextoSql( lxConvervalBasedatos ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CONVERVAL' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CONVERVAL.CODIGO != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.CONVERVAL where ' + lcFiltro )
			loColeccion.cTabla = 'CONVERVAL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.CONVERVAL where  CONVERVAL.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.CONVERVAL where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CONVERVAL.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxconverValConversion as variant, lxconverValvalOrig as variant, lxconverValbasedatos as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONVERSIONVALORES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.CONVERVAL Where  Conversion = ] + "'" + this.FormatearTextoSql( &lcCursor..Conversion ) + "'" + [ and valOrig = ] + "'" + this.FormatearTextoSql( &lcCursor..valOrig    ) + "'" + [ and basedatos = ] + "'" + this.FormatearTextoSql( &lcCursor..basedatos  ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..codigo
				if lxValorClavePK == curSeek.codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.CONVERVAL set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, Conversion = ] + "'" + this.FormatearTextoSql( &lcCursor..Conversion ) + "'"+ [, valOrig = ] + "'" + this.FormatearTextoSql( &lcCursor..valOrig ) + "'"+ [, valDest = ] + "'" + this.FormatearTextoSql( &lcCursor..valDest ) + "'"+ [, basedatos = ] + "'" + this.FormatearTextoSql( &lcCursor..basedatos ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.CONVERVAL Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FMODIFW, FECIMPO, FALTAFW, FECTRANS, TIMESTAMP, BLOQREG, UALTAFW, SMODIFW, UMODIFW, VALTAFW, SALTAFW, ZADSFW, VMODIFW, HORAEXPO, HMODIFW, BDMODIFW, HORAIMPO, HALTAFW, ESTTRANS, BDALTAFW, cObs, codigo, Conversion, valOrig, valDest, basedatos
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Conversion ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..valOrig ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..valDest ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..basedatos ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.CONVERVAL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONVERSIONVALORES'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (100) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Conversión: ' + transform( &tcCursor..Conversion )
		lcRetorno = lcRetorno + ' - Valor Original: ' + transform( &tcCursor..valOrig    )
		lcRetorno = lcRetorno + ' - Base de datos: ' + transform( &tcCursor..basedatos  )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CONVERSIONVALORES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONVERSIONVALORES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONVERSIONVALORES_COBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_converVal')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CONVERSIONVALORES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Conversion ) or isnull( &lcCursor..valOrig ) or isnull( &lcCursor..basedatos )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CONVERSIONVALORES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONVERSIONVALORES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,Conversion + valOrig + basedatos as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Conversion + valOrig + basedatos, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONVERSIONVALORES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_converVal') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_converVal
Create Table ORGANIZACION.TablaTrabajo_converVal ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"cobs" varchar(max)  null, 
"codigo" char( 100 )  null, 
"conversion" char( 40 )  null, 
"valorig" char( 100 )  null, 
"valdest" char( 100 )  null, 
"basedatos" char( 23 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_converVal' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_converVal' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONVERSIONVALORES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('conversion','conversion')
			.AgregarMapeo('valorig','valorig')
			.AgregarMapeo('valdest','valdest')
			.AgregarMapeo('basedatos','basedatos')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_converVal'
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
			CREATE TRIGGER ORGANIZACION.DELETE_<<lcTabla>>
				ON ORGANIZACION.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.COBS = isnull( d.COBS, t.COBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CONVERSION = isnull( d.CONVERSION, t.CONVERSION ),t.VALORIG = isnull( d.VALORIG, t.VALORIG ),t.VALDEST = isnull( d.VALDEST, t.VALDEST ),t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS )
					from ORGANIZACION.CONVERVAL t inner join deleted d 
							 on t.codigo = d.codigo
							 and  t.Conversion = d.Conversion
							 and  t.valOrig = d.valOrig
							 and  t.basedatos = d.basedatos
				-- Fin Updates
				insert into ORGANIZACION.CONVERVAL(Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Bloqreg,Ualtafw,Smodifw,Umodifw,Valtafw,Saltafw,Zadsfw,Vmodifw,Horaexpo,Hmodifw,Bdmodifw,Horaimpo,Haltafw,Esttrans,Bdaltafw,Cobs,Codigo,Conversion,Valorig,Valdest,Basedatos)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.COBS,''),isnull( d.CODIGO,''),isnull( d.CONVERSION,''),isnull( d.VALORIG,''),isnull( d.VALDEST,''),isnull( d.BASEDATOS,'')
						From deleted d left join ORGANIZACION.CONVERVAL pk 
							 on d.codigo = pk.codigo
						 left join ORGANIZACION.CONVERVAL cc 
							 on  d.Conversion = cc.Conversion
							 and  d.valOrig = cc.valOrig
							 and  d.basedatos = cc.basedatos
						Where pk.codigo Is Null 
							 and cc.Conversion Is Null 
							 and cc.valOrig Is Null 
							 and cc.basedatos Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CONVERSIÓN ' + cast( d.Conversion as Varchar(40) ) + ', VALOR ORIGINAL ' + cast( d.valOrig as Varchar(100) ) + ', BASE DE DATOS ' + cast( d.basedatos as Varchar(23) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.CONVERVAL t inner join deleted d 
							on   t.Conversion = d.Conversion
							 and  t.valOrig = d.valOrig
							 and  t.basedatos = d.basedatos
						left join deleted h 
							 on t.codigo = h.codigo
							 where h.codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CONVERSIÓN ' + cast( d.Conversion as Varchar(40) ) + ', VALOR ORIGINAL ' + cast( d.valOrig as Varchar(100) ) + ', BASE DE DATOS ' + cast( d.basedatos as Varchar(23) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.CONVERVAL t inner join deleted d 
							 on t.codigo = d.codigo
						left join deleted h 
							on   t.Conversion = h.Conversion
							 and   t.valOrig = h.valOrig
							 and   t.basedatos = h.basedatos
							where   h.Conversion is null 
							 and   h.valOrig is null 
							 and   h.basedatos is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_converVal') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_converVal
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CONVERSIONVALORES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONVERSIONVALORES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONVERSIONVALORES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONVERSIONVALORES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONVERSIONVALORES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONVERSIONVALORES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_CONVERSIONVALORES.Timestamp, 0 )
					.Bloquearregistro = nvl( c_CONVERSIONVALORES.Bloquearregistro, .F. )
					.Usuarioaltafw = nvl( c_CONVERSIONVALORES.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_CONVERSIONVALORES.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CONVERSIONVALORES.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_CONVERSIONVALORES.Versionaltafw, [] )
					.Seriealtafw = nvl( c_CONVERSIONVALORES.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_CONVERSIONVALORES.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_CONVERSIONVALORES.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_CONVERSIONVALORES.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_CONVERSIONVALORES.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_CONVERSIONVALORES.Horaimpo, [] )
					.Horaaltafw = nvl( c_CONVERSIONVALORES.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_CONVERSIONVALORES.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CONVERSIONVALORES.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Codigo = nvl( c_CONVERSIONVALORES.Codigo, [] )
					.Conversion_PK =  nvl( c_CONVERSIONVALORES.Conversion, [] )
					.Valororiginal = nvl( c_CONVERSIONVALORES.Valororiginal, [] )
					.Valorfinal = nvl( c_CONVERSIONVALORES.Valorfinal, [] )
					.Basededatos = nvl( c_CONVERSIONVALORES.Basededatos, [] )
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
			lxRetorno = c_CONVERSIONVALORES.CODIGO
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
		return c_CONVERSIONVALORES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		local lcNombreBD as String 
		lcNombreBD = ''
		lcNombreBD = this.oConexion.ObtenerNombreBD( 'ZOOLOGICMASTER' )
		lcNombreBD = goLibrerias.EscapeCaracteresSqlServer( lcNombreBD )

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.CONVERVAL' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    codigo from (
							select * 
								from ORGANIZACION.CONVERVAL 
								Where   CONVERVAL.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CONVERVAL", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cobs" as "Obs", "Codigo" as "Codigo", "Conversion" as "Conversion", "Valorig" as "Valororiginal", "Valdest" as "Valorfinal", "Basedatos" as "Basededatos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.CONVERVAL 
								Where   CONVERVAL.CODIGO != ''
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
	Tabla = 'CONVERVAL'
	Filtro = " CONVERVAL.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CONVERVAL.CODIGO != ''"
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
	<row entidad="CONVERSIONVALORES                       " atributo="FECHAEXPO                               " tabla="CONVERVAL      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="FECHAMODIFICACIONFW                     " tabla="CONVERVAL      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="FECHAIMPO                               " tabla="CONVERVAL      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="FECHAALTAFW                             " tabla="CONVERVAL      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="FECHATRANSFERENCIA                      " tabla="CONVERVAL      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="TIMESTAMP                               " tabla="CONVERVAL      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="BLOQUEARREGISTRO                        " tabla="CONVERVAL      " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="USUARIOALTAFW                           " tabla="CONVERVAL      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="SERIEMODIFICACIONFW                     " tabla="CONVERVAL      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="USUARIOMODIFICACIONFW                   " tabla="CONVERVAL      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="VERSIONALTAFW                           " tabla="CONVERVAL      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="SERIEALTAFW                             " tabla="CONVERVAL      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="ZADSFW                                  " tabla="CONVERVAL      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="VERSIONMODIFICACIONFW                   " tabla="CONVERVAL      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="HORAEXPO                                " tabla="CONVERVAL      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="HORAMODIFICACIONFW                      " tabla="CONVERVAL      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CONVERVAL      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="HORAIMPO                                " tabla="CONVERVAL      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="HORAALTAFW                              " tabla="CONVERVAL      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="ESTADOTRANSFERENCIA                     " tabla="CONVERVAL      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="BASEDEDATOSALTAFW                       " tabla="CONVERVAL      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="OBS                                     " tabla="CONVERVAL      " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="CODIGO                                  " tabla="CONVERVAL      " campo="CODIGO    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Codigo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="CONVERSION                              " tabla="CONVERVAL      " campo="CONVERSION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="conversion                              " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Conversión                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="VALORORIGINAL                           " tabla="CONVERVAL      " campo="VALORIG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Valor Original                                                                                                                                                  " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="VALORFINAL                              " tabla="CONVERVAL      " campo="VALDEST   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Valor Final                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSIONVALORES                       " atributo="BASEDEDATOS                             " tabla="CONVERVAL      " campo="BASEDATOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="23" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Base de datos                                                                                                                                                   " dominio="COMBOSUCYAGRUCONVACIO         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONVERSION                              " atributo="DESCRIPCION                             " tabla="CONVER         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONVER On CONVERVAL.CONVERSION = CONVER.codigo And  CONVER.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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