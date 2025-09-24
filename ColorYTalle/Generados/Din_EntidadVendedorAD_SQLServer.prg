
define class Din_EntidadVENDEDORAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_VENDEDOR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_VENPK'
	cTablaPrincipal = 'VEN'
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
			local  lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenFaltafw, lxVenFecexpo, lxVenHaltafw, lxVenSaltafw, lxVenValtafw, lxVenZadsfw, lxVenVmodifw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHoraimpo, lxVenEsttrans, lxVenHmodifw, lxVenHoraexpo, lxVenBdmodifw, lxVenBdaltafw, lxVenCltlf, lxVenDescfw, lxVenTipagrupub, lxVenTimestamp, lxVenClpun1, lxVenInactivofw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenCltipodoc, lxVenCldir, lxVenCltlfm, lxVenClpun2, lxVenClnom, lxVenClas, lxVenClfecha, lxVenClemail, lxVenClnrodoc, lxVenClnum, lxVenCldesc, lxVenClfing, lxVenClpiso, lxVenClfegr, lxVenCldepto, lxVenClloc, lxVenClcp, lxVenClprv, lxVenPpais
				lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenHaltafw =  .Horaaltafw			lxVenSaltafw =  .Seriealtafw			lxVenValtafw =  .Versionaltafw			lxVenZadsfw =  .Zadsfw			lxVenVmodifw =  .Versionmodificacionfw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHoraimpo =  .Horaimpo			lxVenEsttrans =  .Estadotransferencia			lxVenHmodifw =  .Horamodificacionfw			lxVenHoraexpo =  .Horaexpo			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenBdaltafw =  .Basededatosaltafw			lxVenCltlf =  .Telefono			lxVenDescfw =  .Descripcionfw			lxVenTipagrupub =  .Tipoagrupamientopublicaciones			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenInactivofw =  .Inactivofw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenCltlfm =  .Movil			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClnom =  .Nombre			lxVenClas =  upper( .Clasificacion_PK ) 			lxVenClfecha =  .Fechanacimiento			lxVenClemail =  .Email			lxVenClnrodoc =  .Nrodocumento			lxVenClnum =  .Numero			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClfegr =  .Fechaegreso			lxVenCldepto =  .Departamento			lxVenClloc =  .Localidad			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 			lxVenPpais =  upper( .Pais_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxVenClcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.VEN ( "Fectrans","Fmodifw","Fecimpo","Faltafw","Fecexpo","Haltafw","Saltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Smodifw","Ualtafw","Horaimpo","Esttrans","Hmodifw","Horaexpo","Bdmodifw","Bdaltafw","Cltlf","Descfw","Tipagrupub","Timestamp","Clpun1","Inactivofw","Cimagen","Clcod","Clobs","Cltipodoc","Cldir","Cltlfm","Clpun2","Clnom","Clas","Clfecha","Clemail","Clnrodoc","Clnum","Cldesc","Clfing","Clpiso","Clfegr","Cldepto","Clloc","Clcp","Clprv","Ppais" ) values ( <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenDescfw ) + "'" >>, <<lxVenTipagrupub >>, <<lxVenTimestamp >>, <<lxVenClpun1 >>, <<iif( lxVenInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'" >>, <<lxVenClpun2 >>, <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClas ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'" >>, <<lxVenClnum >>, <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenPpais ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComisionesDetalle
				if this.oEntidad.ComisionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComision_PK = loItem.Comision_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetComVen("NROITEM","Codigo","Comision" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxComision_PK ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubVEN("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxVenTimestamp
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
			local  lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenFaltafw, lxVenFecexpo, lxVenHaltafw, lxVenSaltafw, lxVenValtafw, lxVenZadsfw, lxVenVmodifw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHoraimpo, lxVenEsttrans, lxVenHmodifw, lxVenHoraexpo, lxVenBdmodifw, lxVenBdaltafw, lxVenCltlf, lxVenDescfw, lxVenTipagrupub, lxVenTimestamp, lxVenClpun1, lxVenInactivofw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenCltipodoc, lxVenCldir, lxVenCltlfm, lxVenClpun2, lxVenClnom, lxVenClas, lxVenClfecha, lxVenClemail, lxVenClnrodoc, lxVenClnum, lxVenCldesc, lxVenClfing, lxVenClpiso, lxVenClfegr, lxVenCldepto, lxVenClloc, lxVenClcp, lxVenClprv, lxVenPpais
				lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenHaltafw =  .Horaaltafw			lxVenSaltafw =  .Seriealtafw			lxVenValtafw =  .Versionaltafw			lxVenZadsfw =  .Zadsfw			lxVenVmodifw =  .Versionmodificacionfw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHoraimpo =  .Horaimpo			lxVenEsttrans =  .Estadotransferencia			lxVenHmodifw =  .Horamodificacionfw			lxVenHoraexpo =  .Horaexpo			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenBdaltafw =  .Basededatosaltafw			lxVenCltlf =  .Telefono			lxVenDescfw =  .Descripcionfw			lxVenTipagrupub =  .Tipoagrupamientopublicaciones			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenInactivofw =  .Inactivofw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenCltlfm =  .Movil			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClnom =  .Nombre			lxVenClas =  upper( .Clasificacion_PK ) 			lxVenClfecha =  .Fechanacimiento			lxVenClemail =  .Email			lxVenClnrodoc =  .Nrodocumento			lxVenClnum =  .Numero			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClfegr =  .Fechaegreso			lxVenCldepto =  .Departamento			lxVenClloc =  .Localidad			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 			lxVenPpais =  upper( .Pais_PK ) 
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.VEN set "Fectrans" = <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxVenDescfw ) + "'">>,"Tipagrupub" = <<lxVenTipagrupub>>,"Timestamp" = <<lxVenTimestamp>>,"Clpun1" = <<lxVenClpun1>>,"Inactivofw" = <<iif( lxVenInactivofw, 1, 0 )>>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'">>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'">>,"Cldir" = <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'">>,"Cltlfm" = <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'">>,"Clpun2" = <<lxVenClpun2>>,"Clnom" = <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'">>,"Clas" = <<"'" + this.FormatearTextoSql( lxVenClas ) + "'">>,"Clfecha" = <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'">>,"Clemail" = <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'">>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'">>,"Clnum" = <<lxVenClnum>>,"Cldesc" = <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'">>,"Clfing" = <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'">>,"Clpiso" = <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'">>,"Clfegr" = <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'">>,"Cldepto" = <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'">>,"Clloc" = <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'">>,"Clcp" = <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'">>,"Clprv" = <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'">>,"Ppais" = <<"'" + this.FormatearTextoSql( lxVenPpais ) + "'">> where "Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">> and  VEN.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetComVen where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubVEN where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComisionesDetalle
				if this.oEntidad.ComisionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComision_PK = loItem.Comision_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetComVen("NROITEM","Codigo","Comision" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxComision_PK ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubVEN("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxVenTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CLCOD from ZooLogic.VEN where " + this.ConvertirFuncionesSql( " VEN.CLCOD != ''" ) )
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
			Local lxVenClcod
			lxVenClcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Descfw" as "Descripcionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clpun1" as "Descmaxdetallefacturas", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Descmaxtotalfacturas", "Clnom" as "Nombre", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cldesc" as "Descuentopreferente", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfegr" as "Fechaegreso", "Cldepto" as "Departamento", "Clloc" as "Localidad", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.VEN where "Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">> and  VEN.CLCOD != ''
			endtext
			use in select('c_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VENDEDOR', set( 'Datasession' ) )

			if reccount( 'c_VENDEDOR' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comision" as "Comision" from ZooLogic.DetComVen where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComisionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComisionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComisionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVEN where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxVenClcod as Variant
		llRetorno = .t.
		lxVenClcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.VEN where "Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">> and  VEN.CLCOD != ''
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Descfw" as "Descripcionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clpun1" as "Descmaxdetallefacturas", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Descmaxtotalfacturas", "Clnom" as "Nombre", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cldesc" as "Descuentopreferente", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfegr" as "Fechaegreso", "Cldepto" as "Departamento", "Clloc" as "Localidad", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.VEN where  VEN.CLCOD != '' order by CLCOD
			endtext
			use in select('c_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VENDEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comision" as "Comision" from ZooLogic.DetComVen where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComisionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComisionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComisionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVEN where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Descfw" as "Descripcionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clpun1" as "Descmaxdetallefacturas", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Descmaxtotalfacturas", "Clnom" as "Nombre", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cldesc" as "Descuentopreferente", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfegr" as "Fechaegreso", "Cldepto" as "Departamento", "Clloc" as "Localidad", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.VEN where  funciones.padr( CLCOD, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VEN.CLCOD != '' order by CLCOD
			endtext
			use in select('c_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VENDEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comision" as "Comision" from ZooLogic.DetComVen where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComisionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComisionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComisionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVEN where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Descfw" as "Descripcionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clpun1" as "Descmaxdetallefacturas", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Descmaxtotalfacturas", "Clnom" as "Nombre", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cldesc" as "Descuentopreferente", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfegr" as "Fechaegreso", "Cldepto" as "Departamento", "Clloc" as "Localidad", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.VEN where  funciones.padr( CLCOD, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VEN.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VENDEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comision" as "Comision" from ZooLogic.DetComVen where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComisionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComisionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComisionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVEN where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Descfw" as "Descripcionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clpun1" as "Descmaxdetallefacturas", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Descmaxtotalfacturas", "Clnom" as "Nombre", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cldesc" as "Descuentopreferente", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfegr" as "Fechaegreso", "Cldepto" as "Departamento", "Clloc" as "Localidad", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.VEN where  VEN.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VENDEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comision" as "Comision" from ZooLogic.DetComVen where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComisionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComisionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComisionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVEN where Codigo = <<"'" + this.FormatearTextoSql( c_VENDEDOR.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fmodifw,Fecimpo,Faltafw,Fecexpo,Haltafw,Saltafw,Valtafw,Zadsfw,Vmodifw,Umodifw,Smod" + ;
"ifw,Ualtafw,Horaimpo,Esttrans,Hmodifw,Horaexpo,Bdmodifw,Bdaltafw,Cltlf,Descfw,Tipagrupub,Timestamp,C" + ;
"lpun1,Inactivofw,Cimagen,Clcod,Clobs,Cltipodoc,Cldir,Cltlfm,Clpun2,Clnom,Clas,Clfecha,Clemail,Clnrod" + ;
"oc,Clnum,Cldesc,Clfing,Clpiso,Clfegr,Cldepto,Clloc,Clcp,Clprv,Ppais" + ;
" from ZooLogic.VEN where  VEN.CLCOD != '' and " + lcFiltro )
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
			local  lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenFaltafw, lxVenFecexpo, lxVenHaltafw, lxVenSaltafw, lxVenValtafw, lxVenZadsfw, lxVenVmodifw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHoraimpo, lxVenEsttrans, lxVenHmodifw, lxVenHoraexpo, lxVenBdmodifw, lxVenBdaltafw, lxVenCltlf, lxVenDescfw, lxVenTipagrupub, lxVenTimestamp, lxVenClpun1, lxVenInactivofw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenCltipodoc, lxVenCldir, lxVenCltlfm, lxVenClpun2, lxVenClnom, lxVenClas, lxVenClfecha, lxVenClemail, lxVenClnrodoc, lxVenClnum, lxVenCldesc, lxVenClfing, lxVenClpiso, lxVenClfegr, lxVenCldepto, lxVenClloc, lxVenClcp, lxVenClprv, lxVenPpais
				lxVenFectrans = ctod( '  /  /    ' )			lxVenFmodifw = ctod( '  /  /    ' )			lxVenFecimpo = ctod( '  /  /    ' )			lxVenFaltafw = ctod( '  /  /    ' )			lxVenFecexpo = ctod( '  /  /    ' )			lxVenHaltafw = []			lxVenSaltafw = []			lxVenValtafw = []			lxVenZadsfw = []			lxVenVmodifw = []			lxVenUmodifw = []			lxVenSmodifw = []			lxVenUaltafw = []			lxVenHoraimpo = []			lxVenEsttrans = []			lxVenHmodifw = []			lxVenHoraexpo = []			lxVenBdmodifw = []			lxVenBdaltafw = []			lxVenCltlf = []			lxVenDescfw = []			lxVenTipagrupub = 0			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenClpun1 = 0			lxVenInactivofw = .F.			lxVenCimagen = []			lxVenClcod = []			lxVenClobs = []			lxVenCltipodoc = []			lxVenCldir = []			lxVenCltlfm = []			lxVenClpun2 = 0			lxVenClnom = []			lxVenClas = []			lxVenClfecha = ctod( '  /  /    ' )			lxVenClemail = []			lxVenClnrodoc = []			lxVenClnum = 0			lxVenCldesc = []			lxVenClfing = ctod( '  /  /    ' )			lxVenClpiso = []			lxVenClfegr = ctod( '  /  /    ' )			lxVenCldepto = []			lxVenClloc = []			lxVenClcp = []			lxVenClprv = []			lxVenPpais = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetComVen where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubVEN where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.VEN where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'VEN' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CLCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CLCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  VEN.CLCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Descfw" as "Descripcionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clpun1" as "Descmaxdetallefacturas", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Descmaxtotalfacturas", "Clnom" as "Nombre", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cldesc" as "Descuentopreferente", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfegr" as "Fechaegreso", "Cldepto" as "Departamento", "Clloc" as "Localidad", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'VEN', '', tnTope )
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
	Function ObtenerDatosDetalleComisionesDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCOMVEN.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comision" as "Comision"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleComisionesDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetComVen', 'ComisionesDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleComisionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleComisionesDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBVEN.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubVEN', 'AgruPubliDetalle', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'DESCMAXDETALLEFACTURAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN1 AS DESCMAXDETALLEFACTURAS'
				Case lcAtributo == 'INACTIVOFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INACTIVOFW AS INACTIVOFW'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDIR AS CALLE'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLFM AS MOVIL'
				Case lcAtributo == 'DESCMAXTOTALFACTURAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN2 AS DESCMAXTOTALFACTURAS'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAS AS CLASIFICACION'
				Case lcAtributo == 'FECHANACIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFECHA AS FECHANACIMIENTO'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNUM AS NUMERO'
				Case lcAtributo == 'DESCUENTOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDESC AS DESCUENTOPREFERENTE'
				Case lcAtributo == 'FECHAINGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFING AS FECHAINGRESO'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPISO AS PISO'
				Case lcAtributo == 'FECHAEGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFEGR AS FECHAEGRESO'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PPAIS AS PAIS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleComisionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'COMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMISION AS COMISION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCMAXDETALLEFACTURAS'
				lcCampo = 'CLPUN1'
			Case upper( alltrim( tcAtributo ) ) == 'INACTIVOFW'
				lcCampo = 'INACTIVOFW'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'CLDIR'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'CLTLFM'
			Case upper( alltrim( tcAtributo ) ) == 'DESCMAXTOTALFACTURAS'
				lcCampo = 'CLPUN2'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLAS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANACIMIENTO'
				lcCampo = 'CLFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CLNUM'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPREFERENTE'
				lcCampo = 'CLDESC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAINGRESO'
				lcCampo = 'CLFING'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'CLPISO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEGRESO'
				lcCampo = 'CLFEGR'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'CLDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'PPAIS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleComisionesDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'COMISION'
				lcCampo = 'COMISION'
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
		if upper( alltrim( tcDetalle ) ) == 'COMISIONESDETALLE'
			lcRetorno = 'DETCOMVEN'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBVEN'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenFaltafw, lxVenFecexpo, lxVenHaltafw, lxVenSaltafw, lxVenValtafw, lxVenZadsfw, lxVenVmodifw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHoraimpo, lxVenEsttrans, lxVenHmodifw, lxVenHoraexpo, lxVenBdmodifw, lxVenBdaltafw, lxVenCltlf, lxVenDescfw, lxVenTipagrupub, lxVenTimestamp, lxVenClpun1, lxVenInactivofw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenCltipodoc, lxVenCldir, lxVenCltlfm, lxVenClpun2, lxVenClnom, lxVenClas, lxVenClfecha, lxVenClemail, lxVenClnrodoc, lxVenClnum, lxVenCldesc, lxVenClfing, lxVenClpiso, lxVenClfegr, lxVenCldepto, lxVenClloc, lxVenClcp, lxVenClprv, lxVenPpais
				lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenHaltafw =  .Horaaltafw			lxVenSaltafw =  .Seriealtafw			lxVenValtafw =  .Versionaltafw			lxVenZadsfw =  .Zadsfw			lxVenVmodifw =  .Versionmodificacionfw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHoraimpo =  .Horaimpo			lxVenEsttrans =  .Estadotransferencia			lxVenHmodifw =  .Horamodificacionfw			lxVenHoraexpo =  .Horaexpo			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenBdaltafw =  .Basededatosaltafw			lxVenCltlf =  .Telefono			lxVenDescfw =  .Descripcionfw			lxVenTipagrupub =  .Tipoagrupamientopublicaciones			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenInactivofw =  .Inactivofw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenCltlfm =  .Movil			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClnom =  .Nombre			lxVenClas =  upper( .Clasificacion_PK ) 			lxVenClfecha =  .Fechanacimiento			lxVenClemail =  .Email			lxVenClnrodoc =  .Nrodocumento			lxVenClnum =  .Numero			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClfegr =  .Fechaegreso			lxVenCldepto =  .Departamento			lxVenClloc =  .Localidad			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 			lxVenPpais =  upper( .Pais_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.VEN ( "Fectrans","Fmodifw","Fecimpo","Faltafw","Fecexpo","Haltafw","Saltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Smodifw","Ualtafw","Horaimpo","Esttrans","Hmodifw","Horaexpo","Bdmodifw","Bdaltafw","Cltlf","Descfw","Tipagrupub","Timestamp","Clpun1","Inactivofw","Cimagen","Clcod","Clobs","Cltipodoc","Cldir","Cltlfm","Clpun2","Clnom","Clas","Clfecha","Clemail","Clnrodoc","Clnum","Cldesc","Clfing","Clpiso","Clfegr","Cldepto","Clloc","Clcp","Clprv","Ppais" ) values ( <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenDescfw ) + "'" >>, <<lxVenTipagrupub >>, <<lxVenTimestamp >>, <<lxVenClpun1 >>, <<iif( lxVenInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'" >>, <<lxVenClpun2 >>, <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClas ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'" >>, <<lxVenClnum >>, <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenPpais ) + "'" >> )
		endtext
		loColeccion.cTabla = 'VEN' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComisionesDetalle
				if this.oEntidad.ComisionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComision_PK = loItem.Comision_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetComVen("NROITEM","Codigo","Comision" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxComision_PK ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubVEN("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenFaltafw, lxVenFecexpo, lxVenHaltafw, lxVenSaltafw, lxVenValtafw, lxVenZadsfw, lxVenVmodifw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHoraimpo, lxVenEsttrans, lxVenHmodifw, lxVenHoraexpo, lxVenBdmodifw, lxVenBdaltafw, lxVenCltlf, lxVenDescfw, lxVenTipagrupub, lxVenTimestamp, lxVenClpun1, lxVenInactivofw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenCltipodoc, lxVenCldir, lxVenCltlfm, lxVenClpun2, lxVenClnom, lxVenClas, lxVenClfecha, lxVenClemail, lxVenClnrodoc, lxVenClnum, lxVenCldesc, lxVenClfing, lxVenClpiso, lxVenClfegr, lxVenCldepto, lxVenClloc, lxVenClcp, lxVenClprv, lxVenPpais
				lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenHaltafw =  .Horaaltafw			lxVenSaltafw =  .Seriealtafw			lxVenValtafw =  .Versionaltafw			lxVenZadsfw =  .Zadsfw			lxVenVmodifw =  .Versionmodificacionfw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHoraimpo =  .Horaimpo			lxVenEsttrans =  .Estadotransferencia			lxVenHmodifw =  .Horamodificacionfw			lxVenHoraexpo =  .Horaexpo			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenBdaltafw =  .Basededatosaltafw			lxVenCltlf =  .Telefono			lxVenDescfw =  .Descripcionfw			lxVenTipagrupub =  .Tipoagrupamientopublicaciones			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenInactivofw =  .Inactivofw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenCltlfm =  .Movil			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClnom =  .Nombre			lxVenClas =  upper( .Clasificacion_PK ) 			lxVenClfecha =  .Fechanacimiento			lxVenClemail =  .Email			lxVenClnrodoc =  .Nrodocumento			lxVenClnum =  .Numero			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClfegr =  .Fechaegreso			lxVenCldepto =  .Departamento			lxVenClloc =  .Localidad			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 			lxVenPpais =  upper( .Pais_PK ) 
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  VEN.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.VEN set "Fectrans" = <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxVenDescfw ) + "'">>, "Tipagrupub" = <<lxVenTipagrupub>>, "Timestamp" = <<lxVenTimestamp>>, "Clpun1" = <<lxVenClpun1>>, "Inactivofw" = <<iif( lxVenInactivofw, 1, 0 )>>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'">>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'">>, "Cldir" = <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'">>, "Cltlfm" = <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'">>, "Clpun2" = <<lxVenClpun2>>, "Clnom" = <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'">>, "Clas" = <<"'" + this.FormatearTextoSql( lxVenClas ) + "'">>, "Clfecha" = <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'">>, "Clemail" = <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'">>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'">>, "Clnum" = <<lxVenClnum>>, "Cldesc" = <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'">>, "Clfing" = <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'">>, "Clpiso" = <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'">>, "Clfegr" = <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'">>, "Cldepto" = <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'">>, "Clloc" = <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'">>, "Clcp" = <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'">>, "Clprv" = <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'">>, "Ppais" = <<"'" + this.FormatearTextoSql( lxVenPpais ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'VEN' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
			loColeccion.Agregar([delete from ZooLogic.DetComVen where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubVEN where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComisionesDetalle
				if this.oEntidad.ComisionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComision_PK = loItem.Comision_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetComVen("NROITEM","Codigo","Comision" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxComision_PK ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubVEN("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  VEN.CLCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.VEN where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DetComVen where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubVEN where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'VEN' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.VEN where  VEN.CLCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.VEN where CLCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  VEN.CLCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxVENInactivoFW as variant, lxVENCLAS as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VENDEDOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.VEN Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					local llInsertarAuditoria as boolean
					llInsertarAuditoria = (  iif( isnull( curSeek.InactivoFW != &lcCursor..InactivoFW ), .F., curSeek.InactivoFW != &lcCursor..InactivoFW ) or  iif( isnull( curSeek.CLAS != &lcCursor..CLAS ), .F., curSeek.CLAS != &lcCursor..CLAS ) )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					if this.oentidad.lActualizarSoloEquivalenciasDeLince
						local lcCadena as String, lnPos as integer
						lnPos = recno(lcCursor)
						afields( laEst, lcCursor )
						lcCadena = [Replace in &lcCursor ]
						if empty( this.oEntidad.CamposEquivalenciaLince )
							this.oEntidad.CamposEquivalenciaLince = this.oEntidad.ObtenerCamposSegunEquivalencia(@laEst)
						endif 
						lcCadena = lcCadena + this.oEntidad.CamposEquivalenciaLince
						lcCadena = lcCadena + [ for CLCOD= curseek.CLCOD]
						&lcCadena.
						select( lcCursor )
						go lnPos
					endif
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.VEN set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CLPUN1 = ] + transform( &lcCursor..CLPUN1 )+ [, InactivoFW = ] + Transform( iif( &lcCursor..InactivoFW, 1, 0 ))+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, CLDIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'"+ [, CLTLFM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLFM ) + "'"+ [, CLPUN2 = ] + transform( &lcCursor..CLPUN2 )+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLAS ) + "'"+ [, CLFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, CLNUM = ] + transform( &lcCursor..CLNUM )+ [, CLDESC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDESC ) + "'"+ [, CLFING = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'"+ [, CLPISO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'"+ [, CLFEGR = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFEGR ) + "'"+ [, CLDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"+ [, PPAIS = ] + "'" + this.FormatearTextoSql( &lcCursor..PPAIS ) + "'" + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					if llInsertarAuditoria
						lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
						this.oConexion.EjecutarSql( lcSentencia )
					EndIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FMODIFW, FECIMPO, FALTAFW, FECEXPO, HALTAFW, SALTAFW, VALTAFW, ZADSFW, VMODIFW, UMODIFW, SMODIFW, UALTAFW, HORAIMPO, ESTTRANS, HMODIFW, HORAEXPO, BDMODIFW, BDALTAFW, CLTLF, DescFW, tipagrupub, TIMESTAMP, CLPUN1, InactivoFW, CIMAGEN, CLCOD, CLOBS, CLTIPODOC, CLDIR, CLTLFM, CLPUN2, CLNOM, CLAS, CLFECHA, CLEMAIL, CLNRODOC, CLNUM, CLDESC, CLFING, CLPISO, CLFEGR, CLDEPTO, CLLOC, CLCP, CLPRV, PPAIS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..tipagrupub ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..CLPUN1 ) + ',' + Transform( iif( &lcCursor..InactivoFW, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLFM ) + "'" + ',' + transform( &lcCursor..CLPUN2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLAS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + transform( &lcCursor..CLNUM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDESC ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFEGR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PPAIS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.VEN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
				this.oConexion.EjecutarSql( lcSentencia )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VENDEDOR'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CLCOD','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CLCOD')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetComVen Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubVEN Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMISIONVENDEDOR'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CLCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Comision"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetComVen ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Comision   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICVEN'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CLCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubVEN ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CLCOD C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CLCOD      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'VENDEDOR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VENDEDOR_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VENDEDOR_CLOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMISIONVENDEDOR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICVEN'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_VEN')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'VENDEDOR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CLCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad VENDEDOR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VENDEDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CLCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CLCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VENDEDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  CLFECHA   
		* Validar ANTERIORES A 1/1/1753  CLFING    
		* Validar ANTERIORES A 1/1/1753  CLFEGR    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_VEN') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_VEN
Create Table ZooLogic.TablaTrabajo_VEN ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"cltlf" char( 30 )  null, 
"descfw" char( 200 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"clpun1" numeric( 15, 2 )  null, 
"inactivofw" bit  null, 
"cimagen" char( 180 )  null, 
"clcod" char( 10 )  null, 
"clobs" varchar(max)  null, 
"cltipodoc" char( 2 )  null, 
"cldir" char( 70 )  null, 
"cltlfm" char( 30 )  null, 
"clpun2" numeric( 15, 2 )  null, 
"clnom" char( 60 )  null, 
"clas" char( 10 )  null, 
"clfecha" datetime  null, 
"clemail" char( 250 )  null, 
"clnrodoc" char( 10 )  null, 
"clnum" numeric( 5, 0 )  null, 
"cldesc" char( 10 )  null, 
"clfing" datetime  null, 
"clpiso" char( 3 )  null, 
"clfegr" datetime  null, 
"cldepto" char( 3 )  null, 
"clloc" char( 70 )  null, 
"clcp" char( 8 )  null, 
"clprv" char( 2 )  null, 
"ppais" char( 3 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_VEN' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_VEN' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VENDEDOR'
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('clpun1','clpun1')
			.AgregarMapeo('inactivofw','inactivofw')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('cldir','cldir')
			.AgregarMapeo('cltlfm','cltlfm')
			.AgregarMapeo('clpun2','clpun2')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('clas','clas')
			.AgregarMapeo('clfecha','clfecha')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('clnum','clnum')
			.AgregarMapeo('cldesc','cldesc')
			.AgregarMapeo('clfing','clfing')
			.AgregarMapeo('clpiso','clpiso')
			.AgregarMapeo('clfegr','clfegr')
			.AgregarMapeo('cldepto','cldepto')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clprv','clprv')
			.AgregarMapeo('ppais','ppais')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_VEN'
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
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_VEN ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Clas" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Clcod,Isnull( d.Inactivofw,t.Inactivofw),Isnull( d.Clas,t.Clas)
						from ZooLogic.VEN t inner join deleted d 
							 on t.CLCOD = d.CLCOD
					where ( d.InactivoFW is not null and d.InactivoFW <> t.InactivoFW ) or ( d.CLAS is not null and d.CLAS <> t.CLAS )
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CLPUN1 = isnull( d.CLPUN1, t.CLPUN1 ),t.INACTIVOFW = isnull( d.INACTIVOFW, t.INACTIVOFW ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.CLDIR = isnull( d.CLDIR, t.CLDIR ),t.CLTLFM = isnull( d.CLTLFM, t.CLTLFM ),t.CLPUN2 = isnull( d.CLPUN2, t.CLPUN2 ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLAS = isnull( d.CLAS, t.CLAS ),t.CLFECHA = isnull( d.CLFECHA, t.CLFECHA ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.CLNUM = isnull( d.CLNUM, t.CLNUM ),t.CLDESC = isnull( d.CLDESC, t.CLDESC ),t.CLFING = isnull( d.CLFING, t.CLFING ),t.CLPISO = isnull( d.CLPISO, t.CLPISO ),t.CLFEGR = isnull( d.CLFEGR, t.CLFEGR ),t.CLDEPTO = isnull( d.CLDEPTO, t.CLDEPTO ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLPRV = isnull( d.CLPRV, t.CLPRV ),t.PPAIS = isnull( d.PPAIS, t.PPAIS )
					from ZooLogic.VEN t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.ADT_VEN ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Clas" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Clcod,isnull( d.INACTIVOFW,0),isnull( d.CLAS,'')
						From deleted d left join ZooLogic.VEN pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				insert into ZooLogic.VEN(Fectrans,Fmodifw,Fecimpo,Faltafw,Fecexpo,Haltafw,Saltafw,Valtafw,Zadsfw,Vmodifw,Umodifw,Smodifw,Ualtafw,Horaimpo,Esttrans,Hmodifw,Horaexpo,Bdmodifw,Bdaltafw,Cltlf,Descfw,Tipagrupub,Timestamp,Clpun1,Inactivofw,Cimagen,Clcod,Clobs,Cltipodoc,Cldir,Cltlfm,Clpun2,Clnom,Clas,Clfecha,Clemail,Clnrodoc,Clnum,Cldesc,Clfing,Clpiso,Clfegr,Cldepto,Clloc,Clcp,Clprv,Ppais)
					Select isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.CLTLF,''),isnull( d.DESCFW,''),isnull( d.TIPAGRUPUB,0),isnull( d.TIMESTAMP,0),isnull( d.CLPUN1,0),isnull( d.INACTIVOFW,0),isnull( d.CIMAGEN,''),isnull( d.CLCOD,''),isnull( d.CLOBS,''),isnull( d.CLTIPODOC,''),isnull( d.CLDIR,''),isnull( d.CLTLFM,''),isnull( d.CLPUN2,0),isnull( d.CLNOM,''),isnull( d.CLAS,''),isnull( d.CLFECHA,''),isnull( d.CLEMAIL,''),isnull( d.CLNRODOC,''),isnull( d.CLNUM,0),isnull( d.CLDESC,''),isnull( d.CLFING,''),isnull( d.CLPISO,''),isnull( d.CLFEGR,''),isnull( d.CLDEPTO,''),isnull( d.CLLOC,''),isnull( d.CLCP,''),isnull( d.CLPRV,''),isnull( d.PPAIS,'')
						From deleted d left join ZooLogic.VEN pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DetComVen( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_VEN_DetComVen
ON ZooLogic.TablaTrabajo_VEN_DetComVen
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.COMISION = isnull( d.COMISION, t.COMISION )
from ZooLogic.DetComVen t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetComVen
( 
"NROITEM",
"CODIGO",
"COMISION"
 )
Select 
d.NROITEM,
d.CODIGO,
d.COMISION
From deleted d left join ZooLogic.DetComVen pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubVEN( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_VEN_AgruPubVEN
ON ZooLogic.TablaTrabajo_VEN_AgruPubVEN
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubVEN t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubVEN
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
From deleted d left join ZooLogic.AgruPubVEN pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_VEN') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_VEN
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_VENDEDOR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_VENDEDOR.Horaaltafw, [] )
					.Seriealtafw = nvl( c_VENDEDOR.Seriealtafw, [] )
					.Versionaltafw = nvl( c_VENDEDOR.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_VENDEDOR.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_VENDEDOR.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_VENDEDOR.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_VENDEDOR.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_VENDEDOR.Horaimpo, [] )
					.Estadotransferencia = nvl( c_VENDEDOR.Estadotransferencia, [] )
					.Horamodificacionfw = nvl( c_VENDEDOR.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_VENDEDOR.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_VENDEDOR.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_VENDEDOR.Basededatosaltafw, [] )
					.Telefono = nvl( c_VENDEDOR.Telefono, [] )
					.Descripcionfw = nvl( c_VENDEDOR.Descripcionfw, [] )
					.Tipoagrupamientopublicaciones = nvl( c_VENDEDOR.Tipoagrupamientopublicaciones, 0 )
					.Timestamp = nvl( c_VENDEDOR.Timestamp, 0 )
					.Descmaxdetallefacturas = nvl( c_VENDEDOR.Descmaxdetallefacturas, 0 )
					.Inactivofw = nvl( c_VENDEDOR.Inactivofw, .F. )
					.Imagen = nvl( c_VENDEDOR.Imagen, [] )
					.Codigo = nvl( c_VENDEDOR.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Tipodocumento = nvl( c_VENDEDOR.Tipodocumento, [] )
					.Calle = nvl( c_VENDEDOR.Calle, [] )
					.Movil = nvl( c_VENDEDOR.Movil, [] )
					.Descmaxtotalfacturas = nvl( c_VENDEDOR.Descmaxtotalfacturas, 0 )
					.Nombre = nvl( c_VENDEDOR.Nombre, [] )
					.Clasificacion_PK =  nvl( c_VENDEDOR.Clasificacion, [] )
					.Comisionesdetalle.Limpiar()
					.Comisionesdetalle.SetearEsNavegacion( .lProcesando )
					.Comisionesdetalle.Cargar()
					.Fechanacimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechanacimiento, ctod( '  /  /    ' ) ) )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Email = nvl( c_VENDEDOR.Email, [] )
					.Nrodocumento = nvl( c_VENDEDOR.Nrodocumento, [] )
					.Numero = nvl( c_VENDEDOR.Numero, 0 )
					.Descuentopreferente_PK =  nvl( c_VENDEDOR.Descuentopreferente, [] )
					.Fechaingreso = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaingreso, ctod( '  /  /    ' ) ) )
					.Piso = nvl( c_VENDEDOR.Piso, [] )
					.Fechaegreso = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaegreso, ctod( '  /  /    ' ) ) )
					.Departamento = nvl( c_VENDEDOR.Departamento, [] )
					.Localidad = nvl( c_VENDEDOR.Localidad, [] )
					.Codigopostal = nvl( c_VENDEDOR.Codigopostal, [] )
					.Provincia_PK =  nvl( c_VENDEDOR.Provincia, [] )
					.Pais_PK =  nvl( c_VENDEDOR.Pais, [] )
					Select c_VENDEDOR
					scatter name This.oEntidad.oAtributosAuditoria
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
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( this.oEntidad.Inactivofw, 1, 0 )
			lcEntidad3 = "'" + this.FormatearTextoSql( this.oEntidad.Clasificacion_pk ) + "'"
			
		else
			lxValorClavePrimaria = &tcCursor..CLCOD
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( &tcCursor..Inactivofw, 1, 0 )
			lcEntidad3 = "'" + this.FormatearTextoSql( &tcCursor..Clas ) + "'"
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_VEN ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Clas" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ComisionesDetalle
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

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_VENDEDOR.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.VEN' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CLCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CLCOD from (
							select * 
								from ZooLogic.VEN 
								Where   VEN.CLCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "VEN", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Descfw" as "Descripcionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clpun1" as "Descmaxdetallefacturas", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Descmaxtotalfacturas", "Clnom" as "Nombre", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cldesc" as "Descuentopreferente", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfegr" as "Fechaegreso", "Cldepto" as "Departamento", "Clloc" as "Localidad", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.VEN 
								Where   VEN.CLCOD != ''
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
	Tabla = 'VEN'
	Filtro = " VEN.CLCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " VEN.CLCOD != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = ""
	FiltroSubEntidad = ' ( VEN.InactivoFW = 0)'

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
	<row entidad="VENDEDOR                                " atributo="FECHATRANSFERENCIA                      " tabla="VEN            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAMODIFICACIONFW                     " tabla="VEN            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAIMPO                               " tabla="VEN            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAALTAFW                             " tabla="VEN            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAEXPO                               " tabla="VEN            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAALTAFW                              " tabla="VEN            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="SERIEALTAFW                             " tabla="VEN            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="VERSIONALTAFW                           " tabla="VEN            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="ZADSFW                                  " tabla="VEN            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="VERSIONMODIFICACIONFW                   " tabla="VEN            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="USUARIOMODIFICACIONFW                   " tabla="VEN            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="SERIEMODIFICACIONFW                     " tabla="VEN            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="USUARIOALTAFW                           " tabla="VEN            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAIMPO                                " tabla="VEN            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="ESTADOTRANSFERENCIA                     " tabla="VEN            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAMODIFICACIONFW                      " tabla="VEN            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAEXPO                                " tabla="VEN            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="VEN            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="BASEDEDATOSALTAFW                       " tabla="VEN            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="TELEFONO                                " tabla="VEN            " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DESCRIPCIONFW                           " tabla="VEN            " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="VEN            " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="TIMESTAMP                               " tabla="VEN            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DESCMAXDETALLEFACTURAS                  " tabla="VEN            " campo="CLPUN1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% En detalle                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="INACTIVOFW                              " tabla="VEN            " campo="INACTIVOFW" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Inactivo                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="IMAGEN                                  " tabla="VEN            " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Archivo                                                                                                                                                         " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="CODIGO                                  " tabla="VEN            " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="OBSERVACION                             " tabla="VEN            " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="TIPODOCUMENTO                           " tabla="VEN            " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Tipo documento                                                                                                                                                  " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="CALLE                                   " tabla="VEN            " campo="CLDIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="MOVIL                                   " tabla="VEN            " campo="CLTLFM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DESCMAXTOTALFACTURAS                    " tabla="VEN            " campo="CLPUN2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% En totales                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="CLASIFICACION                           " tabla="VEN            " campo="CLAS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONVENDEDOR                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="COMISIONESDETALLE                       " tabla="DETCOMVEN      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Comisiones                                                                                                                                                      " dominio="DETALLEITEMCOMISIONVENDEDOR   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHANACIMIENTO                         " tabla="VEN            " campo="CLFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Fecha de nacimiento                                                                                                                                             " dominio="FECHALARGACALENDARIO          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBVEN     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICVEN    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="EMAIL                                   " tabla="VEN            " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NRODOCUMENTO                            " tabla="VEN            " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Número documento                                                                                                                                                " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NUMERO                                  " tabla="VEN            " campo="CLNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DESCUENTOPREFERENTE                     " tabla="VEN            " campo="CLDESC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESCUENTO                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Descuento                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAINGRESO                            " tabla="VEN            " campo="CLFING    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Fecha de ingreso                                                                                                                                                " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="PISO                                    " tabla="VEN            " campo="CLPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAEGRESO                             " tabla="VEN            " campo="CLFEGR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="Fecha de egreso                                                                                                                                                 " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DEPARTAMENTO                            " tabla="VEN            " campo="CLDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="LOCALIDAD                               " tabla="VEN            " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="CODIGOPOSTAL                            " tabla="VEN            " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="PROVINCIA                               " tabla="VEN            " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="PAIS                                    " tabla="VEN            " campo="PPAIS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONVENDEDOR                   " atributo="DESCRIPCION                             " tabla="CLASVEND       " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="27" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASVEND On VEN.CLAS = CLASVEND.CLACOD And  CLASVEND.CLACOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="39" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESCUENTOS On VEN.CLDESC = DESCUENTOS.codigo And  DESCUENTOS.CODIGO != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On VEN.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="19" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On VEN.PPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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