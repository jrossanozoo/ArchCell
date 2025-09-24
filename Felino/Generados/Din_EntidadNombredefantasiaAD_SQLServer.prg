
define class Din_EntidadNOMBREDEFANTASIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_NOMBREDEFANTASIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_NFAPK'
	cTablaPrincipal = 'NOMFANT'
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
			local  lxNomfantFecexpo, lxNomfantFmodifw, lxNomfantFecimpo, lxNomfantFaltafw, lxNomfantFectrans, lxNomfantUaltafw, lxNomfantSaltafw, lxNomfantSmodifw, lxNomfantUmodifw, lxNomfantZadsfw, lxNomfantValtafw, lxNomfantVmodifw, lxNomfantHmodifw, lxNomfantHoraexpo, lxNomfantHoraimpo, lxNomfantEsttrans, lxNomfantHaltafw, lxNomfantBdaltafw, lxNomfantBdmodifw, lxNomfantNfcod, lxNomfantNfobs, lxNomfantNfnomf
				lxNomfantFecexpo =  .Fechaexpo			lxNomfantFmodifw =  .Fechamodificacionfw			lxNomfantFecimpo =  .Fechaimpo			lxNomfantFaltafw =  .Fechaaltafw			lxNomfantFectrans =  .Fechatransferencia			lxNomfantUaltafw =  .Usuarioaltafw			lxNomfantSaltafw =  .Seriealtafw			lxNomfantSmodifw =  .Seriemodificacionfw			lxNomfantUmodifw =  .Usuariomodificacionfw			lxNomfantZadsfw =  .Zadsfw			lxNomfantValtafw =  .Versionaltafw			lxNomfantVmodifw =  .Versionmodificacionfw			lxNomfantHmodifw =  .Horamodificacionfw			lxNomfantHoraexpo =  .Horaexpo			lxNomfantHoraimpo =  .Horaimpo			lxNomfantEsttrans =  .Estadotransferencia			lxNomfantHaltafw =  .Horaaltafw			lxNomfantBdaltafw =  .Basededatosaltafw			lxNomfantBdmodifw =  .Basededatosmodificacionfw			lxNomfantNfcod =  .Codigo			lxNomfantNfobs =  .Observacion			lxNomfantNfnomf =  .Nombrefantasia
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxNomfantNfcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.NOMFANT ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Ualtafw","Saltafw","Smodifw","Umodifw","Zadsfw","Valtafw","Vmodifw","Hmodifw","Horaexpo","Horaimpo","Esttrans","Haltafw","Bdaltafw","Bdmodifw","Nfcod","Nfobs","Nfnomf" ) values ( <<"'" + this.ConvertirDateSql( lxNomfantFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantNfcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantNfobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantNfnomf ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RazonSocial
				if this.oEntidad.RazonSocial.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RAZSOC("NROITEM","RZCOD" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
			local  lxNomfantFecexpo, lxNomfantFmodifw, lxNomfantFecimpo, lxNomfantFaltafw, lxNomfantFectrans, lxNomfantUaltafw, lxNomfantSaltafw, lxNomfantSmodifw, lxNomfantUmodifw, lxNomfantZadsfw, lxNomfantValtafw, lxNomfantVmodifw, lxNomfantHmodifw, lxNomfantHoraexpo, lxNomfantHoraimpo, lxNomfantEsttrans, lxNomfantHaltafw, lxNomfantBdaltafw, lxNomfantBdmodifw, lxNomfantNfcod, lxNomfantNfobs, lxNomfantNfnomf
				lxNomfantFecexpo =  .Fechaexpo			lxNomfantFmodifw =  .Fechamodificacionfw			lxNomfantFecimpo =  .Fechaimpo			lxNomfantFaltafw =  .Fechaaltafw			lxNomfantFectrans =  .Fechatransferencia			lxNomfantUaltafw =  .Usuarioaltafw			lxNomfantSaltafw =  .Seriealtafw			lxNomfantSmodifw =  .Seriemodificacionfw			lxNomfantUmodifw =  .Usuariomodificacionfw			lxNomfantZadsfw =  .Zadsfw			lxNomfantValtafw =  .Versionaltafw			lxNomfantVmodifw =  .Versionmodificacionfw			lxNomfantHmodifw =  .Horamodificacionfw			lxNomfantHoraexpo =  .Horaexpo			lxNomfantHoraimpo =  .Horaimpo			lxNomfantEsttrans =  .Estadotransferencia			lxNomfantHaltafw =  .Horaaltafw			lxNomfantBdaltafw =  .Basededatosaltafw			lxNomfantBdmodifw =  .Basededatosmodificacionfw			lxNomfantNfcod =  .Codigo			lxNomfantNfobs =  .Observacion			lxNomfantNfnomf =  .Nombrefantasia
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.NOMFANT set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxNomfantFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxNomfantFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxNomfantFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxNomfantFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxNomfantFectrans ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxNomfantUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxNomfantSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxNomfantSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxNomfantUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxNomfantZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxNomfantValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxNomfantVmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxNomfantHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxNomfantHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxNomfantHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxNomfantEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxNomfantHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxNomfantBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxNomfantBdmodifw ) + "'">>,"Nfcod" = <<"'" + this.FormatearTextoSql( lxNomfantNfcod ) + "'">>,"Nfobs" = <<"'" + this.FormatearTextoSql( lxNomfantNfobs ) + "'">>,"Nfnomf" = <<"'" + this.FormatearTextoSql( lxNomfantNfnomf ) + "'">> where "Nfcod" = <<"'" + this.FormatearTextoSql( lxNomfantNfcod ) + "'">> and  NOMFANT.NFCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RAZSOC where "RZCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RazonSocial
				if this.oEntidad.RazonSocial.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RAZSOC("NROITEM","RZCOD" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NFCOD from ZooLogic.NOMFANT where " + this.ConvertirFuncionesSql( " NOMFANT.NFCOD != ''" ) )
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
			Local lxNomfantNfcod
			lxNomfantNfcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nfcod" as "Codigo", "Nfobs" as "Observacion", "Nfnomf" as "Nombrefantasia" from ZooLogic.NOMFANT where "Nfcod" = <<"'" + this.FormatearTextoSql( lxNomfantNfcod ) + "'">> and  NOMFANT.NFCOD != ''
			endtext
			use in select('c_NOMBREDEFANTASIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMBREDEFANTASIA', set( 'Datasession' ) )

			if reccount( 'c_NOMBREDEFANTASIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Rzcod" as "Codigo" from ZooLogic.RAZSOC where RZCOD = <<"'" + this.FormatearTextoSql( c_NOMBREDEFANTASIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RazonSocial')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RazonSocial', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RazonSocial
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxNomfantNfcod as Variant
		llRetorno = .t.
		lxNomfantNfcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.NOMFANT where "Nfcod" = <<"'" + this.FormatearTextoSql( lxNomfantNfcod ) + "'">> and  NOMFANT.NFCOD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nfcod" as "Codigo", "Nfobs" as "Observacion", "Nfnomf" as "Nombrefantasia" from ZooLogic.NOMFANT where  NOMFANT.NFCOD != '' order by NFCOD
			endtext
			use in select('c_NOMBREDEFANTASIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMBREDEFANTASIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Rzcod" as "Codigo" from ZooLogic.RAZSOC where RZCOD = <<"'" + this.FormatearTextoSql( c_NOMBREDEFANTASIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RazonSocial')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RazonSocial', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RazonSocial
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nfcod" as "Codigo", "Nfobs" as "Observacion", "Nfnomf" as "Nombrefantasia" from ZooLogic.NOMFANT where  funciones.padr( NFCOD, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  NOMFANT.NFCOD != '' order by NFCOD
			endtext
			use in select('c_NOMBREDEFANTASIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMBREDEFANTASIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Rzcod" as "Codigo" from ZooLogic.RAZSOC where RZCOD = <<"'" + this.FormatearTextoSql( c_NOMBREDEFANTASIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RazonSocial')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RazonSocial', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RazonSocial
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nfcod" as "Codigo", "Nfobs" as "Observacion", "Nfnomf" as "Nombrefantasia" from ZooLogic.NOMFANT where  funciones.padr( NFCOD, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  NOMFANT.NFCOD != '' order by NFCOD desc
			endtext
			use in select('c_NOMBREDEFANTASIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMBREDEFANTASIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Rzcod" as "Codigo" from ZooLogic.RAZSOC where RZCOD = <<"'" + this.FormatearTextoSql( c_NOMBREDEFANTASIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RazonSocial')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RazonSocial', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RazonSocial
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nfcod" as "Codigo", "Nfobs" as "Observacion", "Nfnomf" as "Nombrefantasia" from ZooLogic.NOMFANT where  NOMFANT.NFCOD != '' order by NFCOD desc
			endtext
			use in select('c_NOMBREDEFANTASIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOMBREDEFANTASIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Rzcod" as "Codigo" from ZooLogic.RAZSOC where RZCOD = <<"'" + this.FormatearTextoSql( c_NOMBREDEFANTASIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RazonSocial')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RazonSocial', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RazonSocial
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Ualtafw,Saltafw,Smodifw,Umodifw,Zadsfw,Valtafw,Vmod" + ;
"ifw,Hmodifw,Horaexpo,Horaimpo,Esttrans,Haltafw,Bdaltafw,Bdmodifw,Nfcod,Nfobs,Nfnomf" + ;
" from ZooLogic.NOMFANT where  NOMFANT.NFCOD != '' and " + lcFiltro )
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
			local  lxNomfantFecexpo, lxNomfantFmodifw, lxNomfantFecimpo, lxNomfantFaltafw, lxNomfantFectrans, lxNomfantUaltafw, lxNomfantSaltafw, lxNomfantSmodifw, lxNomfantUmodifw, lxNomfantZadsfw, lxNomfantValtafw, lxNomfantVmodifw, lxNomfantHmodifw, lxNomfantHoraexpo, lxNomfantHoraimpo, lxNomfantEsttrans, lxNomfantHaltafw, lxNomfantBdaltafw, lxNomfantBdmodifw, lxNomfantNfcod, lxNomfantNfobs, lxNomfantNfnomf
				lxNomfantFecexpo = ctod( '  /  /    ' )			lxNomfantFmodifw = ctod( '  /  /    ' )			lxNomfantFecimpo = ctod( '  /  /    ' )			lxNomfantFaltafw = ctod( '  /  /    ' )			lxNomfantFectrans = ctod( '  /  /    ' )			lxNomfantUaltafw = []			lxNomfantSaltafw = []			lxNomfantSmodifw = []			lxNomfantUmodifw = []			lxNomfantZadsfw = []			lxNomfantValtafw = []			lxNomfantVmodifw = []			lxNomfantHmodifw = []			lxNomfantHoraexpo = []			lxNomfantHoraimpo = []			lxNomfantEsttrans = []			lxNomfantHaltafw = []			lxNomfantBdaltafw = []			lxNomfantBdmodifw = []			lxNomfantNfcod = []			lxNomfantNfobs = []			lxNomfantNfnomf = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RAZSOC where "RZCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.NOMFANT where "NFCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'NOMFANT' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NFCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NFCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  NOMFANT.NFCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nfcod" as "Codigo", "Nfobs" as "Observacion", "Nfnomf" as "Nombrefantasia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'NOMFANT', '', tnTope )
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
	Function ObtenerDatosDetalleRazonSocial( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  RAZSOC.RZCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Rzcod" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleRazonSocial( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'RAZSOC', 'RazonSocial', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleRazonSocial( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleRazonSocial( lcAtributo )
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
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
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
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NFCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NFOBS AS OBSERVACION'
				Case lcAtributo == 'NOMBREFANTASIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NFNOMF AS NOMBREFANTASIA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleRazonSocial( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RZCOD AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'NFCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'NFOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREFANTASIA'
				lcCampo = 'NFNOMF'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleRazonSocial( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'RZCOD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'RAZONSOCIAL'
			lcRetorno = 'RAZSOC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxNomfantFecexpo, lxNomfantFmodifw, lxNomfantFecimpo, lxNomfantFaltafw, lxNomfantFectrans, lxNomfantUaltafw, lxNomfantSaltafw, lxNomfantSmodifw, lxNomfantUmodifw, lxNomfantZadsfw, lxNomfantValtafw, lxNomfantVmodifw, lxNomfantHmodifw, lxNomfantHoraexpo, lxNomfantHoraimpo, lxNomfantEsttrans, lxNomfantHaltafw, lxNomfantBdaltafw, lxNomfantBdmodifw, lxNomfantNfcod, lxNomfantNfobs, lxNomfantNfnomf
				lxNomfantFecexpo =  .Fechaexpo			lxNomfantFmodifw =  .Fechamodificacionfw			lxNomfantFecimpo =  .Fechaimpo			lxNomfantFaltafw =  .Fechaaltafw			lxNomfantFectrans =  .Fechatransferencia			lxNomfantUaltafw =  .Usuarioaltafw			lxNomfantSaltafw =  .Seriealtafw			lxNomfantSmodifw =  .Seriemodificacionfw			lxNomfantUmodifw =  .Usuariomodificacionfw			lxNomfantZadsfw =  .Zadsfw			lxNomfantValtafw =  .Versionaltafw			lxNomfantVmodifw =  .Versionmodificacionfw			lxNomfantHmodifw =  .Horamodificacionfw			lxNomfantHoraexpo =  .Horaexpo			lxNomfantHoraimpo =  .Horaimpo			lxNomfantEsttrans =  .Estadotransferencia			lxNomfantHaltafw =  .Horaaltafw			lxNomfantBdaltafw =  .Basededatosaltafw			lxNomfantBdmodifw =  .Basededatosmodificacionfw			lxNomfantNfcod =  .Codigo			lxNomfantNfobs =  .Observacion			lxNomfantNfnomf =  .Nombrefantasia
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.NOMFANT ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Ualtafw","Saltafw","Smodifw","Umodifw","Zadsfw","Valtafw","Vmodifw","Hmodifw","Horaexpo","Horaimpo","Esttrans","Haltafw","Bdaltafw","Bdmodifw","Nfcod","Nfobs","Nfnomf" ) values ( <<"'" + this.ConvertirDateSql( lxNomfantFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxNomfantFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantNfcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantNfobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxNomfantNfnomf ) + "'" >> )
		endtext
		loColeccion.cTabla = 'NOMFANT' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RazonSocial
				if this.oEntidad.RazonSocial.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RAZSOC("NROITEM","RZCOD" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxNomfantFecexpo, lxNomfantFmodifw, lxNomfantFecimpo, lxNomfantFaltafw, lxNomfantFectrans, lxNomfantUaltafw, lxNomfantSaltafw, lxNomfantSmodifw, lxNomfantUmodifw, lxNomfantZadsfw, lxNomfantValtafw, lxNomfantVmodifw, lxNomfantHmodifw, lxNomfantHoraexpo, lxNomfantHoraimpo, lxNomfantEsttrans, lxNomfantHaltafw, lxNomfantBdaltafw, lxNomfantBdmodifw, lxNomfantNfcod, lxNomfantNfobs, lxNomfantNfnomf
				lxNomfantFecexpo =  .Fechaexpo			lxNomfantFmodifw =  .Fechamodificacionfw			lxNomfantFecimpo =  .Fechaimpo			lxNomfantFaltafw =  .Fechaaltafw			lxNomfantFectrans =  .Fechatransferencia			lxNomfantUaltafw =  .Usuarioaltafw			lxNomfantSaltafw =  .Seriealtafw			lxNomfantSmodifw =  .Seriemodificacionfw			lxNomfantUmodifw =  .Usuariomodificacionfw			lxNomfantZadsfw =  .Zadsfw			lxNomfantValtafw =  .Versionaltafw			lxNomfantVmodifw =  .Versionmodificacionfw			lxNomfantHmodifw =  .Horamodificacionfw			lxNomfantHoraexpo =  .Horaexpo			lxNomfantHoraimpo =  .Horaimpo			lxNomfantEsttrans =  .Estadotransferencia			lxNomfantHaltafw =  .Horaaltafw			lxNomfantBdaltafw =  .Basededatosaltafw			lxNomfantBdmodifw =  .Basededatosmodificacionfw			lxNomfantNfcod =  .Codigo			lxNomfantNfobs =  .Observacion			lxNomfantNfnomf =  .Nombrefantasia
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Nfcod" = ] + lcValorClavePrimariaString  + [ and  NOMFANT.NFCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.NOMFANT set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxNomfantFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxNomfantFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxNomfantFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxNomfantFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxNomfantFectrans ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxNomfantUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxNomfantSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxNomfantSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxNomfantUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxNomfantZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxNomfantValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxNomfantVmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxNomfantHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxNomfantHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxNomfantHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxNomfantEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxNomfantHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxNomfantBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxNomfantBdmodifw ) + "'">>, "Nfcod" = <<"'" + this.FormatearTextoSql( lxNomfantNfcod ) + "'">>, "Nfobs" = <<"'" + this.FormatearTextoSql( lxNomfantNfobs ) + "'">>, "Nfnomf" = <<"'" + this.FormatearTextoSql( lxNomfantNfnomf ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'NOMFANT' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.RAZSOC where "RZCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RazonSocial
				if this.oEntidad.RazonSocial.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RAZSOC("NROITEM","RZCOD" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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

			lcFiltro = ["Nfcod" = ] + lcValorClavePrimariaString  + [ and  NOMFANT.NFCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.NOMFANT where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.RAZSOC where "RZCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'NOMFANT' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.NOMFANT where  NOMFANT.NFCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.NOMFANT where NFCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  NOMFANT.NFCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMBREDEFANTASIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.NOMFANT Where NFCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..NFCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.NOMFANT set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, NFCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..NFCOD ) + "'"+ [, NFOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..NFOBS ) + "'"+ [, NFNOMF = ] + "'" + this.FormatearTextoSql( &lcCursor..NFNOMF ) + "'" + [ Where NFCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..NFCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FMODIFW, FECIMPO, FALTAFW, FECTRANS, UALTAFW, SALTAFW, SMODIFW, UMODIFW, ZADSFW, VALTAFW, VMODIFW, HMODIFW, HORAEXPO, HORAIMPO, ESTTRANS, HALTAFW, BDALTAFW, BDMODIFW, NFCOD, NFOBS, NFNOMF
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NFCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NFOBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..NFNOMF ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.NOMFANT ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMBREDEFANTASIA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'NFCOD','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','NFCOD')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.RAZSOC Where RZCOD] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMRAZONSOCIAL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where RZCOD in ( select NFCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","RZCOD"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.RAZSOC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RZCOD      ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NFCOD C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..NFCOD      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'NOMBREDEFANTASIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOMBREDEFANTASIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOMBREDEFANTASIA_NFOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMRAZONSOCIAL'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_NomFant')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'NOMBREDEFANTASIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NFCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad NOMBREDEFANTASIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMBREDEFANTASIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NFCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NFCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMBREDEFANTASIA'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_NomFant') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_NomFant
Create Table ZooLogic.TablaTrabajo_NomFant ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"nfcod" char( 10 )  null, 
"nfobs" varchar(max)  null, 
"nfnomf" char( 60 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_NomFant' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_NomFant' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOMBREDEFANTASIA'
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
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('nfcod','nfcod')
			.AgregarMapeo('nfobs','nfobs')
			.AgregarMapeo('nfnomf','nfnomf')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_NomFant'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.NFCOD = isnull( d.NFCOD, t.NFCOD ),t.NFOBS = isnull( d.NFOBS, t.NFOBS ),t.NFNOMF = isnull( d.NFNOMF, t.NFNOMF )
					from ZooLogic.NOMFANT t inner join deleted d 
							 on t.NFCOD = d.NFCOD
				-- Fin Updates
				insert into ZooLogic.NOMFANT(Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Ualtafw,Saltafw,Smodifw,Umodifw,Zadsfw,Valtafw,Vmodifw,Hmodifw,Horaexpo,Horaimpo,Esttrans,Haltafw,Bdaltafw,Bdmodifw,Nfcod,Nfobs,Nfnomf)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.NFCOD,''),isnull( d.NFOBS,''),isnull( d.NFNOMF,'')
						From deleted d left join ZooLogic.NOMFANT pk 
							 on d.NFCOD = pk.NFCOD
						Where pk.NFCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_RAZSOC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_NOMFANT_RAZSOC
ON ZooLogic.TablaTrabajo_NOMFANT_RAZSOC
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.RZCOD = isnull( d.RZCOD, t.RZCOD )
from ZooLogic.RAZSOC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.RAZSOC
( 
"NROITEM",
"RZCOD"
 )
Select 
d.NROITEM,
d.RZCOD
From deleted d left join ZooLogic.RAZSOC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_NomFant') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_NomFant
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_NOMBREDEFANTASIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMBREDEFANTASIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMBREDEFANTASIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMBREDEFANTASIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMBREDEFANTASIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOMBREDEFANTASIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Usuarioaltafw = nvl( c_NOMBREDEFANTASIA.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_NOMBREDEFANTASIA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_NOMBREDEFANTASIA.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_NOMBREDEFANTASIA.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_NOMBREDEFANTASIA.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_NOMBREDEFANTASIA.Versionmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_NOMBREDEFANTASIA.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_NOMBREDEFANTASIA.Horaexpo, [] )
					.Horaimpo = nvl( c_NOMBREDEFANTASIA.Horaimpo, [] )
					.Estadotransferencia = nvl( c_NOMBREDEFANTASIA.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_NOMBREDEFANTASIA.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_NOMBREDEFANTASIA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_NOMBREDEFANTASIA.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_NOMBREDEFANTASIA.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Nombrefantasia = nvl( c_NOMBREDEFANTASIA.Nombrefantasia, [] )
					.Razonsocial.Limpiar()
					.Razonsocial.SetearEsNavegacion( .lProcesando )
					.Razonsocial.Cargar()
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
		
		loDetalle = this.oEntidad.RazonSocial
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_NOMBREDEFANTASIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.NOMFANT' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NFCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NFCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NFCOD from (
							select * 
								from ZooLogic.NOMFANT 
								Where   NOMFANT.NFCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "NOMFANT", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NFCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Nfcod" as "Codigo", "Nfobs" as "Observacion", "Nfnomf" as "Nombrefantasia"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.NOMFANT 
								Where   NOMFANT.NFCOD != ''
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
	Tabla = 'NOMFANT'
	Filtro = " NOMFANT.NFCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " NOMFANT.NFCOD != ''"
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
	<row entidad="NOMBREDEFANTASIA                        " atributo="FECHAEXPO                               " tabla="NOMFANT        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="FECHAMODIFICACIONFW                     " tabla="NOMFANT        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="FECHAIMPO                               " tabla="NOMFANT        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="FECHAALTAFW                             " tabla="NOMFANT        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="FECHATRANSFERENCIA                      " tabla="NOMFANT        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="USUARIOALTAFW                           " tabla="NOMFANT        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="SERIEALTAFW                             " tabla="NOMFANT        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="SERIEMODIFICACIONFW                     " tabla="NOMFANT        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="USUARIOMODIFICACIONFW                   " tabla="NOMFANT        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="ZADSFW                                  " tabla="NOMFANT        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="VERSIONALTAFW                           " tabla="NOMFANT        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="VERSIONMODIFICACIONFW                   " tabla="NOMFANT        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="HORAMODIFICACIONFW                      " tabla="NOMFANT        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="HORAEXPO                                " tabla="NOMFANT        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="HORAIMPO                                " tabla="NOMFANT        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="ESTADOTRANSFERENCIA                     " tabla="NOMFANT        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="HORAALTAFW                              " tabla="NOMFANT        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="BASEDEDATOSALTAFW                       " tabla="NOMFANT        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="NOMFANT        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="CODIGO                                  " tabla="NOMFANT        " campo="NFCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="OBSERVACION                             " tabla="NOMFANT        " campo="NFOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="NOMBREFANTASIA                          " tabla="NOMFANT        " campo="NFNOMF    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nombre                                                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="RAZONSOCIAL                             " tabla="RAZSOC         " campo="RZCOD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Razones sociales                                                                                                                                                " dominio="DETALLEITEMRAZONSOCIAL        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
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