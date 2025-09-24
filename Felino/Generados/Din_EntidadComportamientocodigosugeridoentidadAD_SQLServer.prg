
define class Din_EntidadCOMPORTAMIENTOCODIGOSUGERIDOENTIDADAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Entidad]
	cExpresionCCPorCampos = [#tabla#.Entidad]
	cTagClaveCandidata = '_CCSCC'
	cTagClavePk = '_CCSPK'
	cTablaPrincipal = 'COMCODSU'
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
			local  lxComcodsuFecimpo, lxComcodsuFectrans, lxComcodsuFmodifw, lxComcodsuFecexpo, lxComcodsuFaltafw, lxComcodsuBloqreg, lxComcodsuUaltafw, lxComcodsuSaltafw, lxComcodsuSmodifw, lxComcodsuUmodifw, lxComcodsuValtafw, lxComcodsuZadsfw, lxComcodsuHmodifw, lxComcodsuVmodifw, lxComcodsuHoraexpo, lxComcodsuEsttrans, lxComcodsuBdmodifw, lxComcodsuHoraimpo, lxComcodsuHaltafw, lxComcodsuBdaltafw, lxComcodsuDesentidad, lxComcodsuEntidad, lxComcodsuAnchodispo, lxComcodsuSugerir, lxComcodsuIdglobal, lxComcodsuAnchosuger, lxComcodsuPrefijobd, lxComcodsuPrefijo, lxComcodsuVistaprev, lxComcodsuBusqextend, lxComcodsuSalta, lxComcodsuObs
				lxComcodsuFecimpo =  .Fechaimpo			lxComcodsuFectrans =  .Fechatransferencia			lxComcodsuFmodifw =  .Fechamodificacionfw			lxComcodsuFecexpo =  .Fechaexpo			lxComcodsuFaltafw =  .Fechaaltafw			lxComcodsuBloqreg =  .Bloquearregistro			lxComcodsuUaltafw =  .Usuarioaltafw			lxComcodsuSaltafw =  .Seriealtafw			lxComcodsuSmodifw =  .Seriemodificacionfw			lxComcodsuUmodifw =  .Usuariomodificacionfw			lxComcodsuValtafw =  .Versionaltafw			lxComcodsuZadsfw =  .Zadsfw			lxComcodsuHmodifw =  .Horamodificacionfw			lxComcodsuVmodifw =  .Versionmodificacionfw			lxComcodsuHoraexpo =  .Horaexpo			lxComcodsuEsttrans =  .Estadotransferencia			lxComcodsuBdmodifw =  .Basededatosmodificacionfw			lxComcodsuHoraimpo =  .Horaimpo			lxComcodsuHaltafw =  .Horaaltafw			lxComcodsuBdaltafw =  .Basededatosaltafw			lxComcodsuDesentidad =  .Descripciondelaentidad			lxComcodsuEntidad =  .Entidad			lxComcodsuAnchodispo =  .Anchodisponible			lxComcodsuSugerir =  .Sugerir			lxComcodsuIdglobal =  .Idglobal			lxComcodsuAnchosuger =  .Anchoasugerir			lxComcodsuPrefijobd =  .Usarprefijobasededatos			lxComcodsuPrefijo =  .Prefijoentidad			lxComcodsuVistaprev =  .Vistaprevia			lxComcodsuBusqextend =  .Busquedaextendida			lxComcodsuSalta =  .Salta			lxComcodsuObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxComcodsuEntidad = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.COMCODSU ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bloqreg","Ualtafw","Saltafw","Smodifw","Umodifw","Valtafw","Zadsfw","Hmodifw","Vmodifw","Horaexpo","Esttrans","Bdmodifw","Horaimpo","Haltafw","Bdaltafw","Desentidad","Entidad","Anchodispo","Sugerir","Idglobal","Anchosuger","Prefijobd","Prefijo","Vistaprev","Busqextend","Salta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxComcodsuFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFaltafw ) + "'" >>, <<iif( lxComcodsuBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComcodsuUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuDesentidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuEntidad ) + "'" >>, <<lxComcodsuAnchodispo >>, <<iif( lxComcodsuSugerir, 1, 0 ) >>, <<iif( lxComcodsuIdglobal, 1, 0 ) >>, <<lxComcodsuAnchosuger >>, <<iif( lxComcodsuPrefijobd, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComcodsuPrefijo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuVistaprev ) + "'" >>, <<iif( lxComcodsuBusqextend, 1, 0 ) >>, <<iif( lxComcodsuSalta, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComcodsuObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ENTIDAD
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
		return this.oEntidad.ENTIDAD
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxComcodsuFecimpo, lxComcodsuFectrans, lxComcodsuFmodifw, lxComcodsuFecexpo, lxComcodsuFaltafw, lxComcodsuBloqreg, lxComcodsuUaltafw, lxComcodsuSaltafw, lxComcodsuSmodifw, lxComcodsuUmodifw, lxComcodsuValtafw, lxComcodsuZadsfw, lxComcodsuHmodifw, lxComcodsuVmodifw, lxComcodsuHoraexpo, lxComcodsuEsttrans, lxComcodsuBdmodifw, lxComcodsuHoraimpo, lxComcodsuHaltafw, lxComcodsuBdaltafw, lxComcodsuDesentidad, lxComcodsuEntidad, lxComcodsuAnchodispo, lxComcodsuSugerir, lxComcodsuIdglobal, lxComcodsuAnchosuger, lxComcodsuPrefijobd, lxComcodsuPrefijo, lxComcodsuVistaprev, lxComcodsuBusqextend, lxComcodsuSalta, lxComcodsuObs
				lxComcodsuFecimpo =  .Fechaimpo			lxComcodsuFectrans =  .Fechatransferencia			lxComcodsuFmodifw =  .Fechamodificacionfw			lxComcodsuFecexpo =  .Fechaexpo			lxComcodsuFaltafw =  .Fechaaltafw			lxComcodsuBloqreg =  .Bloquearregistro			lxComcodsuUaltafw =  .Usuarioaltafw			lxComcodsuSaltafw =  .Seriealtafw			lxComcodsuSmodifw =  .Seriemodificacionfw			lxComcodsuUmodifw =  .Usuariomodificacionfw			lxComcodsuValtafw =  .Versionaltafw			lxComcodsuZadsfw =  .Zadsfw			lxComcodsuHmodifw =  .Horamodificacionfw			lxComcodsuVmodifw =  .Versionmodificacionfw			lxComcodsuHoraexpo =  .Horaexpo			lxComcodsuEsttrans =  .Estadotransferencia			lxComcodsuBdmodifw =  .Basededatosmodificacionfw			lxComcodsuHoraimpo =  .Horaimpo			lxComcodsuHaltafw =  .Horaaltafw			lxComcodsuBdaltafw =  .Basededatosaltafw			lxComcodsuDesentidad =  .Descripciondelaentidad			lxComcodsuEntidad =  .Entidad			lxComcodsuAnchodispo =  .Anchodisponible			lxComcodsuSugerir =  .Sugerir			lxComcodsuIdglobal =  .Idglobal			lxComcodsuAnchosuger =  .Anchoasugerir			lxComcodsuPrefijobd =  .Usarprefijobasededatos			lxComcodsuPrefijo =  .Prefijoentidad			lxComcodsuVistaprev =  .Vistaprevia			lxComcodsuBusqextend =  .Busquedaextendida			lxComcodsuSalta =  .Salta			lxComcodsuObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ENTIDAD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.COMCODSU set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComcodsuFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComcodsuFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxComcodsuFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComcodsuFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComcodsuFaltafw ) + "'">>,"Bloqreg" = <<iif( lxComcodsuBloqreg, 1, 0 )>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComcodsuUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComcodsuSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComcodsuValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComcodsuZadsfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComcodsuHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComcodsuEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComcodsuHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComcodsuHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComcodsuBdaltafw ) + "'">>,"Desentidad" = <<"'" + this.FormatearTextoSql( lxComcodsuDesentidad ) + "'">>,"Entidad" = <<"'" + this.FormatearTextoSql( lxComcodsuEntidad ) + "'">>,"Anchodispo" = <<lxComcodsuAnchodispo>>,"Sugerir" = <<iif( lxComcodsuSugerir, 1, 0 )>>,"Idglobal" = <<iif( lxComcodsuIdglobal, 1, 0 )>>,"Anchosuger" = <<lxComcodsuAnchosuger>>,"Prefijobd" = <<iif( lxComcodsuPrefijobd, 1, 0 )>>,"Prefijo" = <<"'" + this.FormatearTextoSql( lxComcodsuPrefijo ) + "'">>,"Vistaprev" = <<"'" + this.FormatearTextoSql( lxComcodsuVistaprev ) + "'">>,"Busqextend" = <<iif( lxComcodsuBusqextend, 1, 0 )>>,"Salta" = <<iif( lxComcodsuSalta, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxComcodsuObs ) + "'">> where "Entidad" = <<"'" + this.FormatearTextoSql( lxComcodsuEntidad ) + "'">> and  COMCODSU.ENTIDAD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Entidad from ORGANIZACION.COMCODSU where " + this.ConvertirFuncionesSql( " COMCODSU.ENTIDAD != ''" ) )
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
			Local lxComcodsuEntidad
			lxComcodsuEntidad = .Entidad

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion" from ORGANIZACION.COMCODSU where "Entidad" = <<"'" + this.FormatearTextoSql( lxComcodsuEntidad ) + "'">> and  COMCODSU.ENTIDAD != ''
			endtext
			use in select('c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD', set( 'Datasession' ) )

			if reccount( 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD' ) = 0
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
			Local lxComCodSuEntidad As Variant
			lxComCodSuEntidad = .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion" from ORGANIZACION.COMCODSU where  COMCODSU.ENTIDAD != '' And Entidad = <<"'" + this.FormatearTextoSql( lxComCodSuEntidad ) + "'">>
			endtext
			use in select('c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD', set( 'Datasession' ) )
			if reccount( 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxComcodsuEntidad as Variant
		llRetorno = .t.
		lxComcodsuEntidad = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.COMCODSU where "Entidad" = <<"'" + this.FormatearTextoSql( lxComcodsuEntidad ) + "'">> and  COMCODSU.ENTIDAD != ''
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion" from ORGANIZACION.COMCODSU where  COMCODSU.ENTIDAD != '' order by Entidad
			endtext
			use in select('c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD', set( 'Datasession' ) )
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion" from ORGANIZACION.COMCODSU where  funciones.padr( Entidad, 40, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMCODSU.ENTIDAD != '' order by Entidad
			endtext
			use in select('c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD', set( 'Datasession' ) )
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion" from ORGANIZACION.COMCODSU where  funciones.padr( Entidad, 40, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMCODSU.ENTIDAD != '' order by Entidad desc
			endtext
			use in select('c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD', set( 'Datasession' ) )
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion" from ORGANIZACION.COMCODSU where  COMCODSU.ENTIDAD != '' order by Entidad desc
			endtext
			use in select('c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.ENTIDAD ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bloqreg,Ualtafw,Saltafw,Smodifw,Umodifw,Valtafw,Zad" + ;
"sfw,Hmodifw,Vmodifw,Horaexpo,Esttrans,Bdmodifw,Horaimpo,Haltafw,Bdaltafw,Desentidad,Entidad,Anchodis" + ;
"po,Sugerir,Idglobal,Anchosuger,Prefijobd,Prefijo,Vistaprev,Busqextend,Salta,Obs" + ;
" from ORGANIZACION.COMCODSU where  COMCODSU.ENTIDAD != '' and " + lcFiltro )
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
			local  lxComcodsuFecimpo, lxComcodsuFectrans, lxComcodsuFmodifw, lxComcodsuFecexpo, lxComcodsuFaltafw, lxComcodsuBloqreg, lxComcodsuUaltafw, lxComcodsuSaltafw, lxComcodsuSmodifw, lxComcodsuUmodifw, lxComcodsuValtafw, lxComcodsuZadsfw, lxComcodsuHmodifw, lxComcodsuVmodifw, lxComcodsuHoraexpo, lxComcodsuEsttrans, lxComcodsuBdmodifw, lxComcodsuHoraimpo, lxComcodsuHaltafw, lxComcodsuBdaltafw, lxComcodsuDesentidad, lxComcodsuEntidad, lxComcodsuAnchodispo, lxComcodsuSugerir, lxComcodsuIdglobal, lxComcodsuAnchosuger, lxComcodsuPrefijobd, lxComcodsuPrefijo, lxComcodsuVistaprev, lxComcodsuBusqextend, lxComcodsuSalta, lxComcodsuObs
				lxComcodsuFecimpo = ctod( '  /  /    ' )			lxComcodsuFectrans = ctod( '  /  /    ' )			lxComcodsuFmodifw = ctod( '  /  /    ' )			lxComcodsuFecexpo = ctod( '  /  /    ' )			lxComcodsuFaltafw = ctod( '  /  /    ' )			lxComcodsuBloqreg = .F.			lxComcodsuUaltafw = []			lxComcodsuSaltafw = []			lxComcodsuSmodifw = []			lxComcodsuUmodifw = []			lxComcodsuValtafw = []			lxComcodsuZadsfw = []			lxComcodsuHmodifw = []			lxComcodsuVmodifw = []			lxComcodsuHoraexpo = []			lxComcodsuEsttrans = []			lxComcodsuBdmodifw = []			lxComcodsuHoraimpo = []			lxComcodsuHaltafw = []			lxComcodsuBdaltafw = []			lxComcodsuDesentidad = []			lxComcodsuEntidad = []			lxComcodsuAnchodispo = 0			lxComcodsuSugerir = .F.			lxComcodsuIdglobal = .F.			lxComcodsuAnchosuger = 0			lxComcodsuPrefijobd = .F.			lxComcodsuPrefijo = []			lxComcodsuVistaprev = []			lxComcodsuBusqextend = .F.			lxComcodsuSalta = .F.			lxComcodsuObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.COMCODSU where "Entidad" = ] + "'" + this.FormatearTextoSql( .oEntidad.ENTIDAD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMCODSU' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Entidad = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Entidad, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMCODSU.ENTIDAD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMCODSU', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
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
				Case lcAtributo == 'DESCRIPCIONDELAENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESENTIDAD AS DESCRIPCIONDELAENTIDAD'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTIDAD AS ENTIDAD'
				Case lcAtributo == 'ANCHODISPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANCHODISPO AS ANCHODISPONIBLE'
				Case lcAtributo == 'SUGERIR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUGERIR AS SUGERIR'
				Case lcAtributo == 'IDGLOBAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDGLOBAL AS IDGLOBAL'
				Case lcAtributo == 'ANCHOASUGERIR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANCHOSUGER AS ANCHOASUGERIR'
				Case lcAtributo == 'USARPREFIJOBASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PREFIJOBD AS USARPREFIJOBASEDEDATOS'
				Case lcAtributo == 'PREFIJOENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PREFIJO AS PREFIJOENTIDAD'
				Case lcAtributo == 'VISTAPREVIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISTAPREV AS VISTAPREVIA'
				Case lcAtributo == 'BUSQUEDAEXTENDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BUSQEXTEND AS BUSQUEDAEXTENDIDA'
				Case lcAtributo == 'SALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTA AS SALTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONDELAENTIDAD'
				lcCampo = 'DESENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'ENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHODISPONIBLE'
				lcCampo = 'ANCHODISPO'
			Case upper( alltrim( tcAtributo ) ) == 'SUGERIR'
				lcCampo = 'SUGERIR'
			Case upper( alltrim( tcAtributo ) ) == 'IDGLOBAL'
				lcCampo = 'IDGLOBAL'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHOASUGERIR'
				lcCampo = 'ANCHOSUGER'
			Case upper( alltrim( tcAtributo ) ) == 'USARPREFIJOBASEDEDATOS'
				lcCampo = 'PREFIJOBD'
			Case upper( alltrim( tcAtributo ) ) == 'PREFIJOENTIDAD'
				lcCampo = 'PREFIJO'
			Case upper( alltrim( tcAtributo ) ) == 'VISTAPREVIA'
				lcCampo = 'VISTAPREV'
			Case upper( alltrim( tcAtributo ) ) == 'BUSQUEDAEXTENDIDA'
				lcCampo = 'BUSQEXTEND'
			Case upper( alltrim( tcAtributo ) ) == 'SALTA'
				lcCampo = 'SALTA'
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
			local  lxComcodsuFecimpo, lxComcodsuFectrans, lxComcodsuFmodifw, lxComcodsuFecexpo, lxComcodsuFaltafw, lxComcodsuBloqreg, lxComcodsuUaltafw, lxComcodsuSaltafw, lxComcodsuSmodifw, lxComcodsuUmodifw, lxComcodsuValtafw, lxComcodsuZadsfw, lxComcodsuHmodifw, lxComcodsuVmodifw, lxComcodsuHoraexpo, lxComcodsuEsttrans, lxComcodsuBdmodifw, lxComcodsuHoraimpo, lxComcodsuHaltafw, lxComcodsuBdaltafw, lxComcodsuDesentidad, lxComcodsuEntidad, lxComcodsuAnchodispo, lxComcodsuSugerir, lxComcodsuIdglobal, lxComcodsuAnchosuger, lxComcodsuPrefijobd, lxComcodsuPrefijo, lxComcodsuVistaprev, lxComcodsuBusqextend, lxComcodsuSalta, lxComcodsuObs
				lxComcodsuFecimpo =  .Fechaimpo			lxComcodsuFectrans =  .Fechatransferencia			lxComcodsuFmodifw =  .Fechamodificacionfw			lxComcodsuFecexpo =  .Fechaexpo			lxComcodsuFaltafw =  .Fechaaltafw			lxComcodsuBloqreg =  .Bloquearregistro			lxComcodsuUaltafw =  .Usuarioaltafw			lxComcodsuSaltafw =  .Seriealtafw			lxComcodsuSmodifw =  .Seriemodificacionfw			lxComcodsuUmodifw =  .Usuariomodificacionfw			lxComcodsuValtafw =  .Versionaltafw			lxComcodsuZadsfw =  .Zadsfw			lxComcodsuHmodifw =  .Horamodificacionfw			lxComcodsuVmodifw =  .Versionmodificacionfw			lxComcodsuHoraexpo =  .Horaexpo			lxComcodsuEsttrans =  .Estadotransferencia			lxComcodsuBdmodifw =  .Basededatosmodificacionfw			lxComcodsuHoraimpo =  .Horaimpo			lxComcodsuHaltafw =  .Horaaltafw			lxComcodsuBdaltafw =  .Basededatosaltafw			lxComcodsuDesentidad =  .Descripciondelaentidad			lxComcodsuEntidad =  .Entidad			lxComcodsuAnchodispo =  .Anchodisponible			lxComcodsuSugerir =  .Sugerir			lxComcodsuIdglobal =  .Idglobal			lxComcodsuAnchosuger =  .Anchoasugerir			lxComcodsuPrefijobd =  .Usarprefijobasededatos			lxComcodsuPrefijo =  .Prefijoentidad			lxComcodsuVistaprev =  .Vistaprevia			lxComcodsuBusqextend =  .Busquedaextendida			lxComcodsuSalta =  .Salta			lxComcodsuObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.COMCODSU ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bloqreg","Ualtafw","Saltafw","Smodifw","Umodifw","Valtafw","Zadsfw","Hmodifw","Vmodifw","Horaexpo","Esttrans","Bdmodifw","Horaimpo","Haltafw","Bdaltafw","Desentidad","Entidad","Anchodispo","Sugerir","Idglobal","Anchosuger","Prefijobd","Prefijo","Vistaprev","Busqextend","Salta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxComcodsuFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComcodsuFaltafw ) + "'" >>, <<iif( lxComcodsuBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComcodsuUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuDesentidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuEntidad ) + "'" >>, <<lxComcodsuAnchodispo >>, <<iif( lxComcodsuSugerir, 1, 0 ) >>, <<iif( lxComcodsuIdglobal, 1, 0 ) >>, <<lxComcodsuAnchosuger >>, <<iif( lxComcodsuPrefijobd, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComcodsuPrefijo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComcodsuVistaprev ) + "'" >>, <<iif( lxComcodsuBusqextend, 1, 0 ) >>, <<iif( lxComcodsuSalta, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComcodsuObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMCODSU' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.ENTIDAD + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxComcodsuFecimpo, lxComcodsuFectrans, lxComcodsuFmodifw, lxComcodsuFecexpo, lxComcodsuFaltafw, lxComcodsuBloqreg, lxComcodsuUaltafw, lxComcodsuSaltafw, lxComcodsuSmodifw, lxComcodsuUmodifw, lxComcodsuValtafw, lxComcodsuZadsfw, lxComcodsuHmodifw, lxComcodsuVmodifw, lxComcodsuHoraexpo, lxComcodsuEsttrans, lxComcodsuBdmodifw, lxComcodsuHoraimpo, lxComcodsuHaltafw, lxComcodsuBdaltafw, lxComcodsuDesentidad, lxComcodsuEntidad, lxComcodsuAnchodispo, lxComcodsuSugerir, lxComcodsuIdglobal, lxComcodsuAnchosuger, lxComcodsuPrefijobd, lxComcodsuPrefijo, lxComcodsuVistaprev, lxComcodsuBusqextend, lxComcodsuSalta, lxComcodsuObs
				lxComcodsuFecimpo =  .Fechaimpo			lxComcodsuFectrans =  .Fechatransferencia			lxComcodsuFmodifw =  .Fechamodificacionfw			lxComcodsuFecexpo =  .Fechaexpo			lxComcodsuFaltafw =  .Fechaaltafw			lxComcodsuBloqreg =  .Bloquearregistro			lxComcodsuUaltafw =  .Usuarioaltafw			lxComcodsuSaltafw =  .Seriealtafw			lxComcodsuSmodifw =  .Seriemodificacionfw			lxComcodsuUmodifw =  .Usuariomodificacionfw			lxComcodsuValtafw =  .Versionaltafw			lxComcodsuZadsfw =  .Zadsfw			lxComcodsuHmodifw =  .Horamodificacionfw			lxComcodsuVmodifw =  .Versionmodificacionfw			lxComcodsuHoraexpo =  .Horaexpo			lxComcodsuEsttrans =  .Estadotransferencia			lxComcodsuBdmodifw =  .Basededatosmodificacionfw			lxComcodsuHoraimpo =  .Horaimpo			lxComcodsuHaltafw =  .Horaaltafw			lxComcodsuBdaltafw =  .Basededatosaltafw			lxComcodsuDesentidad =  .Descripciondelaentidad			lxComcodsuEntidad =  .Entidad			lxComcodsuAnchodispo =  .Anchodisponible			lxComcodsuSugerir =  .Sugerir			lxComcodsuIdglobal =  .Idglobal			lxComcodsuAnchosuger =  .Anchoasugerir			lxComcodsuPrefijobd =  .Usarprefijobasededatos			lxComcodsuPrefijo =  .Prefijoentidad			lxComcodsuVistaprev =  .Vistaprevia			lxComcodsuBusqextend =  .Busquedaextendida			lxComcodsuSalta =  .Salta			lxComcodsuObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ENTIDAD
			lcValorClavePrimariaString = "'" + this.oEntidad.ENTIDAD + "'"

			lcFiltro = ["Entidad" = ] + lcValorClavePrimariaString  + [ and  COMCODSU.ENTIDAD != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.COMCODSU set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComcodsuFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComcodsuFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComcodsuFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComcodsuFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComcodsuFaltafw ) + "'">>, "Bloqreg" = <<iif( lxComcodsuBloqreg, 1, 0 )>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComcodsuUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComcodsuSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComcodsuValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComcodsuZadsfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComcodsuHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComcodsuEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComcodsuBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComcodsuHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComcodsuHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComcodsuBdaltafw ) + "'">>, "Desentidad" = <<"'" + this.FormatearTextoSql( lxComcodsuDesentidad ) + "'">>, "Entidad" = <<"'" + this.FormatearTextoSql( lxComcodsuEntidad ) + "'">>, "Anchodispo" = <<lxComcodsuAnchodispo>>, "Sugerir" = <<iif( lxComcodsuSugerir, 1, 0 )>>, "Idglobal" = <<iif( lxComcodsuIdglobal, 1, 0 )>>, "Anchosuger" = <<lxComcodsuAnchosuger>>, "Prefijobd" = <<iif( lxComcodsuPrefijobd, 1, 0 )>>, "Prefijo" = <<"'" + this.FormatearTextoSql( lxComcodsuPrefijo ) + "'">>, "Vistaprev" = <<"'" + this.FormatearTextoSql( lxComcodsuVistaprev ) + "'">>, "Busqextend" = <<iif( lxComcodsuBusqextend, 1, 0 )>>, "Salta" = <<iif( lxComcodsuSalta, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxComcodsuObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMCODSU' 
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
			lxValorClavePrimaria = this.oEntidad.ENTIDAD
			lcValorClavePrimariaString = "'" + this.oEntidad.ENTIDAD + "'"

			lcFiltro = ["Entidad" = ] + lcValorClavePrimariaString  + [ and  COMCODSU.ENTIDAD != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.COMCODSU where ' + lcFiltro )
			loColeccion.cTabla = 'COMCODSU' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.COMCODSU where  COMCODSU.ENTIDAD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.COMCODSU where Entidad = " + "'" + this.FormatearTextoSql( this.oEntidad.ENTIDAD ) + "'"+ " and  COMCODSU.ENTIDAD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.COMCODSU Where  Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad    ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Entidad
				if lxValorClavePK == curSeek.Entidad or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Entidad and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Entidad
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.COMCODSU set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, DesEntidad = ] + "'" + this.FormatearTextoSql( &lcCursor..DesEntidad ) + "'"+ [, Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'"+ [, AnchoDispo = ] + transform( &lcCursor..AnchoDispo )+ [, Sugerir = ] + Transform( iif( &lcCursor..Sugerir, 1, 0 ))+ [, IdGlobal = ] + Transform( iif( &lcCursor..IdGlobal, 1, 0 ))+ [, AnchoSuger = ] + transform( &lcCursor..AnchoSuger )+ [, PrefijoBD = ] + Transform( iif( &lcCursor..PrefijoBD, 1, 0 ))+ [, Prefijo = ] + "'" + this.FormatearTextoSql( &lcCursor..Prefijo ) + "'"+ [, vistaprev = ] + "'" + this.FormatearTextoSql( &lcCursor..vistaprev ) + "'"+ [, BusqExtend = ] + Transform( iif( &lcCursor..BusqExtend, 1, 0 ))+ [, Salta = ] + Transform( iif( &lcCursor..Salta, 1, 0 ))+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Entidad = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.COMCODSU Where Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, BLOQREG, UALTAFW, SALTAFW, SMODIFW, UMODIFW, VALTAFW, ZADSFW, HMODIFW, VMODIFW, HORAEXPO, ESTTRANS, BDMODIFW, HORAIMPO, HALTAFW, BDALTAFW, DesEntidad, Entidad, AnchoDispo, Sugerir, IdGlobal, AnchoSuger, PrefijoBD, Prefijo, vistaprev, BusqExtend, Salta, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesEntidad ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'" + ',' + transform( &lcCursor..AnchoDispo ) + ',' + Transform( iif( &lcCursor..Sugerir, 1, 0 )) + ',' + Transform( iif( &lcCursor..IdGlobal, 1, 0 )) + ',' + transform( &lcCursor..AnchoSuger ) + ',' + Transform( iif( &lcCursor..PrefijoBD, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Prefijo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..vistaprev ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..BusqExtend, 1, 0 )) + ',' + Transform( iif( &lcCursor..Salta, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.COMCODSU ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Entidad C (40) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Entidad: ' + transform( &tcCursor..Entidad    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_ComCodSu')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Entidad
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Entidad )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COMPORTAMIENTOCODIGOSUGERIDOENTIDAD. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Entidad as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Entidad, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,Entidad as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Entidad, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_ComCodSu') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_ComCodSu
Create Table ORGANIZACION.TablaTrabajo_ComCodSu ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"bloqreg" bit  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"desentidad" char( 60 )  null, 
"entidad" char( 40 )  null, 
"anchodispo" numeric( 2, 0 )  null, 
"sugerir" bit  null, 
"idglobal" bit  null, 
"anchosuger" numeric( 2, 0 )  null, 
"prefijobd" bit  null, 
"prefijo" char( 3 )  null, 
"vistaprev" char( 30 )  null, 
"busqextend" bit  null, 
"salta" bit  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ComCodSu' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ComCodSu' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('desentidad','desentidad')
			.AgregarMapeo('entidad','entidad')
			.AgregarMapeo('anchodispo','anchodispo')
			.AgregarMapeo('sugerir','sugerir')
			.AgregarMapeo('idglobal','idglobal')
			.AgregarMapeo('anchosuger','anchosuger')
			.AgregarMapeo('prefijobd','prefijobd')
			.AgregarMapeo('prefijo','prefijo')
			.AgregarMapeo('vistaprev','vistaprev')
			.AgregarMapeo('busqextend','busqextend')
			.AgregarMapeo('salta','salta')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_ComCodSu'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.DESENTIDAD = isnull( d.DESENTIDAD, t.DESENTIDAD ),t.ENTIDAD = isnull( d.ENTIDAD, t.ENTIDAD ),t.ANCHODISPO = isnull( d.ANCHODISPO, t.ANCHODISPO ),t.SUGERIR = isnull( d.SUGERIR, t.SUGERIR ),t.IDGLOBAL = isnull( d.IDGLOBAL, t.IDGLOBAL ),t.ANCHOSUGER = isnull( d.ANCHOSUGER, t.ANCHOSUGER ),t.PREFIJOBD = isnull( d.PREFIJOBD, t.PREFIJOBD ),t.PREFIJO = isnull( d.PREFIJO, t.PREFIJO ),t.VISTAPREV = isnull( d.VISTAPREV, t.VISTAPREV ),t.BUSQEXTEND = isnull( d.BUSQEXTEND, t.BUSQEXTEND ),t.SALTA = isnull( d.SALTA, t.SALTA ),t.OBS = isnull( d.OBS, t.OBS )
					from ORGANIZACION.COMCODSU t inner join deleted d 
							 on t.Entidad = d.Entidad
							 and  t.Entidad = d.Entidad
				-- Fin Updates
				insert into ORGANIZACION.COMCODSU(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bloqreg,Ualtafw,Saltafw,Smodifw,Umodifw,Valtafw,Zadsfw,Hmodifw,Vmodifw,Horaexpo,Esttrans,Bdmodifw,Horaimpo,Haltafw,Bdaltafw,Desentidad,Entidad,Anchodispo,Sugerir,Idglobal,Anchosuger,Prefijobd,Prefijo,Vistaprev,Busqextend,Salta,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.BLOQREG,0),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.DESENTIDAD,''),isnull( d.ENTIDAD,''),isnull( d.ANCHODISPO,0),isnull( d.SUGERIR,0),isnull( d.IDGLOBAL,0),isnull( d.ANCHOSUGER,0),isnull( d.PREFIJOBD,0),isnull( d.PREFIJO,''),isnull( d.VISTAPREV,''),isnull( d.BUSQEXTEND,0),isnull( d.SALTA,0),isnull( d.OBS,'')
						From deleted d left join ORGANIZACION.COMCODSU pk 
							 on d.Entidad = pk.Entidad
						 left join ORGANIZACION.COMCODSU cc 
							 on  d.Entidad = cc.Entidad
						Where pk.Entidad Is Null 
							 and cc.Entidad Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ENTIDAD ' + cast( d.Entidad as Varchar(40) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.COMCODSU t inner join deleted d 
							on   t.Entidad = d.Entidad
						left join deleted h 
							 on t.Entidad = h.Entidad
							 where h.Entidad is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ENTIDAD ' + cast( d.Entidad as Varchar(40) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.COMCODSU t inner join deleted d 
							 on t.Entidad = d.Entidad
						left join deleted h 
							on   t.Entidad = h.Entidad
							where   h.Entidad is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_ComCodSu') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_ComCodSu
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Bloquearregistro = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Bloquearregistro, .F. )
					.Usuarioaltafw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horamodificacionfw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Horaexpo, [] )
					.Estadotransferencia = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Horaimpo, [] )
					.Horaaltafw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Basededatosaltafw, [] )
					.Descripciondelaentidad = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Descripciondelaentidad, [] )
					.Entidad = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Entidad, [] )
					.Anchodisponible = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Anchodisponible, 0 )
					.Sugerir = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Sugerir, .F. )
					.Idglobal = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Idglobal, .F. )
					.Anchoasugerir = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Anchoasugerir, 0 )
					.Usarprefijobasededatos = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Usarprefijobasededatos, .F. )
					.Prefijoentidad = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Prefijoentidad, [] )
					.Vistaprevia = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Vistaprevia, [] )
					.Busquedaextendida = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Busquedaextendida, .F. )
					.Salta = nvl( c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.Salta, .F. )
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
			lxRetorno = c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.ENTIDAD
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
		return c_COMPORTAMIENTOCODIGOSUGERIDOENTIDAD.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.COMCODSU' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Entidad"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Entidad as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Entidad from (
							select * 
								from ORGANIZACION.COMCODSU 
								Where   COMCODSU.ENTIDAD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMCODSU", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Entidad"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Desentidad" as "Descripciondelaentidad", "Entidad" as "Entidad", "Anchodispo" as "Anchodisponible", "Sugerir" as "Sugerir", "Idglobal" as "Idglobal", "Anchosuger" as "Anchoasugerir", "Prefijobd" as "Usarprefijobasededatos", "Prefijo" as "Prefijoentidad", "Vistaprev" as "Vistaprevia", "Busqextend" as "Busquedaextendida", "Salta" as "Salta", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.COMCODSU 
								Where   COMCODSU.ENTIDAD != ''
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
	Tabla = 'COMCODSU'
	Filtro = " COMCODSU.ENTIDAD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMCODSU.ENTIDAD != ''"
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
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="FECHAIMPO                               " tabla="COMCODSU       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="FECHATRANSFERENCIA                      " tabla="COMCODSU       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="FECHAMODIFICACIONFW                     " tabla="COMCODSU       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="FECHAEXPO                               " tabla="COMCODSU       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="FECHAALTAFW                             " tabla="COMCODSU       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="BLOQUEARREGISTRO                        " tabla="COMCODSU       " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="USUARIOALTAFW                           " tabla="COMCODSU       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="SERIEALTAFW                             " tabla="COMCODSU       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="SERIEMODIFICACIONFW                     " tabla="COMCODSU       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="USUARIOMODIFICACIONFW                   " tabla="COMCODSU       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="VERSIONALTAFW                           " tabla="COMCODSU       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="ZADSFW                                  " tabla="COMCODSU       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="HORAMODIFICACIONFW                      " tabla="COMCODSU       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="VERSIONMODIFICACIONFW                   " tabla="COMCODSU       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="HORAEXPO                                " tabla="COMCODSU       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="ESTADOTRANSFERENCIA                     " tabla="COMCODSU       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMCODSU       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="HORAIMPO                                " tabla="COMCODSU       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="HORAALTAFW                              " tabla="COMCODSU       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="BASEDEDATOSALTAFW                       " tabla="COMCODSU       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="DESCRIPCIONDELAENTIDAD                  " tabla="COMCODSU       " campo="DESENTIDAD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="ENTIDAD                                 " tabla="COMCODSU       " campo="ENTIDAD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Entidad                                                                                                                                                         " dominio="COMBOENTIDADESCODIGOSUGERIDO  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="ANCHODISPONIBLE                         " tabla="COMCODSU       " campo="ANCHODISPO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Ancho disponible                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="SUGERIR                                 " tabla="COMCODSU       " campo="SUGERIR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="201" etiqueta="Sugerir                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="IDGLOBAL                                " tabla="COMCODSU       " campo="IDGLOBAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Identificador global                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="ANCHOASUGERIR                           " tabla="COMCODSU       " campo="ANCHOSUGER" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="203" etiqueta="Ancho a sugerir                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="USARPREFIJOBASEDEDATOS                  " tabla="COMCODSU       " campo="PREFIJOBD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Prefijo de base de datos                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="PREFIJOENTIDAD                          " tabla="COMCODSU       " campo="PREFIJO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Prefijo                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="VISTAPREVIA                             " tabla="COMCODSU       " campo="VISTAPREV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Detalle                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="BUSQUEDAEXTENDIDA                       " tabla="COMCODSU       " campo="BUSQEXTEND" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="207" etiqueta="Búsqueda extendida                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="SALTA                                   " tabla="COMCODSU       " campo="SALTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="Saltar                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPORTAMIENTOCODIGOSUGERIDOENTIDAD     " atributo="OBSERVACION                             " tabla="COMCODSU       " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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