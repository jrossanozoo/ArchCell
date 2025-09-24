
define class Din_EntidadMONEDAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MONEDA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_025PK'
	cTablaPrincipal = 'MONEDA'
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
			local  lxMonedaFecimpo, lxMonedaFectrans, lxMonedaFmodifw, lxMonedaFecexpo, lxMonedaFaltafw, lxMonedaTimestamp, lxMonedaHoraexpo, lxMonedaHaltafw, lxMonedaHoraimpo, lxMonedaSaltafw, lxMonedaSmodifw, lxMonedaUaltafw, lxMonedaHmodifw, lxMonedaVmodifw, lxMonedaBdaltafw, lxMonedaBdmodifw, lxMonedaZadsfw, lxMonedaEsttrans, lxMonedaUmodifw, lxMonedaValtafw, lxMonedaCodigo, lxMonedaMobs, lxMonedaDescrip, lxMonedaSimbolo, lxMonedaEafip, lxMonedaEdgi, lxMonedaTolpos, lxMonedaMcotafip, lxMonedaCoblig, lxMonedaTolneg
				lxMonedaFecimpo =  .Fechaimpo			lxMonedaFectrans =  .Fechatransferencia			lxMonedaFmodifw =  .Fechamodificacionfw			lxMonedaFecexpo =  .Fechaexpo			lxMonedaFaltafw =  .Fechaaltafw			lxMonedaTimestamp = goLibrerias.ObtenerTimestamp()			lxMonedaHoraexpo =  .Horaexpo			lxMonedaHaltafw =  .Horaaltafw			lxMonedaHoraimpo =  .Horaimpo			lxMonedaSaltafw =  .Seriealtafw			lxMonedaSmodifw =  .Seriemodificacionfw			lxMonedaUaltafw =  .Usuarioaltafw			lxMonedaHmodifw =  .Horamodificacionfw			lxMonedaVmodifw =  .Versionmodificacionfw			lxMonedaBdaltafw =  .Basededatosaltafw			lxMonedaBdmodifw =  .Basededatosmodificacionfw			lxMonedaZadsfw =  .Zadsfw			lxMonedaEsttrans =  .Estadotransferencia			lxMonedaUmodifw =  .Usuariomodificacionfw			lxMonedaValtafw =  .Versionaltafw			lxMonedaCodigo =  .Codigo			lxMonedaMobs =  .Observacion			lxMonedaDescrip =  .Descripcion			lxMonedaSimbolo =  .Simbolo			lxMonedaEafip =  upper( .EquivalenciaAfip_PK ) 			lxMonedaEdgi =  .Equivalenciadgi			lxMonedaTolpos =  .Toleranciapositiva			lxMonedaMcotafip =  upper( .MonedaCotizacionAFIP_PK ) 			lxMonedaCoblig =  .Cargaobligatoria			lxMonedaTolneg =  .Tolerancianegativa
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMonedaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MONEDA ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Timestamp","Horaexpo","Haltafw","Horaimpo","Saltafw","Smodifw","Ualtafw","Hmodifw","Vmodifw","Bdaltafw","Bdmodifw","Zadsfw","Esttrans","Umodifw","Valtafw","Codigo","Mobs","Descrip","Simbolo","Eafip","Edgi","Tolpos","Mcotafip","Coblig","Tolneg" ) values ( <<"'" + this.ConvertirDateSql( lxMonedaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFaltafw ) + "'" >>, <<lxMonedaTimestamp >>, <<"'" + this.FormatearTextoSql( lxMonedaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaSimbolo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaEafip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaEdgi ) + "'" >>, <<lxMonedaTolpos >>, <<"'" + this.FormatearTextoSql( lxMonedaMcotafip ) + "'" >>, <<iif( lxMonedaCoblig, 1, 0 ) >>, <<lxMonedaTolneg >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Cotizaciones
				if this.oEntidad.Cotizaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxCotizacion = loItem.Cotizacion
					lxHora = loItem.Hora
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTIZA("NROITEM","Codigo","Fecha","Cotiz","Hora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCotizacion>>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Denominaciones
				if this.oEntidad.Denominaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor = loItem.Valor
					lxTipo = loItem.Tipo
					lxDescri = loItem.Descri
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DENOMINA("NROITEM","Codigo","Valor","Tipo","Descri","Orden" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<lxOrden>> ) 
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
		this.oEntidad.Timestamp = lxMonedaTimestamp
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
			local  lxMonedaFecimpo, lxMonedaFectrans, lxMonedaFmodifw, lxMonedaFecexpo, lxMonedaFaltafw, lxMonedaTimestamp, lxMonedaHoraexpo, lxMonedaHaltafw, lxMonedaHoraimpo, lxMonedaSaltafw, lxMonedaSmodifw, lxMonedaUaltafw, lxMonedaHmodifw, lxMonedaVmodifw, lxMonedaBdaltafw, lxMonedaBdmodifw, lxMonedaZadsfw, lxMonedaEsttrans, lxMonedaUmodifw, lxMonedaValtafw, lxMonedaCodigo, lxMonedaMobs, lxMonedaDescrip, lxMonedaSimbolo, lxMonedaEafip, lxMonedaEdgi, lxMonedaTolpos, lxMonedaMcotafip, lxMonedaCoblig, lxMonedaTolneg
				lxMonedaFecimpo =  .Fechaimpo			lxMonedaFectrans =  .Fechatransferencia			lxMonedaFmodifw =  .Fechamodificacionfw			lxMonedaFecexpo =  .Fechaexpo			lxMonedaFaltafw =  .Fechaaltafw			lxMonedaTimestamp = goLibrerias.ObtenerTimestamp()			lxMonedaHoraexpo =  .Horaexpo			lxMonedaHaltafw =  .Horaaltafw			lxMonedaHoraimpo =  .Horaimpo			lxMonedaSaltafw =  .Seriealtafw			lxMonedaSmodifw =  .Seriemodificacionfw			lxMonedaUaltafw =  .Usuarioaltafw			lxMonedaHmodifw =  .Horamodificacionfw			lxMonedaVmodifw =  .Versionmodificacionfw			lxMonedaBdaltafw =  .Basededatosaltafw			lxMonedaBdmodifw =  .Basededatosmodificacionfw			lxMonedaZadsfw =  .Zadsfw			lxMonedaEsttrans =  .Estadotransferencia			lxMonedaUmodifw =  .Usuariomodificacionfw			lxMonedaValtafw =  .Versionaltafw			lxMonedaCodigo =  .Codigo			lxMonedaMobs =  .Observacion			lxMonedaDescrip =  .Descripcion			lxMonedaSimbolo =  .Simbolo			lxMonedaEafip =  upper( .EquivalenciaAfip_PK ) 			lxMonedaEdgi =  .Equivalenciadgi			lxMonedaTolpos =  .Toleranciapositiva			lxMonedaMcotafip =  upper( .MonedaCotizacionAFIP_PK ) 			lxMonedaCoblig =  .Cargaobligatoria			lxMonedaTolneg =  .Tolerancianegativa
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
				update ZooLogic.MONEDA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMonedaFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxMonedaFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxMonedaFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxMonedaFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMonedaFaltafw ) + "'">>,"Timestamp" = <<lxMonedaTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMonedaHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMonedaHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMonedaHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMonedaSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMonedaSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMonedaUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMonedaHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMonedaVmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMonedaBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMonedaBdmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMonedaZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMonedaEsttrans ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMonedaUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMonedaValtafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxMonedaCodigo ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxMonedaMobs ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxMonedaDescrip ) + "'">>,"Simbolo" = <<"'" + this.FormatearTextoSql( lxMonedaSimbolo ) + "'">>,"Eafip" = <<"'" + this.FormatearTextoSql( lxMonedaEafip ) + "'">>,"Edgi" = <<"'" + this.FormatearTextoSql( lxMonedaEdgi ) + "'">>,"Tolpos" = <<lxMonedaTolpos>>,"Mcotafip" = <<"'" + this.FormatearTextoSql( lxMonedaMcotafip ) + "'">>,"Coblig" = <<iif( lxMonedaCoblig, 1, 0 )>>,"Tolneg" = <<lxMonedaTolneg>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxMonedaCodigo ) + "'">> and  MONEDA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTIZA where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DENOMINA where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Cotizaciones
				if this.oEntidad.Cotizaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxCotizacion = loItem.Cotizacion
					lxHora = loItem.Hora
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTIZA("NROITEM","Codigo","Fecha","Cotiz","Hora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCotizacion>>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Denominaciones
				if this.oEntidad.Denominaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor = loItem.Valor
					lxTipo = loItem.Tipo
					lxDescri = loItem.Descri
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DENOMINA("NROITEM","Codigo","Valor","Tipo","Descri","Orden" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<lxOrden>> ) 
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
		this.oEntidad.Timestamp = lxMonedaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.MONEDA where " + this.ConvertirFuncionesSql( " MONEDA.CODIGO != ''" ) )
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
			Local lxMonedaCodigo
			lxMonedaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Codigo" as "Codigo", "Mobs" as "Observacion", "Descrip" as "Descripcion", "Simbolo" as "Simbolo", "Eafip" as "Equivalenciaafip", "Edgi" as "Equivalenciadgi", "Tolpos" as "Toleranciapositiva", "Mcotafip" as "Monedacotizacionafip", "Coblig" as "Cargaobligatoria", "Tolneg" as "Tolerancianegativa" from ZooLogic.MONEDA where "Codigo" = <<"'" + this.FormatearTextoSql( lxMonedaCodigo ) + "'">> and  MONEDA.CODIGO != ''
			endtext
			use in select('c_MONEDA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MONEDA', set( 'Datasession' ) )

			if reccount( 'c_MONEDA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fecha" as "Fecha", "Cotiz" as "Cotizacion", "Hora" as "Hora" from ZooLogic.COTIZA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Cotizaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Cotizaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Cotizaciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Tipo" as "Tipo", "Descri" as "Descri", "Orden" as "Orden" from ZooLogic.DENOMINA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Denominaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Denominaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Denominaciones
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMonedaCodigo as Variant
		llRetorno = .t.
		lxMonedaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MONEDA where "Codigo" = <<"'" + this.FormatearTextoSql( lxMonedaCodigo ) + "'">> and  MONEDA.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Codigo" as "Codigo", "Mobs" as "Observacion", "Descrip" as "Descripcion", "Simbolo" as "Simbolo", "Eafip" as "Equivalenciaafip", "Edgi" as "Equivalenciadgi", "Tolpos" as "Toleranciapositiva", "Mcotafip" as "Monedacotizacionafip", "Coblig" as "Cargaobligatoria", "Tolneg" as "Tolerancianegativa" from ZooLogic.MONEDA where  MONEDA.CODIGO != '' order by Codigo
			endtext
			use in select('c_MONEDA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MONEDA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fecha" as "Fecha", "Cotiz" as "Cotizacion", "Hora" as "Hora" from ZooLogic.COTIZA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Cotizaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Cotizaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Cotizaciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Tipo" as "Tipo", "Descri" as "Descri", "Orden" as "Orden" from ZooLogic.DENOMINA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Denominaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Denominaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Denominaciones
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Codigo" as "Codigo", "Mobs" as "Observacion", "Descrip" as "Descripcion", "Simbolo" as "Simbolo", "Eafip" as "Equivalenciaafip", "Edgi" as "Equivalenciadgi", "Tolpos" as "Toleranciapositiva", "Mcotafip" as "Monedacotizacionafip", "Coblig" as "Cargaobligatoria", "Tolneg" as "Tolerancianegativa" from ZooLogic.MONEDA where  funciones.padr( Codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MONEDA.CODIGO != '' order by Codigo
			endtext
			use in select('c_MONEDA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MONEDA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fecha" as "Fecha", "Cotiz" as "Cotizacion", "Hora" as "Hora" from ZooLogic.COTIZA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Cotizaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Cotizaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Cotizaciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Tipo" as "Tipo", "Descri" as "Descri", "Orden" as "Orden" from ZooLogic.DENOMINA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Denominaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Denominaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Denominaciones
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Codigo" as "Codigo", "Mobs" as "Observacion", "Descrip" as "Descripcion", "Simbolo" as "Simbolo", "Eafip" as "Equivalenciaafip", "Edgi" as "Equivalenciadgi", "Tolpos" as "Toleranciapositiva", "Mcotafip" as "Monedacotizacionafip", "Coblig" as "Cargaobligatoria", "Tolneg" as "Tolerancianegativa" from ZooLogic.MONEDA where  funciones.padr( Codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MONEDA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MONEDA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MONEDA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fecha" as "Fecha", "Cotiz" as "Cotizacion", "Hora" as "Hora" from ZooLogic.COTIZA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Cotizaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Cotizaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Cotizaciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Tipo" as "Tipo", "Descri" as "Descri", "Orden" as "Orden" from ZooLogic.DENOMINA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Denominaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Denominaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Denominaciones
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Codigo" as "Codigo", "Mobs" as "Observacion", "Descrip" as "Descripcion", "Simbolo" as "Simbolo", "Eafip" as "Equivalenciaafip", "Edgi" as "Equivalenciadgi", "Tolpos" as "Toleranciapositiva", "Mcotafip" as "Monedacotizacionafip", "Coblig" as "Cargaobligatoria", "Tolneg" as "Tolerancianegativa" from ZooLogic.MONEDA where  MONEDA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MONEDA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MONEDA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fecha" as "Fecha", "Cotiz" as "Cotizacion", "Hora" as "Hora" from ZooLogic.COTIZA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Cotizaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Cotizaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Cotizaciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Tipo" as "Tipo", "Descri" as "Descri", "Orden" as "Orden" from ZooLogic.DENOMINA where Codigo = <<"'" + this.FormatearTextoSql( c_MONEDA.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Denominaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Denominaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Denominaciones
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Timestamp,Horaexpo,Haltafw,Horaimpo,Saltafw,Smodifw" + ;
",Ualtafw,Hmodifw,Vmodifw,Bdaltafw,Bdmodifw,Zadsfw,Esttrans,Umodifw,Valtafw,Codigo,Mobs,Descrip,Simbo" + ;
"lo,Eafip,Edgi,Tolpos,Mcotafip,Coblig,Tolneg" + ;
" from ZooLogic.MONEDA where  MONEDA.CODIGO != '' and " + lcFiltro )
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
			local  lxMonedaFecimpo, lxMonedaFectrans, lxMonedaFmodifw, lxMonedaFecexpo, lxMonedaFaltafw, lxMonedaTimestamp, lxMonedaHoraexpo, lxMonedaHaltafw, lxMonedaHoraimpo, lxMonedaSaltafw, lxMonedaSmodifw, lxMonedaUaltafw, lxMonedaHmodifw, lxMonedaVmodifw, lxMonedaBdaltafw, lxMonedaBdmodifw, lxMonedaZadsfw, lxMonedaEsttrans, lxMonedaUmodifw, lxMonedaValtafw, lxMonedaCodigo, lxMonedaMobs, lxMonedaDescrip, lxMonedaSimbolo, lxMonedaEafip, lxMonedaEdgi, lxMonedaTolpos, lxMonedaMcotafip, lxMonedaCoblig, lxMonedaTolneg
				lxMonedaFecimpo = ctod( '  /  /    ' )			lxMonedaFectrans = ctod( '  /  /    ' )			lxMonedaFmodifw = ctod( '  /  /    ' )			lxMonedaFecexpo = ctod( '  /  /    ' )			lxMonedaFaltafw = ctod( '  /  /    ' )			lxMonedaTimestamp = goLibrerias.ObtenerTimestamp()			lxMonedaHoraexpo = []			lxMonedaHaltafw = []			lxMonedaHoraimpo = []			lxMonedaSaltafw = []			lxMonedaSmodifw = []			lxMonedaUaltafw = []			lxMonedaHmodifw = []			lxMonedaVmodifw = []			lxMonedaBdaltafw = []			lxMonedaBdmodifw = []			lxMonedaZadsfw = []			lxMonedaEsttrans = []			lxMonedaUmodifw = []			lxMonedaValtafw = []			lxMonedaCodigo = []			lxMonedaMobs = []			lxMonedaDescrip = []			lxMonedaSimbolo = []			lxMonedaEafip = []			lxMonedaEdgi = []			lxMonedaTolpos = 0			lxMonedaMcotafip = []			lxMonedaCoblig = .F.			lxMonedaTolneg = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTIZA where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DENOMINA where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MONEDA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MONEDA' + '_' + tcCampo
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
		lcWhere = " Where  MONEDA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Codigo" as "Codigo", "Mobs" as "Observacion", "Descrip" as "Descripcion", "Simbolo" as "Simbolo", "Eafip" as "Equivalenciaafip", "Edgi" as "Equivalenciadgi", "Tolpos" as "Toleranciapositiva", "Mcotafip" as "Monedacotizacionafip", "Coblig" as "Cargaobligatoria", "Tolneg" as "Tolerancianegativa"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MONEDA', '', tnTope )
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
	Function ObtenerDatosDetalleCotizaciones( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COTIZA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fecha" as "Fecha", "Cotiz" as "Cotizacion", "Hora" as "Hora"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCotizaciones( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COTIZA', 'Cotizaciones', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCotizaciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCotizaciones( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDenominaciones( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DENOMINA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Tipo" as "Tipo", "Descri" as "Descri", "Orden" as "Orden"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDenominaciones( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DENOMINA', 'Denominaciones', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDenominaciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDenominaciones( lcAtributo )
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
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'SIMBOLO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBOLO AS SIMBOLO'
				Case lcAtributo == 'EQUIVALENCIAAFIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EAFIP AS EQUIVALENCIAAFIP'
				Case lcAtributo == 'EQUIVALENCIADGI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EDGI AS EQUIVALENCIADGI'
				Case lcAtributo == 'TOLERANCIAPOSITIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOLPOS AS TOLERANCIAPOSITIVA'
				Case lcAtributo == 'MONEDACOTIZACIONAFIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCOTAFIP AS MONEDACOTIZACIONAFIP'
				Case lcAtributo == 'CARGAOBLIGATORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBLIG AS CARGAOBLIGATORIA'
				Case lcAtributo == 'TOLERANCIANEGATIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOLNEG AS TOLERANCIANEGATIVA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCotizaciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDenominaciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'DESCRI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRI'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLO'
				lcCampo = 'SIMBOLO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIAAFIP'
				lcCampo = 'EAFIP'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIADGI'
				lcCampo = 'EDGI'
			Case upper( alltrim( tcAtributo ) ) == 'TOLERANCIAPOSITIVA'
				lcCampo = 'TOLPOS'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOTIZACIONAFIP'
				lcCampo = 'MCOTAFIP'
			Case upper( alltrim( tcAtributo ) ) == 'CARGAOBLIGATORIA'
				lcCampo = 'COBLIG'
			Case upper( alltrim( tcAtributo ) ) == 'TOLERANCIANEGATIVA'
				lcCampo = 'TOLNEG'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCotizaciones( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDenominaciones( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRI'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COTIZACIONES'
			lcRetorno = 'COTIZA'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DENOMINACIONES'
			lcRetorno = 'DENOMINA'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxMonedaFecimpo, lxMonedaFectrans, lxMonedaFmodifw, lxMonedaFecexpo, lxMonedaFaltafw, lxMonedaTimestamp, lxMonedaHoraexpo, lxMonedaHaltafw, lxMonedaHoraimpo, lxMonedaSaltafw, lxMonedaSmodifw, lxMonedaUaltafw, lxMonedaHmodifw, lxMonedaVmodifw, lxMonedaBdaltafw, lxMonedaBdmodifw, lxMonedaZadsfw, lxMonedaEsttrans, lxMonedaUmodifw, lxMonedaValtafw, lxMonedaCodigo, lxMonedaMobs, lxMonedaDescrip, lxMonedaSimbolo, lxMonedaEafip, lxMonedaEdgi, lxMonedaTolpos, lxMonedaMcotafip, lxMonedaCoblig, lxMonedaTolneg
				lxMonedaFecimpo =  .Fechaimpo			lxMonedaFectrans =  .Fechatransferencia			lxMonedaFmodifw =  .Fechamodificacionfw			lxMonedaFecexpo =  .Fechaexpo			lxMonedaFaltafw =  .Fechaaltafw			lxMonedaTimestamp = goLibrerias.ObtenerTimestamp()			lxMonedaHoraexpo =  .Horaexpo			lxMonedaHaltafw =  .Horaaltafw			lxMonedaHoraimpo =  .Horaimpo			lxMonedaSaltafw =  .Seriealtafw			lxMonedaSmodifw =  .Seriemodificacionfw			lxMonedaUaltafw =  .Usuarioaltafw			lxMonedaHmodifw =  .Horamodificacionfw			lxMonedaVmodifw =  .Versionmodificacionfw			lxMonedaBdaltafw =  .Basededatosaltafw			lxMonedaBdmodifw =  .Basededatosmodificacionfw			lxMonedaZadsfw =  .Zadsfw			lxMonedaEsttrans =  .Estadotransferencia			lxMonedaUmodifw =  .Usuariomodificacionfw			lxMonedaValtafw =  .Versionaltafw			lxMonedaCodigo =  .Codigo			lxMonedaMobs =  .Observacion			lxMonedaDescrip =  .Descripcion			lxMonedaSimbolo =  .Simbolo			lxMonedaEafip =  upper( .EquivalenciaAfip_PK ) 			lxMonedaEdgi =  .Equivalenciadgi			lxMonedaTolpos =  .Toleranciapositiva			lxMonedaMcotafip =  upper( .MonedaCotizacionAFIP_PK ) 			lxMonedaCoblig =  .Cargaobligatoria			lxMonedaTolneg =  .Tolerancianegativa
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MONEDA ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Timestamp","Horaexpo","Haltafw","Horaimpo","Saltafw","Smodifw","Ualtafw","Hmodifw","Vmodifw","Bdaltafw","Bdmodifw","Zadsfw","Esttrans","Umodifw","Valtafw","Codigo","Mobs","Descrip","Simbolo","Eafip","Edgi","Tolpos","Mcotafip","Coblig","Tolneg" ) values ( <<"'" + this.ConvertirDateSql( lxMonedaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMonedaFaltafw ) + "'" >>, <<lxMonedaTimestamp >>, <<"'" + this.FormatearTextoSql( lxMonedaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaSimbolo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaEafip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMonedaEdgi ) + "'" >>, <<lxMonedaTolpos >>, <<"'" + this.FormatearTextoSql( lxMonedaMcotafip ) + "'" >>, <<iif( lxMonedaCoblig, 1, 0 ) >>, <<lxMonedaTolneg >> )
		endtext
		loColeccion.cTabla = 'MONEDA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Cotizaciones
				if this.oEntidad.Cotizaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxCotizacion = loItem.Cotizacion
					lxHora = loItem.Hora
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTIZA("NROITEM","Codigo","Fecha","Cotiz","Hora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCotizacion>>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Denominaciones
				if this.oEntidad.Denominaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor = loItem.Valor
					lxTipo = loItem.Tipo
					lxDescri = loItem.Descri
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DENOMINA("NROITEM","Codigo","Valor","Tipo","Descri","Orden" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<lxOrden>> ) 
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
			local  lxMonedaFecimpo, lxMonedaFectrans, lxMonedaFmodifw, lxMonedaFecexpo, lxMonedaFaltafw, lxMonedaTimestamp, lxMonedaHoraexpo, lxMonedaHaltafw, lxMonedaHoraimpo, lxMonedaSaltafw, lxMonedaSmodifw, lxMonedaUaltafw, lxMonedaHmodifw, lxMonedaVmodifw, lxMonedaBdaltafw, lxMonedaBdmodifw, lxMonedaZadsfw, lxMonedaEsttrans, lxMonedaUmodifw, lxMonedaValtafw, lxMonedaCodigo, lxMonedaMobs, lxMonedaDescrip, lxMonedaSimbolo, lxMonedaEafip, lxMonedaEdgi, lxMonedaTolpos, lxMonedaMcotafip, lxMonedaCoblig, lxMonedaTolneg
				lxMonedaFecimpo =  .Fechaimpo			lxMonedaFectrans =  .Fechatransferencia			lxMonedaFmodifw =  .Fechamodificacionfw			lxMonedaFecexpo =  .Fechaexpo			lxMonedaFaltafw =  .Fechaaltafw			lxMonedaTimestamp = goLibrerias.ObtenerTimestamp()			lxMonedaHoraexpo =  .Horaexpo			lxMonedaHaltafw =  .Horaaltafw			lxMonedaHoraimpo =  .Horaimpo			lxMonedaSaltafw =  .Seriealtafw			lxMonedaSmodifw =  .Seriemodificacionfw			lxMonedaUaltafw =  .Usuarioaltafw			lxMonedaHmodifw =  .Horamodificacionfw			lxMonedaVmodifw =  .Versionmodificacionfw			lxMonedaBdaltafw =  .Basededatosaltafw			lxMonedaBdmodifw =  .Basededatosmodificacionfw			lxMonedaZadsfw =  .Zadsfw			lxMonedaEsttrans =  .Estadotransferencia			lxMonedaUmodifw =  .Usuariomodificacionfw			lxMonedaValtafw =  .Versionaltafw			lxMonedaCodigo =  .Codigo			lxMonedaMobs =  .Observacion			lxMonedaDescrip =  .Descripcion			lxMonedaSimbolo =  .Simbolo			lxMonedaEafip =  upper( .EquivalenciaAfip_PK ) 			lxMonedaEdgi =  .Equivalenciadgi			lxMonedaTolpos =  .Toleranciapositiva			lxMonedaMcotafip =  upper( .MonedaCotizacionAFIP_PK ) 			lxMonedaCoblig =  .Cargaobligatoria			lxMonedaTolneg =  .Tolerancianegativa
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MONEDA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MONEDA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMonedaFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxMonedaFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMonedaFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMonedaFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMonedaFaltafw ) + "'">>, "Timestamp" = <<lxMonedaTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMonedaHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMonedaHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMonedaHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMonedaSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMonedaSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMonedaUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMonedaHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMonedaVmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMonedaBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMonedaBdmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMonedaZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMonedaEsttrans ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMonedaUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMonedaValtafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxMonedaCodigo ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxMonedaMobs ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxMonedaDescrip ) + "'">>, "Simbolo" = <<"'" + this.FormatearTextoSql( lxMonedaSimbolo ) + "'">>, "Eafip" = <<"'" + this.FormatearTextoSql( lxMonedaEafip ) + "'">>, "Edgi" = <<"'" + this.FormatearTextoSql( lxMonedaEdgi ) + "'">>, "Tolpos" = <<lxMonedaTolpos>>, "Mcotafip" = <<"'" + this.FormatearTextoSql( lxMonedaMcotafip ) + "'">>, "Coblig" = <<iif( lxMonedaCoblig, 1, 0 )>>, "Tolneg" = <<lxMonedaTolneg>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MONEDA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.COTIZA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DENOMINA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Cotizaciones
				if this.oEntidad.Cotizaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxCotizacion = loItem.Cotizacion
					lxHora = loItem.Hora
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTIZA("NROITEM","Codigo","Fecha","Cotiz","Hora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCotizacion>>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Denominaciones
				if this.oEntidad.Denominaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor = loItem.Valor
					lxTipo = loItem.Tipo
					lxDescri = loItem.Descri
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DENOMINA("NROITEM","Codigo","Valor","Tipo","Descri","Orden" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<lxOrden>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MONEDA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MONEDA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.COTIZA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DENOMINA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MONEDA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MONEDA where  MONEDA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MONEDA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MONEDA.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MONEDA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MONEDA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MONEDA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Simbolo = ] + "'" + this.FormatearTextoSql( &lcCursor..Simbolo ) + "'"+ [, Eafip = ] + "'" + this.FormatearTextoSql( &lcCursor..Eafip ) + "'"+ [, Edgi = ] + "'" + this.FormatearTextoSql( &lcCursor..Edgi ) + "'"+ [, TolPos = ] + transform( &lcCursor..TolPos )+ [, MCotAfip = ] + "'" + this.FormatearTextoSql( &lcCursor..MCotAfip ) + "'"+ [, COblig = ] + Transform( iif( &lcCursor..COblig, 1, 0 ))+ [, TolNeg = ] + transform( &lcCursor..TolNeg ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, TIMESTAMP, HORAEXPO, HALTAFW, HORAIMPO, SALTAFW, SMODIFW, UALTAFW, HMODIFW, VMODIFW, BDALTAFW, BDMODIFW, ZADSFW, ESTTRANS, UMODIFW, VALTAFW, Codigo, MObs, Descrip, Simbolo, Eafip, Edgi, TolPos, MCotAfip, COblig, TolNeg
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Simbolo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Eafip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Edgi ) + "'" + ',' + transform( &lcCursor..TolPos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MCotAfip ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..COblig, 1, 0 )) + ',' + transform( &lcCursor..TolNeg )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MONEDA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MONEDA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.COTIZA Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DENOMINA Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMONEDA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Fecha","Cotiz","Hora"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.COTIZA ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + transform( cDetallesExistentes.Cotiz      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Hora       ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDENOMINACIONES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Valor","Tipo","Descri","Orden"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DENOMINA ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.Valor      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tipo       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Orden      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (10) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'MONEDA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MONEDA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MONEDA_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMONEDA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDENOMINACIONES'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MONEDA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MONEDA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MONEDA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MONEDA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MONEDA'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MONEDA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MONEDA
Create Table ZooLogic.TablaTrabajo_MONEDA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"codigo" char( 10 )  null, 
"mobs" varchar(max)  null, 
"descrip" char( 40 )  null, 
"simbolo" char( 3 )  null, 
"eafip" char( 3 )  null, 
"edgi" char( 3 )  null, 
"tolpos" numeric( 7, 2 )  null, 
"mcotafip" char( 10 )  null, 
"coblig" bit  null, 
"tolneg" numeric( 7, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MONEDA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MONEDA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MONEDA'
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
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('simbolo','simbolo')
			.AgregarMapeo('eafip','eafip')
			.AgregarMapeo('edgi','edgi')
			.AgregarMapeo('tolpos','tolpos')
			.AgregarMapeo('mcotafip','mcotafip')
			.AgregarMapeo('coblig','coblig')
			.AgregarMapeo('tolneg','tolneg')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MONEDA'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.SIMBOLO = isnull( d.SIMBOLO, t.SIMBOLO ),t.EAFIP = isnull( d.EAFIP, t.EAFIP ),t.EDGI = isnull( d.EDGI, t.EDGI ),t.TOLPOS = isnull( d.TOLPOS, t.TOLPOS ),t.MCOTAFIP = isnull( d.MCOTAFIP, t.MCOTAFIP ),t.COBLIG = isnull( d.COBLIG, t.COBLIG ),t.TOLNEG = isnull( d.TOLNEG, t.TOLNEG )
					from ZooLogic.MONEDA t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.MONEDA(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Timestamp,Horaexpo,Haltafw,Horaimpo,Saltafw,Smodifw,Ualtafw,Hmodifw,Vmodifw,Bdaltafw,Bdmodifw,Zadsfw,Esttrans,Umodifw,Valtafw,Codigo,Mobs,Descrip,Simbolo,Eafip,Edgi,Tolpos,Mcotafip,Coblig,Tolneg)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.CODIGO,''),isnull( d.MOBS,''),isnull( d.DESCRIP,''),isnull( d.SIMBOLO,''),isnull( d.EAFIP,''),isnull( d.EDGI,''),isnull( d.TOLPOS,0),isnull( d.MCOTAFIP,''),isnull( d.COBLIG,0),isnull( d.TOLNEG,0)
						From deleted d left join ZooLogic.MONEDA pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_COTIZA( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MONEDA_COTIZA
ON ZooLogic.TablaTrabajo_MONEDA_COTIZA
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FECHA = isnull( d.FECHA, t.FECHA ),
t.COTIZ = isnull( d.COTIZ, t.COTIZ ),
t.HORA = isnull( d.HORA, t.HORA )
from ZooLogic.COTIZA t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.COTIZA
( 
"NROITEM",
"CODIGO",
"FECHA",
"COTIZ",
"HORA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.FECHA,
d.COTIZ,
d.HORA
From deleted d left join ZooLogic.COTIZA pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DENOMINA( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MONEDA_DENOMINA
ON ZooLogic.TablaTrabajo_MONEDA_DENOMINA
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.VALOR = isnull( d.VALOR, t.VALOR ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.ORDEN = isnull( d.ORDEN, t.ORDEN )
from ZooLogic.DENOMINA t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DENOMINA
( 
"NROITEM",
"CODIGO",
"VALOR",
"TIPO",
"DESCRI",
"ORDEN"
 )
Select 
d.NROITEM,
d.CODIGO,
d.VALOR,
d.TIPO,
d.DESCRI,
d.ORDEN
From deleted d left join ZooLogic.DENOMINA pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MONEDA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MONEDA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MONEDA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MONEDA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MONEDA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MONEDA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MONEDA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MONEDA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_MONEDA.Timestamp, 0 )
					.Horaexpo = nvl( c_MONEDA.Horaexpo, [] )
					.Horaaltafw = nvl( c_MONEDA.Horaaltafw, [] )
					.Horaimpo = nvl( c_MONEDA.Horaimpo, [] )
					.Seriealtafw = nvl( c_MONEDA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_MONEDA.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_MONEDA.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_MONEDA.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_MONEDA.Versionmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_MONEDA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_MONEDA.Basededatosmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_MONEDA.Estadotransferencia, [] )
					.Usuariomodificacionfw = nvl( c_MONEDA.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_MONEDA.Versionaltafw, [] )
					.Codigo = nvl( c_MONEDA.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Cotizaciones.Limpiar()
					.Cotizaciones.SetearEsNavegacion( .lProcesando )
					.Cotizaciones.Cargar()
					.Descripcion = nvl( c_MONEDA.Descripcion, [] )
					.Simbolo = nvl( c_MONEDA.Simbolo, [] )
					.Denominaciones.Limpiar()
					.Denominaciones.SetearEsNavegacion( .lProcesando )
					.Denominaciones.Cargar()
					.Equivalenciaafip_PK =  nvl( c_MONEDA.Equivalenciaafip, [] )
					.Equivalenciadgi = nvl( c_MONEDA.Equivalenciadgi, [] )
					.Toleranciapositiva = nvl( c_MONEDA.Toleranciapositiva, 0 )
					.Monedacotizacionafip_PK =  nvl( c_MONEDA.Monedacotizacionafip, [] )
					.Cargaobligatoria = nvl( c_MONEDA.Cargaobligatoria, .F. )
					.Tolerancianegativa = nvl( c_MONEDA.Tolerancianegativa, 0 )
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
		
		loDetalle = this.oEntidad.Cotizaciones
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

		loDetalle = this.oEntidad.Denominaciones
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
		return c_MONEDA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MONEDA' )
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
								from ZooLogic.MONEDA 
								Where   MONEDA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MONEDA", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Codigo" as "Codigo", "Mobs" as "Observacion", "Descrip" as "Descripcion", "Simbolo" as "Simbolo", "Eafip" as "Equivalenciaafip", "Edgi" as "Equivalenciadgi", "Tolpos" as "Toleranciapositiva", "Mcotafip" as "Monedacotizacionafip", "Coblig" as "Cargaobligatoria", "Tolneg" as "Tolerancianegativa"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MONEDA 
								Where   MONEDA.CODIGO != ''
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
	Tabla = 'MONEDA'
	Filtro = " MONEDA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MONEDA.CODIGO != ''"
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
	<row entidad="MONEDA                                  " atributo="FECHAIMPO                               " tabla="MONEDA         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="FECHATRANSFERENCIA                      " tabla="MONEDA         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="FECHAMODIFICACIONFW                     " tabla="MONEDA         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="FECHAEXPO                               " tabla="MONEDA         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="FECHAALTAFW                             " tabla="MONEDA         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="TIMESTAMP                               " tabla="MONEDA         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="HORAEXPO                                " tabla="MONEDA         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="HORAALTAFW                              " tabla="MONEDA         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="HORAIMPO                                " tabla="MONEDA         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="SERIEALTAFW                             " tabla="MONEDA         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="SERIEMODIFICACIONFW                     " tabla="MONEDA         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="USUARIOALTAFW                           " tabla="MONEDA         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="HORAMODIFICACIONFW                      " tabla="MONEDA         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="VERSIONMODIFICACIONFW                   " tabla="MONEDA         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="BASEDEDATOSALTAFW                       " tabla="MONEDA         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MONEDA         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="ZADSFW                                  " tabla="MONEDA         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="ESTADOTRANSFERENCIA                     " tabla="MONEDA         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="USUARIOMODIFICACIONFW                   " tabla="MONEDA         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="VERSIONALTAFW                           " tabla="MONEDA         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="CODIGO                                  " tabla="MONEDA         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="OBSERVACION                             " tabla="MONEDA         " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="COTIZACIONES                            " tabla="COTIZA         " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Cotizaciones                                                                                                                                                    " dominio="DETALLEITEMMONEDA             " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="SIMBOLO                                 " tabla="MONEDA         " campo="SIMBOLO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Simbolo                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DENOMINACIONES                          " tabla="DENOMINA       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Denominaciones                                                                                                                                                  " dominio="DETALLEITEMDENOMINACIONES     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="EQUIVALENCIAAFIP                        " tabla="MONEDA         " campo="EAFIP     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDAAFIP                              " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Código AFIP                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="EQUIVALENCIADGI                         " tabla="MONEDA         " campo="EDGI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Código DGI                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="TOLERANCIAPOSITIVA                      " tabla="MONEDA         " campo="TOLPOS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Monto de tolerancia positivo para ajuste en arqueo de caja                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="MONEDACOTIZACIONAFIP                    " tabla="MONEDA         " campo="MCOTAFIP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Moneda cotización AFIP                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="CARGAOBLIGATORIA                        " tabla="MONEDA         " campo="COBLIG    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Cotización del día obligatoria                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="TOLERANCIANEGATIVA                      " tabla="MONEDA         " campo="TOLNEG    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Monto de tolerancia negativo para ajuste en arqueo de caja                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDAAFIP                              " atributo="DESCRIPCION                             " tabla="AFIPMO         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join AFIPMO On MONEDA.EAFIP = AFIPMO.Codigo And  AFIPMO.CODIGO != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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