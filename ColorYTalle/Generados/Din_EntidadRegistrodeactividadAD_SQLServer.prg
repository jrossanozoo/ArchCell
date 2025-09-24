
define class Din_EntidadREGISTRODEACTIVIDADAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REGISTRODEACTIVIDAD'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_ACTPK'
	cTablaPrincipal = 'REGACTIV'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'SUCURSAL'
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
			local  lxRegactivFecimpo, lxRegactivFectrans, lxRegactivFmodifw, lxRegactivFaltafw, lxRegactivFecexpo, lxRegactivSaltafw, lxRegactivHmodifw, lxRegactivSmodifw, lxRegactivUaltafw, lxRegactivVmodifw, lxRegactivZadsfw, lxRegactivValtafw, lxRegactivHoraimpo, lxRegactivUmodifw, lxRegactivHoraexpo, lxRegactivBdaltafw, lxRegactivBdmodifw, lxRegactivEsttrans, lxRegactivHaltafw, lxRegactivCcodigo, lxRegactivCactividad, lxRegactivCfechaini, lxRegactivChoraini, lxRegactivCfechafin, lxRegactivChorafin, lxRegactivBdaltafw, lxRegactivNneto, lxRegactivObs, lxRegactivInvocador
				lxRegactivFecimpo =  .Fechaimpo			lxRegactivFectrans =  .Fechatransferencia			lxRegactivFmodifw =  .Fechamodificacionfw			lxRegactivFaltafw =  .Fechaaltafw			lxRegactivFecexpo =  .Fechaexpo			lxRegactivSaltafw =  .Seriealtafw			lxRegactivHmodifw =  .Horamodificacionfw			lxRegactivSmodifw =  .Seriemodificacionfw			lxRegactivUaltafw =  .Usuarioaltafw			lxRegactivVmodifw =  .Versionmodificacionfw			lxRegactivZadsfw =  .Zadsfw			lxRegactivValtafw =  .Versionaltafw			lxRegactivHoraimpo =  .Horaimpo			lxRegactivUmodifw =  .Usuariomodificacionfw			lxRegactivHoraexpo =  .Horaexpo			lxRegactivBdaltafw =  .Basededatosaltafw			lxRegactivBdmodifw =  .Basededatosmodificacionfw			lxRegactivEsttrans =  .Estadotransferencia			lxRegactivHaltafw =  .Horaaltafw			lxRegactivCcodigo =  .Codigo			lxRegactivCactividad =  .Actividad			lxRegactivCfechaini =  .Fechainicio			lxRegactivChoraini =  .Horainicio			lxRegactivCfechafin =  .Fechafin			lxRegactivChorafin =  .Horafin			lxRegactivBdaltafw =  .Basededatos			lxRegactivNneto =  .Tiemponetosininteracciondelusuario			lxRegactivObs =  .Observacion			lxRegactivInvocador =  .Invocador
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRegactivCcodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REGACTIV ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Saltafw","Hmodifw","Smodifw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Horaimpo","Umodifw","Horaexpo","Bdaltafw","Bdmodifw","Esttrans","Haltafw","Ccodigo","Cactividad","Cfechaini","Choraini","Cfechafin","Chorafin","Nneto","Obs","Invocador" ) values ( <<"'" + this.ConvertirDateSql( lxRegactivFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivCcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivCactividad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivCfechaini ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivChoraini ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivCfechafin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivChorafin ) + "'" >>, <<lxRegactivNneto >>, <<"'" + this.FormatearTextoSql( lxRegactivObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivInvocador ) + "'" >> )
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
			local  lxRegactivFecimpo, lxRegactivFectrans, lxRegactivFmodifw, lxRegactivFaltafw, lxRegactivFecexpo, lxRegactivSaltafw, lxRegactivHmodifw, lxRegactivSmodifw, lxRegactivUaltafw, lxRegactivVmodifw, lxRegactivZadsfw, lxRegactivValtafw, lxRegactivHoraimpo, lxRegactivUmodifw, lxRegactivHoraexpo, lxRegactivBdaltafw, lxRegactivBdmodifw, lxRegactivEsttrans, lxRegactivHaltafw, lxRegactivCcodigo, lxRegactivCactividad, lxRegactivCfechaini, lxRegactivChoraini, lxRegactivCfechafin, lxRegactivChorafin, lxRegactivBdaltafw, lxRegactivNneto, lxRegactivObs, lxRegactivInvocador
				lxRegactivFecimpo =  .Fechaimpo			lxRegactivFectrans =  .Fechatransferencia			lxRegactivFmodifw =  .Fechamodificacionfw			lxRegactivFaltafw =  .Fechaaltafw			lxRegactivFecexpo =  .Fechaexpo			lxRegactivSaltafw =  .Seriealtafw			lxRegactivHmodifw =  .Horamodificacionfw			lxRegactivSmodifw =  .Seriemodificacionfw			lxRegactivUaltafw =  .Usuarioaltafw			lxRegactivVmodifw =  .Versionmodificacionfw			lxRegactivZadsfw =  .Zadsfw			lxRegactivValtafw =  .Versionaltafw			lxRegactivHoraimpo =  .Horaimpo			lxRegactivUmodifw =  .Usuariomodificacionfw			lxRegactivHoraexpo =  .Horaexpo			lxRegactivBdaltafw =  .Basededatosaltafw			lxRegactivBdmodifw =  .Basededatosmodificacionfw			lxRegactivEsttrans =  .Estadotransferencia			lxRegactivHaltafw =  .Horaaltafw			lxRegactivCcodigo =  .Codigo			lxRegactivCactividad =  .Actividad			lxRegactivCfechaini =  .Fechainicio			lxRegactivChoraini =  .Horainicio			lxRegactivCfechafin =  .Fechafin			lxRegactivChorafin =  .Horafin			lxRegactivBdaltafw =  .Basededatos			lxRegactivNneto =  .Tiemponetosininteracciondelusuario			lxRegactivObs =  .Observacion			lxRegactivInvocador =  .Invocador
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.REGACTIV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegactivFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxRegactivFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegactivFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRegactivFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegactivFecexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRegactivSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegactivHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRegactivSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegactivUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegactivVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegactivZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRegactivValtafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegactivHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRegactivUmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegactivHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegactivBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegactivBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRegactivEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRegactivHaltafw ) + "'">>,"Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactivCcodigo ) + "'">>,"Cactividad" = <<"'" + this.FormatearTextoSql( lxRegactivCactividad ) + "'">>,"Cfechaini" = <<"'" + this.ConvertirDateSql( lxRegactivCfechaini ) + "'">>,"Choraini" = <<"'" + this.FormatearTextoSql( lxRegactivChoraini ) + "'">>,"Cfechafin" = <<"'" + this.ConvertirDateSql( lxRegactivCfechafin ) + "'">>,"Chorafin" = <<"'" + this.FormatearTextoSql( lxRegactivChorafin ) + "'">>,"Nneto" = <<lxRegactivNneto>>,"Obs" = <<"'" + this.FormatearTextoSql( lxRegactivObs ) + "'">>,"Invocador" = <<"'" + this.FormatearTextoSql( lxRegactivInvocador ) + "'">> where "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactivCcodigo ) + "'">> and  REGACTIV.CCODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCodigo from ZooLogic.REGACTIV where " + this.ConvertirFuncionesSql( " REGACTIV.CCODIGO != ''" ) )
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
			Local lxRegactivCcodigo
			lxRegactivCcodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Ccodigo" as "Codigo", "Cactividad" as "Actividad", "Cfechaini" as "Fechainicio", "Choraini" as "Horainicio", "Cfechafin" as "Fechafin", "Chorafin" as "Horafin", "Bdaltafw" as "Basededatos", "Nneto" as "Tiemponetosininteracciondelusuario", "Obs" as "Observacion", "Invocador" as "Invocador" from ZooLogic.REGACTIV where "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactivCcodigo ) + "'">> and  REGACTIV.CCODIGO != ''
			endtext
			use in select('c_REGISTRODEACTIVIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEACTIVIDAD', set( 'Datasession' ) )

			if reccount( 'c_REGISTRODEACTIVIDAD' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRegactivCcodigo as Variant
		llRetorno = .t.
		lxRegactivCcodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REGACTIV where "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactivCcodigo ) + "'">> and  REGACTIV.CCODIGO != ''
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Ccodigo" as "Codigo", "Cactividad" as "Actividad", "Cfechaini" as "Fechainicio", "Choraini" as "Horainicio", "Cfechafin" as "Fechafin", "Chorafin" as "Horafin", "Bdaltafw" as "Basededatos", "Nneto" as "Tiemponetosininteracciondelusuario", "Obs" as "Observacion", "Invocador" as "Invocador" from ZooLogic.REGACTIV where  REGACTIV.CCODIGO != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_REGISTRODEACTIVIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEACTIVIDAD', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Ccodigo" as "Codigo", "Cactividad" as "Actividad", "Cfechaini" as "Fechainicio", "Choraini" as "Horainicio", "Cfechafin" as "Fechafin", "Chorafin" as "Horafin", "Bdaltafw" as "Basededatos", "Nneto" as "Tiemponetosininteracciondelusuario", "Obs" as "Observacion", "Invocador" as "Invocador" from ZooLogic.REGACTIV where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGACTIV.CCODIGO != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_REGISTRODEACTIVIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEACTIVIDAD', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Ccodigo" as "Codigo", "Cactividad" as "Actividad", "Cfechaini" as "Fechainicio", "Choraini" as "Horainicio", "Cfechafin" as "Fechafin", "Chorafin" as "Horafin", "Bdaltafw" as "Basededatos", "Nneto" as "Tiemponetosininteracciondelusuario", "Obs" as "Observacion", "Invocador" as "Invocador" from ZooLogic.REGACTIV where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGACTIV.CCODIGO != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_REGISTRODEACTIVIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEACTIVIDAD', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Ccodigo" as "Codigo", "Cactividad" as "Actividad", "Cfechaini" as "Fechainicio", "Choraini" as "Horainicio", "Cfechafin" as "Fechafin", "Chorafin" as "Horafin", "Bdaltafw" as "Basededatos", "Nneto" as "Tiemponetosininteracciondelusuario", "Obs" as "Observacion", "Invocador" as "Invocador" from ZooLogic.REGACTIV where  REGACTIV.CCODIGO != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_REGISTRODEACTIVIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEACTIVIDAD', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Saltafw,Hmodifw,Smodifw,Ualtafw,Vmodifw,Zadsfw,Valt" + ;
"afw,Horaimpo,Umodifw,Horaexpo,Bdaltafw,Bdmodifw,Esttrans,Haltafw,Ccodigo,Cactividad,Cfechaini,Chorai" + ;
"ni,Cfechafin,Chorafin,Nneto,Obs,Invocador" + ;
" from ZooLogic.REGACTIV where  REGACTIV.CCODIGO != '' and " + lcFiltro )
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
			local  lxRegactivFecimpo, lxRegactivFectrans, lxRegactivFmodifw, lxRegactivFaltafw, lxRegactivFecexpo, lxRegactivSaltafw, lxRegactivHmodifw, lxRegactivSmodifw, lxRegactivUaltafw, lxRegactivVmodifw, lxRegactivZadsfw, lxRegactivValtafw, lxRegactivHoraimpo, lxRegactivUmodifw, lxRegactivHoraexpo, lxRegactivBdaltafw, lxRegactivBdmodifw, lxRegactivEsttrans, lxRegactivHaltafw, lxRegactivCcodigo, lxRegactivCactividad, lxRegactivCfechaini, lxRegactivChoraini, lxRegactivCfechafin, lxRegactivChorafin, lxRegactivBdaltafw, lxRegactivNneto, lxRegactivObs, lxRegactivInvocador
				lxRegactivFecimpo = ctod( '  /  /    ' )			lxRegactivFectrans = ctod( '  /  /    ' )			lxRegactivFmodifw = ctod( '  /  /    ' )			lxRegactivFaltafw = ctod( '  /  /    ' )			lxRegactivFecexpo = ctod( '  /  /    ' )			lxRegactivSaltafw = []			lxRegactivHmodifw = []			lxRegactivSmodifw = []			lxRegactivUaltafw = []			lxRegactivVmodifw = []			lxRegactivZadsfw = []			lxRegactivValtafw = []			lxRegactivHoraimpo = []			lxRegactivUmodifw = []			lxRegactivHoraexpo = []			lxRegactivBdaltafw = []			lxRegactivBdmodifw = []			lxRegactivEsttrans = []			lxRegactivHaltafw = []			lxRegactivCcodigo = []			lxRegactivCactividad = []			lxRegactivCfechaini = ctod( '  /  /    ' )			lxRegactivChoraini = []			lxRegactivCfechafin = ctod( '  /  /    ' )			lxRegactivChorafin = []			lxRegactivBdaltafw = []			lxRegactivNneto = 0			lxRegactivObs = []			lxRegactivInvocador = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REGACTIV where "cCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REGACTIV' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where cCodigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(cCodigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REGACTIV.CCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Ccodigo" as "Codigo", "Cactividad" as "Actividad", "Cfechaini" as "Fechainicio", "Choraini" as "Horainicio", "Cfechafin" as "Fechafin", "Chorafin" as "Horafin", "Bdaltafw" as "Basededatos", "Nneto" as "Tiemponetosininteracciondelusuario", "Obs" as "Observacion", "Invocador" as "Invocador"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REGACTIV', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODIGO AS CODIGO'
				Case lcAtributo == 'ACTIVIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CACTIVIDAD AS ACTIVIDAD'
				Case lcAtributo == 'FECHAINICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAINI AS FECHAINICIO'
				Case lcAtributo == 'HORAINICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHORAINI AS HORAINICIO'
				Case lcAtributo == 'FECHAFIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAFIN AS FECHAFIN'
				Case lcAtributo == 'HORAFIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHORAFIN AS HORAFIN'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOS'
				Case lcAtributo == 'TIEMPONETOSININTERACCIONDELUSUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NNETO AS TIEMPONETOSININTERACCIONDELUSUARIO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'INVOCADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVOCADOR AS INVOCADOR'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVIDAD'
				lcCampo = 'CACTIVIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAINICIO'
				lcCampo = 'CFECHAINI'
			Case upper( alltrim( tcAtributo ) ) == 'HORAINICIO'
				lcCampo = 'CHORAINI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFIN'
				lcCampo = 'CFECHAFIN'
			Case upper( alltrim( tcAtributo ) ) == 'HORAFIN'
				lcCampo = 'CHORAFIN'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPONETOSININTERACCIONDELUSUARIO'
				lcCampo = 'NNETO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'INVOCADOR'
				lcCampo = 'INVOCADOR'
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
			local  lxRegactivFecimpo, lxRegactivFectrans, lxRegactivFmodifw, lxRegactivFaltafw, lxRegactivFecexpo, lxRegactivSaltafw, lxRegactivHmodifw, lxRegactivSmodifw, lxRegactivUaltafw, lxRegactivVmodifw, lxRegactivZadsfw, lxRegactivValtafw, lxRegactivHoraimpo, lxRegactivUmodifw, lxRegactivHoraexpo, lxRegactivBdaltafw, lxRegactivBdmodifw, lxRegactivEsttrans, lxRegactivHaltafw, lxRegactivCcodigo, lxRegactivCactividad, lxRegactivCfechaini, lxRegactivChoraini, lxRegactivCfechafin, lxRegactivChorafin, lxRegactivBdaltafw, lxRegactivNneto, lxRegactivObs, lxRegactivInvocador
				lxRegactivFecimpo =  .Fechaimpo			lxRegactivFectrans =  .Fechatransferencia			lxRegactivFmodifw =  .Fechamodificacionfw			lxRegactivFaltafw =  .Fechaaltafw			lxRegactivFecexpo =  .Fechaexpo			lxRegactivSaltafw =  .Seriealtafw			lxRegactivHmodifw =  .Horamodificacionfw			lxRegactivSmodifw =  .Seriemodificacionfw			lxRegactivUaltafw =  .Usuarioaltafw			lxRegactivVmodifw =  .Versionmodificacionfw			lxRegactivZadsfw =  .Zadsfw			lxRegactivValtafw =  .Versionaltafw			lxRegactivHoraimpo =  .Horaimpo			lxRegactivUmodifw =  .Usuariomodificacionfw			lxRegactivHoraexpo =  .Horaexpo			lxRegactivBdaltafw =  .Basededatosaltafw			lxRegactivBdmodifw =  .Basededatosmodificacionfw			lxRegactivEsttrans =  .Estadotransferencia			lxRegactivHaltafw =  .Horaaltafw			lxRegactivCcodigo =  .Codigo			lxRegactivCactividad =  .Actividad			lxRegactivCfechaini =  .Fechainicio			lxRegactivChoraini =  .Horainicio			lxRegactivCfechafin =  .Fechafin			lxRegactivChorafin =  .Horafin			lxRegactivBdaltafw =  .Basededatos			lxRegactivNneto =  .Tiemponetosininteracciondelusuario			lxRegactivObs =  .Observacion			lxRegactivInvocador =  .Invocador
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REGACTIV ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Saltafw","Hmodifw","Smodifw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Horaimpo","Umodifw","Horaexpo","Bdaltafw","Bdmodifw","Esttrans","Haltafw","Ccodigo","Cactividad","Cfechaini","Choraini","Cfechafin","Chorafin","Nneto","Obs","Invocador" ) values ( <<"'" + this.ConvertirDateSql( lxRegactivFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivCcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivCactividad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivCfechaini ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivChoraini ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactivCfechafin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivChorafin ) + "'" >>, <<lxRegactivNneto >>, <<"'" + this.FormatearTextoSql( lxRegactivObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactivInvocador ) + "'" >> )
		endtext
		loColeccion.cTabla = 'REGACTIV' 
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
			local  lxRegactivFecimpo, lxRegactivFectrans, lxRegactivFmodifw, lxRegactivFaltafw, lxRegactivFecexpo, lxRegactivSaltafw, lxRegactivHmodifw, lxRegactivSmodifw, lxRegactivUaltafw, lxRegactivVmodifw, lxRegactivZadsfw, lxRegactivValtafw, lxRegactivHoraimpo, lxRegactivUmodifw, lxRegactivHoraexpo, lxRegactivBdaltafw, lxRegactivBdmodifw, lxRegactivEsttrans, lxRegactivHaltafw, lxRegactivCcodigo, lxRegactivCactividad, lxRegactivCfechaini, lxRegactivChoraini, lxRegactivCfechafin, lxRegactivChorafin, lxRegactivBdaltafw, lxRegactivNneto, lxRegactivObs, lxRegactivInvocador
				lxRegactivFecimpo =  .Fechaimpo			lxRegactivFectrans =  .Fechatransferencia			lxRegactivFmodifw =  .Fechamodificacionfw			lxRegactivFaltafw =  .Fechaaltafw			lxRegactivFecexpo =  .Fechaexpo			lxRegactivSaltafw =  .Seriealtafw			lxRegactivHmodifw =  .Horamodificacionfw			lxRegactivSmodifw =  .Seriemodificacionfw			lxRegactivUaltafw =  .Usuarioaltafw			lxRegactivVmodifw =  .Versionmodificacionfw			lxRegactivZadsfw =  .Zadsfw			lxRegactivValtafw =  .Versionaltafw			lxRegactivHoraimpo =  .Horaimpo			lxRegactivUmodifw =  .Usuariomodificacionfw			lxRegactivHoraexpo =  .Horaexpo			lxRegactivBdaltafw =  .Basededatosaltafw			lxRegactivBdmodifw =  .Basededatosmodificacionfw			lxRegactivEsttrans =  .Estadotransferencia			lxRegactivHaltafw =  .Horaaltafw			lxRegactivCcodigo =  .Codigo			lxRegactivCactividad =  .Actividad			lxRegactivCfechaini =  .Fechainicio			lxRegactivChoraini =  .Horainicio			lxRegactivCfechafin =  .Fechafin			lxRegactivChorafin =  .Horafin			lxRegactivBdaltafw =  .Basededatos			lxRegactivNneto =  .Tiemponetosininteracciondelusuario			lxRegactivObs =  .Observacion			lxRegactivInvocador =  .Invocador
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccodigo" = ] + lcValorClavePrimariaString  + [ and  REGACTIV.CCODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.REGACTIV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegactivFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxRegactivFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegactivFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRegactivFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegactivFecexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRegactivSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegactivHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRegactivSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegactivUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegactivVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegactivZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRegactivValtafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegactivHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRegactivUmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegactivHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegactivBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegactivBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRegactivEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRegactivHaltafw ) + "'">>, "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactivCcodigo ) + "'">>, "Cactividad" = <<"'" + this.FormatearTextoSql( lxRegactivCactividad ) + "'">>, "Cfechaini" = <<"'" + this.ConvertirDateSql( lxRegactivCfechaini ) + "'">>, "Choraini" = <<"'" + this.FormatearTextoSql( lxRegactivChoraini ) + "'">>, "Cfechafin" = <<"'" + this.ConvertirDateSql( lxRegactivCfechafin ) + "'">>, "Chorafin" = <<"'" + this.FormatearTextoSql( lxRegactivChorafin ) + "'">>, "Nneto" = <<lxRegactivNneto>>, "Obs" = <<"'" + this.FormatearTextoSql( lxRegactivObs ) + "'">>, "Invocador" = <<"'" + this.FormatearTextoSql( lxRegactivInvocador ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REGACTIV' 
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

			lcFiltro = ["Ccodigo" = ] + lcValorClavePrimariaString  + [ and  REGACTIV.CCODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.REGACTIV where ' + lcFiltro )
			loColeccion.cTabla = 'REGACTIV' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REGACTIV where  REGACTIV.CCODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REGACTIV where cCodigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REGACTIV.CCODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEACTIVIDAD'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REGACTIV Where cCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.REGACTIV set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, cCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodigo ) + "'"+ [, cActividad = ] + "'" + this.FormatearTextoSql( &lcCursor..cActividad ) + "'"+ [, cFechaIni = ] + "'" + this.ConvertirDateSql( &lcCursor..cFechaIni ) + "'"+ [, cHoraIni = ] + "'" + this.FormatearTextoSql( &lcCursor..cHoraIni ) + "'"+ [, cFechaFin = ] + "'" + this.ConvertirDateSql( &lcCursor..cFechaFin ) + "'"+ [, cHoraFin = ] + "'" + this.FormatearTextoSql( &lcCursor..cHoraFin ) + "'"+ [, BDAltaFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW ) + "'"+ [, nNeto = ] + transform( &lcCursor..nNeto )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Invocador = ] + "'" + this.FormatearTextoSql( &lcCursor..Invocador ) + "'" + [ Where cCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versi�n m�s actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, SALTAFW, HMODIFW, SMODIFW, UALTAFW, VMODIFW, ZADSFW, VALTAFW, HORAIMPO, UMODIFW, HORAEXPO, BDALTAFW, BDMODIFW, ESTTRANS, HALTAFW, cCodigo, cActividad, cFechaIni, cHoraIni, cFechaFin, cHoraFin, BDAltaFW, nNeto, Obs, Invocador
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cActividad ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFechaIni ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cHoraIni ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFechaFin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cHoraFin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW ) + "'" + ',' + transform( &lcCursor..nNeto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Invocador ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.REGACTIV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEACTIVIDAD'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCodigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - C�digo: ' + transform( &tcCursor..cCodigo    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REGISTRODEACTIVIDAD'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODEACTIVIDAD_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODEACTIVIDAD_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_RegActiv')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REGISTRODEACTIVIDAD'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCodigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REGISTRODEACTIVIDAD. Hay un error en el dise�o de importaci�n.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el dise�o.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEACTIVIDAD'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCodigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCodigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEACTIVIDAD'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  cFechaIni 
		* Validar ANTERIORES A 1/1/1753  cFechaFin 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RegActiv') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RegActiv
Create Table ZooLogic.TablaTrabajo_RegActiv ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"ccodigo" char( 38 )  null, 
"cactividad" char( 240 )  null, 
"cfechaini" datetime  null, 
"choraini" char( 8 )  null, 
"cfechafin" datetime  null, 
"chorafin" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"nneto" numeric( 13, 3 )  null, 
"obs" varchar(max)  null, 
"invocador" char( 100 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_RegActiv' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_RegActiv' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEACTIVIDAD'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ccodigo','ccodigo')
			.AgregarMapeo('cactividad','cactividad')
			.AgregarMapeo('cfechaini','cfechaini')
			.AgregarMapeo('choraini','choraini')
			.AgregarMapeo('cfechafin','cfechafin')
			.AgregarMapeo('chorafin','chorafin')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('nneto','nneto')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('invocador','invocador')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_RegActiv'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.CCODIGO = isnull( d.CCODIGO, t.CCODIGO ),t.CACTIVIDAD = isnull( d.CACTIVIDAD, t.CACTIVIDAD ),t.CFECHAINI = isnull( d.CFECHAINI, t.CFECHAINI ),t.CHORAINI = isnull( d.CHORAINI, t.CHORAINI ),t.CFECHAFIN = isnull( d.CFECHAFIN, t.CFECHAFIN ),t.CHORAFIN = isnull( d.CHORAFIN, t.CHORAFIN ),t.NNETO = isnull( d.NNETO, t.NNETO ),t.OBS = isnull( d.OBS, t.OBS ),t.INVOCADOR = isnull( d.INVOCADOR, t.INVOCADOR )
					from ZooLogic.REGACTIV t inner join deleted d 
							 on t.cCodigo = d.cCodigo
				-- Fin Updates
				insert into ZooLogic.REGACTIV(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Saltafw,Hmodifw,Smodifw,Ualtafw,Vmodifw,Zadsfw,Valtafw,Horaimpo,Umodifw,Horaexpo,Bdaltafw,Bdmodifw,Esttrans,Haltafw,Ccodigo,Cactividad,Cfechaini,Choraini,Cfechafin,Chorafin,Nneto,Obs,Invocador)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.CCODIGO,''),isnull( d.CACTIVIDAD,''),isnull( d.CFECHAINI,''),isnull( d.CHORAINI,''),isnull( d.CFECHAFIN,''),isnull( d.CHORAFIN,''),isnull( d.NNETO,0),isnull( d.OBS,''),isnull( d.INVOCADOR,'')
						From deleted d left join ZooLogic.REGACTIV pk 
							 on d.cCodigo = pk.cCodigo
						Where pk.cCodigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RegActiv') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RegActiv
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REGISTRODEACTIVIDAD' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEACTIVIDAD.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEACTIVIDAD.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEACTIVIDAD.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEACTIVIDAD.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEACTIVIDAD.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_REGISTRODEACTIVIDAD.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_REGISTRODEACTIVIDAD.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_REGISTRODEACTIVIDAD.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_REGISTRODEACTIVIDAD.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_REGISTRODEACTIVIDAD.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_REGISTRODEACTIVIDAD.Versionaltafw, [] )
					.Horaimpo = nvl( c_REGISTRODEACTIVIDAD.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_REGISTRODEACTIVIDAD.Usuariomodificacionfw, [] )
					.Horaexpo = nvl( c_REGISTRODEACTIVIDAD.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_REGISTRODEACTIVIDAD.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_REGISTRODEACTIVIDAD.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_REGISTRODEACTIVIDAD.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_REGISTRODEACTIVIDAD.Horaaltafw, [] )
					.Codigo = nvl( c_REGISTRODEACTIVIDAD.Codigo, [] )
					.Actividad = nvl( c_REGISTRODEACTIVIDAD.Actividad, [] )
					.Fechainicio = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEACTIVIDAD.Fechainicio, ctod( '  /  /    ' ) ) )
					.Horainicio = nvl( c_REGISTRODEACTIVIDAD.Horainicio, [] )
					.Fechafin = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEACTIVIDAD.Fechafin, ctod( '  /  /    ' ) ) )
					.Horafin = nvl( c_REGISTRODEACTIVIDAD.Horafin, [] )
					.Basededatos = nvl( c_REGISTRODEACTIVIDAD.Basededatos, [] )
					.Tiemponetosininteracciondelusuario = nvl( c_REGISTRODEACTIVIDAD.Tiemponetosininteracciondelusuario, 0 )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Invocador = nvl( c_REGISTRODEACTIVIDAD.Invocador, [] )
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
		return c_REGISTRODEACTIVIDAD.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.REGACTIV' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,cCodigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    cCodigo from (
							select * 
								from ZooLogic.REGACTIV 
								Where   REGACTIV.CCODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REGACTIV", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Ccodigo" as "Codigo", "Cactividad" as "Actividad", "Cfechaini" as "Fechainicio", "Choraini" as "Horainicio", "Cfechafin" as "Fechafin", "Chorafin" as "Horafin", "Bdaltafw" as "Basededatos", "Nneto" as "Tiemponetosininteracciondelusuario", "Obs" as "Observacion", "Invocador" as "Invocador"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REGACTIV 
								Where   REGACTIV.CCODIGO != ''
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
	Tabla = 'REGACTIV'
	Filtro = " REGACTIV.CCODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REGACTIV.CCODIGO != ''"
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
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="FECHAIMPO                               " tabla="REGACTIV       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importaci�n                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="FECHATRANSFERENCIA                      " tabla="REGACTIV       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="FECHAMODIFICACIONFW                     " tabla="REGACTIV       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificaci�n                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="FECHAALTAFW                             " tabla="REGACTIV       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="FECHAEXPO                               " tabla="REGACTIV       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportaci�n                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="SERIEALTAFW                             " tabla="REGACTIV       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="HORAMODIFICACIONFW                      " tabla="REGACTIV       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificaci�n                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="SERIEMODIFICACIONFW                     " tabla="REGACTIV       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificaci�n                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="USUARIOALTAFW                           " tabla="REGACTIV       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="VERSIONMODIFICACIONFW                   " tabla="REGACTIV       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versi�n modificaci�n                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="ZADSFW                                  " tabla="REGACTIV       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="VERSIONALTAFW                           " tabla="REGACTIV       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versi�n alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="HORAIMPO                                " tabla="REGACTIV       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importaci�n                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="USUARIOMODIFICACIONFW                   " tabla="REGACTIV       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificaci�n                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="HORAEXPO                                " tabla="REGACTIV       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportaci�n                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="BASEDEDATOSALTAFW                       " tabla="REGACTIV       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REGACTIV       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificaci�n                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="ESTADOTRANSFERENCIA                     " tabla="REGACTIV       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="HORAALTAFW                              " tabla="REGACTIV       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="CODIGO                                  " tabla="REGACTIV       " campo="CCODIGO   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="99" etiqueta="C�digo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="ACTIVIDAD                               " tabla="REGACTIV       " campo="CACTIVIDAD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="240" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Tipo de actividad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="FECHAINICIO                             " tabla="REGACTIV       " campo="CFECHAINI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Inicio del sistema                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="HORAINICIO                              " tabla="REGACTIV       " campo="CHORAINI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Hora inicio del sistema                                                                                                                                         " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="FECHAFIN                                " tabla="REGACTIV       " campo="CFECHAFIN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Fin del inicio del sistema                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="HORAFIN                                 " tabla="REGACTIV       " campo="CHORAFIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Hora fin inicio del sistema                                                                                                                                     " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="BASEDEDATOS                             " tabla="REGACTIV       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Base de datos del inicio del sistema                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="TIEMPONETOSININTERACCIONDELUSUARIO      " tabla="REGACTIV       " campo="NNETO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="13" decimales="3" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Tiempo neto sin interacci�n del usuario                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="OBSERVACION                             " tabla="REGACTIV       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Observaci�n                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEACTIVIDAD                     " atributo="INVOCADOR                               " tabla="REGACTIV       " campo="INVOCADOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Invocador                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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