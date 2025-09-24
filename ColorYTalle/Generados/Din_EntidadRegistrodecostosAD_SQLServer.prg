
define class Din_EntidadREGISTRODECOSTOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REGISTRODECOSTOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CMVPK'
	cTablaPrincipal = 'CMVFACCOMPRA'
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
			local  lxCmvfaccompraFecimpo, lxCmvfaccompraFectrans, lxCmvfaccompraFmodifw, lxCmvfaccompraFecexpo, lxCmvfaccompraFaltafw, lxCmvfaccompraBdmodifw, lxCmvfaccompraEsttrans, lxCmvfaccompraHaltafw, lxCmvfaccompraHoraimpo, lxCmvfaccompraHoraexpo, lxCmvfaccompraValtafw, lxCmvfaccompraZadsfw, lxCmvfaccompraVmodifw, lxCmvfaccompraUmodifw, lxCmvfaccompraUaltafw, lxCmvfaccompraHmodifw, lxCmvfaccompraSmodifw, lxCmvfaccompraSaltafw, lxCmvfaccompraBdaltafw, lxCmvfaccompraTimestamp, lxCmvfaccompraCodigo, lxCmvfaccompraCodcomp, lxCmvfaccompraFnumint, lxCmvfaccompraFacttipo, lxCmvfaccompraFletra, lxCmvfaccompraFptovenex, lxCmvfaccompraFnumcomp, lxCmvfaccompraFptoven, lxCmvfaccompraFfecha, lxCmvfaccompraFdesc, lxCmvfaccompraFarticulo, lxCmvfaccompraFcolor, lxCmvfaccompraFtalle, lxCmvfaccompraFcant, lxCmvfaccompraFstock, lxCmvfaccompraFprecio, lxCmvfaccompraStockant, lxCmvfaccompraEjercicio, lxCmvfaccompraBase, lxCmvfaccompraCosteo, lxCmvfaccompraTingreso, lxCmvfaccompraObs
				lxCmvfaccompraFecimpo =  .Fechaimpo			lxCmvfaccompraFectrans =  .Fechatransferencia			lxCmvfaccompraFmodifw =  .Fechamodificacionfw			lxCmvfaccompraFecexpo =  .Fechaexpo			lxCmvfaccompraFaltafw =  .Fechaaltafw			lxCmvfaccompraBdmodifw =  .Basededatosmodificacionfw			lxCmvfaccompraEsttrans =  .Estadotransferencia			lxCmvfaccompraHaltafw =  .Horaaltafw			lxCmvfaccompraHoraimpo =  .Horaimpo			lxCmvfaccompraHoraexpo =  .Horaexpo			lxCmvfaccompraValtafw =  .Versionaltafw			lxCmvfaccompraZadsfw =  .Zadsfw			lxCmvfaccompraVmodifw =  .Versionmodificacionfw			lxCmvfaccompraUmodifw =  .Usuariomodificacionfw			lxCmvfaccompraUaltafw =  .Usuarioaltafw			lxCmvfaccompraHmodifw =  .Horamodificacionfw			lxCmvfaccompraSmodifw =  .Seriemodificacionfw			lxCmvfaccompraSaltafw =  .Seriealtafw			lxCmvfaccompraBdaltafw =  .Basededatosaltafw			lxCmvfaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCmvfaccompraCodigo =  .Identificador			lxCmvfaccompraCodcomp =  .Codcomprobante			lxCmvfaccompraFnumint =  .Numerointerno			lxCmvfaccompraFacttipo =  .Tipocomprobante			lxCmvfaccompraFletra =  .Letra			lxCmvfaccompraFptovenex =  .Puntodeventaextendido			lxCmvfaccompraFnumcomp =  .Numero			lxCmvfaccompraFptoven =  .Puntodeventa			lxCmvfaccompraFfecha =  .Fecha			lxCmvfaccompraFdesc =  .Descripcioncomp			lxCmvfaccompraFarticulo =  upper( .Articulo_PK ) 			lxCmvfaccompraFcolor =  upper( .Color_PK ) 			lxCmvfaccompraFtalle =  upper( .Talle_PK ) 			lxCmvfaccompraFcant =  .Cantidad			lxCmvfaccompraFstock =  .Stock			lxCmvfaccompraFprecio =  .Precio			lxCmvfaccompraStockant =  .Stockanterior			lxCmvfaccompraEjercicio =  .Ejercicio_PK 			lxCmvfaccompraBase =  .Basededatos			lxCmvfaccompraCosteo =  .Metodocosteo			lxCmvfaccompraTingreso =  .Tipoingreso			lxCmvfaccompraObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCmvfaccompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CMVFACCOMPRA ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bdmodifw","Esttrans","Haltafw","Horaimpo","Horaexpo","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Bdaltafw","Timestamp","Codigo","Codcomp","Fnumint","Facttipo","Fletra","Fptovenex","Fnumcomp","Fptoven","Ffecha","Fdesc","Farticulo","Fcolor","Ftalle","Fcant","Fstock","Fprecio","Stockant","Ejercicio","Base","Costeo","Tingreso","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdaltafw ) + "'" >>, <<lxCmvfaccompraTimestamp >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodcomp ) + "'" >>, <<lxCmvfaccompraFnumint >>, <<lxCmvfaccompraFacttipo >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFletra ) + "'" >>, <<lxCmvfaccompraFptovenex >>, <<lxCmvfaccompraFnumcomp >>, <<lxCmvfaccompraFptoven >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFarticulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFtalle ) + "'" >>, <<lxCmvfaccompraFcant >>, <<lxCmvfaccompraFstock >>, <<lxCmvfaccompraFprecio >>, <<lxCmvfaccompraStockant >>, <<lxCmvfaccompraEjercicio >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraBase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraCosteo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraTingreso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
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
		this.oEntidad.Timestamp = lxCmvfaccompraTimestamp
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
		return this.oEntidad.IDENTIFICADOR
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxCmvfaccompraFecimpo, lxCmvfaccompraFectrans, lxCmvfaccompraFmodifw, lxCmvfaccompraFecexpo, lxCmvfaccompraFaltafw, lxCmvfaccompraBdmodifw, lxCmvfaccompraEsttrans, lxCmvfaccompraHaltafw, lxCmvfaccompraHoraimpo, lxCmvfaccompraHoraexpo, lxCmvfaccompraValtafw, lxCmvfaccompraZadsfw, lxCmvfaccompraVmodifw, lxCmvfaccompraUmodifw, lxCmvfaccompraUaltafw, lxCmvfaccompraHmodifw, lxCmvfaccompraSmodifw, lxCmvfaccompraSaltafw, lxCmvfaccompraBdaltafw, lxCmvfaccompraTimestamp, lxCmvfaccompraCodigo, lxCmvfaccompraCodcomp, lxCmvfaccompraFnumint, lxCmvfaccompraFacttipo, lxCmvfaccompraFletra, lxCmvfaccompraFptovenex, lxCmvfaccompraFnumcomp, lxCmvfaccompraFptoven, lxCmvfaccompraFfecha, lxCmvfaccompraFdesc, lxCmvfaccompraFarticulo, lxCmvfaccompraFcolor, lxCmvfaccompraFtalle, lxCmvfaccompraFcant, lxCmvfaccompraFstock, lxCmvfaccompraFprecio, lxCmvfaccompraStockant, lxCmvfaccompraEjercicio, lxCmvfaccompraBase, lxCmvfaccompraCosteo, lxCmvfaccompraTingreso, lxCmvfaccompraObs
				lxCmvfaccompraFecimpo =  .Fechaimpo			lxCmvfaccompraFectrans =  .Fechatransferencia			lxCmvfaccompraFmodifw =  .Fechamodificacionfw			lxCmvfaccompraFecexpo =  .Fechaexpo			lxCmvfaccompraFaltafw =  .Fechaaltafw			lxCmvfaccompraBdmodifw =  .Basededatosmodificacionfw			lxCmvfaccompraEsttrans =  .Estadotransferencia			lxCmvfaccompraHaltafw =  .Horaaltafw			lxCmvfaccompraHoraimpo =  .Horaimpo			lxCmvfaccompraHoraexpo =  .Horaexpo			lxCmvfaccompraValtafw =  .Versionaltafw			lxCmvfaccompraZadsfw =  .Zadsfw			lxCmvfaccompraVmodifw =  .Versionmodificacionfw			lxCmvfaccompraUmodifw =  .Usuariomodificacionfw			lxCmvfaccompraUaltafw =  .Usuarioaltafw			lxCmvfaccompraHmodifw =  .Horamodificacionfw			lxCmvfaccompraSmodifw =  .Seriemodificacionfw			lxCmvfaccompraSaltafw =  .Seriealtafw			lxCmvfaccompraBdaltafw =  .Basededatosaltafw			lxCmvfaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCmvfaccompraCodigo =  .Identificador			lxCmvfaccompraCodcomp =  .Codcomprobante			lxCmvfaccompraFnumint =  .Numerointerno			lxCmvfaccompraFacttipo =  .Tipocomprobante			lxCmvfaccompraFletra =  .Letra			lxCmvfaccompraFptovenex =  .Puntodeventaextendido			lxCmvfaccompraFnumcomp =  .Numero			lxCmvfaccompraFptoven =  .Puntodeventa			lxCmvfaccompraFfecha =  .Fecha			lxCmvfaccompraFdesc =  .Descripcioncomp			lxCmvfaccompraFarticulo =  upper( .Articulo_PK ) 			lxCmvfaccompraFcolor =  upper( .Color_PK ) 			lxCmvfaccompraFtalle =  upper( .Talle_PK ) 			lxCmvfaccompraFcant =  .Cantidad			lxCmvfaccompraFstock =  .Stock			lxCmvfaccompraFprecio =  .Precio			lxCmvfaccompraStockant =  .Stockanterior			lxCmvfaccompraEjercicio =  .Ejercicio_PK 			lxCmvfaccompraBase =  .Basededatos			lxCmvfaccompraCosteo =  .Metodocosteo			lxCmvfaccompraTingreso =  .Tipoingreso			lxCmvfaccompraObs =  .Obs
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
			lxValorClavePrimaria = .oEntidad.IDENTIFICADOR
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CMVFACCOMPRA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraSaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdaltafw ) + "'">>,"Timestamp" = <<lxCmvfaccompraTimestamp>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodigo ) + "'">>,"Codcomp" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodcomp ) + "'">>,"Fnumint" = <<lxCmvfaccompraFnumint>>,"Facttipo" = <<lxCmvfaccompraFacttipo>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFletra ) + "'">>,"Fptovenex" = <<lxCmvfaccompraFptovenex>>,"Fnumcomp" = <<lxCmvfaccompraFnumcomp>>,"Fptoven" = <<lxCmvfaccompraFptoven>>,"Ffecha" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFfecha ) + "'">>,"Fdesc" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFdesc ) + "'">>,"Farticulo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFarticulo ) + "'">>,"Fcolor" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFcolor ) + "'">>,"Ftalle" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFtalle ) + "'">>,"Fcant" = <<lxCmvfaccompraFcant>>,"Fstock" = <<lxCmvfaccompraFstock>>,"Fprecio" = <<lxCmvfaccompraFprecio>>,"Stockant" = <<lxCmvfaccompraStockant>>,"Ejercicio" = <<lxCmvfaccompraEjercicio>>,"Base" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraBase ) + "'">>,"Costeo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCosteo ) + "'">>,"Tingreso" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraTingreso ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodigo ) + "'">> and  CMVFACCOMPRA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCmvfaccompraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CMVFACCOMPRA where " + this.ConvertirFuncionesSql( " CMVFACCOMPRA.CODIGO != ''" ) )
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
			Local lxCmvfaccompraCodigo
			lxCmvfaccompraCodigo = .Identificador

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Codigo" as "Identificador", "Codcomp" as "Codcomprobante", "Fnumint" as "Numerointerno", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptovenex" as "Puntodeventaextendido", "Fnumcomp" as "Numero", "Fptoven" as "Puntodeventa", "Ffecha" as "Fecha", "Fdesc" as "Descripcioncomp", "Farticulo" as "Articulo", "Fcolor" as "Color", "Ftalle" as "Talle", "Fcant" as "Cantidad", "Fstock" as "Stock", "Fprecio" as "Precio", "Stockant" as "Stockanterior", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Costeo" as "Metodocosteo", "Tingreso" as "Tipoingreso", "Obs" as "Obs" from ZooLogic.CMVFACCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodigo ) + "'">> and  CMVFACCOMPRA.CODIGO != ''
			endtext
			use in select('c_REGISTRODECOSTOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECOSTOS', set( 'Datasession' ) )

			if reccount( 'c_REGISTRODECOSTOS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCmvfaccompraCodigo as Variant
		llRetorno = .t.
		lxCmvfaccompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CMVFACCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodigo ) + "'">> and  CMVFACCOMPRA.CODIGO != ''
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
				lcOrden =  .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Codigo" as "Identificador", "Codcomp" as "Codcomprobante", "Fnumint" as "Numerointerno", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptovenex" as "Puntodeventaextendido", "Fnumcomp" as "Numero", "Fptoven" as "Puntodeventa", "Ffecha" as "Fecha", "Fdesc" as "Descripcioncomp", "Farticulo" as "Articulo", "Fcolor" as "Color", "Ftalle" as "Talle", "Fcant" as "Cantidad", "Fstock" as "Stock", "Fprecio" as "Precio", "Stockant" as "Stockanterior", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Costeo" as "Metodocosteo", "Tingreso" as "Tipoingreso", "Obs" as "Obs" from ZooLogic.CMVFACCOMPRA where  CMVFACCOMPRA.CODIGO != '' order by Codigo
			endtext
			use in select('c_REGISTRODECOSTOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECOSTOS', set( 'Datasession' ) )
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
				lcOrden =  .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Codigo" as "Identificador", "Codcomp" as "Codcomprobante", "Fnumint" as "Numerointerno", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptovenex" as "Puntodeventaextendido", "Fnumcomp" as "Numero", "Fptoven" as "Puntodeventa", "Ffecha" as "Fecha", "Fdesc" as "Descripcioncomp", "Farticulo" as "Articulo", "Fcolor" as "Color", "Ftalle" as "Talle", "Fcant" as "Cantidad", "Fstock" as "Stock", "Fprecio" as "Precio", "Stockant" as "Stockanterior", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Costeo" as "Metodocosteo", "Tingreso" as "Tipoingreso", "Obs" as "Obs" from ZooLogic.CMVFACCOMPRA where  funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CMVFACCOMPRA.CODIGO != '' order by Codigo
			endtext
			use in select('c_REGISTRODECOSTOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECOSTOS', set( 'Datasession' ) )
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
				lcOrden =  .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Codigo" as "Identificador", "Codcomp" as "Codcomprobante", "Fnumint" as "Numerointerno", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptovenex" as "Puntodeventaextendido", "Fnumcomp" as "Numero", "Fptoven" as "Puntodeventa", "Ffecha" as "Fecha", "Fdesc" as "Descripcioncomp", "Farticulo" as "Articulo", "Fcolor" as "Color", "Ftalle" as "Talle", "Fcant" as "Cantidad", "Fstock" as "Stock", "Fprecio" as "Precio", "Stockant" as "Stockanterior", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Costeo" as "Metodocosteo", "Tingreso" as "Tipoingreso", "Obs" as "Obs" from ZooLogic.CMVFACCOMPRA where  funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CMVFACCOMPRA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_REGISTRODECOSTOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECOSTOS', set( 'Datasession' ) )
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
				lcOrden =  .Identificador
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Codigo" as "Identificador", "Codcomp" as "Codcomprobante", "Fnumint" as "Numerointerno", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptovenex" as "Puntodeventaextendido", "Fnumcomp" as "Numero", "Fptoven" as "Puntodeventa", "Ffecha" as "Fecha", "Fdesc" as "Descripcioncomp", "Farticulo" as "Articulo", "Fcolor" as "Color", "Ftalle" as "Talle", "Fcant" as "Cantidad", "Fstock" as "Stock", "Fprecio" as "Precio", "Stockant" as "Stockanterior", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Costeo" as "Metodocosteo", "Tingreso" as "Tipoingreso", "Obs" as "Obs" from ZooLogic.CMVFACCOMPRA where  CMVFACCOMPRA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_REGISTRODECOSTOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECOSTOS', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bdmodifw,Esttrans,Haltafw,Horaimpo,Horaexpo,Valtafw" + ;
",Zadsfw,Vmodifw,Umodifw,Ualtafw,Hmodifw,Smodifw,Saltafw,Bdaltafw,Timestamp,Codigo,Codcomp,Fnumint,Fa" + ;
"cttipo,Fletra,Fptovenex,Fnumcomp,Fptoven,Ffecha,Fdesc,Farticulo,Fcolor,Ftalle,Fcant,Fstock,Fprecio,S" + ;
"tockant,Ejercicio,Base,Costeo,Tingreso,Obs" + ;
" from ZooLogic.CMVFACCOMPRA where  CMVFACCOMPRA.CODIGO != '' and " + lcFiltro )
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
			local  lxCmvfaccompraFecimpo, lxCmvfaccompraFectrans, lxCmvfaccompraFmodifw, lxCmvfaccompraFecexpo, lxCmvfaccompraFaltafw, lxCmvfaccompraBdmodifw, lxCmvfaccompraEsttrans, lxCmvfaccompraHaltafw, lxCmvfaccompraHoraimpo, lxCmvfaccompraHoraexpo, lxCmvfaccompraValtafw, lxCmvfaccompraZadsfw, lxCmvfaccompraVmodifw, lxCmvfaccompraUmodifw, lxCmvfaccompraUaltafw, lxCmvfaccompraHmodifw, lxCmvfaccompraSmodifw, lxCmvfaccompraSaltafw, lxCmvfaccompraBdaltafw, lxCmvfaccompraTimestamp, lxCmvfaccompraCodigo, lxCmvfaccompraCodcomp, lxCmvfaccompraFnumint, lxCmvfaccompraFacttipo, lxCmvfaccompraFletra, lxCmvfaccompraFptovenex, lxCmvfaccompraFnumcomp, lxCmvfaccompraFptoven, lxCmvfaccompraFfecha, lxCmvfaccompraFdesc, lxCmvfaccompraFarticulo, lxCmvfaccompraFcolor, lxCmvfaccompraFtalle, lxCmvfaccompraFcant, lxCmvfaccompraFstock, lxCmvfaccompraFprecio, lxCmvfaccompraStockant, lxCmvfaccompraEjercicio, lxCmvfaccompraBase, lxCmvfaccompraCosteo, lxCmvfaccompraTingreso, lxCmvfaccompraObs
				lxCmvfaccompraFecimpo = ctod( '  /  /    ' )			lxCmvfaccompraFectrans = ctod( '  /  /    ' )			lxCmvfaccompraFmodifw = ctod( '  /  /    ' )			lxCmvfaccompraFecexpo = ctod( '  /  /    ' )			lxCmvfaccompraFaltafw = ctod( '  /  /    ' )			lxCmvfaccompraBdmodifw = []			lxCmvfaccompraEsttrans = []			lxCmvfaccompraHaltafw = []			lxCmvfaccompraHoraimpo = []			lxCmvfaccompraHoraexpo = []			lxCmvfaccompraValtafw = []			lxCmvfaccompraZadsfw = []			lxCmvfaccompraVmodifw = []			lxCmvfaccompraUmodifw = []			lxCmvfaccompraUaltafw = []			lxCmvfaccompraHmodifw = []			lxCmvfaccompraSmodifw = []			lxCmvfaccompraSaltafw = []			lxCmvfaccompraBdaltafw = []			lxCmvfaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCmvfaccompraCodigo = []			lxCmvfaccompraCodcomp = []			lxCmvfaccompraFnumint = 0			lxCmvfaccompraFacttipo = 0			lxCmvfaccompraFletra = []			lxCmvfaccompraFptovenex = 0			lxCmvfaccompraFnumcomp = 0			lxCmvfaccompraFptoven = 0			lxCmvfaccompraFfecha = ctod( '  /  /    ' )			lxCmvfaccompraFdesc = []			lxCmvfaccompraFarticulo = []			lxCmvfaccompraFcolor = []			lxCmvfaccompraFtalle = []			lxCmvfaccompraFcant = 0			lxCmvfaccompraFstock = 0			lxCmvfaccompraFprecio = 0			lxCmvfaccompraStockant = 0			lxCmvfaccompraEjercicio = 0			lxCmvfaccompraBase = []			lxCmvfaccompraCosteo = []			lxCmvfaccompraTingreso = []			lxCmvfaccompraObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CMVFACCOMPRA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CMVFACCOMPRA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CMVFACCOMPRA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Codigo" as "Identificador", "Codcomp" as "Codcomprobante", "Fnumint" as "Numerointerno", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptovenex" as "Puntodeventaextendido", "Fnumcomp" as "Numero", "Fptoven" as "Puntodeventa", "Ffecha" as "Fecha", "Fdesc" as "Descripcioncomp", "Farticulo" as "Articulo", "Fcolor" as "Color", "Ftalle" as "Talle", "Fcant" as "Cantidad", "Fstock" as "Stock", "Fprecio" as "Precio", "Stockant" as "Stockanterior", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Costeo" as "Metodocosteo", "Tingreso" as "Tipoingreso", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CMVFACCOMPRA', '', tnTope )
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
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS IDENTIFICADOR'
				Case lcAtributo == 'CODCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODCOMPROBANTE'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMINT AS NUMEROINTERNO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTAEXTENDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENEX AS PUNTODEVENTAEXTENDIDO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFECHA AS FECHA'
				Case lcAtributo == 'DESCRIPCIONCOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESC AS DESCRIPCIONCOMP'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FARTICULO AS ARTICULO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCANT AS CANTIDAD'
				Case lcAtributo == 'STOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSTOCK AS STOCK'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRECIO AS PRECIO'
				Case lcAtributo == 'STOCKANTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'STOCKANT AS STOCKANTERIOR'
				Case lcAtributo == 'EJERCICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EJERCICIO AS EJERCICIO'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASE AS BASEDEDATOS'
				Case lcAtributo == 'METODOCOSTEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTEO AS METODOCOSTEO'
				Case lcAtributo == 'TIPOINGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TINGRESO AS TIPOINGRESO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'FNUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAEXTENDIDO'
				lcCampo = 'FPTOVENEX'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONCOMP'
				lcCampo = 'FDESC'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'FCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'FCANT'
			Case upper( alltrim( tcAtributo ) ) == 'STOCK'
				lcCampo = 'FSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'FPRECIO'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKANTERIOR'
				lcCampo = 'STOCKANT'
			Case upper( alltrim( tcAtributo ) ) == 'EJERCICIO'
				lcCampo = 'EJERCICIO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASE'
			Case upper( alltrim( tcAtributo ) ) == 'METODOCOSTEO'
				lcCampo = 'COSTEO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINGRESO'
				lcCampo = 'TINGRESO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
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
			local  lxCmvfaccompraFecimpo, lxCmvfaccompraFectrans, lxCmvfaccompraFmodifw, lxCmvfaccompraFecexpo, lxCmvfaccompraFaltafw, lxCmvfaccompraBdmodifw, lxCmvfaccompraEsttrans, lxCmvfaccompraHaltafw, lxCmvfaccompraHoraimpo, lxCmvfaccompraHoraexpo, lxCmvfaccompraValtafw, lxCmvfaccompraZadsfw, lxCmvfaccompraVmodifw, lxCmvfaccompraUmodifw, lxCmvfaccompraUaltafw, lxCmvfaccompraHmodifw, lxCmvfaccompraSmodifw, lxCmvfaccompraSaltafw, lxCmvfaccompraBdaltafw, lxCmvfaccompraTimestamp, lxCmvfaccompraCodigo, lxCmvfaccompraCodcomp, lxCmvfaccompraFnumint, lxCmvfaccompraFacttipo, lxCmvfaccompraFletra, lxCmvfaccompraFptovenex, lxCmvfaccompraFnumcomp, lxCmvfaccompraFptoven, lxCmvfaccompraFfecha, lxCmvfaccompraFdesc, lxCmvfaccompraFarticulo, lxCmvfaccompraFcolor, lxCmvfaccompraFtalle, lxCmvfaccompraFcant, lxCmvfaccompraFstock, lxCmvfaccompraFprecio, lxCmvfaccompraStockant, lxCmvfaccompraEjercicio, lxCmvfaccompraBase, lxCmvfaccompraCosteo, lxCmvfaccompraTingreso, lxCmvfaccompraObs
				lxCmvfaccompraFecimpo =  .Fechaimpo			lxCmvfaccompraFectrans =  .Fechatransferencia			lxCmvfaccompraFmodifw =  .Fechamodificacionfw			lxCmvfaccompraFecexpo =  .Fechaexpo			lxCmvfaccompraFaltafw =  .Fechaaltafw			lxCmvfaccompraBdmodifw =  .Basededatosmodificacionfw			lxCmvfaccompraEsttrans =  .Estadotransferencia			lxCmvfaccompraHaltafw =  .Horaaltafw			lxCmvfaccompraHoraimpo =  .Horaimpo			lxCmvfaccompraHoraexpo =  .Horaexpo			lxCmvfaccompraValtafw =  .Versionaltafw			lxCmvfaccompraZadsfw =  .Zadsfw			lxCmvfaccompraVmodifw =  .Versionmodificacionfw			lxCmvfaccompraUmodifw =  .Usuariomodificacionfw			lxCmvfaccompraUaltafw =  .Usuarioaltafw			lxCmvfaccompraHmodifw =  .Horamodificacionfw			lxCmvfaccompraSmodifw =  .Seriemodificacionfw			lxCmvfaccompraSaltafw =  .Seriealtafw			lxCmvfaccompraBdaltafw =  .Basededatosaltafw			lxCmvfaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCmvfaccompraCodigo =  .Identificador			lxCmvfaccompraCodcomp =  .Codcomprobante			lxCmvfaccompraFnumint =  .Numerointerno			lxCmvfaccompraFacttipo =  .Tipocomprobante			lxCmvfaccompraFletra =  .Letra			lxCmvfaccompraFptovenex =  .Puntodeventaextendido			lxCmvfaccompraFnumcomp =  .Numero			lxCmvfaccompraFptoven =  .Puntodeventa			lxCmvfaccompraFfecha =  .Fecha			lxCmvfaccompraFdesc =  .Descripcioncomp			lxCmvfaccompraFarticulo =  upper( .Articulo_PK ) 			lxCmvfaccompraFcolor =  upper( .Color_PK ) 			lxCmvfaccompraFtalle =  upper( .Talle_PK ) 			lxCmvfaccompraFcant =  .Cantidad			lxCmvfaccompraFstock =  .Stock			lxCmvfaccompraFprecio =  .Precio			lxCmvfaccompraStockant =  .Stockanterior			lxCmvfaccompraEjercicio =  .Ejercicio_PK 			lxCmvfaccompraBase =  .Basededatos			lxCmvfaccompraCosteo =  .Metodocosteo			lxCmvfaccompraTingreso =  .Tipoingreso			lxCmvfaccompraObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CMVFACCOMPRA ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bdmodifw","Esttrans","Haltafw","Horaimpo","Horaexpo","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Bdaltafw","Timestamp","Codigo","Codcomp","Fnumint","Facttipo","Fletra","Fptovenex","Fnumcomp","Fptoven","Ffecha","Fdesc","Farticulo","Fcolor","Ftalle","Fcant","Fstock","Fprecio","Stockant","Ejercicio","Base","Costeo","Tingreso","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdaltafw ) + "'" >>, <<lxCmvfaccompraTimestamp >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodcomp ) + "'" >>, <<lxCmvfaccompraFnumint >>, <<lxCmvfaccompraFacttipo >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFletra ) + "'" >>, <<lxCmvfaccompraFptovenex >>, <<lxCmvfaccompraFnumcomp >>, <<lxCmvfaccompraFptoven >>, <<"'" + this.ConvertirDateSql( lxCmvfaccompraFfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFarticulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraFtalle ) + "'" >>, <<lxCmvfaccompraFcant >>, <<lxCmvfaccompraFstock >>, <<lxCmvfaccompraFprecio >>, <<lxCmvfaccompraStockant >>, <<lxCmvfaccompraEjercicio >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraBase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraCosteo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraTingreso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfaccompraObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CMVFACCOMPRA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCmvfaccompraFecimpo, lxCmvfaccompraFectrans, lxCmvfaccompraFmodifw, lxCmvfaccompraFecexpo, lxCmvfaccompraFaltafw, lxCmvfaccompraBdmodifw, lxCmvfaccompraEsttrans, lxCmvfaccompraHaltafw, lxCmvfaccompraHoraimpo, lxCmvfaccompraHoraexpo, lxCmvfaccompraValtafw, lxCmvfaccompraZadsfw, lxCmvfaccompraVmodifw, lxCmvfaccompraUmodifw, lxCmvfaccompraUaltafw, lxCmvfaccompraHmodifw, lxCmvfaccompraSmodifw, lxCmvfaccompraSaltafw, lxCmvfaccompraBdaltafw, lxCmvfaccompraTimestamp, lxCmvfaccompraCodigo, lxCmvfaccompraCodcomp, lxCmvfaccompraFnumint, lxCmvfaccompraFacttipo, lxCmvfaccompraFletra, lxCmvfaccompraFptovenex, lxCmvfaccompraFnumcomp, lxCmvfaccompraFptoven, lxCmvfaccompraFfecha, lxCmvfaccompraFdesc, lxCmvfaccompraFarticulo, lxCmvfaccompraFcolor, lxCmvfaccompraFtalle, lxCmvfaccompraFcant, lxCmvfaccompraFstock, lxCmvfaccompraFprecio, lxCmvfaccompraStockant, lxCmvfaccompraEjercicio, lxCmvfaccompraBase, lxCmvfaccompraCosteo, lxCmvfaccompraTingreso, lxCmvfaccompraObs
				lxCmvfaccompraFecimpo =  .Fechaimpo			lxCmvfaccompraFectrans =  .Fechatransferencia			lxCmvfaccompraFmodifw =  .Fechamodificacionfw			lxCmvfaccompraFecexpo =  .Fechaexpo			lxCmvfaccompraFaltafw =  .Fechaaltafw			lxCmvfaccompraBdmodifw =  .Basededatosmodificacionfw			lxCmvfaccompraEsttrans =  .Estadotransferencia			lxCmvfaccompraHaltafw =  .Horaaltafw			lxCmvfaccompraHoraimpo =  .Horaimpo			lxCmvfaccompraHoraexpo =  .Horaexpo			lxCmvfaccompraValtafw =  .Versionaltafw			lxCmvfaccompraZadsfw =  .Zadsfw			lxCmvfaccompraVmodifw =  .Versionmodificacionfw			lxCmvfaccompraUmodifw =  .Usuariomodificacionfw			lxCmvfaccompraUaltafw =  .Usuarioaltafw			lxCmvfaccompraHmodifw =  .Horamodificacionfw			lxCmvfaccompraSmodifw =  .Seriemodificacionfw			lxCmvfaccompraSaltafw =  .Seriealtafw			lxCmvfaccompraBdaltafw =  .Basededatosaltafw			lxCmvfaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCmvfaccompraCodigo =  .Identificador			lxCmvfaccompraCodcomp =  .Codcomprobante			lxCmvfaccompraFnumint =  .Numerointerno			lxCmvfaccompraFacttipo =  .Tipocomprobante			lxCmvfaccompraFletra =  .Letra			lxCmvfaccompraFptovenex =  .Puntodeventaextendido			lxCmvfaccompraFnumcomp =  .Numero			lxCmvfaccompraFptoven =  .Puntodeventa			lxCmvfaccompraFfecha =  .Fecha			lxCmvfaccompraFdesc =  .Descripcioncomp			lxCmvfaccompraFarticulo =  upper( .Articulo_PK ) 			lxCmvfaccompraFcolor =  upper( .Color_PK ) 			lxCmvfaccompraFtalle =  upper( .Talle_PK ) 			lxCmvfaccompraFcant =  .Cantidad			lxCmvfaccompraFstock =  .Stock			lxCmvfaccompraFprecio =  .Precio			lxCmvfaccompraStockant =  .Stockanterior			lxCmvfaccompraEjercicio =  .Ejercicio_PK 			lxCmvfaccompraBase =  .Basededatos			lxCmvfaccompraCosteo =  .Metodocosteo			lxCmvfaccompraTingreso =  .Tipoingreso			lxCmvfaccompraObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CMVFACCOMPRA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CMVFACCOMPRA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraSaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraBdaltafw ) + "'">>, "Timestamp" = <<lxCmvfaccompraTimestamp>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodigo ) + "'">>, "Codcomp" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCodcomp ) + "'">>, "Fnumint" = <<lxCmvfaccompraFnumint>>, "Facttipo" = <<lxCmvfaccompraFacttipo>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFletra ) + "'">>, "Fptovenex" = <<lxCmvfaccompraFptovenex>>, "Fnumcomp" = <<lxCmvfaccompraFnumcomp>>, "Fptoven" = <<lxCmvfaccompraFptoven>>, "Ffecha" = <<"'" + this.ConvertirDateSql( lxCmvfaccompraFfecha ) + "'">>, "Fdesc" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFdesc ) + "'">>, "Farticulo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFarticulo ) + "'">>, "Fcolor" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFcolor ) + "'">>, "Ftalle" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraFtalle ) + "'">>, "Fcant" = <<lxCmvfaccompraFcant>>, "Fstock" = <<lxCmvfaccompraFstock>>, "Fprecio" = <<lxCmvfaccompraFprecio>>, "Stockant" = <<lxCmvfaccompraStockant>>, "Ejercicio" = <<lxCmvfaccompraEjercicio>>, "Base" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraBase ) + "'">>, "Costeo" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraCosteo ) + "'">>, "Tingreso" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraTingreso ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCmvfaccompraObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CMVFACCOMPRA' 
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
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CMVFACCOMPRA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CMVFACCOMPRA where ' + lcFiltro )
			loColeccion.cTabla = 'CMVFACCOMPRA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CMVFACCOMPRA where  CMVFACCOMPRA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CMVFACCOMPRA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.IDENTIFICADOR ) + "'"+ " and  CMVFACCOMPRA.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECOSTOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CMVFACCOMPRA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CMVFACCOMPRA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, CodComp = ] + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'"+ [, FNumInt = ] + transform( &lcCursor..FNumInt )+ [, FactTipo = ] + transform( &lcCursor..FactTipo )+ [, FLetra = ] + "'" + this.FormatearTextoSql( &lcCursor..FLetra ) + "'"+ [, FPtoVenEx = ] + transform( &lcCursor..FPtoVenEx )+ [, FNumComp = ] + transform( &lcCursor..FNumComp )+ [, FPtoVen = ] + transform( &lcCursor..FPtoVen )+ [, FFecha = ] + "'" + this.ConvertirDateSql( &lcCursor..FFecha ) + "'"+ [, FDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..FDesc ) + "'"+ [, FArticulo = ] + "'" + this.FormatearTextoSql( &lcCursor..FArticulo ) + "'"+ [, FColor = ] + "'" + this.FormatearTextoSql( &lcCursor..FColor ) + "'"+ [, FTalle = ] + "'" + this.FormatearTextoSql( &lcCursor..FTalle ) + "'"+ [, FCant = ] + transform( &lcCursor..FCant )+ [, FStock = ] + transform( &lcCursor..FStock )+ [, FPrecio = ] + transform( &lcCursor..FPrecio )+ [, StockAnt = ] + transform( &lcCursor..StockAnt )+ [, Ejercicio = ] + transform( &lcCursor..Ejercicio )+ [, Base = ] + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'"+ [, Costeo = ] + "'" + this.FormatearTextoSql( &lcCursor..Costeo ) + "'"+ [, TIngreso = ] + "'" + this.FormatearTextoSql( &lcCursor..TIngreso ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, BDMODIFW, ESTTRANS, HALTAFW, HORAIMPO, HORAEXPO, VALTAFW, ZADSFW, VMODIFW, UMODIFW, UALTAFW, HMODIFW, SMODIFW, SALTAFW, BDALTAFW, TIMESTAMP, Codigo, CodComp, FNumInt, FactTipo, FLetra, FPtoVenEx, FNumComp, FPtoVen, FFecha, FDesc, FArticulo, FColor, FTalle, FCant, FStock, FPrecio, StockAnt, Ejercicio, Base, Costeo, TIngreso, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'" + ',' + transform( &lcCursor..FNumInt ) + ',' + transform( &lcCursor..FactTipo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLetra ) + "'" + ',' + transform( &lcCursor..FPtoVenEx ) + ',' + transform( &lcCursor..FNumComp ) + ',' + transform( &lcCursor..FPtoVen ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FDesc ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FArticulo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FColor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FTalle ) + "'" + ',' + transform( &lcCursor..FCant ) + ',' + transform( &lcCursor..FStock ) + ',' + transform( &lcCursor..FPrecio ) + ',' + transform( &lcCursor..StockAnt ) + ',' + transform( &lcCursor..Ejercicio ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Costeo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TIngreso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CMVFACCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECOSTOS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Identificador: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REGISTRODECOSTOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODECOSTOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODECOSTOS_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CMVFacCompra')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REGISTRODECOSTOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REGISTRODECOSTOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECOSTOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECOSTOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FFecha    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CMVFacCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CMVFacCompra
Create Table ZooLogic.TablaTrabajo_CMVFacCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"codigo" char( 20 )  null, 
"codcomp" char( 38 )  null, 
"fnumint" numeric( 10, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"fletra" char( 2 )  null, 
"fptovenex" numeric( 5, 0 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"ffecha" datetime  null, 
"fdesc" char( 200 )  null, 
"farticulo" char( 15 )  null, 
"fcolor" char( 6 )  null, 
"ftalle" char( 5 )  null, 
"fcant" numeric( 8, 2 )  null, 
"fstock" numeric( 8, 2 )  null, 
"fprecio" numeric( 15, 4 )  null, 
"stockant" numeric( 8, 2 )  null, 
"ejercicio" numeric( 8, 0 )  null, 
"base" char( 21 )  null, 
"costeo" char( 4 )  null, 
"tingreso" char( 1 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CMVFacCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CMVFacCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECOSTOS'
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
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('codcomp','codcomp')
			.AgregarMapeo('fnumint','fnumint')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fptovenex','fptovenex')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('ffecha','ffecha')
			.AgregarMapeo('fdesc','fdesc')
			.AgregarMapeo('farticulo','farticulo')
			.AgregarMapeo('fcolor','fcolor')
			.AgregarMapeo('ftalle','ftalle')
			.AgregarMapeo('fcant','fcant')
			.AgregarMapeo('fstock','fstock')
			.AgregarMapeo('fprecio','fprecio')
			.AgregarMapeo('stockant','stockant')
			.AgregarMapeo('ejercicio','ejercicio')
			.AgregarMapeo('base','base')
			.AgregarMapeo('costeo','costeo')
			.AgregarMapeo('tingreso','tingreso')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CMVFacCompra'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),t.FNUMINT = isnull( d.FNUMINT, t.FNUMINT ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FPTOVENEX = isnull( d.FPTOVENEX, t.FPTOVENEX ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FFECHA = isnull( d.FFECHA, t.FFECHA ),t.FDESC = isnull( d.FDESC, t.FDESC ),t.FARTICULO = isnull( d.FARTICULO, t.FARTICULO ),t.FCOLOR = isnull( d.FCOLOR, t.FCOLOR ),t.FTALLE = isnull( d.FTALLE, t.FTALLE ),t.FCANT = isnull( d.FCANT, t.FCANT ),t.FSTOCK = isnull( d.FSTOCK, t.FSTOCK ),t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),t.STOCKANT = isnull( d.STOCKANT, t.STOCKANT ),t.EJERCICIO = isnull( d.EJERCICIO, t.EJERCICIO ),t.BASE = isnull( d.BASE, t.BASE ),t.COSTEO = isnull( d.COSTEO, t.COSTEO ),t.TINGRESO = isnull( d.TINGRESO, t.TINGRESO ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.CMVFACCOMPRA t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.CMVFACCOMPRA(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bdmodifw,Esttrans,Haltafw,Horaimpo,Horaexpo,Valtafw,Zadsfw,Vmodifw,Umodifw,Ualtafw,Hmodifw,Smodifw,Saltafw,Bdaltafw,Timestamp,Codigo,Codcomp,Fnumint,Facttipo,Fletra,Fptovenex,Fnumcomp,Fptoven,Ffecha,Fdesc,Farticulo,Fcolor,Ftalle,Fcant,Fstock,Fprecio,Stockant,Ejercicio,Base,Costeo,Tingreso,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.BDALTAFW,''),isnull( d.TIMESTAMP,0),isnull( d.CODIGO,''),isnull( d.CODCOMP,''),isnull( d.FNUMINT,0),isnull( d.FACTTIPO,0),isnull( d.FLETRA,''),isnull( d.FPTOVENEX,0),isnull( d.FNUMCOMP,0),isnull( d.FPTOVEN,0),isnull( d.FFECHA,''),isnull( d.FDESC,''),isnull( d.FARTICULO,''),isnull( d.FCOLOR,''),isnull( d.FTALLE,''),isnull( d.FCANT,0),isnull( d.FSTOCK,0),isnull( d.FPRECIO,0),isnull( d.STOCKANT,0),isnull( d.EJERCICIO,0),isnull( d.BASE,''),isnull( d.COSTEO,''),isnull( d.TINGRESO,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.CMVFACCOMPRA pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CMVFacCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CMVFacCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REGISTRODECOSTOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECOSTOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECOSTOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECOSTOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECOSTOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECOSTOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Basededatosmodificacionfw = nvl( c_REGISTRODECOSTOS.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_REGISTRODECOSTOS.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_REGISTRODECOSTOS.Horaaltafw, [] )
					.Horaimpo = nvl( c_REGISTRODECOSTOS.Horaimpo, [] )
					.Horaexpo = nvl( c_REGISTRODECOSTOS.Horaexpo, [] )
					.Versionaltafw = nvl( c_REGISTRODECOSTOS.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_REGISTRODECOSTOS.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_REGISTRODECOSTOS.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_REGISTRODECOSTOS.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_REGISTRODECOSTOS.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_REGISTRODECOSTOS.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_REGISTRODECOSTOS.Seriealtafw, [] )
					.Basededatosaltafw = nvl( c_REGISTRODECOSTOS.Basededatosaltafw, [] )
					.Timestamp = nvl( c_REGISTRODECOSTOS.Timestamp, 0 )
					.Identificador = nvl( c_REGISTRODECOSTOS.Identificador, [] )
					.Codcomprobante = nvl( c_REGISTRODECOSTOS.Codcomprobante, [] )
					.Numerointerno = nvl( c_REGISTRODECOSTOS.Numerointerno, 0 )
					.Tipocomprobante = nvl( c_REGISTRODECOSTOS.Tipocomprobante, 0 )
					.Letra = nvl( c_REGISTRODECOSTOS.Letra, [] )
					.Puntodeventaextendido = nvl( c_REGISTRODECOSTOS.Puntodeventaextendido, 0 )
					.Numero = nvl( c_REGISTRODECOSTOS.Numero, 0 )
					.Puntodeventa = nvl( c_REGISTRODECOSTOS.Puntodeventa, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECOSTOS.Fecha, ctod( '  /  /    ' ) ) )
					.Descripcioncomp = nvl( c_REGISTRODECOSTOS.Descripcioncomp, [] )
					.Articulo_PK =  nvl( c_REGISTRODECOSTOS.Articulo, [] )
					.Color_PK =  nvl( c_REGISTRODECOSTOS.Color, [] )
					.Talle_PK =  nvl( c_REGISTRODECOSTOS.Talle, [] )
					.Cantidad = nvl( c_REGISTRODECOSTOS.Cantidad, 0 )
					.Stock = nvl( c_REGISTRODECOSTOS.Stock, 0 )
					.Precio = nvl( c_REGISTRODECOSTOS.Precio, 0 )
					.Stockanterior = nvl( c_REGISTRODECOSTOS.Stockanterior, 0 )
					.Ejercicio_PK =  nvl( c_REGISTRODECOSTOS.Ejercicio, 0 )
					.Basededatos = nvl( c_REGISTRODECOSTOS.Basededatos, [] )
					.Metodocosteo = nvl( c_REGISTRODECOSTOS.Metodocosteo, [] )
					.Tipoingreso = nvl( c_REGISTRODECOSTOS.Tipoingreso, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
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
		return c_REGISTRODECOSTOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CMVFACCOMPRA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from ZooLogic.CMVFACCOMPRA 
								Where   CMVFACCOMPRA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CMVFACCOMPRA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Codigo" as "Identificador", "Codcomp" as "Codcomprobante", "Fnumint" as "Numerointerno", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptovenex" as "Puntodeventaextendido", "Fnumcomp" as "Numero", "Fptoven" as "Puntodeventa", "Ffecha" as "Fecha", "Fdesc" as "Descripcioncomp", "Farticulo" as "Articulo", "Fcolor" as "Color", "Ftalle" as "Talle", "Fcant" as "Cantidad", "Fstock" as "Stock", "Fprecio" as "Precio", "Stockant" as "Stockanterior", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Costeo" as "Metodocosteo", "Tingreso" as "Tipoingreso", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CMVFACCOMPRA 
								Where   CMVFACCOMPRA.CODIGO != ''
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
	Tabla = 'CMVFACCOMPRA'
	Filtro = " CMVFACCOMPRA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CMVFACCOMPRA.CODIGO != ''"
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
	<row entidad="REGISTRODECOSTOS                        " atributo="FECHAIMPO                               " tabla="CMVFACCOMPRA   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="FECHATRANSFERENCIA                      " tabla="CMVFACCOMPRA   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="FECHAMODIFICACIONFW                     " tabla="CMVFACCOMPRA   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="FECHAEXPO                               " tabla="CMVFACCOMPRA   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="FECHAALTAFW                             " tabla="CMVFACCOMPRA   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CMVFACCOMPRA   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="ESTADOTRANSFERENCIA                     " tabla="CMVFACCOMPRA   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="HORAALTAFW                              " tabla="CMVFACCOMPRA   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="HORAIMPO                                " tabla="CMVFACCOMPRA   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="HORAEXPO                                " tabla="CMVFACCOMPRA   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="VERSIONALTAFW                           " tabla="CMVFACCOMPRA   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="ZADSFW                                  " tabla="CMVFACCOMPRA   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="VERSIONMODIFICACIONFW                   " tabla="CMVFACCOMPRA   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="USUARIOMODIFICACIONFW                   " tabla="CMVFACCOMPRA   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="USUARIOALTAFW                           " tabla="CMVFACCOMPRA   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="HORAMODIFICACIONFW                      " tabla="CMVFACCOMPRA   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="SERIEMODIFICACIONFW                     " tabla="CMVFACCOMPRA   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="SERIEALTAFW                             " tabla="CMVFACCOMPRA   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="BASEDEDATOSALTAFW                       " tabla="CMVFACCOMPRA   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="TIMESTAMP                               " tabla="CMVFACCOMPRA   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="IDENTIFICADOR                           " tabla="CMVFACCOMPRA   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Identificador                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="CODCOMPROBANTE                          " tabla="CMVFACCOMPRA   " campo="CODCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cod. comp.                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="NUMEROINTERNO                           " tabla="CMVFACCOMPRA   " campo="FNUMINT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="TIPOCOMPROBANTE                         " tabla="CMVFACCOMPRA   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=8                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="402" etiqueta="Comprobante                                                                                                                                                     " dominio="COMBOTIPOCOMPROBANTE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="LETRA                                   " tabla="CMVFACCOMPRA   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Letra comprobante                                                                                                                                               " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="PUNTODEVENTAEXTENDIDO                   " tabla="CMVFACCOMPRA   " campo="FPTOVENEX " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Punto extendido comprobante                                                                                                                                     " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="NUMERO                                  " tabla="CMVFACCOMPRA   " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número comprobante                                                                                                                                              " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="PUNTODEVENTA                            " tabla="CMVFACCOMPRA   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Punto de venta comprobante                                                                                                                                      " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="FECHA                                   " tabla="CMVFACCOMPRA   " campo="FFECHA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTEDECOMPRA      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="DESCRIPCIONCOMP                         " tabla="CMVFACCOMPRA   " campo="FDESC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descipción comprobante                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="ARTICULO                                " tabla="CMVFACCOMPRA   " campo="FARTICULO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="COLOR                                   " tabla="CMVFACCOMPRA   " campo="FCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="TALLE                                   " tabla="CMVFACCOMPRA   " campo="FTALLE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Talle                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="CANTIDAD                                " tabla="CMVFACCOMPRA   " campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Cantidad                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="STOCK                                   " tabla="CMVFACCOMPRA   " campo="FSTOCK    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="414" etiqueta="Saldo                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="PRECIO                                  " tabla="CMVFACCOMPRA   " campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="416" etiqueta="Precio                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="29" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="STOCKANTERIOR                           " tabla="CMVFACCOMPRA   " campo="STOCKANT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Stock anterior                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="31" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="EJERCICIO                               " tabla="CMVFACCOMPRA   " campo="EJERCICIO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="EJERCICIO                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="418" etiqueta="Ejercicio                                                                                                                                                       " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="33" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="BASEDEDATOS                             " tabla="CMVFACCOMPRA   " campo="BASE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="420" etiqueta="Base                                                                                                                                                            " dominio="COMBOSUCYAGRUCONVACIO         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="METODOCOSTEO                            " tabla="CMVFACCOMPRA   " campo="COSTEO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Método de costeo                                                                                                                                                " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="37" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="TIPOINGRESO                             " tabla="CMVFACCOMPRA   " campo="TINGRESO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de ingreso                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="39" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECOSTOS                        " atributo="OBS                                     " tabla="CMVFACCOMPRA   " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On CMVFACCOMPRA.FARTICULO = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On CMVFACCOMPRA.FCOLOR = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On CMVFACCOMPRA.FTALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EJERCICIO                               " atributo="DESCRIPCION                             " tabla="EJERCICIO      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Eje.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join EJERCICIO On CMVFACCOMPRA.EJERCICIO = EJERCICIO.NUMERO And  EJERCICIO.NUMERO != 0                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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