
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
	cTagClavePk = '_007PK'
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
			local  lxVenFaltafw, lxVenFecexpo, lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenClnrodoc, lxVenCltipodoc, lxVenCldir, lxVenClpun1, lxVenTimestamp, lxVenHaltafw, lxVenHoraexpo, lxVenSaltafw, lxVenHoraimpo, lxVenVmodifw, lxVenZadsfw, lxVenValtafw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHmodifw, lxVenEsttrans, lxVenBdmodifw, lxVenCltlf, lxVenCltlfm, lxVenBdaltafw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenClnum, lxVenClnom, lxVenClpun2, lxVenClemail, lxVenClfecha, lxVenClfing, lxVenClpiso, lxVenClpageweb, lxVenCldesc, lxVenCldepto, lxVenCnx1, lxVenCldto, lxVenClloc, lxVenClfegr, lxVenClcp, lxVenClprv
				lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenClnrodoc =  .Nrodocumento			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenHaltafw =  .Horaaltafw			lxVenHoraexpo =  .Horaexpo			lxVenSaltafw =  .Seriealtafw			lxVenHoraimpo =  .Horaimpo			lxVenVmodifw =  .Versionmodificacionfw			lxVenZadsfw =  .Zadsfw			lxVenValtafw =  .Versionaltafw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHmodifw =  .Horamodificacionfw			lxVenEsttrans =  .Estadotransferencia			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenCltlf =  .Telefono			lxVenCltlfm =  .Movil			lxVenBdaltafw =  .Basededatosaltafw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenClnum =  .Numero			lxVenClnom =  .Nombre			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClemail =  .Email			lxVenClfecha =  .Fechanacimiento			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClpageweb =  .Paginaweb			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenCldepto =  .Departamento			lxVenCnx1 =  .Objetivomensual			lxVenCldto =  .Comision			lxVenClloc =  .Localidad			lxVenClfegr =  .Fechaegreso			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 
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
				insert into ZooLogic.VEN ( "Faltafw","Fecexpo","Fectrans","Fmodifw","Fecimpo","Clnrodoc","Cltipodoc","Cldir","Clpun1","Timestamp","Haltafw","Horaexpo","Saltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Cltlf","Cltlfm","Bdaltafw","Cimagen","Clcod","Clobs","Clnum","Clnom","Clpun2","Clemail","Clfecha","Clfing","Clpiso","Clpageweb","Cldesc","Cldepto","Cnx1","Cldto","Clloc","Clfegr","Clcp","Clprv" ) values ( <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'" >>, <<lxVenClpun1 >>, <<lxVenTimestamp >>, <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'" >>, <<lxVenClnum >>, <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'" >>, <<lxVenClpun2 >>, <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'" >>, <<lxVenCnx1 >>, <<lxVenCldto >>, <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


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
			local  lxVenFaltafw, lxVenFecexpo, lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenClnrodoc, lxVenCltipodoc, lxVenCldir, lxVenClpun1, lxVenTimestamp, lxVenHaltafw, lxVenHoraexpo, lxVenSaltafw, lxVenHoraimpo, lxVenVmodifw, lxVenZadsfw, lxVenValtafw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHmodifw, lxVenEsttrans, lxVenBdmodifw, lxVenCltlf, lxVenCltlfm, lxVenBdaltafw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenClnum, lxVenClnom, lxVenClpun2, lxVenClemail, lxVenClfecha, lxVenClfing, lxVenClpiso, lxVenClpageweb, lxVenCldesc, lxVenCldepto, lxVenCnx1, lxVenCldto, lxVenClloc, lxVenClfegr, lxVenClcp, lxVenClprv
				lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenClnrodoc =  .Nrodocumento			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenHaltafw =  .Horaaltafw			lxVenHoraexpo =  .Horaexpo			lxVenSaltafw =  .Seriealtafw			lxVenHoraimpo =  .Horaimpo			lxVenVmodifw =  .Versionmodificacionfw			lxVenZadsfw =  .Zadsfw			lxVenValtafw =  .Versionaltafw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHmodifw =  .Horamodificacionfw			lxVenEsttrans =  .Estadotransferencia			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenCltlf =  .Telefono			lxVenCltlfm =  .Movil			lxVenBdaltafw =  .Basededatosaltafw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenClnum =  .Numero			lxVenClnom =  .Nombre			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClemail =  .Email			lxVenClfecha =  .Fechanacimiento			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClpageweb =  .Paginaweb			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenCldepto =  .Departamento			lxVenCnx1 =  .Objetivomensual			lxVenCldto =  .Comision			lxVenClloc =  .Localidad			lxVenClfegr =  .Fechaegreso			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 
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
				update ZooLogic.VEN set "Faltafw" = <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'">>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'">>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'">>,"Cldir" = <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'">>,"Clpun1" = <<lxVenClpun1>>,"Timestamp" = <<lxVenTimestamp>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'">>,"Cltlfm" = <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'">>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'">>,"Clnum" = <<lxVenClnum>>,"Clnom" = <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'">>,"Clpun2" = <<lxVenClpun2>>,"Clemail" = <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'">>,"Clfecha" = <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'">>,"Clfing" = <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'">>,"Clpiso" = <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'">>,"Clpageweb" = <<"'" + this.FormatearTextoSql( lxVenClpageweb ) + "'">>,"Cldesc" = <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'">>,"Cldepto" = <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'">>,"Cnx1" = <<lxVenCnx1>>,"Cldto" = <<lxVenCldto>>,"Clloc" = <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'">>,"Clfegr" = <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'">>,"Clcp" = <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'">>,"Clprv" = <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'">> where "Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">> and  VEN.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetComVen where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
				select "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clnrodoc" as "Nrodocumento", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Clpun1" as "Descmaxdetallefacturas", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Cltlfm" as "Movil", "Bdaltafw" as "Basededatosaltafw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clnum" as "Numero", "Clnom" as "Nombre", "Clpun2" as "Descmaxtotalfacturas", "Clemail" as "Email", "Clfecha" as "Fechanacimiento", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clpageweb" as "Paginaweb", "Cldesc" as "Descuentopreferente", "Cldepto" as "Departamento", "Cnx1" as "Objetivomensual", "Cldto" as "Comision", "Clloc" as "Localidad", "Clfegr" as "Fechaegreso", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ZooLogic.VEN where "Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">> and  VEN.CLCOD != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clnrodoc" as "Nrodocumento", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Clpun1" as "Descmaxdetallefacturas", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Cltlfm" as "Movil", "Bdaltafw" as "Basededatosaltafw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clnum" as "Numero", "Clnom" as "Nombre", "Clpun2" as "Descmaxtotalfacturas", "Clemail" as "Email", "Clfecha" as "Fechanacimiento", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clpageweb" as "Paginaweb", "Cldesc" as "Descuentopreferente", "Cldepto" as "Departamento", "Cnx1" as "Objetivomensual", "Cldto" as "Comision", "Clloc" as "Localidad", "Clfegr" as "Fechaegreso", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ZooLogic.VEN where  VEN.CLCOD != '' order by CLCOD
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clnrodoc" as "Nrodocumento", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Clpun1" as "Descmaxdetallefacturas", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Cltlfm" as "Movil", "Bdaltafw" as "Basededatosaltafw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clnum" as "Numero", "Clnom" as "Nombre", "Clpun2" as "Descmaxtotalfacturas", "Clemail" as "Email", "Clfecha" as "Fechanacimiento", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clpageweb" as "Paginaweb", "Cldesc" as "Descuentopreferente", "Cldepto" as "Departamento", "Cnx1" as "Objetivomensual", "Cldto" as "Comision", "Clloc" as "Localidad", "Clfegr" as "Fechaegreso", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ZooLogic.VEN where  funciones.padr( CLCOD, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VEN.CLCOD != '' order by CLCOD
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clnrodoc" as "Nrodocumento", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Clpun1" as "Descmaxdetallefacturas", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Cltlfm" as "Movil", "Bdaltafw" as "Basededatosaltafw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clnum" as "Numero", "Clnom" as "Nombre", "Clpun2" as "Descmaxtotalfacturas", "Clemail" as "Email", "Clfecha" as "Fechanacimiento", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clpageweb" as "Paginaweb", "Cldesc" as "Descuentopreferente", "Cldepto" as "Departamento", "Cnx1" as "Objetivomensual", "Cldto" as "Comision", "Clloc" as "Localidad", "Clfegr" as "Fechaegreso", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ZooLogic.VEN where  funciones.padr( CLCOD, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VEN.CLCOD != '' order by CLCOD desc
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clnrodoc" as "Nrodocumento", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Clpun1" as "Descmaxdetallefacturas", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Cltlfm" as "Movil", "Bdaltafw" as "Basededatosaltafw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clnum" as "Numero", "Clnom" as "Nombre", "Clpun2" as "Descmaxtotalfacturas", "Clemail" as "Email", "Clfecha" as "Fechanacimiento", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clpageweb" as "Paginaweb", "Cldesc" as "Descuentopreferente", "Cldepto" as "Departamento", "Cnx1" as "Objetivomensual", "Cldto" as "Comision", "Clloc" as "Localidad", "Clfegr" as "Fechaegreso", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ZooLogic.VEN where  VEN.CLCOD != '' order by CLCOD desc
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fecexpo,Fectrans,Fmodifw,Fecimpo,Clnrodoc,Cltipodoc,Cldir,Clpun1,Timestamp,Haltafw,H" + ;
"oraexpo,Saltafw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Cl" + ;
"tlf,Cltlfm,Bdaltafw,Cimagen,Clcod,Clobs,Clnum,Clnom,Clpun2,Clemail,Clfecha,Clfing,Clpiso,Clpageweb,C" + ;
"ldesc,Cldepto,Cnx1,Cldto,Clloc,Clfegr,Clcp,Clprv" + ;
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
			local  lxVenFaltafw, lxVenFecexpo, lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenClnrodoc, lxVenCltipodoc, lxVenCldir, lxVenClpun1, lxVenTimestamp, lxVenHaltafw, lxVenHoraexpo, lxVenSaltafw, lxVenHoraimpo, lxVenVmodifw, lxVenZadsfw, lxVenValtafw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHmodifw, lxVenEsttrans, lxVenBdmodifw, lxVenCltlf, lxVenCltlfm, lxVenBdaltafw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenClnum, lxVenClnom, lxVenClpun2, lxVenClemail, lxVenClfecha, lxVenClfing, lxVenClpiso, lxVenClpageweb, lxVenCldesc, lxVenCldepto, lxVenCnx1, lxVenCldto, lxVenClloc, lxVenClfegr, lxVenClcp, lxVenClprv
				lxVenFaltafw = ctod( '  /  /    ' )			lxVenFecexpo = ctod( '  /  /    ' )			lxVenFectrans = ctod( '  /  /    ' )			lxVenFmodifw = ctod( '  /  /    ' )			lxVenFecimpo = ctod( '  /  /    ' )			lxVenClnrodoc = []			lxVenCltipodoc = []			lxVenCldir = []			lxVenClpun1 = 0			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenHaltafw = []			lxVenHoraexpo = []			lxVenSaltafw = []			lxVenHoraimpo = []			lxVenVmodifw = []			lxVenZadsfw = []			lxVenValtafw = []			lxVenUmodifw = []			lxVenSmodifw = []			lxVenUaltafw = []			lxVenHmodifw = []			lxVenEsttrans = []			lxVenBdmodifw = []			lxVenCltlf = []			lxVenCltlfm = []			lxVenBdaltafw = []			lxVenCimagen = []			lxVenClcod = []			lxVenClobs = []			lxVenClnum = 0			lxVenClnom = []			lxVenClpun2 = 0			lxVenClemail = []			lxVenClfecha = ctod( '  /  /    ' )			lxVenClfing = ctod( '  /  /    ' )			lxVenClpiso = []			lxVenClpageweb = []			lxVenCldesc = []			lxVenCldepto = []			lxVenCnx1 = 0			lxVenCldto = 0			lxVenClloc = []			lxVenClfegr = ctod( '  /  /    ' )			lxVenClcp = []			lxVenClprv = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetComVen where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
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
					"Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clnrodoc" as "Nrodocumento", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Clpun1" as "Descmaxdetallefacturas", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Cltlfm" as "Movil", "Bdaltafw" as "Basededatosaltafw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clnum" as "Numero", "Clnom" as "Nombre", "Clpun2" as "Descmaxtotalfacturas", "Clemail" as "Email", "Clfecha" as "Fechanacimiento", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clpageweb" as "Paginaweb", "Cldesc" as "Descuentopreferente", "Cldepto" as "Departamento", "Cnx1" as "Objetivomensual", "Cldto" as "Comision", "Clloc" as "Localidad", "Clfegr" as "Fechaegreso", "Clcp" as "Codigopostal", "Clprv" as "Provincia"
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDIR AS CALLE'
				Case lcAtributo == 'DESCMAXDETALLEFACTURAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN1 AS DESCMAXDETALLEFACTURAS'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
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
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLFM AS MOVIL'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNUM AS NUMERO'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'DESCMAXTOTALFACTURAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN2 AS DESCMAXTOTALFACTURAS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'FECHANACIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFECHA AS FECHANACIMIENTO'
				Case lcAtributo == 'FECHAINGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFING AS FECHAINGRESO'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPISO AS PISO'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'DESCUENTOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDESC AS DESCUENTOPREFERENTE'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'OBJETIVOMENSUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNX1 AS OBJETIVOMENSUAL'
				Case lcAtributo == 'COMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDTO AS COMISION'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'FECHAEGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFEGR AS FECHAEGRESO'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
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
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'CLDIR'
			Case upper( alltrim( tcAtributo ) ) == 'DESCMAXDETALLEFACTURAS'
				lcCampo = 'CLPUN1'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'CLTLFM'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CLNUM'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'DESCMAXTOTALFACTURAS'
				lcCampo = 'CLPUN2'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANACIMIENTO'
				lcCampo = 'CLFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAINGRESO'
				lcCampo = 'CLFING'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'CLPISO'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'CLPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPREFERENTE'
				lcCampo = 'CLDESC'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'CLDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBJETIVOMENSUAL'
				lcCampo = 'CNX1'
			Case upper( alltrim( tcAtributo ) ) == 'COMISION'
				lcCampo = 'CLDTO'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEGRESO'
				lcCampo = 'CLFEGR'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
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
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COMISIONESDETALLE'
			lcRetorno = 'DETCOMVEN'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxVenFaltafw, lxVenFecexpo, lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenClnrodoc, lxVenCltipodoc, lxVenCldir, lxVenClpun1, lxVenTimestamp, lxVenHaltafw, lxVenHoraexpo, lxVenSaltafw, lxVenHoraimpo, lxVenVmodifw, lxVenZadsfw, lxVenValtafw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHmodifw, lxVenEsttrans, lxVenBdmodifw, lxVenCltlf, lxVenCltlfm, lxVenBdaltafw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenClnum, lxVenClnom, lxVenClpun2, lxVenClemail, lxVenClfecha, lxVenClfing, lxVenClpiso, lxVenClpageweb, lxVenCldesc, lxVenCldepto, lxVenCnx1, lxVenCldto, lxVenClloc, lxVenClfegr, lxVenClcp, lxVenClprv
				lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenClnrodoc =  .Nrodocumento			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenHaltafw =  .Horaaltafw			lxVenHoraexpo =  .Horaexpo			lxVenSaltafw =  .Seriealtafw			lxVenHoraimpo =  .Horaimpo			lxVenVmodifw =  .Versionmodificacionfw			lxVenZadsfw =  .Zadsfw			lxVenValtafw =  .Versionaltafw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHmodifw =  .Horamodificacionfw			lxVenEsttrans =  .Estadotransferencia			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenCltlf =  .Telefono			lxVenCltlfm =  .Movil			lxVenBdaltafw =  .Basededatosaltafw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenClnum =  .Numero			lxVenClnom =  .Nombre			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClemail =  .Email			lxVenClfecha =  .Fechanacimiento			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClpageweb =  .Paginaweb			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenCldepto =  .Departamento			lxVenCnx1 =  .Objetivomensual			lxVenCldto =  .Comision			lxVenClloc =  .Localidad			lxVenClfegr =  .Fechaegreso			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.VEN ( "Faltafw","Fecexpo","Fectrans","Fmodifw","Fecimpo","Clnrodoc","Cltipodoc","Cldir","Clpun1","Timestamp","Haltafw","Horaexpo","Saltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Cltlf","Cltlfm","Bdaltafw","Cimagen","Clcod","Clobs","Clnum","Clnom","Clpun2","Clemail","Clfecha","Clfing","Clpiso","Clpageweb","Cldesc","Cldepto","Cnx1","Cldto","Clloc","Clfegr","Clcp","Clprv" ) values ( <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'" >>, <<lxVenClpun1 >>, <<lxVenTimestamp >>, <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'" >>, <<lxVenClnum >>, <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'" >>, <<lxVenClpun2 >>, <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'" >>, <<lxVenCnx1 >>, <<lxVenCldto >>, <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'" >> )
		endtext
		loColeccion.cTabla = 'VEN' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

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
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxVenFaltafw, lxVenFecexpo, lxVenFectrans, lxVenFmodifw, lxVenFecimpo, lxVenClnrodoc, lxVenCltipodoc, lxVenCldir, lxVenClpun1, lxVenTimestamp, lxVenHaltafw, lxVenHoraexpo, lxVenSaltafw, lxVenHoraimpo, lxVenVmodifw, lxVenZadsfw, lxVenValtafw, lxVenUmodifw, lxVenSmodifw, lxVenUaltafw, lxVenHmodifw, lxVenEsttrans, lxVenBdmodifw, lxVenCltlf, lxVenCltlfm, lxVenBdaltafw, lxVenCimagen, lxVenClcod, lxVenClobs, lxVenClnum, lxVenClnom, lxVenClpun2, lxVenClemail, lxVenClfecha, lxVenClfing, lxVenClpiso, lxVenClpageweb, lxVenCldesc, lxVenCldepto, lxVenCnx1, lxVenCldto, lxVenClloc, lxVenClfegr, lxVenClcp, lxVenClprv
				lxVenFaltafw =  .Fechaaltafw			lxVenFecexpo =  .Fechaexpo			lxVenFectrans =  .Fechatransferencia			lxVenFmodifw =  .Fechamodificacionfw			lxVenFecimpo =  .Fechaimpo			lxVenClnrodoc =  .Nrodocumento			lxVenCltipodoc =  .Tipodocumento			lxVenCldir =  .Calle			lxVenClpun1 =  .Descmaxdetallefacturas			lxVenTimestamp = goLibrerias.ObtenerTimestamp()			lxVenHaltafw =  .Horaaltafw			lxVenHoraexpo =  .Horaexpo			lxVenSaltafw =  .Seriealtafw			lxVenHoraimpo =  .Horaimpo			lxVenVmodifw =  .Versionmodificacionfw			lxVenZadsfw =  .Zadsfw			lxVenValtafw =  .Versionaltafw			lxVenUmodifw =  .Usuariomodificacionfw			lxVenSmodifw =  .Seriemodificacionfw			lxVenUaltafw =  .Usuarioaltafw			lxVenHmodifw =  .Horamodificacionfw			lxVenEsttrans =  .Estadotransferencia			lxVenBdmodifw =  .Basededatosmodificacionfw			lxVenCltlf =  .Telefono			lxVenCltlfm =  .Movil			lxVenBdaltafw =  .Basededatosaltafw			lxVenCimagen =  .Imagen			lxVenClcod =  .Codigo			lxVenClobs =  .Observacion			lxVenClnum =  .Numero			lxVenClnom =  .Nombre			lxVenClpun2 =  .Descmaxtotalfacturas			lxVenClemail =  .Email			lxVenClfecha =  .Fechanacimiento			lxVenClfing =  .Fechaingreso			lxVenClpiso =  .Piso			lxVenClpageweb =  .Paginaweb			lxVenCldesc =  upper( .DescuentoPreferente_PK ) 			lxVenCldepto =  .Departamento			lxVenCnx1 =  .Objetivomensual			lxVenCldto =  .Comision			lxVenClloc =  .Localidad			lxVenClfegr =  .Fechaegreso			lxVenClcp =  .Codigopostal			lxVenClprv =  upper( .Provincia_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  VEN.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.VEN set "Faltafw" = <<"'" + this.ConvertirDateSql( lxVenFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxVenFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxVenFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxVenFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxVenFecimpo ) + "'">>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxVenClnrodoc ) + "'">>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxVenCltipodoc ) + "'">>, "Cldir" = <<"'" + this.FormatearTextoSql( lxVenCldir ) + "'">>, "Clpun1" = <<lxVenClpun1>>, "Timestamp" = <<lxVenTimestamp>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxVenHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxVenHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxVenSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxVenHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxVenVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxVenZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxVenValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxVenUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxVenSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxVenUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxVenHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxVenEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxVenBdmodifw ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxVenCltlf ) + "'">>, "Cltlfm" = <<"'" + this.FormatearTextoSql( lxVenCltlfm ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxVenBdaltafw ) + "'">>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxVenCimagen ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxVenClcod ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxVenClobs ) + "'">>, "Clnum" = <<lxVenClnum>>, "Clnom" = <<"'" + this.FormatearTextoSql( lxVenClnom ) + "'">>, "Clpun2" = <<lxVenClpun2>>, "Clemail" = <<"'" + this.FormatearTextoSql( lxVenClemail ) + "'">>, "Clfecha" = <<"'" + this.ConvertirDateSql( lxVenClfecha ) + "'">>, "Clfing" = <<"'" + this.ConvertirDateSql( lxVenClfing ) + "'">>, "Clpiso" = <<"'" + this.FormatearTextoSql( lxVenClpiso ) + "'">>, "Clpageweb" = <<"'" + this.FormatearTextoSql( lxVenClpageweb ) + "'">>, "Cldesc" = <<"'" + this.FormatearTextoSql( lxVenCldesc ) + "'">>, "Cldepto" = <<"'" + this.FormatearTextoSql( lxVenCldepto ) + "'">>, "Cnx1" = <<lxVenCnx1>>, "Cldto" = <<lxVenCldto>>, "Clloc" = <<"'" + this.FormatearTextoSql( lxVenClloc ) + "'">>, "Clfegr" = <<"'" + this.ConvertirDateSql( lxVenClfegr ) + "'">>, "Clcp" = <<"'" + this.FormatearTextoSql( lxVenClcp ) + "'">>, "Clprv" = <<"'" + this.FormatearTextoSql( lxVenClprv ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'VEN' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DetComVen where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
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
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.VEN set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, CLDIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'"+ [, CLPUN1 = ] + transform( &lcCursor..CLPUN1 )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, CLTLFM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLFM ) + "'"+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CLNUM = ] + transform( &lcCursor..CLNUM )+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLPUN2 = ] + transform( &lcCursor..CLPUN2 )+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, CLFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"+ [, CLFING = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'"+ [, CLPISO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'"+ [, CLPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"+ [, CLDESC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDESC ) + "'"+ [, CLDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"+ [, CNX1 = ] + transform( &lcCursor..CNX1 )+ [, CLDTO = ] + transform( &lcCursor..CLDTO )+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLFEGR = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFEGR ) + "'"+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'" + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECEXPO, FECTRANS, FMODIFW, FECIMPO, CLNRODOC, CLTIPODOC, CLDIR, CLPUN1, TIMESTAMP, HALTAFW, HORAEXPO, SALTAFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, HMODIFW, ESTTRANS, BDMODIFW, CLTLF, CLTLFM, BDALTAFW, CIMAGEN, CLCOD, CLOBS, CLNUM, CLNOM, CLPUN2, CLEMAIL, CLFECHA, CLFING, CLPISO, CLPAGEWEB, CLDESC, CLDEPTO, CNX1, CLDTO, CLLOC, CLFEGR, CLCP, CLPRV
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'" + ',' + transform( &lcCursor..CLPUN1 ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLFM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + transform( &lcCursor..CLNUM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + transform( &lcCursor..CLPUN2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDESC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'" + ',' + transform( &lcCursor..CNX1 ) + ',' + transform( &lcCursor..CLDTO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFEGR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.VEN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CLCOD C (5) , Orden N(16), texto C(80))
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
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
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
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"clnrodoc" char( 10 )  null, 
"cltipodoc" char( 2 )  null, 
"cldir" char( 70 )  null, 
"clpun1" numeric( 16, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"cltlf" char( 30 )  null, 
"cltlfm" char( 30 )  null, 
"bdaltafw" char( 8 )  null, 
"cimagen" char( 180 )  null, 
"clcod" char( 5 )  null, 
"clobs" varchar(max)  null, 
"clnum" numeric( 5, 0 )  null, 
"clnom" char( 60 )  null, 
"clpun2" numeric( 16, 2 )  null, 
"clemail" char( 60 )  null, 
"clfecha" datetime  null, 
"clfing" datetime  null, 
"clpiso" char( 3 )  null, 
"clpageweb" char( 60 )  null, 
"cldesc" char( 10 )  null, 
"cldepto" char( 3 )  null, 
"cnx1" numeric( 16, 2 )  null, 
"cldto" numeric( 8, 2 )  null, 
"clloc" char( 70 )  null, 
"clfegr" datetime  null, 
"clcp" char( 8 )  null, 
"clprv" char( 2 )  null )
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('cldir','cldir')
			.AgregarMapeo('clpun1','clpun1')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('cltlfm','cltlfm')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('clnum','clnum')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('clpun2','clpun2')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('clfecha','clfecha')
			.AgregarMapeo('clfing','clfing')
			.AgregarMapeo('clpiso','clpiso')
			.AgregarMapeo('clpageweb','clpageweb')
			.AgregarMapeo('cldesc','cldesc')
			.AgregarMapeo('cldepto','cldepto')
			.AgregarMapeo('cnx1','cnx1')
			.AgregarMapeo('cldto','cldto')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clfegr','clfegr')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clprv','clprv')
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
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.CLDIR = isnull( d.CLDIR, t.CLDIR ),t.CLPUN1 = isnull( d.CLPUN1, t.CLPUN1 ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.CLTLFM = isnull( d.CLTLFM, t.CLTLFM ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CLNUM = isnull( d.CLNUM, t.CLNUM ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLPUN2 = isnull( d.CLPUN2, t.CLPUN2 ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.CLFECHA = isnull( d.CLFECHA, t.CLFECHA ),t.CLFING = isnull( d.CLFING, t.CLFING ),t.CLPISO = isnull( d.CLPISO, t.CLPISO ),t.CLPAGEWEB = isnull( d.CLPAGEWEB, t.CLPAGEWEB ),t.CLDESC = isnull( d.CLDESC, t.CLDESC ),t.CLDEPTO = isnull( d.CLDEPTO, t.CLDEPTO ),t.CNX1 = isnull( d.CNX1, t.CNX1 ),t.CLDTO = isnull( d.CLDTO, t.CLDTO ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLFEGR = isnull( d.CLFEGR, t.CLFEGR ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLPRV = isnull( d.CLPRV, t.CLPRV )
					from ZooLogic.VEN t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.VEN(Faltafw,Fecexpo,Fectrans,Fmodifw,Fecimpo,Clnrodoc,Cltipodoc,Cldir,Clpun1,Timestamp,Haltafw,Horaexpo,Saltafw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Cltlf,Cltlfm,Bdaltafw,Cimagen,Clcod,Clobs,Clnum,Clnom,Clpun2,Clemail,Clfecha,Clfing,Clpiso,Clpageweb,Cldesc,Cldepto,Cnx1,Cldto,Clloc,Clfegr,Clcp,Clprv)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.CLNRODOC,''),isnull( d.CLTIPODOC,''),isnull( d.CLDIR,''),isnull( d.CLPUN1,0),isnull( d.TIMESTAMP,0),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.CLTLF,''),isnull( d.CLTLFM,''),isnull( d.BDALTAFW,''),isnull( d.CIMAGEN,''),isnull( d.CLCOD,''),isnull( d.CLOBS,''),isnull( d.CLNUM,0),isnull( d.CLNOM,''),isnull( d.CLPUN2,0),isnull( d.CLEMAIL,''),isnull( d.CLFECHA,''),isnull( d.CLFING,''),isnull( d.CLPISO,''),isnull( d.CLPAGEWEB,''),isnull( d.CLDESC,''),isnull( d.CLDEPTO,''),isnull( d.CNX1,0),isnull( d.CLDTO,0),isnull( d.CLLOC,''),isnull( d.CLFEGR,''),isnull( d.CLCP,''),isnull( d.CLPRV,'')
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
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Nrodocumento = nvl( c_VENDEDOR.Nrodocumento, [] )
					.Tipodocumento = nvl( c_VENDEDOR.Tipodocumento, [] )
					.Calle = nvl( c_VENDEDOR.Calle, [] )
					.Descmaxdetallefacturas = nvl( c_VENDEDOR.Descmaxdetallefacturas, 0 )
					.Timestamp = nvl( c_VENDEDOR.Timestamp, 0 )
					.Horaaltafw = nvl( c_VENDEDOR.Horaaltafw, [] )
					.Horaexpo = nvl( c_VENDEDOR.Horaexpo, [] )
					.Seriealtafw = nvl( c_VENDEDOR.Seriealtafw, [] )
					.Horaimpo = nvl( c_VENDEDOR.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_VENDEDOR.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_VENDEDOR.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_VENDEDOR.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_VENDEDOR.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_VENDEDOR.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_VENDEDOR.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_VENDEDOR.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_VENDEDOR.Basededatosmodificacionfw, [] )
					.Telefono = nvl( c_VENDEDOR.Telefono, [] )
					.Movil = nvl( c_VENDEDOR.Movil, [] )
					.Basededatosaltafw = nvl( c_VENDEDOR.Basededatosaltafw, [] )
					.Imagen = nvl( c_VENDEDOR.Imagen, [] )
					.Codigo = nvl( c_VENDEDOR.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Numero = nvl( c_VENDEDOR.Numero, 0 )
					.Nombre = nvl( c_VENDEDOR.Nombre, [] )
					.Descmaxtotalfacturas = nvl( c_VENDEDOR.Descmaxtotalfacturas, 0 )
					.Email = nvl( c_VENDEDOR.Email, [] )
					.Comisionesdetalle.Limpiar()
					.Comisionesdetalle.SetearEsNavegacion( .lProcesando )
					.Comisionesdetalle.Cargar()
					.Fechanacimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechanacimiento, ctod( '  /  /    ' ) ) )
					.Fechaingreso = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaingreso, ctod( '  /  /    ' ) ) )
					.Piso = nvl( c_VENDEDOR.Piso, [] )
					.Paginaweb = nvl( c_VENDEDOR.Paginaweb, [] )
					.Descuentopreferente_PK =  nvl( c_VENDEDOR.Descuentopreferente, [] )
					.Departamento = nvl( c_VENDEDOR.Departamento, [] )
					.Objetivomensual = nvl( c_VENDEDOR.Objetivomensual, 0 )
					.Comision = nvl( c_VENDEDOR.Comision, 0 )
					.Localidad = nvl( c_VENDEDOR.Localidad, [] )
					.Fechaegreso = GoLibrerias.ObtenerFechaFormateada( nvl( c_VENDEDOR.Fechaegreso, ctod( '  /  /    ' ) ) )
					.Codigopostal = nvl( c_VENDEDOR.Codigopostal, [] )
					.Provincia_PK =  nvl( c_VENDEDOR.Provincia, [] )
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
			"Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clnrodoc" as "Nrodocumento", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Clpun1" as "Descmaxdetallefacturas", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Cltlfm" as "Movil", "Bdaltafw" as "Basededatosaltafw", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clnum" as "Numero", "Clnom" as "Nombre", "Clpun2" as "Descmaxtotalfacturas", "Clemail" as "Email", "Clfecha" as "Fechanacimiento", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clpageweb" as "Paginaweb", "Cldesc" as "Descuentopreferente", "Cldepto" as "Departamento", "Cnx1" as "Objetivomensual", "Cldto" as "Comision", "Clloc" as "Localidad", "Clfegr" as "Fechaegreso", "Clcp" as "Codigopostal", "Clprv" as "Provincia"
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
	<row entidad="VENDEDOR                                " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAALTAFW                             " tabla="VEN            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAEXPO                               " tabla="VEN            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHATRANSFERENCIA                      " tabla="VEN            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAMODIFICACIONFW                     " tabla="VEN            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAIMPO                               " tabla="VEN            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NRODOCUMENTO                            " tabla="VEN            " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="TIPODOCUMENTO                           " tabla="VEN            " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="CALLE                                   " tabla="VEN            " campo="CLDIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DESCMAXDETALLEFACTURAS                  " tabla="VEN            " campo="CLPUN1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% en detalle                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="TIMESTAMP                               " tabla="VEN            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAALTAFW                              " tabla="VEN            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAEXPO                                " tabla="VEN            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="SERIEALTAFW                             " tabla="VEN            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAIMPO                                " tabla="VEN            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="VERSIONMODIFICACIONFW                   " tabla="VEN            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="ZADSFW                                  " tabla="VEN            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="VERSIONALTAFW                           " tabla="VEN            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="USUARIOMODIFICACIONFW                   " tabla="VEN            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="SERIEMODIFICACIONFW                     " tabla="VEN            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="USUARIOALTAFW                           " tabla="VEN            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="HORAMODIFICACIONFW                      " tabla="VEN            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="ESTADOTRANSFERENCIA                     " tabla="VEN            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="VEN            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="TELEFONO                                " tabla="VEN            " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="MOVIL                                   " tabla="VEN            " campo="CLTLFM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="BASEDEDATOSALTAFW                       " tabla="VEN            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="IMAGEN                                  " tabla="VEN            " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Imagen                                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="CODIGO                                  " tabla="VEN            " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="OBSERVACION                             " tabla="VEN            " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NUMERO                                  " tabla="VEN            " campo="CLNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Nro                                                                                                                                                             " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DESCMAXTOTALFACTURAS                    " tabla="VEN            " campo="CLPUN2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% en totales                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="EMAIL                                   " tabla="VEN            " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="E-Mail                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="COMISIONESDETALLE                       " tabla="DETCOMVEN      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Comisiones                                                                                                                                                      " dominio="DETALLEITEMCOMISIONVENDEDOR   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHANACIMIENTO                         " tabla="VEN            " campo="CLFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Fecha Nacimiento                                                                                                                                                " dominio="FECHALARGACALENDARIO          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAINGRESO                            " tabla="VEN            " campo="CLFING    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Fecha Ing                                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="PISO                                    " tabla="VEN            " campo="CLPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="PAGINAWEB                               " tabla="VEN            " campo="CLPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Página Web                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DESCUENTOPREFERENTE                     " tabla="VEN            " campo="CLDESC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESCUENTO                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Descuento                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="DEPARTAMENTO                            " tabla="VEN            " campo="CLDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="OBJETIVOMENSUAL                         " tabla="VEN            " campo="CNX1      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Objetivo Mensual                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="COMISION                                " tabla="VEN            " campo="CLDTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Comisión %                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="LOCALIDAD                               " tabla="VEN            " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="FECHAEGRESO                             " tabla="VEN            " campo="CLFEGR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Fecha Egreso                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="CODIGOPOSTAL                            " tabla="VEN            " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Código Postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="PROVINCIA                               " tabla="VEN            " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="39" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESCUENTOS On VEN.CLDESC = DESCUENTOS.codigo And  DESCUENTOS.CODIGO != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On VEN.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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