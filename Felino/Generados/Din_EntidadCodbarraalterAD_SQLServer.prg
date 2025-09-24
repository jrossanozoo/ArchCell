
define class Din_EntidadCODBARRAALTERAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CODBARRAALTER'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CABPK'
	cTablaPrincipal = 'CODBARALTER'
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
			local  lxCodbaralterFecexpo, lxCodbaralterFectrans, lxCodbaralterFecimpo, lxCodbaralterFaltafw, lxCodbaralterFmodifw, lxCodbaralterTimestamp, lxCodbaralterUaltafw, lxCodbaralterSaltafw, lxCodbaralterSmodifw, lxCodbaralterValtafw, lxCodbaralterZadsfw, lxCodbaralterHmodifw, lxCodbaralterVmodifw, lxCodbaralterUmodifw, lxCodbaralterHaltafw, lxCodbaralterBdaltafw, lxCodbaralterHoraimpo, lxCodbaralterEsttrans, lxCodbaralterBdmodifw, lxCodbaralterHoraexpo, lxCodbaralterCtrluni, lxCodbaralterCodigo, lxCodbaralterObs, lxCodbaralterCoddesc, lxCodbaralterHabilitado, lxCodbaralterUsasecuen
				lxCodbaralterFecexpo =  .Fechaexpo			lxCodbaralterFectrans =  .Fechatransferencia			lxCodbaralterFecimpo =  .Fechaimpo			lxCodbaralterFaltafw =  .Fechaaltafw			lxCodbaralterFmodifw =  .Fechamodificacionfw			lxCodbaralterTimestamp = goLibrerias.ObtenerTimestamp()			lxCodbaralterUaltafw =  .Usuarioaltafw			lxCodbaralterSaltafw =  .Seriealtafw			lxCodbaralterSmodifw =  .Seriemodificacionfw			lxCodbaralterValtafw =  .Versionaltafw			lxCodbaralterZadsfw =  .Zadsfw			lxCodbaralterHmodifw =  .Horamodificacionfw			lxCodbaralterVmodifw =  .Versionmodificacionfw			lxCodbaralterUmodifw =  .Usuariomodificacionfw			lxCodbaralterHaltafw =  .Horaaltafw			lxCodbaralterBdaltafw =  .Basededatosaltafw			lxCodbaralterHoraimpo =  .Horaimpo			lxCodbaralterEsttrans =  .Estadotransferencia			lxCodbaralterBdmodifw =  .Basededatosmodificacionfw			lxCodbaralterHoraexpo =  .Horaexpo			lxCodbaralterCtrluni =  .Controlaunicidad			lxCodbaralterCodigo =  .Codigo			lxCodbaralterObs =  .Obs			lxCodbaralterCoddesc =  .Descripcion			lxCodbaralterHabilitado =  .Habilitado			lxCodbaralterUsasecuen =  .Utilizasecuencial
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCodbaralterCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CODBARALTER ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Timestamp","Ualtafw","Saltafw","Smodifw","Valtafw","Zadsfw","Hmodifw","Vmodifw","Umodifw","Haltafw","Bdaltafw","Horaimpo","Esttrans","Bdmodifw","Horaexpo","Ctrluni","Codigo","Obs","Coddesc","Habilitado","Usasecuen" ) values ( <<"'" + this.ConvertirDateSql( lxCodbaralterFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFmodifw ) + "'" >>, <<lxCodbaralterTimestamp >>, <<"'" + this.FormatearTextoSql( lxCodbaralterUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHoraexpo ) + "'" >>, <<lxCodbaralterCtrluni >>, <<"'" + this.FormatearTextoSql( lxCodbaralterCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterCoddesc ) + "'" >>, <<iif( lxCodbaralterHabilitado, 1, 0 ) >>, <<iif( lxCodbaralterUsasecuen, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CodBarDetalle
				if this.oEntidad.CodBarDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNombre = loItem.Nombre
					lxAtributo = loItem.Atributo
					lxPosicioninicial = loItem.Posicioninicial
					lxCantidadcaracteres = loItem.Cantidadcaracteres
					lxCantidaddecimales = loItem.Cantidaddecimales
					lxValorbandera = loItem.Valorbandera
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CODBARALTERDET("NROITEM","Codigo","Nombre","Atributo","PosInicial","Cantidad","Decimales","Bandera" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxPosicioninicial>>, <<lxCantidadcaracteres>>, <<lxCantidaddecimales>>, <<"'" + this.FormatearTextoSql( lxValorbandera ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCodbaralterTimestamp
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
			local  lxCodbaralterFecexpo, lxCodbaralterFectrans, lxCodbaralterFecimpo, lxCodbaralterFaltafw, lxCodbaralterFmodifw, lxCodbaralterTimestamp, lxCodbaralterUaltafw, lxCodbaralterSaltafw, lxCodbaralterSmodifw, lxCodbaralterValtafw, lxCodbaralterZadsfw, lxCodbaralterHmodifw, lxCodbaralterVmodifw, lxCodbaralterUmodifw, lxCodbaralterHaltafw, lxCodbaralterBdaltafw, lxCodbaralterHoraimpo, lxCodbaralterEsttrans, lxCodbaralterBdmodifw, lxCodbaralterHoraexpo, lxCodbaralterCtrluni, lxCodbaralterCodigo, lxCodbaralterObs, lxCodbaralterCoddesc, lxCodbaralterHabilitado, lxCodbaralterUsasecuen
				lxCodbaralterFecexpo =  .Fechaexpo			lxCodbaralterFectrans =  .Fechatransferencia			lxCodbaralterFecimpo =  .Fechaimpo			lxCodbaralterFaltafw =  .Fechaaltafw			lxCodbaralterFmodifw =  .Fechamodificacionfw			lxCodbaralterTimestamp = goLibrerias.ObtenerTimestamp()			lxCodbaralterUaltafw =  .Usuarioaltafw			lxCodbaralterSaltafw =  .Seriealtafw			lxCodbaralterSmodifw =  .Seriemodificacionfw			lxCodbaralterValtafw =  .Versionaltafw			lxCodbaralterZadsfw =  .Zadsfw			lxCodbaralterHmodifw =  .Horamodificacionfw			lxCodbaralterVmodifw =  .Versionmodificacionfw			lxCodbaralterUmodifw =  .Usuariomodificacionfw			lxCodbaralterHaltafw =  .Horaaltafw			lxCodbaralterBdaltafw =  .Basededatosaltafw			lxCodbaralterHoraimpo =  .Horaimpo			lxCodbaralterEsttrans =  .Estadotransferencia			lxCodbaralterBdmodifw =  .Basededatosmodificacionfw			lxCodbaralterHoraexpo =  .Horaexpo			lxCodbaralterCtrluni =  .Controlaunicidad			lxCodbaralterCodigo =  .Codigo			lxCodbaralterObs =  .Obs			lxCodbaralterCoddesc =  .Descripcion			lxCodbaralterHabilitado =  .Habilitado			lxCodbaralterUsasecuen =  .Utilizasecuencial
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
				update ZooLogic.CODBARALTER set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCodbaralterFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCodbaralterFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCodbaralterFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCodbaralterFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCodbaralterFmodifw ) + "'">>,"Timestamp" = <<lxCodbaralterTimestamp>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterSmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCodbaralterZadsfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterBdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCodbaralterHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCodbaralterEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCodbaralterHoraexpo ) + "'">>,"Ctrluni" = <<lxCodbaralterCtrluni>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCodbaralterCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCodbaralterObs ) + "'">>,"Coddesc" = <<"'" + this.FormatearTextoSql( lxCodbaralterCoddesc ) + "'">>,"Habilitado" = <<iif( lxCodbaralterHabilitado, 1, 0 )>>,"Usasecuen" = <<iif( lxCodbaralterUsasecuen, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCodbaralterCodigo ) + "'">> and  CODBARALTER.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CODBARALTERDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CodBarDetalle
				if this.oEntidad.CodBarDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNombre = loItem.Nombre
					lxAtributo = loItem.Atributo
					lxPosicioninicial = loItem.Posicioninicial
					lxCantidadcaracteres = loItem.Cantidadcaracteres
					lxCantidaddecimales = loItem.Cantidaddecimales
					lxValorbandera = loItem.Valorbandera
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CODBARALTERDET("NROITEM","Codigo","Nombre","Atributo","PosInicial","Cantidad","Decimales","Bandera" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxPosicioninicial>>, <<lxCantidadcaracteres>>, <<lxCantidaddecimales>>, <<"'" + this.FormatearTextoSql( lxValorbandera ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCodbaralterTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CODBARALTER where " + this.ConvertirFuncionesSql( " CODBARALTER.CODIGO != ''" ) )
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
			Local lxCodbaralterCodigo
			lxCodbaralterCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Ctrluni" as "Controlaunicidad", "Codigo" as "Codigo", "Obs" as "Obs", "Coddesc" as "Descripcion", "Habilitado" as "Habilitado", "Usasecuen" as "Utilizasecuencial" from ZooLogic.CODBARALTER where "Codigo" = <<"'" + this.FormatearTextoSql( lxCodbaralterCodigo ) + "'">> and  CODBARALTER.CODIGO != ''
			endtext
			use in select('c_CODBARRAALTER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODBARRAALTER', set( 'Datasession' ) )

			if reccount( 'c_CODBARRAALTER' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Nombre" as "Nombre", "Atributo" as "Atributo", "Posinicial" as "Posicioninicial", "Cantidad" as "Cantidadcaracteres", "Decimales" as "Cantidaddecimales", "Bandera" as "Valorbandera" from ZooLogic.CODBARALTERDET where Codigo = <<"'" + this.FormatearTextoSql( c_CODBARRAALTER.CODIGO ) + "'">> Order by PosicionInicial
			endtext
			use in select('c_CodBarDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CodBarDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CodBarDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCodbaralterCodigo as Variant
		llRetorno = .t.
		lxCodbaralterCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CODBARALTER where "Codigo" = <<"'" + this.FormatearTextoSql( lxCodbaralterCodigo ) + "'">> and  CODBARALTER.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Ctrluni" as "Controlaunicidad", "Codigo" as "Codigo", "Obs" as "Obs", "Coddesc" as "Descripcion", "Habilitado" as "Habilitado", "Usasecuen" as "Utilizasecuencial" from ZooLogic.CODBARALTER where  CODBARALTER.CODIGO != '' order by Codigo
			endtext
			use in select('c_CODBARRAALTER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODBARRAALTER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Nombre" as "Nombre", "Atributo" as "Atributo", "Posinicial" as "Posicioninicial", "Cantidad" as "Cantidadcaracteres", "Decimales" as "Cantidaddecimales", "Bandera" as "Valorbandera" from ZooLogic.CODBARALTERDET where Codigo = <<"'" + this.FormatearTextoSql( c_CODBARRAALTER.CODIGO ) + "'">> Order by PosicionInicial
			endtext
			use in select('c_CodBarDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CodBarDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CodBarDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Ctrluni" as "Controlaunicidad", "Codigo" as "Codigo", "Obs" as "Obs", "Coddesc" as "Descripcion", "Habilitado" as "Habilitado", "Usasecuen" as "Utilizasecuencial" from ZooLogic.CODBARALTER where  funciones.padr( Codigo, 3, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CODBARALTER.CODIGO != '' order by Codigo
			endtext
			use in select('c_CODBARRAALTER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODBARRAALTER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Nombre" as "Nombre", "Atributo" as "Atributo", "Posinicial" as "Posicioninicial", "Cantidad" as "Cantidadcaracteres", "Decimales" as "Cantidaddecimales", "Bandera" as "Valorbandera" from ZooLogic.CODBARALTERDET where Codigo = <<"'" + this.FormatearTextoSql( c_CODBARRAALTER.CODIGO ) + "'">> Order by PosicionInicial
			endtext
			use in select('c_CodBarDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CodBarDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CodBarDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Ctrluni" as "Controlaunicidad", "Codigo" as "Codigo", "Obs" as "Obs", "Coddesc" as "Descripcion", "Habilitado" as "Habilitado", "Usasecuen" as "Utilizasecuencial" from ZooLogic.CODBARALTER where  funciones.padr( Codigo, 3, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CODBARALTER.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_CODBARRAALTER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODBARRAALTER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Nombre" as "Nombre", "Atributo" as "Atributo", "Posinicial" as "Posicioninicial", "Cantidad" as "Cantidadcaracteres", "Decimales" as "Cantidaddecimales", "Bandera" as "Valorbandera" from ZooLogic.CODBARALTERDET where Codigo = <<"'" + this.FormatearTextoSql( c_CODBARRAALTER.CODIGO ) + "'">> Order by PosicionInicial
			endtext
			use in select('c_CodBarDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CodBarDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CodBarDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Ctrluni" as "Controlaunicidad", "Codigo" as "Codigo", "Obs" as "Obs", "Coddesc" as "Descripcion", "Habilitado" as "Habilitado", "Usasecuen" as "Utilizasecuencial" from ZooLogic.CODBARALTER where  CODBARALTER.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_CODBARRAALTER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODBARRAALTER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Nombre" as "Nombre", "Atributo" as "Atributo", "Posinicial" as "Posicioninicial", "Cantidad" as "Cantidadcaracteres", "Decimales" as "Cantidaddecimales", "Bandera" as "Valorbandera" from ZooLogic.CODBARALTERDET where Codigo = <<"'" + this.FormatearTextoSql( c_CODBARRAALTER.CODIGO ) + "'">> Order by PosicionInicial
			endtext
			use in select('c_CodBarDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CodBarDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CodBarDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Timestamp,Ualtafw,Saltafw,Smodifw,Valtafw,Zadsfw,Hm" + ;
"odifw,Vmodifw,Umodifw,Haltafw,Bdaltafw,Horaimpo,Esttrans,Bdmodifw,Horaexpo,Ctrluni,Codigo,Obs,Coddes" + ;
"c,Habilitado,Usasecuen" + ;
" from ZooLogic.CODBARALTER where  CODBARALTER.CODIGO != '' and " + lcFiltro )
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
			local  lxCodbaralterFecexpo, lxCodbaralterFectrans, lxCodbaralterFecimpo, lxCodbaralterFaltafw, lxCodbaralterFmodifw, lxCodbaralterTimestamp, lxCodbaralterUaltafw, lxCodbaralterSaltafw, lxCodbaralterSmodifw, lxCodbaralterValtafw, lxCodbaralterZadsfw, lxCodbaralterHmodifw, lxCodbaralterVmodifw, lxCodbaralterUmodifw, lxCodbaralterHaltafw, lxCodbaralterBdaltafw, lxCodbaralterHoraimpo, lxCodbaralterEsttrans, lxCodbaralterBdmodifw, lxCodbaralterHoraexpo, lxCodbaralterCtrluni, lxCodbaralterCodigo, lxCodbaralterObs, lxCodbaralterCoddesc, lxCodbaralterHabilitado, lxCodbaralterUsasecuen
				lxCodbaralterFecexpo = ctod( '  /  /    ' )			lxCodbaralterFectrans = ctod( '  /  /    ' )			lxCodbaralterFecimpo = ctod( '  /  /    ' )			lxCodbaralterFaltafw = ctod( '  /  /    ' )			lxCodbaralterFmodifw = ctod( '  /  /    ' )			lxCodbaralterTimestamp = goLibrerias.ObtenerTimestamp()			lxCodbaralterUaltafw = []			lxCodbaralterSaltafw = []			lxCodbaralterSmodifw = []			lxCodbaralterValtafw = []			lxCodbaralterZadsfw = []			lxCodbaralterHmodifw = []			lxCodbaralterVmodifw = []			lxCodbaralterUmodifw = []			lxCodbaralterHaltafw = []			lxCodbaralterBdaltafw = []			lxCodbaralterHoraimpo = []			lxCodbaralterEsttrans = []			lxCodbaralterBdmodifw = []			lxCodbaralterHoraexpo = []			lxCodbaralterCtrluni = 0			lxCodbaralterCodigo = []			lxCodbaralterObs = []			lxCodbaralterCoddesc = []			lxCodbaralterHabilitado = .F.			lxCodbaralterUsasecuen = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CODBARALTERDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CODBARALTER where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CODBARALTER' + '_' + tcCampo
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
		lcWhere = " Where  CODBARALTER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Ctrluni" as "Controlaunicidad", "Codigo" as "Codigo", "Obs" as "Obs", "Coddesc" as "Descripcion", "Habilitado" as "Habilitado", "Usasecuen" as "Utilizasecuencial"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CODBARALTER', '', tnTope )
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
	Function ObtenerDatosDetalleCodBarDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CODBARALTERDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Nombre" as "Nombre", "Atributo" as "Atributo", "Posinicial" as "Posicioninicial", "Cantidad" as "Cantidadcaracteres", "Decimales" as "Cantidaddecimales", "Bandera" as "Valorbandera"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCodBarDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CODBARALTERDET', 'CodBarDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCodBarDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCodBarDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'CONTROLAUNICIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTRLUNI AS CONTROLAUNICIDAD'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODDESC AS DESCRIPCION'
				Case lcAtributo == 'HABILITADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HABILITADO AS HABILITADO'
				Case lcAtributo == 'UTILIZASECUENCIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USASECUEN AS UTILIZASECUENCIAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCodBarDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMBRE AS NOMBRE'
				Case lcAtributo == 'ATRIBUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATRIBUTO AS ATRIBUTO'
				Case lcAtributo == 'POSICIONINICIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'POSINICIAL AS POSICIONINICIAL'
				Case lcAtributo == 'CANTIDADCARACTERES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDADCARACTERES'
				Case lcAtributo == 'CANTIDADDECIMALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DECIMALES AS CANTIDADDECIMALES'
				Case lcAtributo == 'VALORBANDERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BANDERA AS VALORBANDERA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CONTROLAUNICIDAD'
				lcCampo = 'CTRLUNI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CODDESC'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITADO'
				lcCampo = 'HABILITADO'
			Case upper( alltrim( tcAtributo ) ) == 'UTILIZASECUENCIAL'
				lcCampo = 'USASECUEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCodBarDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTO'
				lcCampo = 'ATRIBUTO'
			Case upper( alltrim( tcAtributo ) ) == 'POSICIONINICIAL'
				lcCampo = 'POSINICIAL'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADCARACTERES'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADDECIMALES'
				lcCampo = 'DECIMALES'
			Case upper( alltrim( tcAtributo ) ) == 'VALORBANDERA'
				lcCampo = 'BANDERA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CODBARDETALLE'
			lcRetorno = 'CODBARALTERDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCodbaralterFecexpo, lxCodbaralterFectrans, lxCodbaralterFecimpo, lxCodbaralterFaltafw, lxCodbaralterFmodifw, lxCodbaralterTimestamp, lxCodbaralterUaltafw, lxCodbaralterSaltafw, lxCodbaralterSmodifw, lxCodbaralterValtafw, lxCodbaralterZadsfw, lxCodbaralterHmodifw, lxCodbaralterVmodifw, lxCodbaralterUmodifw, lxCodbaralterHaltafw, lxCodbaralterBdaltafw, lxCodbaralterHoraimpo, lxCodbaralterEsttrans, lxCodbaralterBdmodifw, lxCodbaralterHoraexpo, lxCodbaralterCtrluni, lxCodbaralterCodigo, lxCodbaralterObs, lxCodbaralterCoddesc, lxCodbaralterHabilitado, lxCodbaralterUsasecuen
				lxCodbaralterFecexpo =  .Fechaexpo			lxCodbaralterFectrans =  .Fechatransferencia			lxCodbaralterFecimpo =  .Fechaimpo			lxCodbaralterFaltafw =  .Fechaaltafw			lxCodbaralterFmodifw =  .Fechamodificacionfw			lxCodbaralterTimestamp = goLibrerias.ObtenerTimestamp()			lxCodbaralterUaltafw =  .Usuarioaltafw			lxCodbaralterSaltafw =  .Seriealtafw			lxCodbaralterSmodifw =  .Seriemodificacionfw			lxCodbaralterValtafw =  .Versionaltafw			lxCodbaralterZadsfw =  .Zadsfw			lxCodbaralterHmodifw =  .Horamodificacionfw			lxCodbaralterVmodifw =  .Versionmodificacionfw			lxCodbaralterUmodifw =  .Usuariomodificacionfw			lxCodbaralterHaltafw =  .Horaaltafw			lxCodbaralterBdaltafw =  .Basededatosaltafw			lxCodbaralterHoraimpo =  .Horaimpo			lxCodbaralterEsttrans =  .Estadotransferencia			lxCodbaralterBdmodifw =  .Basededatosmodificacionfw			lxCodbaralterHoraexpo =  .Horaexpo			lxCodbaralterCtrluni =  .Controlaunicidad			lxCodbaralterCodigo =  .Codigo			lxCodbaralterObs =  .Obs			lxCodbaralterCoddesc =  .Descripcion			lxCodbaralterHabilitado =  .Habilitado			lxCodbaralterUsasecuen =  .Utilizasecuencial
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CODBARALTER ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Timestamp","Ualtafw","Saltafw","Smodifw","Valtafw","Zadsfw","Hmodifw","Vmodifw","Umodifw","Haltafw","Bdaltafw","Horaimpo","Esttrans","Bdmodifw","Horaexpo","Ctrluni","Codigo","Obs","Coddesc","Habilitado","Usasecuen" ) values ( <<"'" + this.ConvertirDateSql( lxCodbaralterFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodbaralterFmodifw ) + "'" >>, <<lxCodbaralterTimestamp >>, <<"'" + this.FormatearTextoSql( lxCodbaralterUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterHoraexpo ) + "'" >>, <<lxCodbaralterCtrluni >>, <<"'" + this.FormatearTextoSql( lxCodbaralterCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodbaralterCoddesc ) + "'" >>, <<iif( lxCodbaralterHabilitado, 1, 0 ) >>, <<iif( lxCodbaralterUsasecuen, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'CODBARALTER' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CodBarDetalle
				if this.oEntidad.CodBarDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNombre = loItem.Nombre
					lxAtributo = loItem.Atributo
					lxPosicioninicial = loItem.Posicioninicial
					lxCantidadcaracteres = loItem.Cantidadcaracteres
					lxCantidaddecimales = loItem.Cantidaddecimales
					lxValorbandera = loItem.Valorbandera
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CODBARALTERDET("NROITEM","Codigo","Nombre","Atributo","PosInicial","Cantidad","Decimales","Bandera" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxPosicioninicial>>, <<lxCantidadcaracteres>>, <<lxCantidaddecimales>>, <<"'" + this.FormatearTextoSql( lxValorbandera ) + "'">> ) 
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
			local  lxCodbaralterFecexpo, lxCodbaralterFectrans, lxCodbaralterFecimpo, lxCodbaralterFaltafw, lxCodbaralterFmodifw, lxCodbaralterTimestamp, lxCodbaralterUaltafw, lxCodbaralterSaltafw, lxCodbaralterSmodifw, lxCodbaralterValtafw, lxCodbaralterZadsfw, lxCodbaralterHmodifw, lxCodbaralterVmodifw, lxCodbaralterUmodifw, lxCodbaralterHaltafw, lxCodbaralterBdaltafw, lxCodbaralterHoraimpo, lxCodbaralterEsttrans, lxCodbaralterBdmodifw, lxCodbaralterHoraexpo, lxCodbaralterCtrluni, lxCodbaralterCodigo, lxCodbaralterObs, lxCodbaralterCoddesc, lxCodbaralterHabilitado, lxCodbaralterUsasecuen
				lxCodbaralterFecexpo =  .Fechaexpo			lxCodbaralterFectrans =  .Fechatransferencia			lxCodbaralterFecimpo =  .Fechaimpo			lxCodbaralterFaltafw =  .Fechaaltafw			lxCodbaralterFmodifw =  .Fechamodificacionfw			lxCodbaralterTimestamp = goLibrerias.ObtenerTimestamp()			lxCodbaralterUaltafw =  .Usuarioaltafw			lxCodbaralterSaltafw =  .Seriealtafw			lxCodbaralterSmodifw =  .Seriemodificacionfw			lxCodbaralterValtafw =  .Versionaltafw			lxCodbaralterZadsfw =  .Zadsfw			lxCodbaralterHmodifw =  .Horamodificacionfw			lxCodbaralterVmodifw =  .Versionmodificacionfw			lxCodbaralterUmodifw =  .Usuariomodificacionfw			lxCodbaralterHaltafw =  .Horaaltafw			lxCodbaralterBdaltafw =  .Basededatosaltafw			lxCodbaralterHoraimpo =  .Horaimpo			lxCodbaralterEsttrans =  .Estadotransferencia			lxCodbaralterBdmodifw =  .Basededatosmodificacionfw			lxCodbaralterHoraexpo =  .Horaexpo			lxCodbaralterCtrluni =  .Controlaunicidad			lxCodbaralterCodigo =  .Codigo			lxCodbaralterObs =  .Obs			lxCodbaralterCoddesc =  .Descripcion			lxCodbaralterHabilitado =  .Habilitado			lxCodbaralterUsasecuen =  .Utilizasecuencial
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CODBARALTER.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CODBARALTER set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCodbaralterFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCodbaralterFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCodbaralterFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCodbaralterFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCodbaralterFmodifw ) + "'">>, "Timestamp" = <<lxCodbaralterTimestamp>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterSmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCodbaralterZadsfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCodbaralterBdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCodbaralterHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCodbaralterEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCodbaralterBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCodbaralterHoraexpo ) + "'">>, "Ctrluni" = <<lxCodbaralterCtrluni>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCodbaralterCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCodbaralterObs ) + "'">>, "Coddesc" = <<"'" + this.FormatearTextoSql( lxCodbaralterCoddesc ) + "'">>, "Habilitado" = <<iif( lxCodbaralterHabilitado, 1, 0 )>>, "Usasecuen" = <<iif( lxCodbaralterUsasecuen, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CODBARALTER' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CODBARALTERDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CodBarDetalle
				if this.oEntidad.CodBarDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNombre = loItem.Nombre
					lxAtributo = loItem.Atributo
					lxPosicioninicial = loItem.Posicioninicial
					lxCantidadcaracteres = loItem.Cantidadcaracteres
					lxCantidaddecimales = loItem.Cantidaddecimales
					lxValorbandera = loItem.Valorbandera
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CODBARALTERDET("NROITEM","Codigo","Nombre","Atributo","PosInicial","Cantidad","Decimales","Bandera" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxPosicioninicial>>, <<lxCantidadcaracteres>>, <<lxCantidaddecimales>>, <<"'" + this.FormatearTextoSql( lxValorbandera ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CODBARALTER.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CODBARALTER where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CODBARALTERDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CODBARALTER' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CODBARALTER where  CODBARALTER.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CODBARALTER where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CODBARALTER.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CODBARRAALTER'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CODBARALTER Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CODBARALTER set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, CtrlUni = ] + transform( &lcCursor..CtrlUni )+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, CodDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..CodDesc ) + "'"+ [, Habilitado = ] + Transform( iif( &lcCursor..Habilitado, 1, 0 ))+ [, UsaSecuen = ] + Transform( iif( &lcCursor..UsaSecuen, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, TIMESTAMP, UALTAFW, SALTAFW, SMODIFW, VALTAFW, ZADSFW, HMODIFW, VMODIFW, UMODIFW, HALTAFW, BDALTAFW, HORAIMPO, ESTTRANS, BDMODIFW, HORAEXPO, CtrlUni, Codigo, Obs, CodDesc, Habilitado, UsaSecuen
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + transform( &lcCursor..CtrlUni )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodDesc ) + "'" + ',' + Transform( iif( &lcCursor..Habilitado, 1, 0 )) + ',' + Transform( iif( &lcCursor..UsaSecuen, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CODBARALTER ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CODBARRAALTER'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CODBARALTERDET Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCODBARRAALTER'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Nombre","Atributo","PosInicial","Cantidad","Decimales","Bandera"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CODBARALTERDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Nombre     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Atributo   ) + "'" + ',' + transform( cDetallesExistentes.PosInicial ) + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + transform( cDetallesExistentes.Decimales  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Bandera    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (3) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CODBARRAALTER'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CODBARRAALTER_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CODBARRAALTER_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCODBARRAALTER'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CODBARALTER')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CODBARRAALTER'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CODBARRAALTER. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CODBARRAALTER'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CODBARRAALTER'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CODBARALTER') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CODBARALTER
Create Table ZooLogic.TablaTrabajo_CODBARALTER ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"ctrluni" numeric( 1, 0 )  null, 
"codigo" char( 3 )  null, 
"obs" varchar(max)  null, 
"coddesc" char( 50 )  null, 
"habilitado" bit  null, 
"usasecuen" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CODBARALTER' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CODBARALTER' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CODBARRAALTER'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ctrluni','ctrluni')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('coddesc','coddesc')
			.AgregarMapeo('habilitado','habilitado')
			.AgregarMapeo('usasecuen','usasecuen')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CODBARALTER'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.CTRLUNI = isnull( d.CTRLUNI, t.CTRLUNI ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.CODDESC = isnull( d.CODDESC, t.CODDESC ),t.HABILITADO = isnull( d.HABILITADO, t.HABILITADO ),t.USASECUEN = isnull( d.USASECUEN, t.USASECUEN )
					from ZooLogic.CODBARALTER t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.CODBARALTER(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Timestamp,Ualtafw,Saltafw,Smodifw,Valtafw,Zadsfw,Hmodifw,Vmodifw,Umodifw,Haltafw,Bdaltafw,Horaimpo,Esttrans,Bdmodifw,Horaexpo,Ctrluni,Codigo,Obs,Coddesc,Habilitado,Usasecuen)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.CTRLUNI,0),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.CODDESC,''),isnull( d.HABILITADO,0),isnull( d.USASECUEN,0)
						From deleted d left join ZooLogic.CODBARALTER pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CODBARALTERDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CODBARALTER_CODBARALTERDET
ON ZooLogic.TablaTrabajo_CODBARALTER_CODBARALTERDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NOMBRE = isnull( d.NOMBRE, t.NOMBRE ),
t.ATRIBUTO = isnull( d.ATRIBUTO, t.ATRIBUTO ),
t.POSINICIAL = isnull( d.POSINICIAL, t.POSINICIAL ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.DECIMALES = isnull( d.DECIMALES, t.DECIMALES ),
t.BANDERA = isnull( d.BANDERA, t.BANDERA )
from ZooLogic.CODBARALTERDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CODBARALTERDET
( 
"NROITEM",
"CODIGO",
"NOMBRE",
"ATRIBUTO",
"POSINICIAL",
"CANTIDAD",
"DECIMALES",
"BANDERA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.NOMBRE,
d.ATRIBUTO,
d.POSINICIAL,
d.CANTIDAD,
d.DECIMALES,
d.BANDERA
From deleted d left join ZooLogic.CODBARALTERDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CODBARALTER') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CODBARALTER
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CODBARRAALTER' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODBARRAALTER.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODBARRAALTER.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODBARRAALTER.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODBARRAALTER.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODBARRAALTER.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_CODBARRAALTER.Timestamp, 0 )
					.Usuarioaltafw = nvl( c_CODBARRAALTER.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_CODBARRAALTER.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_CODBARRAALTER.Seriemodificacionfw, [] )
					.Versionaltafw = nvl( c_CODBARRAALTER.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horamodificacionfw = nvl( c_CODBARRAALTER.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CODBARRAALTER.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CODBARRAALTER.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_CODBARRAALTER.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_CODBARRAALTER.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_CODBARRAALTER.Horaimpo, [] )
					.Estadotransferencia = nvl( c_CODBARRAALTER.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_CODBARRAALTER.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_CODBARRAALTER.Horaexpo, [] )
					.Codbardetalle.Limpiar()
					.Codbardetalle.SetearEsNavegacion( .lProcesando )
					.Codbardetalle.Cargar()
					.Controlaunicidad = nvl( c_CODBARRAALTER.Controlaunicidad, 0 )
					.Codigo = nvl( c_CODBARRAALTER.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Descripcion = nvl( c_CODBARRAALTER.Descripcion, [] )
					.Habilitado = nvl( c_CODBARRAALTER.Habilitado, .F. )
					.Utilizasecuencial = nvl( c_CODBARRAALTER.Utilizasecuencial, .F. )
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
		
		loDetalle = this.oEntidad.CodBarDetalle
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
		return c_CODBARRAALTER.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CODBARALTER' )
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
								from ZooLogic.CODBARALTER 
								Where   CODBARALTER.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CODBARALTER", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Ctrluni" as "Controlaunicidad", "Codigo" as "Codigo", "Obs" as "Obs", "Coddesc" as "Descripcion", "Habilitado" as "Habilitado", "Usasecuen" as "Utilizasecuencial"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CODBARALTER 
								Where   CODBARALTER.CODIGO != ''
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
	Tabla = 'CODBARALTER'
	Filtro = " CODBARALTER.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CODBARALTER.CODIGO != ''"
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
	<row entidad="CODBARRAALTER                           " atributo="FECHAEXPO                               " tabla="CODBARALTER    " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="FECHATRANSFERENCIA                      " tabla="CODBARALTER    " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="FECHAIMPO                               " tabla="CODBARALTER    " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="FECHAALTAFW                             " tabla="CODBARALTER    " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="FECHAMODIFICACIONFW                     " tabla="CODBARALTER    " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="TIMESTAMP                               " tabla="CODBARALTER    " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="USUARIOALTAFW                           " tabla="CODBARALTER    " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="SERIEALTAFW                             " tabla="CODBARALTER    " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="SERIEMODIFICACIONFW                     " tabla="CODBARALTER    " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="VERSIONALTAFW                           " tabla="CODBARALTER    " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="ZADSFW                                  " tabla="CODBARALTER    " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="HORAMODIFICACIONFW                      " tabla="CODBARALTER    " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="VERSIONMODIFICACIONFW                   " tabla="CODBARALTER    " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="USUARIOMODIFICACIONFW                   " tabla="CODBARALTER    " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="HORAALTAFW                              " tabla="CODBARALTER    " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="BASEDEDATOSALTAFW                       " tabla="CODBARALTER    " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="HORAIMPO                                " tabla="CODBARALTER    " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="ESTADOTRANSFERENCIA                     " tabla="CODBARALTER    " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CODBARALTER    " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="HORAEXPO                                " tabla="CODBARALTER    " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="CODBARDETALLE                           " tabla="CODBARALTERDET " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Detalle                                                                                                                                                         " dominio="DETALLEITEMCODBARRAALTER      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="CONTROLAUNICIDAD                        " tabla="CODBARALTER    " campo="CTRLUNI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Controla la unicidad en la lectura                                                                                                                              " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="CODIGO                                  " tabla="CODBARALTER    " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="OBS                                     " tabla="CODBARALTER    " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="DESCRIPCION                             " tabla="CODBARALTER    " campo="CODDESC   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="HABILITADO                              " tabla="CODBARALTER    " campo="HABILITADO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="203" etiqueta="Habilitado                                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODBARRAALTER                           " atributo="UTILIZASECUENCIAL                       " tabla="CODBARALTER    " campo="USASECUEN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Utiliza número secuencial                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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