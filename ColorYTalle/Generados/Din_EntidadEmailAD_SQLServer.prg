
define class Din_EntidadEMAILAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_EMAIL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_MILPK'
	cTablaPrincipal = 'MAIL'
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
			local  lxMailFecimpo, lxMailFectrans, lxMailFmodifw, lxMailFecexpo, lxMailFaltafw, lxMailZadsfw, lxMailEsttrans, lxMailValtafw, lxMailVmodifw, lxMailSaltafw, lxMailHoraimpo, lxMailHaltafw, lxMailHoraexpo, lxMailBdmodifw, lxMailBdaltafw, lxMailHmodifw, lxMailSmodifw, lxMailUmodifw, lxMailUaltafw, lxMailTipagrupub, lxMailCodigo, lxMailObs, lxMailTexto, lxMailDescr, lxMailCondic, lxMailEnvguar, lxMailServ, lxMailEnvio, lxMailMpara, lxMailMcc, lxMailMcco, lxMailAsunto
				lxMailFecimpo =  .Fechaimpo			lxMailFectrans =  .Fechatransferencia			lxMailFmodifw =  .Fechamodificacionfw			lxMailFecexpo =  .Fechaexpo			lxMailFaltafw =  .Fechaaltafw			lxMailZadsfw =  .Zadsfw			lxMailEsttrans =  .Estadotransferencia			lxMailValtafw =  .Versionaltafw			lxMailVmodifw =  .Versionmodificacionfw			lxMailSaltafw =  .Seriealtafw			lxMailHoraimpo =  .Horaimpo			lxMailHaltafw =  .Horaaltafw			lxMailHoraexpo =  .Horaexpo			lxMailBdmodifw =  .Basededatosmodificacionfw			lxMailBdaltafw =  .Basededatosaltafw			lxMailHmodifw =  .Horamodificacionfw			lxMailSmodifw =  .Seriemodificacionfw			lxMailUmodifw =  .Usuariomodificacionfw			lxMailUaltafw =  .Usuarioaltafw			lxMailTipagrupub =  .Tipoagrupamientopublicaciones			lxMailCodigo =  .Codigo			lxMailObs =  .Observacion			lxMailTexto =  .Texto			lxMailDescr =  .Descripcion			lxMailCondic =  .Condicion			lxMailEnvguar =  .Enviaralguardar			lxMailServ =  upper( .Servidor_PK ) 			lxMailEnvio =  .Confirmaenvio			lxMailMpara =  .Mailpara			lxMailMcc =  .Mailcopia			lxMailMcco =  .Mailcopiaoculta			lxMailAsunto =  .Asunto
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMailCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MAIL ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Zadsfw","Esttrans","Valtafw","Vmodifw","Saltafw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Tipagrupub","Codigo","Obs","Texto","Descr","Condic","Envguar","Serv","Envio","Mpara","Mcc","Mcco","Asunto" ) values ( <<"'" + this.ConvertirDateSql( lxMailFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailUaltafw ) + "'" >>, <<lxMailTipagrupub >>, <<"'" + this.FormatearTextoSql( lxMailCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailTexto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailDescr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailCondic ) + "'" >>, <<iif( lxMailEnvguar, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxMailServ ) + "'" >>, <<lxMailEnvio >>, <<"'" + this.FormatearTextoSql( lxMailMpara ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailMcc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailMcco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailAsunto ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEntMAIL("NROITEM","iCod","iEnt" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubMIL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArchivosDetalle
				if this.oEntidad.ArchivosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArchivo = loItem.Archivo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.mailarch("NROITEM","arccod","archivo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArchivo ) + "'">> ) 
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
			local  lxMailFecimpo, lxMailFectrans, lxMailFmodifw, lxMailFecexpo, lxMailFaltafw, lxMailZadsfw, lxMailEsttrans, lxMailValtafw, lxMailVmodifw, lxMailSaltafw, lxMailHoraimpo, lxMailHaltafw, lxMailHoraexpo, lxMailBdmodifw, lxMailBdaltafw, lxMailHmodifw, lxMailSmodifw, lxMailUmodifw, lxMailUaltafw, lxMailTipagrupub, lxMailCodigo, lxMailObs, lxMailTexto, lxMailDescr, lxMailCondic, lxMailEnvguar, lxMailServ, lxMailEnvio, lxMailMpara, lxMailMcc, lxMailMcco, lxMailAsunto
				lxMailFecimpo =  .Fechaimpo			lxMailFectrans =  .Fechatransferencia			lxMailFmodifw =  .Fechamodificacionfw			lxMailFecexpo =  .Fechaexpo			lxMailFaltafw =  .Fechaaltafw			lxMailZadsfw =  .Zadsfw			lxMailEsttrans =  .Estadotransferencia			lxMailValtafw =  .Versionaltafw			lxMailVmodifw =  .Versionmodificacionfw			lxMailSaltafw =  .Seriealtafw			lxMailHoraimpo =  .Horaimpo			lxMailHaltafw =  .Horaaltafw			lxMailHoraexpo =  .Horaexpo			lxMailBdmodifw =  .Basededatosmodificacionfw			lxMailBdaltafw =  .Basededatosaltafw			lxMailHmodifw =  .Horamodificacionfw			lxMailSmodifw =  .Seriemodificacionfw			lxMailUmodifw =  .Usuariomodificacionfw			lxMailUaltafw =  .Usuarioaltafw			lxMailTipagrupub =  .Tipoagrupamientopublicaciones			lxMailCodigo =  .Codigo			lxMailObs =  .Observacion			lxMailTexto =  .Texto			lxMailDescr =  .Descripcion			lxMailCondic =  .Condicion			lxMailEnvguar =  .Enviaralguardar			lxMailServ =  upper( .Servidor_PK ) 			lxMailEnvio =  .Confirmaenvio			lxMailMpara =  .Mailpara			lxMailMcc =  .Mailcopia			lxMailMcco =  .Mailcopiaoculta			lxMailAsunto =  .Asunto
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.MAIL set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMailFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxMailFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxMailFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxMailFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMailFaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMailZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMailEsttrans ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMailValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMailVmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMailSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMailHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMailHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMailHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMailBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMailBdaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMailHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMailSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMailUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMailUaltafw ) + "'">>,"Tipagrupub" = <<lxMailTipagrupub>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxMailCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxMailObs ) + "'">>,"Texto" = <<"'" + this.FormatearTextoSql( lxMailTexto ) + "'">>,"Descr" = <<"'" + this.FormatearTextoSql( lxMailDescr ) + "'">>,"Condic" = <<"'" + this.FormatearTextoSql( lxMailCondic ) + "'">>,"Envguar" = <<iif( lxMailEnvguar, 1, 0 )>>,"Serv" = <<"'" + this.FormatearTextoSql( lxMailServ ) + "'">>,"Envio" = <<lxMailEnvio>>,"Mpara" = <<"'" + this.FormatearTextoSql( lxMailMpara ) + "'">>,"Mcc" = <<"'" + this.FormatearTextoSql( lxMailMcc ) + "'">>,"Mcco" = <<"'" + this.FormatearTextoSql( lxMailMcco ) + "'">>,"Asunto" = <<"'" + this.FormatearTextoSql( lxMailAsunto ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxMailCodigo ) + "'">> and  MAIL.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisEntMAIL where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubMIL where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.mailarch where "arccod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEntMAIL("NROITEM","iCod","iEnt" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubMIL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArchivosDetalle
				if this.oEntidad.ArchivosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArchivo = loItem.Archivo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.mailarch("NROITEM","arccod","archivo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArchivo ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.MAIL where " + this.ConvertirFuncionesSql( " MAIL.CODIGO != ''" ) )
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
			Local lxMailCodigo
			lxMailCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Texto" as "Texto", "Descr" as "Descripcion", "Condic" as "Condicion", "Envguar" as "Enviaralguardar", "Serv" as "Servidor", "Envio" as "Confirmaenvio", "Mpara" as "Mailpara", "Mcc" as "Mailcopia", "Mcco" as "Mailcopiaoculta", "Asunto" as "Asunto" from ZooLogic.MAIL where "Codigo" = <<"'" + this.FormatearTextoSql( lxMailCodigo ) + "'">> and  MAIL.CODIGO != ''
			endtext
			use in select('c_EMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EMAIL', set( 'Datasession' ) )

			if reccount( 'c_EMAIL' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEntMAIL where iCod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubMIL where Codigo = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Arccod" as "Codigo", "Archivo" as "Archivo" from ZooLogic.mailarch where arccod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArchivosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArchivosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArchivosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMailCodigo as Variant
		llRetorno = .t.
		lxMailCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MAIL where "Codigo" = <<"'" + this.FormatearTextoSql( lxMailCodigo ) + "'">> and  MAIL.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Texto" as "Texto", "Descr" as "Descripcion", "Condic" as "Condicion", "Envguar" as "Enviaralguardar", "Serv" as "Servidor", "Envio" as "Confirmaenvio", "Mpara" as "Mailpara", "Mcc" as "Mailcopia", "Mcco" as "Mailcopiaoculta", "Asunto" as "Asunto" from ZooLogic.MAIL where  MAIL.CODIGO != '' order by codigo
			endtext
			use in select('c_EMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EMAIL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEntMAIL where iCod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubMIL where Codigo = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Arccod" as "Codigo", "Archivo" as "Archivo" from ZooLogic.mailarch where arccod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArchivosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArchivosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArchivosDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Texto" as "Texto", "Descr" as "Descripcion", "Condic" as "Condicion", "Envguar" as "Enviaralguardar", "Serv" as "Servidor", "Envio" as "Confirmaenvio", "Mpara" as "Mailpara", "Mcc" as "Mailcopia", "Mcco" as "Mailcopiaoculta", "Asunto" as "Asunto" from ZooLogic.MAIL where  funciones.padr( codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MAIL.CODIGO != '' order by codigo
			endtext
			use in select('c_EMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EMAIL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEntMAIL where iCod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubMIL where Codigo = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Arccod" as "Codigo", "Archivo" as "Archivo" from ZooLogic.mailarch where arccod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArchivosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArchivosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArchivosDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Texto" as "Texto", "Descr" as "Descripcion", "Condic" as "Condicion", "Envguar" as "Enviaralguardar", "Serv" as "Servidor", "Envio" as "Confirmaenvio", "Mpara" as "Mailpara", "Mcc" as "Mailcopia", "Mcco" as "Mailcopiaoculta", "Asunto" as "Asunto" from ZooLogic.MAIL where  funciones.padr( codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MAIL.CODIGO != '' order by codigo desc
			endtext
			use in select('c_EMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EMAIL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEntMAIL where iCod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubMIL where Codigo = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Arccod" as "Codigo", "Archivo" as "Archivo" from ZooLogic.mailarch where arccod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArchivosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArchivosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArchivosDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Texto" as "Texto", "Descr" as "Descripcion", "Condic" as "Condicion", "Envguar" as "Enviaralguardar", "Serv" as "Servidor", "Envio" as "Confirmaenvio", "Mpara" as "Mailpara", "Mcc" as "Mailcopia", "Mcco" as "Mailcopiaoculta", "Asunto" as "Asunto" from ZooLogic.MAIL where  MAIL.CODIGO != '' order by codigo desc
			endtext
			use in select('c_EMAIL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EMAIL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEntMAIL where iCod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubMIL where Codigo = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Arccod" as "Codigo", "Archivo" as "Archivo" from ZooLogic.mailarch where arccod = <<"'" + this.FormatearTextoSql( c_EMAIL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArchivosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArchivosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArchivosDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Zadsfw,Esttrans,Valtafw,Vmodifw,Saltafw,Horaimpo,Ha" + ;
"ltafw,Horaexpo,Bdmodifw,Bdaltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Tipagrupub,Codigo,Obs,Texto,Descr,C" + ;
"ondic,Envguar,Serv,Envio,Mpara,Mcc,Mcco,Asunto" + ;
" from ZooLogic.MAIL where  MAIL.CODIGO != '' and " + lcFiltro )
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
			local  lxMailFecimpo, lxMailFectrans, lxMailFmodifw, lxMailFecexpo, lxMailFaltafw, lxMailZadsfw, lxMailEsttrans, lxMailValtafw, lxMailVmodifw, lxMailSaltafw, lxMailHoraimpo, lxMailHaltafw, lxMailHoraexpo, lxMailBdmodifw, lxMailBdaltafw, lxMailHmodifw, lxMailSmodifw, lxMailUmodifw, lxMailUaltafw, lxMailTipagrupub, lxMailCodigo, lxMailObs, lxMailTexto, lxMailDescr, lxMailCondic, lxMailEnvguar, lxMailServ, lxMailEnvio, lxMailMpara, lxMailMcc, lxMailMcco, lxMailAsunto
				lxMailFecimpo = ctod( '  /  /    ' )			lxMailFectrans = ctod( '  /  /    ' )			lxMailFmodifw = ctod( '  /  /    ' )			lxMailFecexpo = ctod( '  /  /    ' )			lxMailFaltafw = ctod( '  /  /    ' )			lxMailZadsfw = []			lxMailEsttrans = []			lxMailValtafw = []			lxMailVmodifw = []			lxMailSaltafw = []			lxMailHoraimpo = []			lxMailHaltafw = []			lxMailHoraexpo = []			lxMailBdmodifw = []			lxMailBdaltafw = []			lxMailHmodifw = []			lxMailSmodifw = []			lxMailUmodifw = []			lxMailUaltafw = []			lxMailTipagrupub = 0			lxMailCodigo = []			lxMailObs = []			lxMailTexto = []			lxMailDescr = []			lxMailCondic = []			lxMailEnvguar = .F.			lxMailServ = []			lxMailEnvio = 0			lxMailMpara = []			lxMailMcc = []			lxMailMcco = []			lxMailAsunto = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisEntMAIL where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubMIL where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.mailarch where "arccod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MAIL where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MAIL' + '_' + tcCampo
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
		lcWhere = " Where  MAIL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Texto" as "Texto", "Descr" as "Descripcion", "Condic" as "Condicion", "Envguar" as "Enviaralguardar", "Serv" as "Servidor", "Envio" as "Confirmaenvio", "Mpara" as "Mailpara", "Mcc" as "Mailcopia", "Mcco" as "Mailcopiaoculta", "Asunto" as "Asunto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MAIL', '', tnTope )
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
	Function ObtenerDatosDetalleEntidades( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISENTMAIL.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Icod" as "Codigo", "Ient" as "Entidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleEntidades( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisEntMAIL', 'Entidades', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleEntidades( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleEntidades( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBMIL.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubMIL', 'AgruPubliDetalle', tnTope )
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
	Function ObtenerDatosDetalleArchivosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MAILARCH.ARCCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Arccod" as "Codigo", "Archivo" as "Archivo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleArchivosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'mailarch', 'ArchivosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleArchivosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleArchivosDetalle( lcAtributo )
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
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'TEXTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEXTO AS TEXTO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCR AS DESCRIPCION'
				Case lcAtributo == 'CONDICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIC AS CONDICION'
				Case lcAtributo == 'ENVIARALGUARDAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENVGUAR AS ENVIARALGUARDAR'
				Case lcAtributo == 'SERVIDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERV AS SERVIDOR'
				Case lcAtributo == 'CONFIRMAENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENVIO AS CONFIRMAENVIO'
				Case lcAtributo == 'MAILPARA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MPARA AS MAILPARA'
				Case lcAtributo == 'MAILCOPIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCC AS MAILCOPIA'
				Case lcAtributo == 'MAILCOPIAOCULTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCCO AS MAILCOPIAOCULTA'
				Case lcAtributo == 'ASUNTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ASUNTO AS ASUNTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleEntidades( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOD AS CODIGO'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IENT AS ENTIDAD'
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
	Function ObtenerCamposSelectDetalleArchivosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARCCOD AS CODIGO'
				Case lcAtributo == 'ARCHIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARCHIVO AS ARCHIVO'
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
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'TEXTO'
				lcCampo = 'TEXTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCR'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICION'
				lcCampo = 'CONDIC'
			Case upper( alltrim( tcAtributo ) ) == 'ENVIARALGUARDAR'
				lcCampo = 'ENVGUAR'
			Case upper( alltrim( tcAtributo ) ) == 'SERVIDOR'
				lcCampo = 'SERV'
			Case upper( alltrim( tcAtributo ) ) == 'CONFIRMAENVIO'
				lcCampo = 'ENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'MAILPARA'
				lcCampo = 'MPARA'
			Case upper( alltrim( tcAtributo ) ) == 'MAILCOPIA'
				lcCampo = 'MCC'
			Case upper( alltrim( tcAtributo ) ) == 'MAILCOPIAOCULTA'
				lcCampo = 'MCCO'
			Case upper( alltrim( tcAtributo ) ) == 'ASUNTO'
				lcCampo = 'ASUNTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleEntidades( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ICOD'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'IENT'
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
	Function ObtenerCampoDetalleArchivosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ARCCOD'
			Case upper( alltrim( tcAtributo ) ) == 'ARCHIVO'
				lcCampo = 'ARCHIVO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ENTIDADES'
			lcRetorno = 'DISENTMAIL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBMIL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ARCHIVOSDETALLE'
			lcRetorno = 'MAILARCH'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxMailFecimpo, lxMailFectrans, lxMailFmodifw, lxMailFecexpo, lxMailFaltafw, lxMailZadsfw, lxMailEsttrans, lxMailValtafw, lxMailVmodifw, lxMailSaltafw, lxMailHoraimpo, lxMailHaltafw, lxMailHoraexpo, lxMailBdmodifw, lxMailBdaltafw, lxMailHmodifw, lxMailSmodifw, lxMailUmodifw, lxMailUaltafw, lxMailTipagrupub, lxMailCodigo, lxMailObs, lxMailTexto, lxMailDescr, lxMailCondic, lxMailEnvguar, lxMailServ, lxMailEnvio, lxMailMpara, lxMailMcc, lxMailMcco, lxMailAsunto
				lxMailFecimpo =  .Fechaimpo			lxMailFectrans =  .Fechatransferencia			lxMailFmodifw =  .Fechamodificacionfw			lxMailFecexpo =  .Fechaexpo			lxMailFaltafw =  .Fechaaltafw			lxMailZadsfw =  .Zadsfw			lxMailEsttrans =  .Estadotransferencia			lxMailValtafw =  .Versionaltafw			lxMailVmodifw =  .Versionmodificacionfw			lxMailSaltafw =  .Seriealtafw			lxMailHoraimpo =  .Horaimpo			lxMailHaltafw =  .Horaaltafw			lxMailHoraexpo =  .Horaexpo			lxMailBdmodifw =  .Basededatosmodificacionfw			lxMailBdaltafw =  .Basededatosaltafw			lxMailHmodifw =  .Horamodificacionfw			lxMailSmodifw =  .Seriemodificacionfw			lxMailUmodifw =  .Usuariomodificacionfw			lxMailUaltafw =  .Usuarioaltafw			lxMailTipagrupub =  .Tipoagrupamientopublicaciones			lxMailCodigo =  .Codigo			lxMailObs =  .Observacion			lxMailTexto =  .Texto			lxMailDescr =  .Descripcion			lxMailCondic =  .Condicion			lxMailEnvguar =  .Enviaralguardar			lxMailServ =  upper( .Servidor_PK ) 			lxMailEnvio =  .Confirmaenvio			lxMailMpara =  .Mailpara			lxMailMcc =  .Mailcopia			lxMailMcco =  .Mailcopiaoculta			lxMailAsunto =  .Asunto
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MAIL ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Zadsfw","Esttrans","Valtafw","Vmodifw","Saltafw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Tipagrupub","Codigo","Obs","Texto","Descr","Condic","Envguar","Serv","Envio","Mpara","Mcc","Mcco","Asunto" ) values ( <<"'" + this.ConvertirDateSql( lxMailFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMailFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailUaltafw ) + "'" >>, <<lxMailTipagrupub >>, <<"'" + this.FormatearTextoSql( lxMailCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailTexto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailDescr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailCondic ) + "'" >>, <<iif( lxMailEnvguar, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxMailServ ) + "'" >>, <<lxMailEnvio >>, <<"'" + this.FormatearTextoSql( lxMailMpara ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailMcc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailMcco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMailAsunto ) + "'" >> )
		endtext
		loColeccion.cTabla = 'MAIL' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEntMAIL("NROITEM","iCod","iEnt" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubMIL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArchivosDetalle
				if this.oEntidad.ArchivosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArchivo = loItem.Archivo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.mailarch("NROITEM","arccod","archivo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArchivo ) + "'">> ) 
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
			local  lxMailFecimpo, lxMailFectrans, lxMailFmodifw, lxMailFecexpo, lxMailFaltafw, lxMailZadsfw, lxMailEsttrans, lxMailValtafw, lxMailVmodifw, lxMailSaltafw, lxMailHoraimpo, lxMailHaltafw, lxMailHoraexpo, lxMailBdmodifw, lxMailBdaltafw, lxMailHmodifw, lxMailSmodifw, lxMailUmodifw, lxMailUaltafw, lxMailTipagrupub, lxMailCodigo, lxMailObs, lxMailTexto, lxMailDescr, lxMailCondic, lxMailEnvguar, lxMailServ, lxMailEnvio, lxMailMpara, lxMailMcc, lxMailMcco, lxMailAsunto
				lxMailFecimpo =  .Fechaimpo			lxMailFectrans =  .Fechatransferencia			lxMailFmodifw =  .Fechamodificacionfw			lxMailFecexpo =  .Fechaexpo			lxMailFaltafw =  .Fechaaltafw			lxMailZadsfw =  .Zadsfw			lxMailEsttrans =  .Estadotransferencia			lxMailValtafw =  .Versionaltafw			lxMailVmodifw =  .Versionmodificacionfw			lxMailSaltafw =  .Seriealtafw			lxMailHoraimpo =  .Horaimpo			lxMailHaltafw =  .Horaaltafw			lxMailHoraexpo =  .Horaexpo			lxMailBdmodifw =  .Basededatosmodificacionfw			lxMailBdaltafw =  .Basededatosaltafw			lxMailHmodifw =  .Horamodificacionfw			lxMailSmodifw =  .Seriemodificacionfw			lxMailUmodifw =  .Usuariomodificacionfw			lxMailUaltafw =  .Usuarioaltafw			lxMailTipagrupub =  .Tipoagrupamientopublicaciones			lxMailCodigo =  .Codigo			lxMailObs =  .Observacion			lxMailTexto =  .Texto			lxMailDescr =  .Descripcion			lxMailCondic =  .Condicion			lxMailEnvguar =  .Enviaralguardar			lxMailServ =  upper( .Servidor_PK ) 			lxMailEnvio =  .Confirmaenvio			lxMailMpara =  .Mailpara			lxMailMcc =  .Mailcopia			lxMailMcco =  .Mailcopiaoculta			lxMailAsunto =  .Asunto
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MAIL.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MAIL set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMailFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxMailFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMailFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMailFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMailFaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMailZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMailEsttrans ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMailValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMailVmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMailSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMailHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMailHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMailHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMailBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMailBdaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMailHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMailSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMailUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMailUaltafw ) + "'">>, "Tipagrupub" = <<lxMailTipagrupub>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxMailCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxMailObs ) + "'">>, "Texto" = <<"'" + this.FormatearTextoSql( lxMailTexto ) + "'">>, "Descr" = <<"'" + this.FormatearTextoSql( lxMailDescr ) + "'">>, "Condic" = <<"'" + this.FormatearTextoSql( lxMailCondic ) + "'">>, "Envguar" = <<iif( lxMailEnvguar, 1, 0 )>>, "Serv" = <<"'" + this.FormatearTextoSql( lxMailServ ) + "'">>, "Envio" = <<lxMailEnvio>>, "Mpara" = <<"'" + this.FormatearTextoSql( lxMailMpara ) + "'">>, "Mcc" = <<"'" + this.FormatearTextoSql( lxMailMcc ) + "'">>, "Mcco" = <<"'" + this.FormatearTextoSql( lxMailMcco ) + "'">>, "Asunto" = <<"'" + this.FormatearTextoSql( lxMailAsunto ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MAIL' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DisEntMAIL where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubMIL where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.mailarch where "arccod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEntMAIL("NROITEM","iCod","iEnt" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubMIL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArchivosDetalle
				if this.oEntidad.ArchivosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArchivo = loItem.Archivo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.mailarch("NROITEM","arccod","archivo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArchivo ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MAIL.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MAIL where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DisEntMAIL where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubMIL where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.mailarch where "arccod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MAIL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MAIL where  MAIL.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MAIL where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MAIL.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'EMAIL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MAIL Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MAIL set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, obs = ] + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"+ [, Texto = ] + "'" + this.FormatearTextoSql( &lcCursor..Texto ) + "'"+ [, descr = ] + "'" + this.FormatearTextoSql( &lcCursor..descr ) + "'"+ [, condic = ] + "'" + this.FormatearTextoSql( &lcCursor..condic ) + "'"+ [, envguar = ] + Transform( iif( &lcCursor..envguar, 1, 0 ))+ [, serv = ] + "'" + this.FormatearTextoSql( &lcCursor..serv ) + "'"+ [, envio = ] + transform( &lcCursor..envio )+ [, mPara = ] + "'" + this.FormatearTextoSql( &lcCursor..mPara ) + "'"+ [, mCC = ] + "'" + this.FormatearTextoSql( &lcCursor..mCC ) + "'"+ [, mCCo = ] + "'" + this.FormatearTextoSql( &lcCursor..mCCo ) + "'"+ [, asunto = ] + "'" + this.FormatearTextoSql( &lcCursor..asunto ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, ZADSFW, ESTTRANS, VALTAFW, VMODIFW, SALTAFW, HORAIMPO, HALTAFW, HORAEXPO, BDMODIFW, BDALTAFW, HMODIFW, SMODIFW, UMODIFW, UALTAFW, tipagrupub, codigo, obs, Texto, descr, condic, envguar, serv, envio, mPara, mCC, mCCo, asunto
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Texto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..descr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..condic ) + "'" + ',' + Transform( iif( &lcCursor..envguar, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..serv ) + "'" + ',' + transform( &lcCursor..envio )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..mPara ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..mCC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..mCCo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..asunto ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MAIL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'EMAIL'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DisEntMAIL Where iCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubMIL Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.mailarch Where arccod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMENTIDADESMAIL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","iCod","iEnt"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DisEntMAIL ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iEnt       ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICMIL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubMIL ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARCHIVOSMAIL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where arccod in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","arccod","archivo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.mailarch ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.arccod     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.archivo    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (20) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'EMAIL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'EMAIL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'EMAIL_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'EMAIL_TEXTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMENTIDADESMAIL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICMIL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARCHIVOSMAIL'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_mail')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'EMAIL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad EMAIL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'EMAIL'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'EMAIL'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_mail') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_mail
Create Table ZooLogic.TablaTrabajo_mail ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"codigo" char( 20 )  null, 
"obs" varchar(max)  null, 
"texto" varchar(max)  null, 
"descr" char( 80 )  null, 
"condic" char( 254 )  null, 
"envguar" bit  null, 
"serv" char( 10 )  null, 
"envio" numeric( 2, 0 )  null, 
"mpara" char( 200 )  null, 
"mcc" char( 200 )  null, 
"mcco" char( 200 )  null, 
"asunto" char( 200 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_mail' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_mail' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'EMAIL'
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
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('texto','texto')
			.AgregarMapeo('descr','descr')
			.AgregarMapeo('condic','condic')
			.AgregarMapeo('envguar','envguar')
			.AgregarMapeo('serv','serv')
			.AgregarMapeo('envio','envio')
			.AgregarMapeo('mpara','mpara')
			.AgregarMapeo('mcc','mcc')
			.AgregarMapeo('mcco','mcco')
			.AgregarMapeo('asunto','asunto')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_mail'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.TEXTO = isnull( d.TEXTO, t.TEXTO ),t.DESCR = isnull( d.DESCR, t.DESCR ),t.CONDIC = isnull( d.CONDIC, t.CONDIC ),t.ENVGUAR = isnull( d.ENVGUAR, t.ENVGUAR ),t.SERV = isnull( d.SERV, t.SERV ),t.ENVIO = isnull( d.ENVIO, t.ENVIO ),t.MPARA = isnull( d.MPARA, t.MPARA ),t.MCC = isnull( d.MCC, t.MCC ),t.MCCO = isnull( d.MCCO, t.MCCO ),t.ASUNTO = isnull( d.ASUNTO, t.ASUNTO )
					from ZooLogic.MAIL t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ZooLogic.MAIL(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Zadsfw,Esttrans,Valtafw,Vmodifw,Saltafw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Tipagrupub,Codigo,Obs,Texto,Descr,Condic,Envguar,Serv,Envio,Mpara,Mcc,Mcco,Asunto)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.TIPAGRUPUB,0),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.TEXTO,''),isnull( d.DESCR,''),isnull( d.CONDIC,''),isnull( d.ENVGUAR,0),isnull( d.SERV,''),isnull( d.ENVIO,0),isnull( d.MPARA,''),isnull( d.MCC,''),isnull( d.MCCO,''),isnull( d.ASUNTO,'')
						From deleted d left join ZooLogic.MAIL pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisEntMAIL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MAIL_DisEntMAIL
ON ZooLogic.TablaTrabajo_MAIL_DisEntMAIL
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.IENT = isnull( d.IENT, t.IENT )
from ZooLogic.DisEntMAIL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DisEntMAIL
( 
"NROITEM",
"ICOD",
"IENT"
 )
Select 
d.NROITEM,
d.ICOD,
d.IENT
From deleted d left join ZooLogic.DisEntMAIL pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubMIL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MAIL_AgruPubMIL
ON ZooLogic.TablaTrabajo_MAIL_AgruPubMIL
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubMIL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubMIL
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
From deleted d left join ZooLogic.AgruPubMIL pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_mailarch( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MAIL_mailarch
ON ZooLogic.TablaTrabajo_MAIL_mailarch
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.ARCCOD = isnull( d.ARCCOD, t.ARCCOD ),
t.ARCHIVO = isnull( d.ARCHIVO, t.ARCHIVO )
from ZooLogic.mailarch t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.mailarch
( 
"NROITEM",
"ARCCOD",
"ARCHIVO"
 )
Select 
d.NROITEM,
d.ARCCOD,
d.ARCHIVO
From deleted d left join ZooLogic.mailarch pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_mail') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_mail
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_EMAIL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_EMAIL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_EMAIL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_EMAIL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_EMAIL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_EMAIL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_EMAIL.Estadotransferencia, [] )
					.Versionaltafw = nvl( c_EMAIL.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_EMAIL.Versionmodificacionfw, [] )
					.Seriealtafw = nvl( c_EMAIL.Seriealtafw, [] )
					.Horaimpo = nvl( c_EMAIL.Horaimpo, [] )
					.Horaaltafw = nvl( c_EMAIL.Horaaltafw, [] )
					.Horaexpo = nvl( c_EMAIL.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_EMAIL.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_EMAIL.Basededatosaltafw, [] )
					.Horamodificacionfw = nvl( c_EMAIL.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_EMAIL.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_EMAIL.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_EMAIL.Usuarioaltafw, [] )
					.Tipoagrupamientopublicaciones = nvl( c_EMAIL.Tipoagrupamientopublicaciones, 0 )
					.Codigo = nvl( c_EMAIL.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					lcValor = This.ObtenerMemo( 'c_Texto')
					.Texto = lcValor 
					.Entidades.Limpiar()
					.Entidades.SetearEsNavegacion( .lProcesando )
					.Entidades.Cargar()
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Descripcion = nvl( c_EMAIL.Descripcion, [] )
					.Condicion = nvl( c_EMAIL.Condicion, [] )
					.Enviaralguardar = nvl( c_EMAIL.Enviaralguardar, .F. )
					.Servidor_PK =  nvl( c_EMAIL.Servidor, [] )
					.Confirmaenvio = nvl( c_EMAIL.Confirmaenvio, 0 )
					.Archivosdetalle.Limpiar()
					.Archivosdetalle.SetearEsNavegacion( .lProcesando )
					.Archivosdetalle.Cargar()
					.Mailpara = nvl( c_EMAIL.Mailpara, [] )
					.Mailcopia = nvl( c_EMAIL.Mailcopia, [] )
					.Mailcopiaoculta = nvl( c_EMAIL.Mailcopiaoculta, [] )
					.Asunto = nvl( c_EMAIL.Asunto, [] )
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
		
		loDetalle = this.oEntidad.Entidades
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

		loDetalle = this.oEntidad.ArchivosDetalle
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
		return c_EMAIL.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MAIL' )
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
								from ZooLogic.MAIL 
								Where   MAIL.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MAIL", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Obs" as "Observacion", "Texto" as "Texto", "Descr" as "Descripcion", "Condic" as "Condicion", "Envguar" as "Enviaralguardar", "Serv" as "Servidor", "Envio" as "Confirmaenvio", "Mpara" as "Mailpara", "Mcc" as "Mailcopia", "Mcco" as "Mailcopiaoculta", "Asunto" as "Asunto"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MAIL 
								Where   MAIL.CODIGO != ''
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
	Tabla = 'MAIL'
	Filtro = " MAIL.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MAIL.CODIGO != ''"
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
	<row entidad="EMAIL                                   " atributo="FECHAIMPO                               " tabla="MAIL           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="FECHATRANSFERENCIA                      " tabla="MAIL           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="FECHAMODIFICACIONFW                     " tabla="MAIL           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="FECHAEXPO                               " tabla="MAIL           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="FECHAALTAFW                             " tabla="MAIL           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="ZADSFW                                  " tabla="MAIL           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="ESTADOTRANSFERENCIA                     " tabla="MAIL           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="VERSIONALTAFW                           " tabla="MAIL           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="VERSIONMODIFICACIONFW                   " tabla="MAIL           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="SERIEALTAFW                             " tabla="MAIL           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="HORAIMPO                                " tabla="MAIL           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="HORAALTAFW                              " tabla="MAIL           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="HORAEXPO                                " tabla="MAIL           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MAIL           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="BASEDEDATOSALTAFW                       " tabla="MAIL           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="HORAMODIFICACIONFW                      " tabla="MAIL           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="SERIEMODIFICACIONFW                     " tabla="MAIL           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="USUARIOMODIFICACIONFW                   " tabla="MAIL           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="USUARIOALTAFW                           " tabla="MAIL           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="MAIL           " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="CODIGO                                  " tabla="MAIL           " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="OBSERVACION                             " tabla="MAIL           " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="TEXTO                                   " tabla="MAIL           " campo="TEXTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Cuerpo                                                                                                                                                          " dominio="OBSERVACION10R                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="ENTIDADES                               " tabla="DISENTMAIL     " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Entidades afectadas                                                                                                                                             " dominio="DETALLEITEMENTIDADESMAIL      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBMIL     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICMIL    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="DESCRIPCION                             " tabla="MAIL           " campo="DESCR     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="CONDICION                               " tabla="MAIL           " campo="CONDIC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Condición                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="ENVIARALGUARDAR                         " tabla="MAIL           " campo="ENVGUAR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Enviar al guardar                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="20" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="SERVIDOR                                " tabla="MAIL           " campo="SERV      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTACORREO                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Cuenta                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="CONFIRMAENVIO                           " tabla="MAIL           " campo="ENVIO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Confirma envío                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="20" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="ARCHIVOSDETALLE                         " tabla="MAILARCH       " campo="ARCCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Adjuntos                                                                                                                                                        " dominio="DETALLEITEMARCHIVOSMAIL       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="20" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="MAILPARA                                " tabla="MAIL           " campo="MPARA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Para                                                                                                                                                            " dominio="MAILATRIBUTO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="110" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="MAILCOPIA                               " tabla="MAIL           " campo="MCC       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Con copia                                                                                                                                                       " dominio="MAILATRIBUTO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="120" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="MAILCOPIAOCULTA                         " tabla="MAIL           " campo="MCCO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Con copia oculta                                                                                                                                                " dominio="MAILATRIBUTO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="130" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EMAIL                                   " atributo="ASUNTO                                  " tabla="MAIL           " campo="ASUNTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Asunto                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="140" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTACORREO                            " atributo="DESCRIPCION                             " tabla="CCORREO        " campo="DESCR     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CCORREO On MAIL.SERV = CCORREO.codigo And  CCORREO.CODIGO != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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