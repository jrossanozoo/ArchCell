
define class Din_EntidadREPORTEELECTRONICOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REPORTEELECTRONICO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 8, 0)]
	cTagClaveCandidata = '_RPECC'
	cTagClavePk = '_RPEPK'
	cTablaPrincipal = 'REPOELEC'
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
			local  lxRepoelecFectrans, lxRepoelecFmodifw, lxRepoelecFaltafw, lxRepoelecFecexpo, lxRepoelecFecimpo, lxRepoelecZadsfw, lxRepoelecNumero, lxRepoelecHaltafw, lxRepoelecHoraexpo, lxRepoelecUaltafw, lxRepoelecHoraimpo, lxRepoelecVmodifw, lxRepoelecZadsfw, lxRepoelecValtafw, lxRepoelecUmodifw, lxRepoelecSaltafw, lxRepoelecSmodifw, lxRepoelecHmodifw, lxRepoelecBdaltafw, lxRepoelecBdmodifw, lxRepoelecEsttrans, lxRepoelecCodint, lxRepoelecFaltafw, lxRepoelecPtoventa, lxRepoelecDesafip, lxRepoelecDesaudi, lxRepoelecFecddeafip, lxRepoelecTipodes, lxRepoelecFecddeaudi, lxRepoelecFechtaafip, lxRepoelecFechtaaudi, lxRepoelecRutaafip, lxRepoelecNroddeaudi, lxRepoelecNrohtaaud, lxRepoelecRutaaudi, lxRepoelecObs
				lxRepoelecFectrans =  .Fechatransferencia			lxRepoelecFmodifw =  .Fechamodificacionfw			lxRepoelecFaltafw =  .Fechaaltafw			lxRepoelecFecexpo =  .Fechaexpo			lxRepoelecFecimpo =  .Fechaimpo			lxRepoelecZadsfw =  .Acciones			lxRepoelecNumero =  .Numero			lxRepoelecHaltafw =  .Horaaltafw			lxRepoelecHoraexpo =  .Horaexpo			lxRepoelecUaltafw =  .Usuarioaltafw			lxRepoelecHoraimpo =  .Horaimpo			lxRepoelecVmodifw =  .Versionmodificacionfw			lxRepoelecZadsfw =  .Zadsfw			lxRepoelecValtafw =  .Versionaltafw			lxRepoelecUmodifw =  .Usuariomodificacionfw			lxRepoelecSaltafw =  .Seriealtafw			lxRepoelecSmodifw =  .Seriemodificacionfw			lxRepoelecHmodifw =  .Horamodificacionfw			lxRepoelecBdaltafw =  .Basededatosaltafw			lxRepoelecBdmodifw =  .Basededatosmodificacionfw			lxRepoelecEsttrans =  .Estadotransferencia			lxRepoelecCodint =  .Codint			lxRepoelecFaltafw =  .Fecha			lxRepoelecPtoventa =  .Puntodeventa			lxRepoelecDesafip =  .Descargaafip			lxRepoelecDesaudi =  .Descargaauditoria			lxRepoelecFecddeafip =  .Fechadesdeafip			lxRepoelecTipodes =  .Tipodescargaauditoria			lxRepoelecFecddeaudi =  .Fechadesdeauditoria			lxRepoelecFechtaafip =  .Fechahastaafip			lxRepoelecFechtaaudi =  .Fechahastaauditoria			lxRepoelecRutaafip =  .Rutaafip			lxRepoelecNroddeaudi =  .Numerodesdeauditoria			lxRepoelecNrohtaaud =  .Numerohastaauditoria			lxRepoelecRutaaudi =  .Rutaauditoria			lxRepoelecObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRepoelecCodint = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REPOELEC ( "Fectrans","Fmodifw","Faltafw","Fecexpo","Fecimpo","Zadsfw","Numero","Haltafw","Horaexpo","Ualtafw","Horaimpo","Vmodifw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Bdaltafw","Bdmodifw","Esttrans","Codint","Ptoventa","Desafip","Desaudi","Fecddeafip","Tipodes","Fecddeaudi","Fechtaafip","Fechtaaudi","Rutaafip","Nroddeaudi","Nrohtaaud","Rutaaudi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxRepoelecFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecZadsfw ) + "'" >>, <<lxRepoelecNumero >>, <<"'" + this.FormatearTextoSql( lxRepoelecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecCodint ) + "'" >>, <<lxRepoelecPtoventa >>, <<iif( lxRepoelecDesafip, 1, 0 ) >>, <<iif( lxRepoelecDesaudi, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecddeafip ) + "'" >>, <<lxRepoelecTipodes >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecddeaudi ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFechtaafip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFechtaaudi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecRutaafip ) + "'" >>, <<lxRepoelecNroddeaudi >>, <<lxRepoelecNrohtaaud >>, <<"'" + this.FormatearTextoSql( lxRepoelecRutaaudi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODINT
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
			If this.ConsultarPorClaveCandidata()
				lcError  = 'El número a grabar ya existe. Cambie el último número del talonario correspondiente'
			endif
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.CODINT
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxRepoelecFectrans, lxRepoelecFmodifw, lxRepoelecFaltafw, lxRepoelecFecexpo, lxRepoelecFecimpo, lxRepoelecZadsfw, lxRepoelecNumero, lxRepoelecHaltafw, lxRepoelecHoraexpo, lxRepoelecUaltafw, lxRepoelecHoraimpo, lxRepoelecVmodifw, lxRepoelecZadsfw, lxRepoelecValtafw, lxRepoelecUmodifw, lxRepoelecSaltafw, lxRepoelecSmodifw, lxRepoelecHmodifw, lxRepoelecBdaltafw, lxRepoelecBdmodifw, lxRepoelecEsttrans, lxRepoelecCodint, lxRepoelecFaltafw, lxRepoelecPtoventa, lxRepoelecDesafip, lxRepoelecDesaudi, lxRepoelecFecddeafip, lxRepoelecTipodes, lxRepoelecFecddeaudi, lxRepoelecFechtaafip, lxRepoelecFechtaaudi, lxRepoelecRutaafip, lxRepoelecNroddeaudi, lxRepoelecNrohtaaud, lxRepoelecRutaaudi, lxRepoelecObs
				lxRepoelecFectrans =  .Fechatransferencia			lxRepoelecFmodifw =  .Fechamodificacionfw			lxRepoelecFaltafw =  .Fechaaltafw			lxRepoelecFecexpo =  .Fechaexpo			lxRepoelecFecimpo =  .Fechaimpo			lxRepoelecZadsfw =  .Acciones			lxRepoelecNumero =  .Numero			lxRepoelecHaltafw =  .Horaaltafw			lxRepoelecHoraexpo =  .Horaexpo			lxRepoelecUaltafw =  .Usuarioaltafw			lxRepoelecHoraimpo =  .Horaimpo			lxRepoelecVmodifw =  .Versionmodificacionfw			lxRepoelecZadsfw =  .Zadsfw			lxRepoelecValtafw =  .Versionaltafw			lxRepoelecUmodifw =  .Usuariomodificacionfw			lxRepoelecSaltafw =  .Seriealtafw			lxRepoelecSmodifw =  .Seriemodificacionfw			lxRepoelecHmodifw =  .Horamodificacionfw			lxRepoelecBdaltafw =  .Basededatosaltafw			lxRepoelecBdmodifw =  .Basededatosmodificacionfw			lxRepoelecEsttrans =  .Estadotransferencia			lxRepoelecCodint =  .Codint			lxRepoelecFaltafw =  .Fecha			lxRepoelecPtoventa =  .Puntodeventa			lxRepoelecDesafip =  .Descargaafip			lxRepoelecDesaudi =  .Descargaauditoria			lxRepoelecFecddeafip =  .Fechadesdeafip			lxRepoelecTipodes =  .Tipodescargaauditoria			lxRepoelecFecddeaudi =  .Fechadesdeauditoria			lxRepoelecFechtaafip =  .Fechahastaafip			lxRepoelecFechtaaudi =  .Fechahastaauditoria			lxRepoelecRutaafip =  .Rutaafip			lxRepoelecNroddeaudi =  .Numerodesdeauditoria			lxRepoelecNrohtaaud =  .Numerohastaauditoria			lxRepoelecRutaaudi =  .Rutaauditoria			lxRepoelecObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODINT
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.REPOELEC set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRepoelecFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRepoelecFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRepoelecFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRepoelecFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxRepoelecFecimpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRepoelecZadsfw ) + "'">>,"Numero" = <<lxRepoelecNumero>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRepoelecHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRepoelecHoraexpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRepoelecUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRepoelecHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRepoelecValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRepoelecSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRepoelecBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRepoelecEsttrans ) + "'">>,"Codint" = <<"'" + this.FormatearTextoSql( lxRepoelecCodint ) + "'">>,"Ptoventa" = <<lxRepoelecPtoventa>>,"Desafip" = <<iif( lxRepoelecDesafip, 1, 0 )>>,"Desaudi" = <<iif( lxRepoelecDesaudi, 1, 0 )>>,"Fecddeafip" = <<"'" + this.ConvertirDateSql( lxRepoelecFecddeafip ) + "'">>,"Tipodes" = <<lxRepoelecTipodes>>,"Fecddeaudi" = <<"'" + this.ConvertirDateSql( lxRepoelecFecddeaudi ) + "'">>,"Fechtaafip" = <<"'" + this.ConvertirDateSql( lxRepoelecFechtaafip ) + "'">>,"Fechtaaudi" = <<"'" + this.ConvertirDateSql( lxRepoelecFechtaaudi ) + "'">>,"Rutaafip" = <<"'" + this.FormatearTextoSql( lxRepoelecRutaafip ) + "'">>,"Nroddeaudi" = <<lxRepoelecNroddeaudi>>,"Nrohtaaud" = <<lxRepoelecNrohtaaud>>,"Rutaaudi" = <<"'" + this.FormatearTextoSql( lxRepoelecRutaaudi ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxRepoelecObs ) + "'">> where "Codint" = <<"'" + this.FormatearTextoSql( lxRepoelecCodint ) + "'">> and  REPOELEC.CODINT != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CodInt from ZooLogic.REPOELEC where " + this.ConvertirFuncionesSql( " REPOELEC.CODINT != ''" ) )
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
			Local lxRepoelecCodint
			lxRepoelecCodint = .Codint

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion" from ZooLogic.REPOELEC where "Codint" = <<"'" + this.FormatearTextoSql( lxRepoelecCodint ) + "'">> and  REPOELEC.CODINT != ''
			endtext
			use in select('c_REPORTEELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEELECTRONICO', set( 'Datasession' ) )

			if reccount( 'c_REPORTEELECTRONICO' ) = 0
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
			Local lxREPOELECNumero As Variant
			lxREPOELECNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion" from ZooLogic.REPOELEC where  REPOELEC.CODINT != '' And Numero = <<lxREPOELECNumero>>
			endtext
			use in select('c_REPORTEELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEELECTRONICO', set( 'Datasession' ) )
			if reccount( 'c_REPORTEELECTRONICO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRepoelecCodint as Variant
		llRetorno = .t.
		lxRepoelecCodint = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REPOELEC where "Codint" = <<"'" + this.FormatearTextoSql( lxRepoelecCodint ) + "'">> and  REPOELEC.CODINT != ''
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion" from ZooLogic.REPOELEC where  REPOELEC.CODINT != '' order by Numero
			endtext
			use in select('c_REPORTEELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEELECTRONICO', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion" from ZooLogic.REPOELEC where  str( Numero, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REPOELEC.CODINT != '' order by Numero
			endtext
			use in select('c_REPORTEELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEELECTRONICO', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion" from ZooLogic.REPOELEC where  str( Numero, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REPOELEC.CODINT != '' order by Numero desc
			endtext
			use in select('c_REPORTEELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEELECTRONICO', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion" from ZooLogic.REPOELEC where  REPOELEC.CODINT != '' order by Numero desc
			endtext
			use in select('c_REPORTEELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEELECTRONICO', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.CODINT ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fmodifw,Faltafw,Fecexpo,Fecimpo,Zadsfw,Numero,Haltafw,Horaexpo,Ualtafw,Horaimpo,Vmo" + ;
"difw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Bdaltafw,Bdmodifw,Esttrans,Codint,Ptoventa,Desafip,Desa" + ;
"udi,Fecddeafip,Tipodes,Fecddeaudi,Fechtaafip,Fechtaaudi,Rutaafip,Nroddeaudi,Nrohtaaud,Rutaaudi,Obs" + ;
" from ZooLogic.REPOELEC where  REPOELEC.CODINT != '' and " + lcFiltro )
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
			local  lxRepoelecFectrans, lxRepoelecFmodifw, lxRepoelecFaltafw, lxRepoelecFecexpo, lxRepoelecFecimpo, lxRepoelecZadsfw, lxRepoelecNumero, lxRepoelecHaltafw, lxRepoelecHoraexpo, lxRepoelecUaltafw, lxRepoelecHoraimpo, lxRepoelecVmodifw, lxRepoelecZadsfw, lxRepoelecValtafw, lxRepoelecUmodifw, lxRepoelecSaltafw, lxRepoelecSmodifw, lxRepoelecHmodifw, lxRepoelecBdaltafw, lxRepoelecBdmodifw, lxRepoelecEsttrans, lxRepoelecCodint, lxRepoelecFaltafw, lxRepoelecPtoventa, lxRepoelecDesafip, lxRepoelecDesaudi, lxRepoelecFecddeafip, lxRepoelecTipodes, lxRepoelecFecddeaudi, lxRepoelecFechtaafip, lxRepoelecFechtaaudi, lxRepoelecRutaafip, lxRepoelecNroddeaudi, lxRepoelecNrohtaaud, lxRepoelecRutaaudi, lxRepoelecObs
				lxRepoelecFectrans = ctod( '  /  /    ' )			lxRepoelecFmodifw = ctod( '  /  /    ' )			lxRepoelecFaltafw = ctod( '  /  /    ' )			lxRepoelecFecexpo = ctod( '  /  /    ' )			lxRepoelecFecimpo = ctod( '  /  /    ' )			lxRepoelecZadsfw = []			lxRepoelecNumero = 0			lxRepoelecHaltafw = []			lxRepoelecHoraexpo = []			lxRepoelecUaltafw = []			lxRepoelecHoraimpo = []			lxRepoelecVmodifw = []			lxRepoelecZadsfw = []			lxRepoelecValtafw = []			lxRepoelecUmodifw = []			lxRepoelecSaltafw = []			lxRepoelecSmodifw = []			lxRepoelecHmodifw = []			lxRepoelecBdaltafw = []			lxRepoelecBdmodifw = []			lxRepoelecEsttrans = []			lxRepoelecCodint = []			lxRepoelecFaltafw = ctod( '  /  /    ' )			lxRepoelecPtoventa = 0			lxRepoelecDesafip = .F.			lxRepoelecDesaudi = .F.			lxRepoelecFecddeafip = ctod( '  /  /    ' )			lxRepoelecTipodes = 0			lxRepoelecFecddeaudi = ctod( '  /  /    ' )			lxRepoelecFechtaafip = ctod( '  /  /    ' )			lxRepoelecFechtaaudi = ctod( '  /  /    ' )			lxRepoelecRutaafip = []			lxRepoelecNroddeaudi = 0			lxRepoelecNrohtaaud = 0			lxRepoelecRutaaudi = []			lxRepoelecObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REPOELEC where "CodInt" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODINT ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REPOELEC' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CodInt = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CodInt, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REPOELEC.CODINT != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REPOELEC', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'ACCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ACCIONES'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODINT'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'DESCARGAAFIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAFIP AS DESCARGAAFIP'
				Case lcAtributo == 'DESCARGAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUDI AS DESCARGAAUDITORIA'
				Case lcAtributo == 'FECHADESDEAFIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECDDEAFIP AS FECHADESDEAFIP'
				Case lcAtributo == 'TIPODESCARGAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODES AS TIPODESCARGAAUDITORIA'
				Case lcAtributo == 'FECHADESDEAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECDDEAUDI AS FECHADESDEAUDITORIA'
				Case lcAtributo == 'FECHAHASTAAFIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHTAAFIP AS FECHAHASTAAFIP'
				Case lcAtributo == 'FECHAHASTAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHTAAUDI AS FECHAHASTAAUDITORIA'
				Case lcAtributo == 'RUTAAFIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUTAAFIP AS RUTAAFIP'
				Case lcAtributo == 'NUMERODESDEAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODDEAUDI AS NUMERODESDEAUDITORIA'
				Case lcAtributo == 'NUMEROHASTAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROHTAAUD AS NUMEROHASTAAUDITORIA'
				Case lcAtributo == 'RUTAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUTAAUDI AS RUTAAUDITORIA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ACCIONES'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODINT'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCARGAAFIP'
				lcCampo = 'DESAFIP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCARGAAUDITORIA'
				lcCampo = 'DESAUDI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDEAFIP'
				lcCampo = 'FECDDEAFIP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODESCARGAAUDITORIA'
				lcCampo = 'TIPODES'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDEAUDITORIA'
				lcCampo = 'FECDDEAUDI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTAAFIP'
				lcCampo = 'FECHTAAFIP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTAAUDITORIA'
				lcCampo = 'FECHTAAUDI'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAAFIP'
				lcCampo = 'RUTAAFIP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODESDEAUDITORIA'
				lcCampo = 'NRODDEAUDI'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROHASTAAUDITORIA'
				lcCampo = 'NROHTAAUD'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAAUDITORIA'
				lcCampo = 'RUTAAUDI'
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
			local  lxRepoelecFectrans, lxRepoelecFmodifw, lxRepoelecFaltafw, lxRepoelecFecexpo, lxRepoelecFecimpo, lxRepoelecZadsfw, lxRepoelecNumero, lxRepoelecHaltafw, lxRepoelecHoraexpo, lxRepoelecUaltafw, lxRepoelecHoraimpo, lxRepoelecVmodifw, lxRepoelecZadsfw, lxRepoelecValtafw, lxRepoelecUmodifw, lxRepoelecSaltafw, lxRepoelecSmodifw, lxRepoelecHmodifw, lxRepoelecBdaltafw, lxRepoelecBdmodifw, lxRepoelecEsttrans, lxRepoelecCodint, lxRepoelecFaltafw, lxRepoelecPtoventa, lxRepoelecDesafip, lxRepoelecDesaudi, lxRepoelecFecddeafip, lxRepoelecTipodes, lxRepoelecFecddeaudi, lxRepoelecFechtaafip, lxRepoelecFechtaaudi, lxRepoelecRutaafip, lxRepoelecNroddeaudi, lxRepoelecNrohtaaud, lxRepoelecRutaaudi, lxRepoelecObs
				lxRepoelecFectrans =  .Fechatransferencia			lxRepoelecFmodifw =  .Fechamodificacionfw			lxRepoelecFaltafw =  .Fechaaltafw			lxRepoelecFecexpo =  .Fechaexpo			lxRepoelecFecimpo =  .Fechaimpo			lxRepoelecZadsfw =  .Acciones			lxRepoelecNumero =  .Numero			lxRepoelecHaltafw =  .Horaaltafw			lxRepoelecHoraexpo =  .Horaexpo			lxRepoelecUaltafw =  .Usuarioaltafw			lxRepoelecHoraimpo =  .Horaimpo			lxRepoelecVmodifw =  .Versionmodificacionfw			lxRepoelecZadsfw =  .Zadsfw			lxRepoelecValtafw =  .Versionaltafw			lxRepoelecUmodifw =  .Usuariomodificacionfw			lxRepoelecSaltafw =  .Seriealtafw			lxRepoelecSmodifw =  .Seriemodificacionfw			lxRepoelecHmodifw =  .Horamodificacionfw			lxRepoelecBdaltafw =  .Basededatosaltafw			lxRepoelecBdmodifw =  .Basededatosmodificacionfw			lxRepoelecEsttrans =  .Estadotransferencia			lxRepoelecCodint =  .Codint			lxRepoelecFaltafw =  .Fecha			lxRepoelecPtoventa =  .Puntodeventa			lxRepoelecDesafip =  .Descargaafip			lxRepoelecDesaudi =  .Descargaauditoria			lxRepoelecFecddeafip =  .Fechadesdeafip			lxRepoelecTipodes =  .Tipodescargaauditoria			lxRepoelecFecddeaudi =  .Fechadesdeauditoria			lxRepoelecFechtaafip =  .Fechahastaafip			lxRepoelecFechtaaudi =  .Fechahastaauditoria			lxRepoelecRutaafip =  .Rutaafip			lxRepoelecNroddeaudi =  .Numerodesdeauditoria			lxRepoelecNrohtaaud =  .Numerohastaauditoria			lxRepoelecRutaaudi =  .Rutaauditoria			lxRepoelecObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REPOELEC ( "Fectrans","Fmodifw","Faltafw","Fecexpo","Fecimpo","Zadsfw","Numero","Haltafw","Horaexpo","Ualtafw","Horaimpo","Vmodifw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Bdaltafw","Bdmodifw","Esttrans","Codint","Ptoventa","Desafip","Desaudi","Fecddeafip","Tipodes","Fecddeaudi","Fechtaafip","Fechtaaudi","Rutaafip","Nroddeaudi","Nrohtaaud","Rutaaudi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxRepoelecFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecZadsfw ) + "'" >>, <<lxRepoelecNumero >>, <<"'" + this.FormatearTextoSql( lxRepoelecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecCodint ) + "'" >>, <<lxRepoelecPtoventa >>, <<iif( lxRepoelecDesafip, 1, 0 ) >>, <<iif( lxRepoelecDesaudi, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecddeafip ) + "'" >>, <<lxRepoelecTipodes >>, <<"'" + this.ConvertirDateSql( lxRepoelecFecddeaudi ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFechtaafip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepoelecFechtaaudi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecRutaafip ) + "'" >>, <<lxRepoelecNroddeaudi >>, <<lxRepoelecNrohtaaud >>, <<"'" + this.FormatearTextoSql( lxRepoelecRutaaudi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepoelecObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'REPOELEC' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxRepoelecFectrans, lxRepoelecFmodifw, lxRepoelecFaltafw, lxRepoelecFecexpo, lxRepoelecFecimpo, lxRepoelecZadsfw, lxRepoelecNumero, lxRepoelecHaltafw, lxRepoelecHoraexpo, lxRepoelecUaltafw, lxRepoelecHoraimpo, lxRepoelecVmodifw, lxRepoelecZadsfw, lxRepoelecValtafw, lxRepoelecUmodifw, lxRepoelecSaltafw, lxRepoelecSmodifw, lxRepoelecHmodifw, lxRepoelecBdaltafw, lxRepoelecBdmodifw, lxRepoelecEsttrans, lxRepoelecCodint, lxRepoelecFaltafw, lxRepoelecPtoventa, lxRepoelecDesafip, lxRepoelecDesaudi, lxRepoelecFecddeafip, lxRepoelecTipodes, lxRepoelecFecddeaudi, lxRepoelecFechtaafip, lxRepoelecFechtaaudi, lxRepoelecRutaafip, lxRepoelecNroddeaudi, lxRepoelecNrohtaaud, lxRepoelecRutaaudi, lxRepoelecObs
				lxRepoelecFectrans =  .Fechatransferencia			lxRepoelecFmodifw =  .Fechamodificacionfw			lxRepoelecFaltafw =  .Fechaaltafw			lxRepoelecFecexpo =  .Fechaexpo			lxRepoelecFecimpo =  .Fechaimpo			lxRepoelecZadsfw =  .Acciones			lxRepoelecNumero =  .Numero			lxRepoelecHaltafw =  .Horaaltafw			lxRepoelecHoraexpo =  .Horaexpo			lxRepoelecUaltafw =  .Usuarioaltafw			lxRepoelecHoraimpo =  .Horaimpo			lxRepoelecVmodifw =  .Versionmodificacionfw			lxRepoelecZadsfw =  .Zadsfw			lxRepoelecValtafw =  .Versionaltafw			lxRepoelecUmodifw =  .Usuariomodificacionfw			lxRepoelecSaltafw =  .Seriealtafw			lxRepoelecSmodifw =  .Seriemodificacionfw			lxRepoelecHmodifw =  .Horamodificacionfw			lxRepoelecBdaltafw =  .Basededatosaltafw			lxRepoelecBdmodifw =  .Basededatosmodificacionfw			lxRepoelecEsttrans =  .Estadotransferencia			lxRepoelecCodint =  .Codint			lxRepoelecFaltafw =  .Fecha			lxRepoelecPtoventa =  .Puntodeventa			lxRepoelecDesafip =  .Descargaafip			lxRepoelecDesaudi =  .Descargaauditoria			lxRepoelecFecddeafip =  .Fechadesdeafip			lxRepoelecTipodes =  .Tipodescargaauditoria			lxRepoelecFecddeaudi =  .Fechadesdeauditoria			lxRepoelecFechtaafip =  .Fechahastaafip			lxRepoelecFechtaaudi =  .Fechahastaauditoria			lxRepoelecRutaafip =  .Rutaafip			lxRepoelecNroddeaudi =  .Numerodesdeauditoria			lxRepoelecNrohtaaud =  .Numerohastaauditoria			lxRepoelecRutaaudi =  .Rutaauditoria			lxRepoelecObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  REPOELEC.CODINT != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.REPOELEC set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRepoelecFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRepoelecFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRepoelecFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRepoelecFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRepoelecFecimpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRepoelecZadsfw ) + "'">>, "Numero" = <<lxRepoelecNumero>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRepoelecHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRepoelecHoraexpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRepoelecUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRepoelecHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRepoelecValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRepoelecSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRepoelecBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRepoelecBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRepoelecEsttrans ) + "'">>, "Codint" = <<"'" + this.FormatearTextoSql( lxRepoelecCodint ) + "'">>, "Ptoventa" = <<lxRepoelecPtoventa>>, "Desafip" = <<iif( lxRepoelecDesafip, 1, 0 )>>, "Desaudi" = <<iif( lxRepoelecDesaudi, 1, 0 )>>, "Fecddeafip" = <<"'" + this.ConvertirDateSql( lxRepoelecFecddeafip ) + "'">>, "Tipodes" = <<lxRepoelecTipodes>>, "Fecddeaudi" = <<"'" + this.ConvertirDateSql( lxRepoelecFecddeaudi ) + "'">>, "Fechtaafip" = <<"'" + this.ConvertirDateSql( lxRepoelecFechtaafip ) + "'">>, "Fechtaaudi" = <<"'" + this.ConvertirDateSql( lxRepoelecFechtaaudi ) + "'">>, "Rutaafip" = <<"'" + this.FormatearTextoSql( lxRepoelecRutaafip ) + "'">>, "Nroddeaudi" = <<lxRepoelecNroddeaudi>>, "Nrohtaaud" = <<lxRepoelecNrohtaaud>>, "Rutaaudi" = <<"'" + this.FormatearTextoSql( lxRepoelecRutaaudi ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxRepoelecObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REPOELEC' 
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
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  REPOELEC.CODINT != '']
		loColeccion.Agregar( 'delete from ZooLogic.REPOELEC where ' + lcFiltro )
			loColeccion.cTabla = 'REPOELEC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REPOELEC where  REPOELEC.CODINT != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REPOELEC where CodInt = " + "'" + this.FormatearTextoSql( this.oEntidad.CODINT ) + "'"+ " and  REPOELEC.CODINT != ''" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMERO') ) and iif( type( '.NUMERO' ) = 'C', int( val( .NUMERO ) ),.NUMERO ) = .oNumeraciones.UltimoNumero( 'NUMERO' )
						.oNumeraciones.Actualizar( 'NUMERO' )
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
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxREPOELECNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEELECTRONICO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REPOELEC Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CodInt
				if lxValorClavePK == curSeek.CodInt or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CodInt and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CodInt
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.REPOELEC set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'"+ [, FAltaFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'"+ [, PtoVenta = ] + transform( &lcCursor..PtoVenta )+ [, DesAFIP = ] + Transform( iif( &lcCursor..DesAFIP, 1, 0 ))+ [, DesAudi = ] + Transform( iif( &lcCursor..DesAudi, 1, 0 ))+ [, FecDdeAFIP = ] + "'" + this.ConvertirDateSql( &lcCursor..FecDdeAFIP ) + "'"+ [, TipoDes = ] + transform( &lcCursor..TipoDes )+ [, FecDdeAudi = ] + "'" + this.ConvertirDateSql( &lcCursor..FecDdeAudi ) + "'"+ [, FecHtaAFIP = ] + "'" + this.ConvertirDateSql( &lcCursor..FecHtaAFIP ) + "'"+ [, FecHtaAudi = ] + "'" + this.ConvertirDateSql( &lcCursor..FecHtaAudi ) + "'"+ [, RutaAFIP = ] + "'" + this.FormatearTextoSql( &lcCursor..RutaAFIP ) + "'"+ [, NroDdeAudi = ] + transform( &lcCursor..NroDdeAudi )+ [, NroHtaAud = ] + transform( &lcCursor..NroHtaAud )+ [, RutaAudi = ] + "'" + this.FormatearTextoSql( &lcCursor..RutaAudi ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where CodInt = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.REPOELEC Where CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FMODIFW, FALTAFW, FECEXPO, FECIMPO, ZADSFW, Numero, HALTAFW, HORAEXPO, UALTAFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SALTAFW, SMODIFW, HMODIFW, BDALTAFW, BDMODIFW, ESTTRANS, CodInt, FAltaFW, PtoVenta, DesAFIP, DesAudi, FecDdeAFIP, TipoDes, FecDdeAudi, FecHtaAFIP, FecHtaAudi, RutaAFIP, NroDdeAudi, NroHtaAud, RutaAudi, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + transform( &lcCursor..Numero )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + transform( &lcCursor..PtoVenta ) + ',' + Transform( iif( &lcCursor..DesAFIP, 1, 0 )) + ',' + Transform( iif( &lcCursor..DesAudi, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecDdeAFIP ) + "'" + ',' + transform( &lcCursor..TipoDes ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecDdeAudi ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecHtaAFIP ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecHtaAudi ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RutaAFIP ) + "'" + ',' + transform( &lcCursor..NroDdeAudi ) + ',' + transform( &lcCursor..NroHtaAud ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..RutaAudi ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.REPOELEC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEELECTRONICO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CodInt C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REPORTEELECTRONICO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REPORTEELECTRONICO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REPORTEELECTRONICO_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_REPOELEC')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REPORTEELECTRONICO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CodInt
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REPORTEELECTRONICO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEELECTRONICO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CodInt as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CodInt, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEELECTRONICO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FecDdeAFIP
		* Validar ANTERIORES A 1/1/1753  FecDdeAudi
		* Validar ANTERIORES A 1/1/1753  FecHtaAFIP
		* Validar ANTERIORES A 1/1/1753  FecHtaAudi
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_REPOELEC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_REPOELEC
Create Table ZooLogic.TablaTrabajo_REPOELEC ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"zadsfw" varchar(max)  null, 
"numero" numeric( 8, 0 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codint" char( 38 )  null, 
"faltafw" datetime  null, 
"ptoventa" numeric( 4, 0 )  null, 
"desafip" bit  null, 
"desaudi" bit  null, 
"fecddeafip" datetime  null, 
"tipodes" numeric( 1, 0 )  null, 
"fecddeaudi" datetime  null, 
"fechtaafip" datetime  null, 
"fechtaaudi" datetime  null, 
"rutaafip" char( 254 )  null, 
"nroddeaudi" numeric( 8, 0 )  null, 
"nrohtaaud" numeric( 8, 0 )  null, 
"rutaaudi" char( 254 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_REPOELEC' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_REPOELEC' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEELECTRONICO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codint','codint')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('desafip','desafip')
			.AgregarMapeo('desaudi','desaudi')
			.AgregarMapeo('fecddeafip','fecddeafip')
			.AgregarMapeo('tipodes','tipodes')
			.AgregarMapeo('fecddeaudi','fecddeaudi')
			.AgregarMapeo('fechtaafip','fechtaafip')
			.AgregarMapeo('fechtaaudi','fechtaaudi')
			.AgregarMapeo('rutaafip','rutaafip')
			.AgregarMapeo('nroddeaudi','nroddeaudi')
			.AgregarMapeo('nrohtaaud','nrohtaaud')
			.AgregarMapeo('rutaaudi','rutaaudi')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_REPOELEC'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODINT = isnull( d.CODINT, t.CODINT ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.DESAFIP = isnull( d.DESAFIP, t.DESAFIP ),t.DESAUDI = isnull( d.DESAUDI, t.DESAUDI ),t.FECDDEAFIP = isnull( d.FECDDEAFIP, t.FECDDEAFIP ),t.TIPODES = isnull( d.TIPODES, t.TIPODES ),t.FECDDEAUDI = isnull( d.FECDDEAUDI, t.FECDDEAUDI ),t.FECHTAAFIP = isnull( d.FECHTAAFIP, t.FECHTAAFIP ),t.FECHTAAUDI = isnull( d.FECHTAAUDI, t.FECHTAAUDI ),t.RUTAAFIP = isnull( d.RUTAAFIP, t.RUTAAFIP ),t.NRODDEAUDI = isnull( d.NRODDEAUDI, t.NRODDEAUDI ),t.NROHTAAUD = isnull( d.NROHTAAUD, t.NROHTAAUD ),t.RUTAAUDI = isnull( d.RUTAAUDI, t.RUTAAUDI ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.REPOELEC t inner join deleted d 
							 on t.CodInt = d.CodInt
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.REPOELEC(Fectrans,Fmodifw,Faltafw,Fecexpo,Fecimpo,Zadsfw,Numero,Haltafw,Horaexpo,Ualtafw,Horaimpo,Vmodifw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Bdaltafw,Bdmodifw,Esttrans,Codint,Ptoventa,Desafip,Desaudi,Fecddeafip,Tipodes,Fecddeaudi,Fechtaafip,Fechtaaudi,Rutaafip,Nroddeaudi,Nrohtaaud,Rutaaudi,Obs)
					Select isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.ZADSFW,''),isnull( d.NUMERO,0),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.CODINT,''),isnull( d.PTOVENTA,0),isnull( d.DESAFIP,0),isnull( d.DESAUDI,0),isnull( d.FECDDEAFIP,''),isnull( d.TIPODES,0),isnull( d.FECDDEAUDI,''),isnull( d.FECHTAAFIP,''),isnull( d.FECHTAAUDI,''),isnull( d.RUTAAFIP,''),isnull( d.NRODDEAUDI,0),isnull( d.NROHTAAUD,0),isnull( d.RUTAAUDI,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.REPOELEC pk 
							 on d.CodInt = pk.CodInt
						 left join ZooLogic.REPOELEC cc 
							 on  d.Numero = cc.Numero
						Where pk.CodInt Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.REPOELEC t inner join deleted d 
							on   t.Numero = d.Numero
						left join deleted h 
							 on t.CodInt = h.CodInt
							 where h.CodInt is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.REPOELEC t inner join deleted d 
							 on t.CodInt = d.CodInt
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_REPOELEC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_REPOELEC
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REPORTEELECTRONICO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechaimpo, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Acciones')
					.Acciones = lcValor 
					.Numero = nvl( c_REPORTEELECTRONICO.Numero, 0 )
					.Horaaltafw = nvl( c_REPORTEELECTRONICO.Horaaltafw, [] )
					.Horaexpo = nvl( c_REPORTEELECTRONICO.Horaexpo, [] )
					.Usuarioaltafw = nvl( c_REPORTEELECTRONICO.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_REPORTEELECTRONICO.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_REPORTEELECTRONICO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_REPORTEELECTRONICO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_REPORTEELECTRONICO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_REPORTEELECTRONICO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_REPORTEELECTRONICO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_REPORTEELECTRONICO.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_REPORTEELECTRONICO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_REPORTEELECTRONICO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_REPORTEELECTRONICO.Estadotransferencia, [] )
					.Codint = nvl( c_REPORTEELECTRONICO.Codint, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fecha, ctod( '  /  /    ' ) ) )
					.Puntodeventa = nvl( c_REPORTEELECTRONICO.Puntodeventa, 0 )
					.Descargaafip = nvl( c_REPORTEELECTRONICO.Descargaafip, .F. )
					.Descargaauditoria = nvl( c_REPORTEELECTRONICO.Descargaauditoria, .F. )
					.Fechadesdeafip = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechadesdeafip, ctod( '  /  /    ' ) ) )
					.Tipodescargaauditoria = nvl( c_REPORTEELECTRONICO.Tipodescargaauditoria, 0 )
					.Fechadesdeauditoria = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechadesdeauditoria, ctod( '  /  /    ' ) ) )
					.Fechahastaafip = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechahastaafip, ctod( '  /  /    ' ) ) )
					.Fechahastaauditoria = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEELECTRONICO.Fechahastaauditoria, ctod( '  /  /    ' ) ) )
					.Rutaafip = nvl( c_REPORTEELECTRONICO.Rutaafip, [] )
					.Numerodesdeauditoria = nvl( c_REPORTEELECTRONICO.Numerodesdeauditoria, 0 )
					.Numerohastaauditoria = nvl( c_REPORTEELECTRONICO.Numerohastaauditoria, 0 )
					.Rutaauditoria = nvl( c_REPORTEELECTRONICO.Rutaauditoria, [] )
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
			lxRetorno = c_REPORTEELECTRONICO.CODINT
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
		return c_REPORTEELECTRONICO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.REPOELEC' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodInt"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CodInt as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CodInt from (
							select * 
								from ZooLogic.REPOELEC 
								Where   REPOELEC.CODINT != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REPOELEC", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodInt"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Acciones", "Numero" as "Numero", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Codint" as "Codint", "Faltafw" as "Fecha", "Ptoventa" as "Puntodeventa", "Desafip" as "Descargaafip", "Desaudi" as "Descargaauditoria", "Fecddeafip" as "Fechadesdeafip", "Tipodes" as "Tipodescargaauditoria", "Fecddeaudi" as "Fechadesdeauditoria", "Fechtaafip" as "Fechahastaafip", "Fechtaaudi" as "Fechahastaauditoria", "Rutaafip" as "Rutaafip", "Nroddeaudi" as "Numerodesdeauditoria", "Nrohtaaud" as "Numerohastaauditoria", "Rutaaudi" as "Rutaauditoria", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REPOELEC 
								Where   REPOELEC.CODINT != ''
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
	Tabla = 'REPOELEC'
	Filtro = " REPOELEC.CODINT != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REPOELEC.CODINT != ''"
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
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHATRANSFERENCIA                      " tabla="REPOELEC       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHAMODIFICACIONFW                     " tabla="REPOELEC       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHAALTAFW                             " tabla="REPOELEC       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHAEXPO                               " tabla="REPOELEC       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHAIMPO                               " tabla="REPOELEC       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="ACCIONES                                " tabla="REPOELEC       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Acciones del sistema                                                                                                                                            " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="NUMERO                                  " tabla="REPOELEC       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="HORAALTAFW                              " tabla="REPOELEC       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="HORAEXPO                                " tabla="REPOELEC       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="USUARIOALTAFW                           " tabla="REPOELEC       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="HORAIMPO                                " tabla="REPOELEC       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="VERSIONMODIFICACIONFW                   " tabla="REPOELEC       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="ZADSFW                                  " tabla="REPOELEC       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="VERSIONALTAFW                           " tabla="REPOELEC       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="USUARIOMODIFICACIONFW                   " tabla="REPOELEC       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="SERIEALTAFW                             " tabla="REPOELEC       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="SERIEMODIFICACIONFW                     " tabla="REPOELEC       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="HORAMODIFICACIONFW                      " tabla="REPOELEC       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="BASEDEDATOSALTAFW                       " tabla="REPOELEC       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REPOELEC       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="ESTADOTRANSFERENCIA                     " tabla="REPOELEC       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="CODINT                                  " tabla="REPOELEC       " campo="CODINT    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHA                                   " tabla="REPOELEC       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="201" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="PUNTODEVENTA                            " tabla="REPOELEC       " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.Felino.ControladoresFiscales.PuntoDeVenta                                                                                                                                                                                             " obligatorio="false" admitebusqueda="202" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="DESCARGAAFIP                            " tabla="REPOELEC       " campo="DESAFIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="203" etiqueta="Descargar                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="DESCARGAAUDITORIA                       " tabla="REPOELEC       " campo="DESAUDI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="204" etiqueta="Descargar para auditoría                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHADESDEAFIP                          " tabla="REPOELEC       " campo="FECDDEAFIP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Fecha desde                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="TIPODESCARGAAUDITORIA                   " tabla="REPOELEC       " campo="TIPODES   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Tipo de descarga                                                                                                                                                " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHADESDEAUDITORIA                     " tabla="REPOELEC       " campo="FECDDEAUDI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="Fecha desde para auditoría                                                                                                                                      " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHAHASTAAFIP                          " tabla="REPOELEC       " campo="FECHTAAFIP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="Fecha hasta                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="FECHAHASTAAUDITORIA                     " tabla="REPOELEC       " campo="FECHTAAUDI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="Fecha hasta para auditoría                                                                                                                                      " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="RUTAAFIP                                " tabla="REPOELEC       " campo="RUTAAFIP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="Ruta para envío                                                                                                                                                 " dominio="DIRECTORIO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="NUMERODESDEAUDITORIA                    " tabla="REPOELEC       " campo="NRODDEAUDI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="211" etiqueta="Número desde                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="NUMEROHASTAAUDITORIA                    " tabla="REPOELEC       " campo="NROHTAAUD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="212" etiqueta="Número hasta                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="RUTAAUDITORIA                           " tabla="REPOELEC       " campo="RUTAAUDI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="213" etiqueta="Ruta para auditoría                                                                                                                                             " dominio="DIRECTORIO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEELECTRONICO                      " atributo="OBSERVACION                             " tabla="REPOELEC       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="214" etiqueta="Obs.                                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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