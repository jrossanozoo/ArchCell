
define class Din_EntidadCUENTACORREOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CUENTACORREO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_SMTPK'
	cTablaPrincipal = 'CCORREO'
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
			local  lxCcorreoFecimpo, lxCcorreoFectrans, lxCcorreoFmodifw, lxCcorreoFecexpo, lxCcorreoFaltafw, lxCcorreoHaltafw, lxCcorreoHoraexpo, lxCcorreoValtafw, lxCcorreoHmodifw, lxCcorreoHoraimpo, lxCcorreoUaltafw, lxCcorreoSmodifw, lxCcorreoSaltafw, lxCcorreoUmodifw, lxCcorreoVmodifw, lxCcorreoZadsfw, lxCcorreoBdaltafw, lxCcorreoBdmodifw, lxCcorreoEsttrans, lxCcorreoTipagrupub, lxCcorreoCodigo, lxCcorreoObs, lxCcorreoDescr, lxCcorreoRtoken, lxCcorreoFechatoken, lxCcorreoServidor, lxCcorreoPuerto, lxCcorreoUsuario, lxCcorreoPass, lxCcorreoConseg, lxCcorreoTimout, lxCcorreoMde, lxCcorreoMalias
				lxCcorreoFecimpo =  .Fechaimpo			lxCcorreoFectrans =  .Fechatransferencia			lxCcorreoFmodifw =  .Fechamodificacionfw			lxCcorreoFecexpo =  .Fechaexpo			lxCcorreoFaltafw =  .Fechaaltafw			lxCcorreoHaltafw =  .Horaaltafw			lxCcorreoHoraexpo =  .Horaexpo			lxCcorreoValtafw =  .Versionaltafw			lxCcorreoHmodifw =  .Horamodificacionfw			lxCcorreoHoraimpo =  .Horaimpo			lxCcorreoUaltafw =  .Usuarioaltafw			lxCcorreoSmodifw =  .Seriemodificacionfw			lxCcorreoSaltafw =  .Seriealtafw			lxCcorreoUmodifw =  .Usuariomodificacionfw			lxCcorreoVmodifw =  .Versionmodificacionfw			lxCcorreoZadsfw =  .Zadsfw			lxCcorreoBdaltafw =  .Basededatosaltafw			lxCcorreoBdmodifw =  .Basededatosmodificacionfw			lxCcorreoEsttrans =  .Estadotransferencia			lxCcorreoTipagrupub =  .Tipoagrupamientopublicaciones			lxCcorreoCodigo =  .Codigo			lxCcorreoObs =  .Observacion			lxCcorreoDescr =  .Descripcion			lxCcorreoRtoken =  .Refreshtoken			lxCcorreoFechatoken =  .Fechatoken			lxCcorreoServidor =  .Servidor			lxCcorreoPuerto =  .Puerto			lxCcorreoUsuario =  .Usuario			lxCcorreoPass =  .Password			lxCcorreoConseg =  .Conexionesseguras			lxCcorreoTimout =  .Tiempodeespera			lxCcorreoMde =  .Mailde			lxCcorreoMalias =  .Mailalias
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCcorreoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CCORREO ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Horaexpo","Valtafw","Hmodifw","Horaimpo","Ualtafw","Smodifw","Saltafw","Umodifw","Vmodifw","Zadsfw","Bdaltafw","Bdmodifw","Esttrans","Tipagrupub","Codigo","Obs","Descr","Rtoken","Fechatoken","Servidor","Puerto","Usuario","Pass","Conseg","Timout","Mde","Malias" ) values ( <<"'" + this.ConvertirDateSql( lxCcorreoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoEsttrans ) + "'" >>, <<lxCcorreoTipagrupub >>, <<"'" + this.FormatearTextoSql( lxCcorreoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoDescr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoRtoken ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFechatoken ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoServidor ) + "'" >>, <<lxCcorreoPuerto >>, <<"'" + this.FormatearTextoSql( lxCcorreoUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoPass ) + "'" >>, <<iif( lxCcorreoConseg, 1, 0 ) >>, <<lxCcorreoTimout >>, <<"'" + this.FormatearTextoSql( lxCcorreoMde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoMalias ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSMT("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxCcorreoFecimpo, lxCcorreoFectrans, lxCcorreoFmodifw, lxCcorreoFecexpo, lxCcorreoFaltafw, lxCcorreoHaltafw, lxCcorreoHoraexpo, lxCcorreoValtafw, lxCcorreoHmodifw, lxCcorreoHoraimpo, lxCcorreoUaltafw, lxCcorreoSmodifw, lxCcorreoSaltafw, lxCcorreoUmodifw, lxCcorreoVmodifw, lxCcorreoZadsfw, lxCcorreoBdaltafw, lxCcorreoBdmodifw, lxCcorreoEsttrans, lxCcorreoTipagrupub, lxCcorreoCodigo, lxCcorreoObs, lxCcorreoDescr, lxCcorreoRtoken, lxCcorreoFechatoken, lxCcorreoServidor, lxCcorreoPuerto, lxCcorreoUsuario, lxCcorreoPass, lxCcorreoConseg, lxCcorreoTimout, lxCcorreoMde, lxCcorreoMalias
				lxCcorreoFecimpo =  .Fechaimpo			lxCcorreoFectrans =  .Fechatransferencia			lxCcorreoFmodifw =  .Fechamodificacionfw			lxCcorreoFecexpo =  .Fechaexpo			lxCcorreoFaltafw =  .Fechaaltafw			lxCcorreoHaltafw =  .Horaaltafw			lxCcorreoHoraexpo =  .Horaexpo			lxCcorreoValtafw =  .Versionaltafw			lxCcorreoHmodifw =  .Horamodificacionfw			lxCcorreoHoraimpo =  .Horaimpo			lxCcorreoUaltafw =  .Usuarioaltafw			lxCcorreoSmodifw =  .Seriemodificacionfw			lxCcorreoSaltafw =  .Seriealtafw			lxCcorreoUmodifw =  .Usuariomodificacionfw			lxCcorreoVmodifw =  .Versionmodificacionfw			lxCcorreoZadsfw =  .Zadsfw			lxCcorreoBdaltafw =  .Basededatosaltafw			lxCcorreoBdmodifw =  .Basededatosmodificacionfw			lxCcorreoEsttrans =  .Estadotransferencia			lxCcorreoTipagrupub =  .Tipoagrupamientopublicaciones			lxCcorreoCodigo =  .Codigo			lxCcorreoObs =  .Observacion			lxCcorreoDescr =  .Descripcion			lxCcorreoRtoken =  .Refreshtoken			lxCcorreoFechatoken =  .Fechatoken			lxCcorreoServidor =  .Servidor			lxCcorreoPuerto =  .Puerto			lxCcorreoUsuario =  .Usuario			lxCcorreoPass =  .Password			lxCcorreoConseg =  .Conexionesseguras			lxCcorreoTimout =  .Tiempodeespera			lxCcorreoMde =  .Mailde			lxCcorreoMalias =  .Mailalias
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CCORREO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCcorreoFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCcorreoFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCcorreoFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCcorreoFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCcorreoFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCcorreoHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCcorreoHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCcorreoValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCcorreoHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCcorreoUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCcorreoSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCcorreoZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCcorreoBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCcorreoEsttrans ) + "'">>,"Tipagrupub" = <<lxCcorreoTipagrupub>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCcorreoCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCcorreoObs ) + "'">>,"Descr" = <<"'" + this.FormatearTextoSql( lxCcorreoDescr ) + "'">>,"Rtoken" = <<"'" + this.FormatearTextoSql( lxCcorreoRtoken ) + "'">>,"Fechatoken" = <<"'" + this.ConvertirDateSql( lxCcorreoFechatoken ) + "'">>,"Servidor" = <<"'" + this.FormatearTextoSql( lxCcorreoServidor ) + "'">>,"Puerto" = <<lxCcorreoPuerto>>,"Usuario" = <<"'" + this.FormatearTextoSql( lxCcorreoUsuario ) + "'">>,"Pass" = <<"'" + this.FormatearTextoSql( lxCcorreoPass ) + "'">>,"Conseg" = <<iif( lxCcorreoConseg, 1, 0 )>>,"Timout" = <<lxCcorreoTimout>>,"Mde" = <<"'" + this.FormatearTextoSql( lxCcorreoMde ) + "'">>,"Malias" = <<"'" + this.FormatearTextoSql( lxCcorreoMalias ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCcorreoCodigo ) + "'">> and  CCORREO.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubSMT where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSMT("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.CCORREO where " + this.ConvertirFuncionesSql( " CCORREO.CODIGO != ''" ) )
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
			Local lxCcorreoCodigo
			lxCcorreoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Descr" as "Descripcion", "Rtoken" as "Refreshtoken", "Fechatoken" as "Fechatoken", "Servidor" as "Servidor", "Puerto" as "Puerto", "Usuario" as "Usuario", "Pass" as "Password", "Conseg" as "Conexionesseguras", "Timout" as "Tiempodeespera", "Mde" as "Mailde", "Malias" as "Mailalias" from ZooLogic.CCORREO where "Codigo" = <<"'" + this.FormatearTextoSql( lxCcorreoCodigo ) + "'">> and  CCORREO.CODIGO != ''
			endtext
			use in select('c_CUENTACORREO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTACORREO', set( 'Datasession' ) )

			if reccount( 'c_CUENTACORREO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSMT where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTACORREO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCcorreoCodigo as Variant
		llRetorno = .t.
		lxCcorreoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CCORREO where "Codigo" = <<"'" + this.FormatearTextoSql( lxCcorreoCodigo ) + "'">> and  CCORREO.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Descr" as "Descripcion", "Rtoken" as "Refreshtoken", "Fechatoken" as "Fechatoken", "Servidor" as "Servidor", "Puerto" as "Puerto", "Usuario" as "Usuario", "Pass" as "Password", "Conseg" as "Conexionesseguras", "Timout" as "Tiempodeespera", "Mde" as "Mailde", "Malias" as "Mailalias" from ZooLogic.CCORREO where  CCORREO.CODIGO != '' order by codigo
			endtext
			use in select('c_CUENTACORREO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTACORREO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSMT where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTACORREO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Descr" as "Descripcion", "Rtoken" as "Refreshtoken", "Fechatoken" as "Fechatoken", "Servidor" as "Servidor", "Puerto" as "Puerto", "Usuario" as "Usuario", "Pass" as "Password", "Conseg" as "Conexionesseguras", "Timout" as "Tiempodeespera", "Mde" as "Mailde", "Malias" as "Mailalias" from ZooLogic.CCORREO where  funciones.padr( codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CCORREO.CODIGO != '' order by codigo
			endtext
			use in select('c_CUENTACORREO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTACORREO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSMT where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTACORREO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Descr" as "Descripcion", "Rtoken" as "Refreshtoken", "Fechatoken" as "Fechatoken", "Servidor" as "Servidor", "Puerto" as "Puerto", "Usuario" as "Usuario", "Pass" as "Password", "Conseg" as "Conexionesseguras", "Timout" as "Tiempodeespera", "Mde" as "Mailde", "Malias" as "Mailalias" from ZooLogic.CCORREO where  funciones.padr( codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CCORREO.CODIGO != '' order by codigo desc
			endtext
			use in select('c_CUENTACORREO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTACORREO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSMT where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTACORREO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Descr" as "Descripcion", "Rtoken" as "Refreshtoken", "Fechatoken" as "Fechatoken", "Servidor" as "Servidor", "Puerto" as "Puerto", "Usuario" as "Usuario", "Pass" as "Password", "Conseg" as "Conexionesseguras", "Timout" as "Tiempodeespera", "Mde" as "Mailde", "Malias" as "Mailalias" from ZooLogic.CCORREO where  CCORREO.CODIGO != '' order by codigo desc
			endtext
			use in select('c_CUENTACORREO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTACORREO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSMT where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTACORREO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Horaexpo,Valtafw,Hmodifw,Horaimpo,Ualtafw,S" + ;
"modifw,Saltafw,Umodifw,Vmodifw,Zadsfw,Bdaltafw,Bdmodifw,Esttrans,Tipagrupub,Codigo,Obs,Descr,Rtoken," + ;
"Fechatoken,Servidor,Puerto,Usuario,Pass,Conseg,Timout,Mde,Malias" + ;
" from ZooLogic.CCORREO where  CCORREO.CODIGO != '' and " + lcFiltro )
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
			local  lxCcorreoFecimpo, lxCcorreoFectrans, lxCcorreoFmodifw, lxCcorreoFecexpo, lxCcorreoFaltafw, lxCcorreoHaltafw, lxCcorreoHoraexpo, lxCcorreoValtafw, lxCcorreoHmodifw, lxCcorreoHoraimpo, lxCcorreoUaltafw, lxCcorreoSmodifw, lxCcorreoSaltafw, lxCcorreoUmodifw, lxCcorreoVmodifw, lxCcorreoZadsfw, lxCcorreoBdaltafw, lxCcorreoBdmodifw, lxCcorreoEsttrans, lxCcorreoTipagrupub, lxCcorreoCodigo, lxCcorreoObs, lxCcorreoDescr, lxCcorreoRtoken, lxCcorreoFechatoken, lxCcorreoServidor, lxCcorreoPuerto, lxCcorreoUsuario, lxCcorreoPass, lxCcorreoConseg, lxCcorreoTimout, lxCcorreoMde, lxCcorreoMalias
				lxCcorreoFecimpo = ctod( '  /  /    ' )			lxCcorreoFectrans = ctod( '  /  /    ' )			lxCcorreoFmodifw = ctod( '  /  /    ' )			lxCcorreoFecexpo = ctod( '  /  /    ' )			lxCcorreoFaltafw = ctod( '  /  /    ' )			lxCcorreoHaltafw = []			lxCcorreoHoraexpo = []			lxCcorreoValtafw = []			lxCcorreoHmodifw = []			lxCcorreoHoraimpo = []			lxCcorreoUaltafw = []			lxCcorreoSmodifw = []			lxCcorreoSaltafw = []			lxCcorreoUmodifw = []			lxCcorreoVmodifw = []			lxCcorreoZadsfw = []			lxCcorreoBdaltafw = []			lxCcorreoBdmodifw = []			lxCcorreoEsttrans = []			lxCcorreoTipagrupub = 0			lxCcorreoCodigo = []			lxCcorreoObs = []			lxCcorreoDescr = []			lxCcorreoRtoken = []			lxCcorreoFechatoken = ctod( '  /  /    ' )			lxCcorreoServidor = []			lxCcorreoPuerto = 0			lxCcorreoUsuario = []			lxCcorreoPass = []			lxCcorreoConseg = .F.			lxCcorreoTimout = 0			lxCcorreoMde = []			lxCcorreoMalias = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubSMT where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CCORREO where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CCORREO' + '_' + tcCampo
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
		lcWhere = " Where  CCORREO.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Descr" as "Descripcion", "Rtoken" as "Refreshtoken", "Fechatoken" as "Fechatoken", "Servidor" as "Servidor", "Puerto" as "Puerto", "Usuario" as "Usuario", "Pass" as "Password", "Conseg" as "Conexionesseguras", "Timout" as "Tiempodeespera", "Mde" as "Mailde", "Malias" as "Mailalias"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CCORREO', '', tnTope )
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
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBSMT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgruPubliDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubSMT', 'AgruPubliDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgruPubliDetalle( lcAtributo )
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
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCR AS DESCRIPCION'
				Case lcAtributo == 'REFRESHTOKEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RTOKEN AS REFRESHTOKEN'
				Case lcAtributo == 'FECHATOKEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHATOKEN AS FECHATOKEN'
				Case lcAtributo == 'SERVIDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERVIDOR AS SERVIDOR'
				Case lcAtributo == 'PUERTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUERTO AS PUERTO'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USUARIO AS USUARIO'
				Case lcAtributo == 'PASSWORD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PASS AS PASSWORD'
				Case lcAtributo == 'CONEXIONESSEGURAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONSEG AS CONEXIONESSEGURAS'
				Case lcAtributo == 'TIEMPODEESPERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMOUT AS TIEMPODEESPERA'
				Case lcAtributo == 'MAILDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDE AS MAILDE'
				Case lcAtributo == 'MAILALIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MALIAS AS MAILALIAS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPDES AS AGRUPAMIENTODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCR'
			Case upper( alltrim( tcAtributo ) ) == 'REFRESHTOKEN'
				lcCampo = 'RTOKEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATOKEN'
				lcCampo = 'FECHATOKEN'
			Case upper( alltrim( tcAtributo ) ) == 'SERVIDOR'
				lcCampo = 'SERVIDOR'
			Case upper( alltrim( tcAtributo ) ) == 'PUERTO'
				lcCampo = 'PUERTO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'USUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'PASSWORD'
				lcCampo = 'PASS'
			Case upper( alltrim( tcAtributo ) ) == 'CONEXIONESSEGURAS'
				lcCampo = 'CONSEG'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPODEESPERA'
				lcCampo = 'TIMOUT'
			Case upper( alltrim( tcAtributo ) ) == 'MAILDE'
				lcCampo = 'MDE'
			Case upper( alltrim( tcAtributo ) ) == 'MAILALIAS'
				lcCampo = 'MALIAS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgruPubliDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'AGRUPDES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBSMT'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCcorreoFecimpo, lxCcorreoFectrans, lxCcorreoFmodifw, lxCcorreoFecexpo, lxCcorreoFaltafw, lxCcorreoHaltafw, lxCcorreoHoraexpo, lxCcorreoValtafw, lxCcorreoHmodifw, lxCcorreoHoraimpo, lxCcorreoUaltafw, lxCcorreoSmodifw, lxCcorreoSaltafw, lxCcorreoUmodifw, lxCcorreoVmodifw, lxCcorreoZadsfw, lxCcorreoBdaltafw, lxCcorreoBdmodifw, lxCcorreoEsttrans, lxCcorreoTipagrupub, lxCcorreoCodigo, lxCcorreoObs, lxCcorreoDescr, lxCcorreoRtoken, lxCcorreoFechatoken, lxCcorreoServidor, lxCcorreoPuerto, lxCcorreoUsuario, lxCcorreoPass, lxCcorreoConseg, lxCcorreoTimout, lxCcorreoMde, lxCcorreoMalias
				lxCcorreoFecimpo =  .Fechaimpo			lxCcorreoFectrans =  .Fechatransferencia			lxCcorreoFmodifw =  .Fechamodificacionfw			lxCcorreoFecexpo =  .Fechaexpo			lxCcorreoFaltafw =  .Fechaaltafw			lxCcorreoHaltafw =  .Horaaltafw			lxCcorreoHoraexpo =  .Horaexpo			lxCcorreoValtafw =  .Versionaltafw			lxCcorreoHmodifw =  .Horamodificacionfw			lxCcorreoHoraimpo =  .Horaimpo			lxCcorreoUaltafw =  .Usuarioaltafw			lxCcorreoSmodifw =  .Seriemodificacionfw			lxCcorreoSaltafw =  .Seriealtafw			lxCcorreoUmodifw =  .Usuariomodificacionfw			lxCcorreoVmodifw =  .Versionmodificacionfw			lxCcorreoZadsfw =  .Zadsfw			lxCcorreoBdaltafw =  .Basededatosaltafw			lxCcorreoBdmodifw =  .Basededatosmodificacionfw			lxCcorreoEsttrans =  .Estadotransferencia			lxCcorreoTipagrupub =  .Tipoagrupamientopublicaciones			lxCcorreoCodigo =  .Codigo			lxCcorreoObs =  .Observacion			lxCcorreoDescr =  .Descripcion			lxCcorreoRtoken =  .Refreshtoken			lxCcorreoFechatoken =  .Fechatoken			lxCcorreoServidor =  .Servidor			lxCcorreoPuerto =  .Puerto			lxCcorreoUsuario =  .Usuario			lxCcorreoPass =  .Password			lxCcorreoConseg =  .Conexionesseguras			lxCcorreoTimout =  .Tiempodeespera			lxCcorreoMde =  .Mailde			lxCcorreoMalias =  .Mailalias
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CCORREO ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Horaexpo","Valtafw","Hmodifw","Horaimpo","Ualtafw","Smodifw","Saltafw","Umodifw","Vmodifw","Zadsfw","Bdaltafw","Bdmodifw","Esttrans","Tipagrupub","Codigo","Obs","Descr","Rtoken","Fechatoken","Servidor","Puerto","Usuario","Pass","Conseg","Timout","Mde","Malias" ) values ( <<"'" + this.ConvertirDateSql( lxCcorreoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoEsttrans ) + "'" >>, <<lxCcorreoTipagrupub >>, <<"'" + this.FormatearTextoSql( lxCcorreoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoDescr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoRtoken ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCcorreoFechatoken ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoServidor ) + "'" >>, <<lxCcorreoPuerto >>, <<"'" + this.FormatearTextoSql( lxCcorreoUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoPass ) + "'" >>, <<iif( lxCcorreoConseg, 1, 0 ) >>, <<lxCcorreoTimout >>, <<"'" + this.FormatearTextoSql( lxCcorreoMde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCcorreoMalias ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CCORREO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSMT("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxCcorreoFecimpo, lxCcorreoFectrans, lxCcorreoFmodifw, lxCcorreoFecexpo, lxCcorreoFaltafw, lxCcorreoHaltafw, lxCcorreoHoraexpo, lxCcorreoValtafw, lxCcorreoHmodifw, lxCcorreoHoraimpo, lxCcorreoUaltafw, lxCcorreoSmodifw, lxCcorreoSaltafw, lxCcorreoUmodifw, lxCcorreoVmodifw, lxCcorreoZadsfw, lxCcorreoBdaltafw, lxCcorreoBdmodifw, lxCcorreoEsttrans, lxCcorreoTipagrupub, lxCcorreoCodigo, lxCcorreoObs, lxCcorreoDescr, lxCcorreoRtoken, lxCcorreoFechatoken, lxCcorreoServidor, lxCcorreoPuerto, lxCcorreoUsuario, lxCcorreoPass, lxCcorreoConseg, lxCcorreoTimout, lxCcorreoMde, lxCcorreoMalias
				lxCcorreoFecimpo =  .Fechaimpo			lxCcorreoFectrans =  .Fechatransferencia			lxCcorreoFmodifw =  .Fechamodificacionfw			lxCcorreoFecexpo =  .Fechaexpo			lxCcorreoFaltafw =  .Fechaaltafw			lxCcorreoHaltafw =  .Horaaltafw			lxCcorreoHoraexpo =  .Horaexpo			lxCcorreoValtafw =  .Versionaltafw			lxCcorreoHmodifw =  .Horamodificacionfw			lxCcorreoHoraimpo =  .Horaimpo			lxCcorreoUaltafw =  .Usuarioaltafw			lxCcorreoSmodifw =  .Seriemodificacionfw			lxCcorreoSaltafw =  .Seriealtafw			lxCcorreoUmodifw =  .Usuariomodificacionfw			lxCcorreoVmodifw =  .Versionmodificacionfw			lxCcorreoZadsfw =  .Zadsfw			lxCcorreoBdaltafw =  .Basededatosaltafw			lxCcorreoBdmodifw =  .Basededatosmodificacionfw			lxCcorreoEsttrans =  .Estadotransferencia			lxCcorreoTipagrupub =  .Tipoagrupamientopublicaciones			lxCcorreoCodigo =  .Codigo			lxCcorreoObs =  .Observacion			lxCcorreoDescr =  .Descripcion			lxCcorreoRtoken =  .Refreshtoken			lxCcorreoFechatoken =  .Fechatoken			lxCcorreoServidor =  .Servidor			lxCcorreoPuerto =  .Puerto			lxCcorreoUsuario =  .Usuario			lxCcorreoPass =  .Password			lxCcorreoConseg =  .Conexionesseguras			lxCcorreoTimout =  .Tiempodeespera			lxCcorreoMde =  .Mailde			lxCcorreoMalias =  .Mailalias
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CCORREO.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CCORREO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCcorreoFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCcorreoFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCcorreoFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCcorreoFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCcorreoFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCcorreoHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCcorreoHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCcorreoValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCcorreoHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCcorreoUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCcorreoSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCcorreoZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCcorreoBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCcorreoBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCcorreoEsttrans ) + "'">>, "Tipagrupub" = <<lxCcorreoTipagrupub>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCcorreoCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCcorreoObs ) + "'">>, "Descr" = <<"'" + this.FormatearTextoSql( lxCcorreoDescr ) + "'">>, "Rtoken" = <<"'" + this.FormatearTextoSql( lxCcorreoRtoken ) + "'">>, "Fechatoken" = <<"'" + this.ConvertirDateSql( lxCcorreoFechatoken ) + "'">>, "Servidor" = <<"'" + this.FormatearTextoSql( lxCcorreoServidor ) + "'">>, "Puerto" = <<lxCcorreoPuerto>>, "Usuario" = <<"'" + this.FormatearTextoSql( lxCcorreoUsuario ) + "'">>, "Pass" = <<"'" + this.FormatearTextoSql( lxCcorreoPass ) + "'">>, "Conseg" = <<iif( lxCcorreoConseg, 1, 0 )>>, "Timout" = <<lxCcorreoTimout>>, "Mde" = <<"'" + this.FormatearTextoSql( lxCcorreoMde ) + "'">>, "Malias" = <<"'" + this.FormatearTextoSql( lxCcorreoMalias ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CCORREO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPubSMT where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSMT("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CCORREO.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CCORREO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPubSMT where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CCORREO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CCORREO where  CCORREO.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CCORREO where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CCORREO.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTACORREO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CCORREO Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CCORREO set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, obs = ] + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"+ [, descr = ] + "'" + this.FormatearTextoSql( &lcCursor..descr ) + "'"+ [, RToken = ] + "'" + this.FormatearTextoSql( &lcCursor..RToken ) + "'"+ [, FechaToken = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaToken ) + "'"+ [, servidor = ] + "'" + this.FormatearTextoSql( &lcCursor..servidor ) + "'"+ [, puerto = ] + transform( &lcCursor..puerto )+ [, usuario = ] + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'"+ [, pass = ] + "'" + this.FormatearTextoSql( &lcCursor..pass ) + "'"+ [, conseg = ] + Transform( iif( &lcCursor..conseg, 1, 0 ))+ [, timout = ] + transform( &lcCursor..timout )+ [, mDe = ] + "'" + this.FormatearTextoSql( &lcCursor..mDe ) + "'"+ [, mAlias = ] + "'" + this.FormatearTextoSql( &lcCursor..mAlias ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HALTAFW, HORAEXPO, VALTAFW, HMODIFW, HORAIMPO, UALTAFW, SMODIFW, SALTAFW, UMODIFW, VMODIFW, ZADSFW, BDALTAFW, BDMODIFW, ESTTRANS, tipagrupub, codigo, obs, descr, RToken, FechaToken, servidor, puerto, usuario, pass, conseg, timout, mDe, mAlias
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..descr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RToken ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaToken ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..servidor ) + "'" + ',' + transform( &lcCursor..puerto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..pass ) + "'" + ',' + Transform( iif( &lcCursor..conseg, 1, 0 )) + ',' + transform( &lcCursor..timout ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..mDe ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..mAlias ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CCORREO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTACORREO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubSMT Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICSMT'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubSMT ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CUENTACORREO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUENTACORREO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUENTACORREO_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUENTACORREO_RTOKEN'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICSMT'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ccorreo')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CUENTACORREO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CUENTACORREO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTACORREO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTACORREO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FechaToken
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ccorreo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ccorreo
Create Table ZooLogic.TablaTrabajo_ccorreo ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"codigo" char( 10 )  null, 
"obs" varchar(max)  null, 
"descr" char( 80 )  null, 
"rtoken" varchar(max)  null, 
"fechatoken" datetime  null, 
"servidor" char( 130 )  null, 
"puerto" numeric( 5, 0 )  null, 
"usuario" char( 200 )  null, 
"pass" char( 200 )  null, 
"conseg" bit  null, 
"timout" numeric( 3, 0 )  null, 
"mde" char( 200 )  null, 
"malias" char( 200 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ccorreo' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ccorreo' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTACORREO'
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
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('descr','descr')
			.AgregarMapeo('rtoken','rtoken')
			.AgregarMapeo('fechatoken','fechatoken')
			.AgregarMapeo('servidor','servidor')
			.AgregarMapeo('puerto','puerto')
			.AgregarMapeo('usuario','usuario')
			.AgregarMapeo('pass','pass')
			.AgregarMapeo('conseg','conseg')
			.AgregarMapeo('timout','timout')
			.AgregarMapeo('mde','mde')
			.AgregarMapeo('malias','malias')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ccorreo'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.DESCR = isnull( d.DESCR, t.DESCR ),t.RTOKEN = isnull( d.RTOKEN, t.RTOKEN ),t.FECHATOKEN = isnull( d.FECHATOKEN, t.FECHATOKEN ),t.SERVIDOR = isnull( d.SERVIDOR, t.SERVIDOR ),t.PUERTO = isnull( d.PUERTO, t.PUERTO ),t.USUARIO = isnull( d.USUARIO, t.USUARIO ),t.PASS = isnull( d.PASS, t.PASS ),t.CONSEG = isnull( d.CONSEG, t.CONSEG ),t.TIMOUT = isnull( d.TIMOUT, t.TIMOUT ),t.MDE = isnull( d.MDE, t.MDE ),t.MALIAS = isnull( d.MALIAS, t.MALIAS )
					from ZooLogic.CCORREO t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ZooLogic.CCORREO(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Horaexpo,Valtafw,Hmodifw,Horaimpo,Ualtafw,Smodifw,Saltafw,Umodifw,Vmodifw,Zadsfw,Bdaltafw,Bdmodifw,Esttrans,Tipagrupub,Codigo,Obs,Descr,Rtoken,Fechatoken,Servidor,Puerto,Usuario,Pass,Conseg,Timout,Mde,Malias)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.TIPAGRUPUB,0),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.DESCR,''),isnull( d.RTOKEN,''),isnull( d.FECHATOKEN,''),isnull( d.SERVIDOR,''),isnull( d.PUERTO,0),isnull( d.USUARIO,''),isnull( d.PASS,''),isnull( d.CONSEG,0),isnull( d.TIMOUT,0),isnull( d.MDE,''),isnull( d.MALIAS,'')
						From deleted d left join ZooLogic.CCORREO pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubSMT( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CCORREO_AgruPubSMT
ON ZooLogic.TablaTrabajo_CCORREO_AgruPubSMT
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubSMT t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubSMT
( 
"NROITEM",
"CODIGO",
"AGRUP",
"AGRUPDES"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AGRUP,
d.AGRUPDES
From deleted d left join ZooLogic.AgruPubSMT pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ccorreo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ccorreo
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CUENTACORREO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTACORREO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTACORREO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTACORREO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTACORREO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTACORREO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_CUENTACORREO.Horaaltafw, [] )
					.Horaexpo = nvl( c_CUENTACORREO.Horaexpo, [] )
					.Versionaltafw = nvl( c_CUENTACORREO.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_CUENTACORREO.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_CUENTACORREO.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_CUENTACORREO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_CUENTACORREO.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_CUENTACORREO.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_CUENTACORREO.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CUENTACORREO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_CUENTACORREO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CUENTACORREO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CUENTACORREO.Estadotransferencia, [] )
					.Tipoagrupamientopublicaciones = nvl( c_CUENTACORREO.Tipoagrupamientopublicaciones, 0 )
					.Codigo = nvl( c_CUENTACORREO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Descripcion = nvl( c_CUENTACORREO.Descripcion, [] )
					lcValor = This.ObtenerMemo( 'c_Refreshtoken')
					.Refreshtoken = lcValor 
					.Fechatoken = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTACORREO.Fechatoken, ctod( '  /  /    ' ) ) )
					.Servidor = nvl( c_CUENTACORREO.Servidor, [] )
					.Puerto = nvl( c_CUENTACORREO.Puerto, 0 )
					.Usuario = nvl( c_CUENTACORREO.Usuario, [] )
					.Password = nvl( c_CUENTACORREO.Password, [] )
					.Conexionesseguras = nvl( c_CUENTACORREO.Conexionesseguras, .F. )
					.Tiempodeespera = nvl( c_CUENTACORREO.Tiempodeespera, 0 )
					.Mailde = nvl( c_CUENTACORREO.Mailde, [] )
					.Mailalias = nvl( c_CUENTACORREO.Mailalias, [] )
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
		
		loDetalle = this.oEntidad.AgruPubliDetalle
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
		return c_CUENTACORREO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CCORREO' )
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
								from ZooLogic.CCORREO 
								Where   CCORREO.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CCORREO", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Descr" as "Descripcion", "Rtoken" as "Refreshtoken", "Fechatoken" as "Fechatoken", "Servidor" as "Servidor", "Puerto" as "Puerto", "Usuario" as "Usuario", "Pass" as "Password", "Conseg" as "Conexionesseguras", "Timout" as "Tiempodeespera", "Mde" as "Mailde", "Malias" as "Mailalias"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CCORREO 
								Where   CCORREO.CODIGO != ''
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
	Tabla = 'CCORREO'
	Filtro = " CCORREO.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CCORREO.CODIGO != ''"
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
	<row entidad="CUENTACORREO                            " atributo="FECHAIMPO                               " tabla="CCORREO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="FECHATRANSFERENCIA                      " tabla="CCORREO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="FECHAMODIFICACIONFW                     " tabla="CCORREO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="FECHAEXPO                               " tabla="CCORREO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="FECHAALTAFW                             " tabla="CCORREO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="HORAALTAFW                              " tabla="CCORREO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="HORAEXPO                                " tabla="CCORREO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="VERSIONALTAFW                           " tabla="CCORREO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="HORAMODIFICACIONFW                      " tabla="CCORREO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="HORAIMPO                                " tabla="CCORREO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="USUARIOALTAFW                           " tabla="CCORREO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="SERIEMODIFICACIONFW                     " tabla="CCORREO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="SERIEALTAFW                             " tabla="CCORREO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="USUARIOMODIFICACIONFW                   " tabla="CCORREO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="VERSIONMODIFICACIONFW                   " tabla="CCORREO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="ZADSFW                                  " tabla="CCORREO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="BASEDEDATOSALTAFW                       " tabla="CCORREO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CCORREO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="ESTADOTRANSFERENCIA                     " tabla="CCORREO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="CCORREO        " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="CODIGO                                  " tabla="CCORREO        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="OBSERVACION                             " tabla="CCORREO        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBSMT     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICSMT    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="DESCRIPCION                             " tabla="CCORREO        " campo="DESCR     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="REFRESHTOKEN                            " tabla="CCORREO        " campo="RTOKEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Refresh token                                                                                                                                                   " dominio="TOKENENCRIPTADO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="FECHATOKEN                              " tabla="CCORREO        " campo="FECHATOKEN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha vencimiento token                                                                                                                                         " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="SERVIDOR                                " tabla="CCORREO        " campo="SERVIDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="130" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="3" etiqueta="Servidor                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="PUERTO                                  " tabla="CCORREO        " campo="PUERTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Puerto                                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="USUARIO                                 " tabla="CCORREO        " campo="USUARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="PASSWORD                                " tabla="CCORREO        " campo="PASS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Contraseña                                                                                                                                                      " dominio="CONTRASENIA                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="CONEXIONESSEGURAS                       " tabla="CCORREO        " campo="CONSEG    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.t.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="203" etiqueta="Conexiones seguras                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="TIEMPODEESPERA                          " tabla="CCORREO        " campo="TIMOUT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="=GOrEGISTRY.NUCLEO.DefaultTiempoDeEsperaSmtp                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="0" etiqueta="Tiempo de espera                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="60" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="MAILDE                                  " tabla="CCORREO        " campo="MDE       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Correo electrónico                                                                                                                                              " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="100" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="MAILALIAS                               " tabla="CCORREO        " campo="MALIAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Alias                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="110" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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